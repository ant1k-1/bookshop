package com.example.bookshop.controller;

import com.example.bookshop.dto.UserDTO;
import com.example.bookshop.enums.Role;
import com.example.bookshop.model.Order;
import com.example.bookshop.model.UserDetailsImpl;
import com.example.bookshop.service.BookService;
import com.example.bookshop.service.CommentService;
import com.example.bookshop.service.OrderService;
import com.example.bookshop.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.Comparator;

@RequestMapping("/profile")
@Controller
public class ProfileController {
    private final UserService userService;
    private final CommentService commentService;
    private final BookService bookService;

    private final OrderService orderService;

    @Autowired
    public ProfileController(UserService userService,
                             CommentService commentService,
                             BookService bookService,
                             OrderService orderService
    ) {
        this.userService = userService;
        this.commentService = commentService;
        this.bookService = bookService;
        this.orderService = orderService;
    }

    @GetMapping
    public String profile(
            @AuthenticationPrincipal UserDetailsImpl userDetails,
            Model model
    ) {
        UserDTO user = userService.getById(userDetails.getUser().getId());
        model.addAttribute("user", user);
        model.addAttribute("deliveredOrders",
                user
                        .getOrders()
                        .stream()
                        .filter(Order::getIsDelivered)
                        .sorted(Comparator.comparing(Order::getCreationDate))
                        .map(orderService::makeDTO)
                        .toList()
                );
        model.addAttribute("unDeliveredOrders",
                user
                        .getOrders()
                        .stream()
                        .filter(order -> !order.getIsDelivered())
                        .sorted(Comparator.comparing(Order::getCreationDate))
                        .map(orderService::makeDTO)
                        .toList()
        );
        model.addAttribute("orders",
                user
                        .getOrders()
                        .stream()
                        .map(orderService::makeDTO)
                        .toList()
        );
        return "profile";
    }

    @RequestMapping(value = "/close-order/{id}", method = RequestMethod.POST)
    public String closeOrder(
            @PathVariable("id") Long orderId
    ) {
        orderService.closeById(orderId);
        return "redirect:/profile";
    }

    @PostMapping("/edit")
    public String editUser(
            @AuthenticationPrincipal UserDetailsImpl userDetails,
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("oldPassword") String oldPassword,
            @RequestParam("newPassword") String newPassword
    ) {
        if (userDetails.getUser().getRoles().contains(Role.ROLE_ADMIN) || userDetails.getUser().getRoles().contains(Role.ROLE_MODERATOR)){
//            userService.updateUserById(
//                    userDetails.getUser().getId(),
//                    oldPassword,
//                    newPassword,
//                    null,
//                    null
//            );
            System.out.println(oldPassword);
            System.out.println(newPassword);
        } else {
//            userService.updateUserById(
//                    userDetails.getUser().getId(),
//                    oldPassword,
//                    newPassword,
//                    email,
//                    name
//            );
            System.out.println(name);
            System.out.println(email);
            System.out.println(oldPassword);
            System.out.println(newPassword);
        }
        return "redirect:/profile";
    }

}
