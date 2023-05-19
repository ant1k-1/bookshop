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
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

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
        Map<Long, Integer> cartMap = userService.getPrivateById(userDetails.getUser().getId()).getCart();
        double cost = 0.0;
        Map<Book, Integer> cartMapBooks = new HashMap<>();
        for (Long key : cartMap.keySet()) {
            Book book = bookService.getById(key);
            Integer amount = cartMap.get(key);
            cost += book.getFinalPrice()*amount;
            cartMapBooks.put(book, amount);
        }
        model.addAttribute("cartMap", cartMapBooks);
        model.addAttribute("cost", cost);
        return "cart";
    }

    @PostMapping("/delete")
    public String deleteBook(
            @AuthenticationPrincipal UserDetailsImpl userDetails,
            @RequestParam Map<String, String> form
    ) {
        form.remove("_csrf");
        for (String key : form.keySet()) {
            if (key.contains("amount")){
                userService.updateUserCartById(userDetails.getUser().getId(),
                        Long.parseLong(key.replace("amount", "")),
                        Integer.parseInt(form.get(key)),
                        true);
            }
            if (key.contains("delete")) {
                userService.updateUserCartById(userDetails.getUser().getId(),
                        Long.parseLong(key.replace("delete", "")),
                        0,
                        false);
            }
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
                    new HashMap<>(user.getCart()),
                    user,
                    user.getCart()
                            .keySet()
                            .stream()
                            .map(bookService::getById)
                            .toList()
            ));
            for (Long bookId : user.getCart().keySet()) {
                Book book = bookService.getById(bookId);
                book.sold(user.getCart().get(bookId));
                bookService.update(book);
            }
            userService.clearCartById(userDetails.getUser().getId());
        }
        return "redirect:/cart";
    }
}
