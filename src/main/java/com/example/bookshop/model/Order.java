package com.example.bookshop.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.*;

@Getter
@Setter
@NoArgsConstructor
@Table(name = "orders")
@Entity
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private LocalDateTime creationDate;

    private LocalDateTime deliverDate;

    private String address;

    private Double price;

    private Double finalPrice;

    private Boolean isDelivered;

    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name = "order_books")
    private Map<Long, Integer> books = new HashMap<>();

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private User customer;

    public Order(String address, Map<Long, Integer> cartMap, User customer,  Collection<Book> booksObj) {
        this.address = address;
        this.books = cartMap;
        this.customer = customer;

        this.creationDate = LocalDateTime.now();
        this.deliverDate = creationDate.plusDays(7);
        this.isDelivered = false;
        this.price = 0.0;
        this.finalPrice = 0.0;

        for (Book book : booksObj) {
            this.price += book.getPrice()*cartMap.get(book.getId());
        }

        for (Book book : booksObj) {
            this.finalPrice += book.getPrice()*cartMap.get(book.getId());
        }
    }
}
