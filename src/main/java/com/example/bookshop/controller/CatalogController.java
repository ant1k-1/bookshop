package com.example.bookshop.controller;

import com.example.bookshop.dto.BookDTO;
import com.example.bookshop.enums.Category;
import com.example.bookshop.enums.Genre;
import com.example.bookshop.model.Book;
import com.example.bookshop.model.UserDetailsImpl;
import com.example.bookshop.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.annotation.CurrentSecurityContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@RequestMapping("/catalog")
@Controller
public class CatalogController {
    private final BookService bookService;

    @Autowired
    public CatalogController(BookService bookService) {
        this.bookService = bookService;
    }

    @GetMapping
    public String books(
            @CurrentSecurityContext(expression = "authentication?.name") String username,
            @AuthenticationPrincipal UserDetailsImpl userDetails,
            @RequestParam(name = "searchBar", required = false, defaultValue = "") String searchBar,
            @RequestParam(required = false, defaultValue = "{}") Map<String, String> formFilter,
            Model model
    ) {
        if (username.equals("anonymousUser")) {
            model.addAttribute("logged", false);
            model.addAttribute("userId", -1);
        }
        else {
            model.addAttribute("logged", true);
            model.addAttribute("userId", userDetails.getUser().getId());
        }
        List<String> categoriesForm = formFilter.keySet().stream()
                .filter(s -> s.contains("CATEGORY")).toList();

        List<String> genresForm = formFilter.keySet().stream()
                .filter(s -> s.contains("GENRE")).toList();
        boolean sortReverse = formFilter
                .getOrDefault("sortingType", "sortReverse").equals("sortReverse");

        boolean reset = formFilter.getOrDefault("reset", "false").equals("true");

        String sortingBy = formFilter.getOrDefault("sorting", "sortByShuffle");

        model.addAttribute("stringActiveCategories", parseCategories(categoriesForm));
        model.addAttribute("stringActiveGenres", parseGenres(genresForm));

        model.addAttribute("sortingType", sortReverse);
        model.addAttribute("sortBy", switch (sortingBy) {
            case "sortByYear" -> "по году издания";
            case "sortByPrice" -> "по цене";
            case "sortByRating" -> "по рейтингу";
            default -> "в перемешку";
        } );
        // Make radios checked if sortBy is chosen
        model.addAttribute("sortByYear", sortingBy.equals("sortByYear") && !reset ? "checked" : "");
        model.addAttribute("sortByPrice", sortingBy.equals("sortByPrice") && !reset ? "checked" : "");
        model.addAttribute("sortByRating", sortingBy.equals("sortByRating") && !reset ? "checked" : "");
        model.addAttribute("sortByShuffle", sortingBy.equals("sortByShuffle") ? "checked" : "");

        // Make radios checked if sortType is different from default
        model.addAttribute("sortingType", sortReverse && !reset);

        model.addAttribute("categories", Category.values());
        model.addAttribute("genres", Genre.values());

        Map<Genre, String> genreStringMap = new HashMap<>();
        for (var genre : Genre.values()) {
            genreStringMap.put(genre, genresForm.contains(genre.toString()) && !reset ? "checked" : "");
        }

        Map<Category, String> categoryStringMap = new HashMap<>();
        for (var category : Category.values()) {
            categoryStringMap.put(category, categoriesForm.contains(category.toString()) && !reset ? "checked" : "");
        }

        model.addAttribute("searchBar", searchBar);
        List<BookDTO> bookDTOS = getByFilter(searchBar, categoriesForm, genresForm, sortingBy, sortReverse);
        model.addAttribute("books", bookDTOS);
        model.addAttribute("genreStringMap", genreStringMap);
        model.addAttribute("categoryStringMap", categoryStringMap);
        return "catalog";
    }

    public List<BookDTO> getByFilter(String searchBar, List<String> categoriesForm, List<String> genresForm, String sortingType, boolean sortReverse) {
        Stream<Book> bookStream = bookService.getAll().stream();
        if (!searchBar.isEmpty()) {
            bookStream = bookStream.filter(book ->
                    book.getTitle().toLowerCase().contains(searchBar.toLowerCase()) ||
                    book.getAuthor().toLowerCase().contains(searchBar.toLowerCase()));
        }
        if (!categoriesForm.isEmpty()) {
            bookStream = bookStream.filter(
                    book -> categoriesForm
                            .stream()
                            .map(Category::valueOf)
                            .collect(Collectors.toSet())
                            .contains(book.getCategory())
            );
        }

        if (!genresForm.isEmpty()) {
            bookStream = bookStream.filter(
                    book -> book.getGenres().stream().anyMatch(
                            genre -> genresForm
                                    .stream()
                                    .map(Genre::valueOf)
                                    .toList()
                                    .contains(genre)
                    )
            );
        }
        switch (sortingType) {
            case "sortByYear" -> bookStream = sortReverse ? bookStream.sorted(Comparator.comparingInt(Book::getYear).reversed()) :
                    bookStream.sorted(Comparator.comparing(Book::getYear));
            case "sortByPrice" -> bookStream = sortReverse ? bookStream.sorted(Comparator.comparingDouble(Book::getFinalPrice).reversed()) :
                    bookStream.sorted(Comparator.comparing(Book::getFinalPrice));
            case "sortByRating" -> bookStream = sortReverse ? bookStream.sorted(Comparator.comparingDouble(Book::getRating).reversed()) :
                    bookStream.sorted(Comparator.comparing(Book::getRating));
        }

        List<Book> bookList = bookStream.collect(Collectors.toList());
        if (sortingType.equals("sortByShuffle")) {
            Collections.shuffle(bookList, new Random(LocalDateTime.now().getSecond()));
        }
        return bookList.stream().map(Book::makeDTO).toList();
    }

    public String parseCategories(List<String> categoryList){
        StringBuilder categories = new StringBuilder();
        for (String category : categoryList) {
            categories.append(Category.valueOf(category).toRussian()).append(", ");
        }
        if (!categories.isEmpty()) {
            categories.delete(categories.lastIndexOf(","), categories.length());
        }
        return categories.toString();
    }

    public String parseGenres(List<String> genreList) {
        StringBuilder genres = new StringBuilder();
        for (String key : genreList) {
            genres.append(Genre.valueOf(key).toRussian()).append(", ");
        }
        if (!genres.isEmpty()) {
            genres.delete(genres.lastIndexOf(","), genres.length());
        }
        return genres.toString();
    }

}
