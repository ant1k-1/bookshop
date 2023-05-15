package com.example.bookshop.controller;

import com.example.bookshop.model.Book;
import com.example.bookshop.model.Comment;
import com.example.bookshop.service.BookService;
import com.example.bookshop.service.CommentService;
import com.example.bookshop.service.OrderService;
import com.example.bookshop.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.Comparator;

@RequestMapping("/moder")
@Controller
@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MODERATOR')")
public class ModerController {
    private final UserService userService;
    private final BookService bookService;
    private final OrderService orderService;
    private final CommentService commentService;

    @Autowired
    public ModerController(UserService userService,
                           BookService bookService,
                           OrderService orderService,
                           CommentService commentService) {
        this.userService = userService;
        this.bookService = bookService;
        this.orderService = orderService;
        this.commentService = commentService;
    }

    @GetMapping
    public String moder(Model model){
        model.addAttribute("comments", commentService.getAll()
                .stream()
                .filter(comment -> !comment.getIsModerated())
                .sorted(Comparator.comparing(Comment::getCreationDate))
                .toList());
        return "moder";
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
        return "redirect:/moder";
    }
}
