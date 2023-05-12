package com.example.bookshop.model;


import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Getter
@Setter
@NoArgsConstructor
@Table(name = "comments")
@Entity
public class Comment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "book_id")
    private Book book;

    private String title;

    private Integer rate;

    private String text;

    private LocalDateTime creationDate;

    private Integer likes;

    private Integer dislikes;

    private Boolean isModerated;

    public Comment(User user, Book book, String title, Integer rate, String text) {
        this.user = user;
        this.book = book;
        book.updateRating(rate);
        this.title = title;
        this.rate = rate;
        this.text = text;
        this.creationDate = LocalDateTime.now();
        this.likes = 0;
        this.dislikes = 0;
        this.isModerated = user.isAdmin();

    }

    public String formatDate() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd.MM.yyyy");
        return creationDate.format(formatter) + " в " + creationDate.getHour() + ":" + creationDate.getMinute();
    }

    @Override
    public String toString() {
        return "Comment{" +
                "id=" + id +
                ", user=" + user.getUsername() +
                ", book=" + book.getTitle() +
                ", title='" + title + '\'' +
                ", rate=" + rate +
                ", text='" + text + '\'' +
                ", creationDate=" + creationDate +
                ", likes=" + likes +
                ", dislikes=" + dislikes +
                ", isModerated=" + isModerated +
                '}';
    }
}