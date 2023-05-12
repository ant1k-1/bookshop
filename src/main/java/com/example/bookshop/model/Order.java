package com.example.bookshop.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

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
    private List<Long> books = new ArrayList<>();

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private User customer;

    public Order(String address, List<Long> booksId, User customer, Collection<Book> booksObj) {
        this.address = address;
        this.books = booksId;
        this.customer = customer;

        this.creationDate = LocalDateTime.now();
        this.deliverDate = creationDate.plusDays(7);
        this.isDelivered = false;

        this.price = booksObj.stream()
                .map(Book::getPrice)
                .mapToDouble(Double::doubleValue)
                .sum();

        this.finalPrice = booksObj.stream()
                .map(Book::getFinalPrice)
                .mapToDouble(Double::doubleValue)
                .sum();
    }

    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", creationDate=" + creationDate +
                ", deliverDate=" + deliverDate +
                ", address='" + address + '\'' +
                ", price=" + price +
                ", finalPrice=" + finalPrice +
                ", isDelivered=" + isDelivered +
                ", books=" + books.stream().map(Object::toString).toList()+
                ", customer=" + customer.getUsername() +
                '}';
    }
}
