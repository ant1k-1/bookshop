package com.example.bookshop.controller;

import com.example.bookshop.dto.BookDTO;
import com.example.bookshop.model.Book;
import com.example.bookshop.model.UserDetailsImpl;
import com.example.bookshop.service.BookService;
import com.example.bookshop.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.annotation.CurrentSecurityContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Comparator;
import java.util.List;
import java.util.Objects;

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
        List<BookDTO> topRate = trending.get(0);
        List<BookDTO> topSold = trending.get(1);

        model.addAttribute("topRate", topRate);
        model.addAttribute("topSold", topSold);
        if (username.equals("anonymousUser")) {
            model.addAttribute("logged", false);
            model.addAttribute("name", ", Аноним!");
            model.addAttribute("userId", -1);
        }
        else {
            model.addAttribute("logged", true);
            model.addAttribute("name", ", " + username + "!");
            model.addAttribute("userId", userDetails.getUser().getId());
        }
        return "home";
    }

    @RequestMapping(value = {"/buy"}, method = RequestMethod.POST)
    public String sendToCart(
            @RequestParam("bookId") String bookId,
            @AuthenticationPrincipal UserDetailsImpl userDetails
    ) {
        System.out.println(userDetails.getUsername() + " buy book id="+bookId);
        userService.updateUserCartById(userDetails.getUser().getId(), Long.parseLong(bookId), true);
        return "redirect:/home";
    }


}
