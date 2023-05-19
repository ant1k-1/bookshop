package com.example.bookshop.controller;

import com.example.bookshop.dto.SignUpDTO;
import com.example.bookshop.model.User;
import com.example.bookshop.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.Map;

@Controller
public class SignUpController {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public SignUpController(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/sign-up")
    public String signUp(Model model) {
        model.addAttribute("warn", false);
        return "sign-up";
    }

    @PostMapping("/sign-up")
    public String signUp(SignUpDTO user, Model model) {
        if (userRepository.existsByUsername(user.username()) || user.password().isEmpty() || user.email().isEmpty() ||
                user.name().isEmpty() || user.birthDate().isEmpty()) {
            model.addAttribute("warn", true);
            return "sign-up";
        }
        userRepository.save(
                new User(
                        user.username(),
                        passwordEncoder.encode(user.password()),
                        user.email(),
                        user.name(),
                        user.birthDate()
                )
        );
        return "redirect:/sign-up";
    }
}
