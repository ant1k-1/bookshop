package com.example.bookshop.repository;

import com.example.bookshop.enums.Category;
import com.example.bookshop.enums.Genre;
import com.example.bookshop.model.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.*;

@Repository
public interface BookRepository extends JpaRepository<Book, Long> {

    Optional<Book> findBookById(Long id);

    List<Book> findAllByPublisherContainingIgnoreCase(String publisher);

    List<Book> findAllByTitleContainingIgnoreCase(String title);

    List<Book> findAllByCategory(Category category);


    /**
     * Returns books where x.ageRestriction < age
     * @param age
     */
    List<Book> findAllByAgeRestrictionLessThan(Integer age);

    /**
     * Returns books where x.ageRestriction >= age
     * @param age
     */
    List<Book> findAllByAgeRestrictionGreaterThanEqual(Integer age);

    /**
     * Returns books where x.amount > amount
     * @param amount
     */
    List<Book> findAllByAmountGreaterThan(Integer amount);

    List<Book> findAllByGenresIn(Collection<Genre> genres);
}
