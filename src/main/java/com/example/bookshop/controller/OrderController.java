package com.example.bookshop.controller;

import com.example.bookshop.model.UserDetailsImpl;
import com.example.bookshop.service.BookService;
import com.example.bookshop.service.OrderService;
import com.example.bookshop.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/orders")
@Controller
public class OrderController {
    private final UserService userService;
    private final OrderService orderService;
    private final BookService bookService;

    @Autowired
    public OrderController(UserService userService, OrderService orderService, BookService bookService) {
        this.userService = userService;
        this.orderService = orderService;
        this.bookService = bookService;
    }

    @GetMapping
    public String orders(
            @AuthenticationPrincipal UserDetailsImpl userDetails,
            Model model
    ) {
        return "order";
    }

    @PostMapping
    public String closeOrder(
            @AuthenticationPrincipal UserDetailsImpl userDetails,
            Model model
    ) {
        return "redirect:/order";
    }
}
