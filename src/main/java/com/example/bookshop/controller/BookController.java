package com.example.bookshop.controller;

import com.example.bookshop.dto.CommentDTO;
import com.example.bookshop.dto.UserDTO;
import com.example.bookshop.model.Book;
import com.example.bookshop.model.Comment;
import com.example.bookshop.model.User;
import com.example.bookshop.model.UserDetailsImpl;
import com.example.bookshop.repository.BookRepository;
import com.example.bookshop.service.BookService;
import com.example.bookshop.service.CommentService;
import com.example.bookshop.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/book")
public class BookController {
    private final BookService bookService;
    private final UserService userService;
    private final CommentService commentService;
    @Autowired
    public BookController(BookService bookService,
                          UserService userService,
                          CommentService commentService) {
        this.bookService = bookService;
        this.userService = userService;
        this.commentService = commentService;
    }

    @GetMapping("/{id}")
    public String bookPage(
            @PathVariable Long id,
            @AuthenticationPrincipal UserDetailsImpl userDetails,
            Model model
    ) {
        Book book = bookService.getById(id);
        if (book == null) {
            model.addAttribute("empty", true);
            return "book";
        }

        model.addAttribute("book", book);
        model.addAttribute("user", userDetails.getUser());
        return "book";
    }

    @RequestMapping(value = "/{id}/buy", name = "cart", method = RequestMethod.POST)
    public void sendToCart(
            @PathVariable("id") Long bookId,
            @AuthenticationPrincipal UserDetailsImpl userDetails
    ) {
        userService.updateUserCartById(userDetails.getUser().getId(), bookId, true);
    }

    @RequestMapping(value = "/{id}/comment", name = "comment", method = RequestMethod.POST)
    public String sendComment(
            @PathVariable("id") Long bookId,
            @AuthenticationPrincipal UserDetailsImpl userDetails,
            @RequestParam("title") String title,
            @RequestParam("description") String text,
            @RequestParam Map<String, String> form,
            Model model
    ) {
        UserDTO userDTO = userDetails.getUser();
        if (userDTO.getIsCommentsAllowed()){
            User user = userService.getPrivateById(userDTO.getId());
            Book book =  bookService.getById(bookId);
            Comment comment = new Comment(
                    user,
                    book,
                    form.get("title"),
                    Integer.parseInt(form.get("rating")),
                    form.get("description")
            );
            bookService.update(book);
            commentService.create(comment);
            model.addAttribute("status", true);
        } else {
            model.addAttribute("status", false);
        }
        model.addAttribute("book", bookService.getById(bookId));
        model.addAttribute("user", userDetails.getUser());
        return "redirect:/book";
    }
}
