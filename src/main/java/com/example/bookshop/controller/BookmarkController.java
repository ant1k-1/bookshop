package com.example.bookshop.controller;

import com.example.bookshop.dto.UserDTO;
import com.example.bookshop.model.UserDetailsImpl;
import com.example.bookshop.service.BookService;
import com.example.bookshop.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@RequestMapping("/bookmark")
@Controller
public class BookmarkController {
    private final UserService userService;
    private final BookService bookService;
    @Autowired
    public BookmarkController(UserService userService, BookService bookService) {
        this.userService = userService;
        this.bookService = bookService;
    }

    @GetMapping
    public String bookmarks(
            @AuthenticationPrincipal UserDetailsImpl userDetails,
            Model model
    ) {
        UserDTO user = userService.getById(userDetails.getUser().getId());
        model.addAttribute("bookmarks", user.getBookmarks().stream()
                .map(bookService::getById)
                .toList());
        return "bookmark";
    }

    @PostMapping("/delete")
    public String deleteBook(
            @AuthenticationPrincipal UserDetailsImpl userDetails,
            @RequestParam Map<String, String> form
    ) {
        form.remove("_csrf");
        for (String key : form.keySet()) {
            userService.updateUserBookmarksById(userDetails.getUser().getId(), Long.parseLong(key), false);
        }
        return "redirect:/bookmark";
    }
}
