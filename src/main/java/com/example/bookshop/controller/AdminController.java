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
        model.addAttribute("addBook", true);
        model.addAttribute("categories", Category.values());
        model.addAttribute("genres", Genre.values());
        return "admin";
    }

    @GetMapping("/add-book")
    public String addBook(Model model) {
        model.addAttribute("bookShow", false);
        model.addAttribute("userShow", false);
        model.addAttribute("addBook", true);
        model.addAttribute("categories", Category.values());
        model.addAttribute("genres", Genre.values());
        return "admin";
    }

    @GetMapping("/users")
    public String getUsers(Model model) {
        List<User> users = userService.getPrivateAll();
        model.addAttribute("bookShow", false);
        model.addAttribute("addBook", false);
        model.addAttribute("userShow", true);
        model.addAttribute("users", users);
        return "admin";
    }

    @GetMapping("/books")
    public String getBooks(Model model) {
        List<Book> books = bookService.getAll();
        model.addAttribute("bookShow", true);
        model.addAttribute("userShow", false);
        model.addAttribute("addBook", false);
        model.addAttribute("books", books.stream()
                .sorted(Comparator.comparing(Book::getId)).collect(Collectors.toList()));
        model.addAttribute("categories", Category.values());
        model.addAttribute("genres", Genre.values());
        return "admin";
    }

    @PostMapping(value = "/add-book")
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
        Set<String> genres = Arrays.stream(Genre.values())
                .map(Genre::name)
                .collect(Collectors.toSet());

        book.setCategory(Category.valueOf(form.get("category")));

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
        bookService.create(book);
        return "redirect:/admin";
    }

    @GetMapping("/users/{id}")
    public String userEditForm(
            @PathVariable("id") Long userId,
            Model model
    ) {
        User user = userService.getPrivateById(userId);
        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());
        return "userEdit";
    }

    @GetMapping("/books/{id}")
    public String bookEditForm(
            @PathVariable("id") Long bookId,
            Model model
    ) {
        Book book = bookService.getById(bookId);
        model.addAttribute("book", book);
        model.addAttribute("categories", Category.values());
        model.addAttribute("genres", Genre.values());
        return "bookEdit";
    }

    @GetMapping("/findBookById")
    public String redirectToBook(
            @RequestParam(value = "id", defaultValue = "0") Long id
    ) {
        if (id == 0 || !bookService.isExisted(id)){
            return "redirect:/admin/books";
        } else {
            return "redirect:/admin/books/" + id;
        }
    }

    @GetMapping("/findUserById")
    public String redirectToUserById(
            @RequestParam(value = "id", defaultValue = "0") Long id
    ) {
        if (id == 0 || !userService.isExisted(id)){
            return "redirect:/admin/users";
        } else {
            return "redirect:/admin/users/" + id;
        }
    }
    @GetMapping("/findUserByUsername")
    public String redirectToUserByUsername(
            @RequestParam(value = "username", defaultValue = "") String username
    ) {
        Long id = userService.isExisted(username);
        if (id == -1L || username.isEmpty()){
            return "redirect:/admin/users";
        } else {
            return "redirect:/admin/users/" + id;
        }
    }

    @PostMapping(value = "/books/{id}")
    public String updateBook(
            @PathVariable("id") Long bookId,
            @RequestParam("title") String title,
            @RequestParam("author") String author,
            @RequestParam("year") String year,
            @RequestParam("publisher") String publisher,
            @RequestParam("ISBN") String ISBN,
            @RequestParam("price") String price,
            @RequestParam("sale") String sale,
            @RequestParam("amount") String amount,
            @RequestParam("ageRestriction") String ageRestriction,
            @RequestParam("description") String description,
            @RequestParam Map<String, String> map
    ) {
        // Навалил некрасивую кучу кода
        bookService.editBookById(
                bookId,
                title,
                author,
                Integer.parseInt(year.replace("\u00a0", "")),
                publisher,
                ISBN,
                Double.parseDouble(price.replace("\u00a0", "")),
                Integer.parseInt(sale.replace("\u00a0", "")),
                Integer.parseInt(amount.replace("\u00a0", "")),
                Integer.parseInt(ageRestriction.replace("\u00a0", "")),
                description,
                Category.valueOf(map.keySet().stream()
                        .filter(s -> s.contains("CATEGORY"))
                        .findFirst()
                        .orElse("CATEGORY_MANGA")),
                map.keySet().stream()
                        .filter(s -> s.contains("GENRE"))
                        .map(Genre::valueOf)
                        .collect(Collectors.toSet())
        );
        return "redirect:/admin/books/" + bookId.toString();
    }

    @RequestMapping(value = "/users/{id}", method = RequestMethod.POST)
    public String updateUser(
            @PathVariable("id") Long userId,
            @RequestParam("username") String username,
            @RequestParam(value = "password", defaultValue = "nochange") String password,
            @RequestParam(value = "commentsAllowed", required = false) String commentsAllowed,
            @RequestParam(value = "activeStatus", required = false) String activeStatus,
            @RequestParam(value = "isModer",  required = false) String isModer,
            @RequestParam(value = "isAdmin",  required = false) String isAdmin
    ) {
        userService.editUserById(userId, username, password, commentsAllowed, activeStatus, isModer, isAdmin);
        return "redirect:/admin/users/" + userId.toString();
    }
}
