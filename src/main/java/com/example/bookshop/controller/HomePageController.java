package com.example.bookshop.controller;

import com.example.bookshop.dto.BookDTO;
import com.example.bookshop.model.UserDetailsImpl;
import com.example.bookshop.service.BookService;
import com.example.bookshop.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.annotation.CurrentSecurityContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class HomePageController {
    private final BookService bookService;
    private final UserService userService;

    @Autowired
    public HomePageController(BookService bookService, UserService userService) {
        this.bookService = bookService;
        this.userService = userService;
    }

    @GetMapping({"/", "/home"})
    public String welcome(
            @CurrentSecurityContext(expression = "authentication?.name") String username,
            @AuthenticationPrincipal UserDetailsImpl userDetails,
            Model model) {
        List<List<BookDTO>> trending = bookService.getTrending();
        model.addAttribute("topRate", trending.get(0));
        model.addAttribute("topSold", trending.get(1));
        if (username.equals("anonymousUser")) {
            model.addAttribute("logged", false);
            model.addAttribute("name", ", Аноним!");
            model.addAttribute("userId", -1);
        }
        else {
            model.addAttribute("logged", true);
            model.addAttribute("name", ", " + username + "!");
            model.addAttribute("userId", userDetails.getUser().getId());
            model.addAttribute("user", userDetails.getUser());
        }
        return "home";
    }

    @RequestMapping(value = {"/buy"}, method = RequestMethod.POST)
    public String sendToCart(
            @RequestParam("bookId") Long bookId,
            @AuthenticationPrincipal UserDetailsImpl userDetails
    ) {
        userService.updateUserCartById(userDetails.getUser().getId(), bookId, 1, true);
        return "redirect:/home";
    }


}
