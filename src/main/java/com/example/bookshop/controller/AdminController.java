package com.example.bookshop.controller;

import com.example.bookshop.enums.Category;
import com.example.bookshop.enums.Genre;
import com.example.bookshop.enums.Role;
import com.example.bookshop.model.Book;
import com.example.bookshop.model.User;
import com.example.bookshop.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@RequestMapping("/admin")
@Controller
@PreAuthorize("hasAuthority('ROLE_ADMIN')")
public class AdminController {
    private final UserService userService;
    private final BookService bookService;
    private final OrderService orderService;
    private final CommentService commentService;

    @Value("${upload.path}")
    private String uploadPath;

    @Autowired
    public AdminController(UserService userService,
                           BookService bookService,
                           OrderService orderService,
                           CommentService commentService) {
        this.userService = userService;
        this.bookService = bookService;
        this.orderService = orderService;
        this.commentService = commentService;
    }

    @GetMapping
    public String adminPage(Model model) {
        model.addAttribute("bookShow", false);
        model.addAttribute("userShow", false);
        model.addAttribute("categories", Category.values());
        model.addAttribute("genres", Genre.values());
        return "admin";
    }

    @GetMapping("users")
    public String getUsers(Model model) {
        List<User> users = userService.getPrivateAll();
        model.addAttribute("bookShow", false);
        model.addAttribute("userShow", true);
        model.addAttribute("users", users);
        return "admin";
    }

    @GetMapping("books")
    public String getBooks(Model model) {
        List<Book> books = bookService.getAll();
        model.addAttribute("bookShow", true);
        model.addAttribute("userShow", false);
        model.addAttribute("books", books);
        model.addAttribute("categories", Category.values());
        model.addAttribute("genres", Genre.values());
        return "admin";
    }

    @PostMapping(value = "/books")
    public String addBook(
            @RequestParam("title") String title,
            @RequestParam("author_name") String authorName,
            @RequestParam("year") Integer year,
            @RequestParam("publisher") String publisher,
            @RequestParam("ISBN") String ISBN,
            @RequestParam("price") Double price,
            @RequestParam("sale") Integer sale,
            @RequestParam("amount") Integer amount,
            @RequestParam("age") Integer age,
            @RequestParam("description") String description,
            @RequestParam("file") MultipartFile file,
            @RequestParam Map<String, String> form
            ) throws IOException {
        Book book = new Book(
                title,
                authorName,
                year,
                publisher,
                ISBN,
                null,
                new HashSet<>(),
                price,
                sale,
                amount,
                age,
                description,
                null
        );
        Set<String> categories = Arrays.stream(Category.values())
                .map(Category::name)
                .collect(Collectors.toSet());
        Set<String> genres = Arrays.stream(Genre.values())
                .map(Genre::name)
                .collect(Collectors.toSet());

        for (String key : form.keySet()) {
            if (categories.contains(key)) {
                book.setCategory(Category.valueOf(key));
                break;
            }
        }

        for (String key : form.keySet()) {
            if (genres.contains(key)) {
                book.getGenres().add(Genre.valueOf(key));
            }
        }

        if (!file.isEmpty()){
            File uploadDir = new File(uploadPath);

            if (!uploadDir.exists()){
                uploadDir.mkdir();
            }

            String uuidFile = UUID.randomUUID().toString();
            String resultFilename = uuidFile + "_" + file.getOriginalFilename();

            file.transferTo(new File(uploadPath + "/" + resultFilename));

            book.setImage(resultFilename);
        }
        System.out.println("!!!!!!!!!!!\n" + book);
        bookService.create(book);
        return "redirect:/admin";
    }

    @GetMapping("users/{user}")
    public String userEditForm(@PathVariable User user, Model model) {
        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());
        return "userEdit";
    }

    @GetMapping("books/{book}")
    public String bookEditForm(@PathVariable Book book, Model model) {
        model.addAttribute("book", book);
        return "bookEdit";
    }
}
