package com.example.bookshop.controller;

import com.example.bookshop.dto.UserDTO;
import com.example.bookshop.enums.Role;
import com.example.bookshop.model.UserDetailsImpl;
import com.example.bookshop.service.OrderService;
import com.example.bookshop.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


@RequestMapping("/profile")
@Controller
public class ProfileController {
    private final UserService userService;

    private final OrderService orderService;

    @Autowired
    public ProfileController(UserService userService, OrderService orderService) {
        this.userService = userService;
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
                orderService.getDeliveredByCustomerId(user.getId(), true)
        );
        model.addAttribute("unDeliveredOrders",
                orderService.getDeliveredByCustomerId(user.getId(), false)
        );
        model.addAttribute("orders", orderService.getByCustomerId(user.getId()));
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
            @RequestParam(value = "name", defaultValue = "nochange") String name,
            @RequestParam(value = "email", defaultValue = "nochange") String email,
            @RequestParam(value = "oldPassword", defaultValue = "nochange") String oldPassword,
            @RequestParam(value = "newPassword", defaultValue = "nochange") String newPassword
    ) {
        if (userDetails.getUser().getRoles().contains(Role.ROLE_ADMIN) ||
                userDetails.getUser().getRoles().contains(Role.ROLE_MODERATOR)
        ){
            userService.updateUserById(userDetails.getUser().getId(), oldPassword, newPassword, null, null);
        } else {
            userService.updateUserById(userDetails.getUser().getId(), oldPassword,newPassword, email, name);
        }
        return "redirect:/profile";
    }

}
