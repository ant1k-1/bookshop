package com.example.bookshop.model;

import com.example.bookshop.dto.BookDTO;
import com.example.bookshop.dto.CommentDTO;
import com.example.bookshop.enums.Category;
import com.example.bookshop.enums.Genre;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Getter
@Setter
@NoArgsConstructor
@Table(name = "books")
@Entity
public class Book {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;

    private String author;

    private Integer year;

    private String publisher;

    private String ISBN;

    private Category category;

    @ElementCollection(targetClass = Genre.class, fetch = FetchType.EAGER)
    @CollectionTable(name = "book_genre", joinColumns = @JoinColumn(name = "book_id"))
    @Enumerated(EnumType.STRING)
    private Set<Genre> genres;

    private Double price;

    private Integer sale;

    private Double finalPrice;

    private Integer amount;

    private Integer ageRestriction;

    @OneToMany(cascade = CascadeType.REMOVE, fetch = FetchType.LAZY, mappedBy = "book")
    private Collection<Comment> comments = new ArrayList<>();

    @ElementCollection
    @CollectionTable(name = "ratesOfBook")
    private List<Integer> rates = new ArrayList<>();

    private Double rating;

    private String description;

    private String image;

    private Integer soldAmount;

    public Book(String title,
                String author,
                Integer year,
                String publisher,
                String ISBN,
                Category category,
                Set<Genre> genres,
                Double price,
                Integer sale,
                Integer amount,
                Integer ageRestriction,
                String description,
                String image
    ) {
        this.title = title;
        this.author = author;
        this.year = year;
        this.publisher = publisher;
        this.ISBN = ISBN;
        this.category = category;
        this.genres = genres;
        this.price = price;
        this.sale = sale;
        this.amount = amount;
        this.ageRestriction = ageRestriction;
        this.description = description;
        this.image = image;

        this.finalPrice = price - (price/100d * sale);
        this.rating = -1.0;
        this.soldAmount = 0;
    }

    public void updateRating(Integer rate) {
        rates.add(rate);
        this.rating = (double) rates.stream()
                .mapToInt(Integer::intValue)
                .sum() / (double) rates.size();
    }

    public void updateSaleAndFinalPrice(Integer sale) {
        this.sale = sale;
        this.finalPrice = price - (price/100d * sale);
    }

    public void updateFinalPrice() {
        this.finalPrice = price - (price/100d * sale);
    }

    public void buy() {
        this.soldAmount += 1;
    }

    public BookDTO makeDTO() {
        return new BookDTO(
                id,
                title,
                price,
                sale,
                finalPrice,
                image,
                soldAmount,
                rating,
                amount
        );
    }

    @Override
    public String toString() {
        return "Book{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", author='" + author + '\'' +
                ", year=" + year +
                ", publisher='" + publisher + '\'' +
                ", ISBN='" + ISBN + '\'' +
                ", category=" + category +
                ", genres=" + genres +
                ", price=" + price +
                ", sale=" + sale +
                ", finalPrice=" + finalPrice +
                ", amount=" + amount +
                ", ageRestriction=" + ageRestriction +
                ", comments=" + comments +
                ", rates=" + rates +
                ", rating=" + rating +
                ", description='" + description + '\'' +
                ", image='" + image + '\'' +
                ", soldAmount=" + soldAmount +
                '}';
    }

    public String toStringGenres() {
        if (!genres.isEmpty()) {
            StringBuilder string = new StringBuilder();
            for (Genre genre : genres) {
                string.append(genre.toRussian(genre)).append(", ");
            }
            string.delete(string.lastIndexOf(","), string.length());
            return string.toString();
        }
        return "";
    }

    public void sold(Integer amount) {
        this.soldAmount += amount;
        this.amount -= amount;
    }

    public void removeComment(Integer rate) {
        this.rates.remove(rate);
        if (rates.isEmpty()) {
            this.rating = -1.0;
        } else {
            this.rating = (double) rates.stream()
                    .mapToInt(Integer::intValue)
                    .sum() / (double) rates.size();
        }
    }
}
