package com.example.bookshop.controller;

import com.example.bookshop.model.Book;
import com.example.bookshop.model.Comment;
import com.example.bookshop.service.BookService;
import com.example.bookshop.service.CommentService;
import com.example.bookshop.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/moder")
@Controller
@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MODERATOR')")
public class ModerController {
    private final UserService userService;
    private final BookService bookService;
    private final CommentService commentService;

    @Autowired
    public ModerController(UserService userService, BookService bookService, CommentService commentService) {
        this.userService = userService;
        this.bookService = bookService;
        this.commentService = commentService;
    }

    @GetMapping
    public String moder(Model model){
        model.addAttribute("commentsDisplay", true);
        model.addAttribute("userDisplay", false);
        model.addAttribute("users", userService.getAllCommentBlocked());
        model.addAttribute("comments", commentService.getUnModerated());
        return "moder";
    }

    @GetMapping("/users")
    public String blockedUsers(Model model) {
        model.addAttribute("commentsDisplay", false);
        model.addAttribute("userDisplay", true);
        model.addAttribute("users", userService.getAllCommentBlocked());
        return "moder";
    }

    @PostMapping("/unlock")
    public String unlockUser(
            @RequestParam("userId") Long userId
    ) {
        userService.accessCommentsById(userId, true);
        return "redirect:/moder/users";
    }

    @RequestMapping(value = "/allow-comment/{id}", method = RequestMethod.POST)
    public String allowComment(
            @PathVariable("id") Long commentId
    ) {
        Comment comment = commentService.getById(commentId);
        comment.setIsModerated(true);
        commentService.update(comment);
        return "redirect:/moder";
    }

    @RequestMapping(value = "/delete-comment/{id}", method = RequestMethod.POST)
    public String deleteComment(
            @PathVariable("id") Long commentId
    ) {
        Comment comment = commentService.getById(commentId);
        Book book = comment.getBook();
        book.removeComment(comment.getRate());
        commentService.deleteById(commentId);
        bookService.update(book);
        userService.accessCommentsById(comment.getUser().getId(), false);
        return "redirect:/moder";
    }
}
