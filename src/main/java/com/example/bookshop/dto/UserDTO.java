package com.example.bookshop.dto;

import com.example.bookshop.enums.Role;
import com.example.bookshop.model.Book;
import com.example.bookshop.model.Comment;
import com.example.bookshop.model.Order;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Set;

@Getter
@Setter
@AllArgsConstructor
public class UserDTO {
    private Long id;
    private String username;
    private Set<Role> roles;
    private String email;
    private String name;
    private LocalDate birthDate;
    private LocalDateTime creationDate;
    private Boolean isActiveStatus;
    private Boolean isCommentsAllowed;
    private Integer bonuses;
    private Integer cashbackLevel;
    private Double totalCost;
    private Collection<Order> orders;
    private Collection<Long> cart;
    private Collection<Comment> comments;
    private Collection<Long> bookmarks;

    public boolean isCommented(Long bookId) {
        return comments.stream().mapToLong(s -> s.getBook().getId()).anyMatch(s -> s == bookId);
    }

    public boolean isAdmin() {
        return roles.contains(Role.ROLE_ADMIN);
    }

    public boolean isModerator() {
        return roles.contains(Role.ROLE_MODERATOR);
    }
}
