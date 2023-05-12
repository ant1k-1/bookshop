package com.example.bookshop.controller;

import com.example.bookshop.model.Book;
import com.example.bookshop.model.Order;
import com.example.bookshop.model.User;
import com.example.bookshop.model.UserDetailsImpl;
import com.example.bookshop.service.BookService;
import com.example.bookshop.service.OrderService;
import com.example.bookshop.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RequestMapping("/cart")
@Controller
public class CartController {
    private final UserService userService;
    private final OrderService orderService;
    private final BookService bookService;
    @Autowired
    public CartController(UserService userService, OrderService orderService, BookService bookService) {
        this.userService = userService;
        this.orderService = orderService;
        this.bookService = bookService;
    }

    @GetMapping
    public String cart(
            @AuthenticationPrincipal UserDetailsImpl userDetails,
            Model model
            ) {
        List<Book> cart = userService.getPrivateById(userDetails.getUser().getId()).getCart()
                .stream().map(bookService::getById)
                .toList();
        model.addAttribute("cart", cart);
        return "cart";
    }

    @PostMapping("/delete")
    public String deleteBook(
            @AuthenticationPrincipal UserDetailsImpl userDetails,
            @RequestParam Map<String, String> form
    ) {
        form.remove("_csrf");
        for (String key : form.keySet()) {
            userService.updateUserCartById(userDetails.getUser().getId(), Long.parseLong(key), false);
        }
        return "redirect:/cart";
    }

    @PostMapping("/create")
    public String createOrder(
            @AuthenticationPrincipal UserDetailsImpl userDetails,
            @RequestParam("address") String address,
            Model model
    ) {
        if (userDetails.getUser().getIsActiveStatus()) {
            model.addAttribute("status", true);
            User user = userService.getPrivateById(userDetails.getUser().getId());
            orderService.create(new Order(
                    address,
                    new ArrayList<>(user.getCart()),
                    user,
                    user.getCart()
                            .stream()
                            .map(bookService::getById)
                            .toList()
            ));
            userService.clearCartById(userDetails.getUser().getId());
        }
        return "redirect:/cart";
    }
}
