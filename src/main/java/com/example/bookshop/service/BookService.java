package com.example.bookshop.service;

import com.example.bookshop.dto.BookDTO;
import com.example.bookshop.enums.Category;
import com.example.bookshop.enums.Genre;
import com.example.bookshop.model.Book;
import com.example.bookshop.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class BookService {
    private final BookRepository bookRepository;

    @Autowired
    public BookService(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    public List<Book> getAll() {
        return bookRepository.findAll();
    }

    public void create(Book book) {
        bookRepository.save(book);
    }

    public Book getById(Long id) {
        return bookRepository.findBookById(id).orElse(null);
    }

    public List<Book> getByPublisher(String publisher) {
        return bookRepository.findAllByPublisherContainingIgnoreCase(publisher);
    }

    public List<Book> getByTitle(String title) {
        return bookRepository.findAllByTitleContainingIgnoreCase(title);
    }

    public List<Book> getByCategory(Category category) {
        return bookRepository.findAllByCategory(category);
    }

    public List<Book> getByAgeRestriction(Integer age, Boolean LessThen) {
        return LessThen ? bookRepository.findAllByAgeRestrictionLessThan(age) :
                bookRepository.findAllByAgeRestrictionGreaterThanEqual(age);
    }

    public List<Book> getByAmount(Integer amountGreaterThan) {
        return bookRepository.findAllByAmountGreaterThan(amountGreaterThan);
    }

    public List<Book> getByGenres(Set<Genre> genres) {
        return bookRepository.findAllByGenresIn(genres);
    }

    public Boolean isExisted(Long id) {
        return bookRepository.existsById(id);
    }

    /**
     *
     * @return [0] - topRate, [1] topSold
     */
    public List<List<BookDTO>> getTrending() {
        List<BookDTO> books = bookRepository.findAll()
                .stream().map(Book::makeDTO).toList();
        List<BookDTO> topRate = books.stream()
                .sorted(Comparator.comparingDouble(BookDTO::rating).reversed())
                .toList();
        if (topRate.size() > 3) {
            topRate = topRate.subList(0, 3);
        }
        List<BookDTO> topSold = books.stream()
                .sorted(Comparator.comparing(BookDTO::soldAmount).reversed())
                .toList();
        if (topSold.size() > 3) {
            topSold = topSold.subList(0, 3);
        }
        List<List<BookDTO>> trending = new ArrayList<>();
        trending.add(topRate);
        trending.add(topSold);
        return trending;
    }

    public void update(Book book) {
        bookRepository.save(book);
    }
}
