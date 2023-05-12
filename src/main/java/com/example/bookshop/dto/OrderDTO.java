package com.example.bookshop.dto;

import com.example.bookshop.model.Book;
import com.example.bookshop.model.User;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;

@Getter
@Setter
public class OrderDTO {
    private Long id;

    private LocalDateTime creationDate;

    private LocalDateTime deliverDate;

    private String address;

    private Double price;

    private Double finalPrice;

    private Boolean isDelivered;

    private Collection<Book> books;

    private User customer;

    public OrderDTO(Long id, LocalDateTime creationDate, LocalDateTime deliverDate, String address, Double price, Double finalPrice, Boolean isDelivered, Collection<Book> books, User customer) {
        this.id = id;
        this.creationDate = creationDate;
        this.deliverDate = deliverDate;
        this.address = address;
        this.price = price;
        this.finalPrice = finalPrice;
        this.isDelivered = isDelivered;
        this.books = books;
        this.customer = customer;
    }
}
