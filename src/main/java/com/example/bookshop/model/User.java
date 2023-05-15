package com.example.bookshop.model;

import com.example.bookshop.dto.UserDTO;
import com.example.bookshop.enums.Role;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Getter
@Setter
@NoArgsConstructor
@Table(name = "users")
@Entity
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String username;

    private String password;

    @ElementCollection(targetClass = Role.class, fetch = FetchType.EAGER)
    @CollectionTable(name = "user_role", joinColumns = @JoinColumn(name = "user_id"))
    @Enumerated(EnumType.STRING)
    private Set<Role> roles = new HashSet<>();

    private String email;

    private String name;

    private LocalDate birthDate;

    private LocalDateTime creationDate;

    private Boolean isActiveStatus;

    private Boolean isCommentsAllowed;

    @OneToMany(mappedBy = "customer", fetch = FetchType.EAGER)
    private Set<Order> orders = new HashSet<>();

    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name = "user_bookmarks")
    private Set<Long> bookmarks = new HashSet<>();

    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name = "user_cart")
    private Map<Long, Integer> cart = new HashMap<>();

    @OneToMany(mappedBy = "user", fetch = FetchType.EAGER)
    private Collection<Comment> comments = new ArrayList<>();

    public User(
            String username,
            String password,
            String email,
            String name,
            String birthday
    ) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        this.username = username;
        this.password = password;
        this.roles.add(Role.ROLE_CUSTOMER);
        this.email = email;
        this.name = name;
        this.birthDate = LocalDate.parse(birthday, formatter);
        this.creationDate = LocalDateTime.now();
        this.isActiveStatus = true;
        this.isCommentsAllowed = true;
    }
    public static User makeModer(String username, String password) {
        User user = new User();
        user.username = username;
        user.password = password;
        user.roles.add(Role.ROLE_CUSTOMER);
        user.roles.add(Role.ROLE_MODERATOR);
        user.creationDate = LocalDateTime.now();
        user.isActiveStatus = true;
        user.isCommentsAllowed = true;
        return user;
    }
    public static User makeAdmin(String username, String password) {
        User user = new User();
        user.username = username;
        user.password = password;
        user.roles.add(Role.ROLE_CUSTOMER);
        user.roles.add(Role.ROLE_ADMIN);
        user.roles.add(Role.ROLE_MODERATOR);
        user.creationDate = LocalDateTime.now();
        user.isActiveStatus = true;
        user.isCommentsAllowed = true;
        return user;
    }

    public UserDTO makeDTO() {
        return new UserDTO(
                id,
                username,
                roles,
                email,
                name,
                birthDate,
                creationDate,
                isActiveStatus,
                isCommentsAllowed,
                new ArrayList<>(orders),
                new HashMap<>(cart),
                new ArrayList<>(comments),
                new HashSet<>(bookmarks)
        );
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", roles=" + roles +
                ", email='" + email + '\'' +
                ", name='" + name + '\'' +
                ", birthDate=" + birthDate +
                ", creationDate=" + creationDate +
                ", isActiveStatus=" + isActiveStatus +
                ", isCommentsAllowed=" + isCommentsAllowed +
                ", orders ID=" + orders.stream().map(Order::getId).toList() +
                ", bookmarks ID=" + bookmarks.stream().toList() +
                ", cart ID=" + cart.keySet().stream().toList() +
                ", comments ID=" + comments.stream().map(Comment::getId).toList() +
                '}';
    }

    public boolean isAdmin() {
        return roles.contains(Role.ROLE_ADMIN);
    }

    public boolean isModer() {
        return roles.contains(Role.ROLE_MODERATOR);
    }

    public boolean isCommented(Long bookId) {
        return comments.stream().mapToLong(s -> s.getBook().getId()).anyMatch(s -> s == bookId);
    }
}
