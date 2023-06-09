package com.example.bookshop.dto;

import com.example.bookshop.enums.Role;
import com.example.bookshop.model.Book;
import com.example.bookshop.model.Comment;
import com.example.bookshop.model.Order;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;

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
    private Collection<Order> orders;
    private Map<Long, Integer> cart;
    private Collection<Comment> comments;
    private Set<Long> bookmarks;

    public boolean isCommented(Long bookId) {
        return comments.stream().mapToLong(s -> s.getBook().getId()).anyMatch(s -> s == bookId);
    }

    public boolean isBookmarked(Long bookId) {
        return bookmarks.contains(bookId);
    }

    public boolean isCarted(Long bookId) {
        return cart.containsKey(bookId);
    }

    public boolean isAdmin() {
        return roles.contains(Role.ROLE_ADMIN);
    }

    public boolean isModerator() {
        return roles.contains(Role.ROLE_MODERATOR);
    }
}
