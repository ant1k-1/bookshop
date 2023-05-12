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

    private Integer bonuses;

    private Integer cashbackLevel;

    private Double totalCost;

    @OneToMany(mappedBy = "customer", fetch = FetchType.EAGER)
    private Collection<Order> orders = new ArrayList<>();

    @ElementCollection(targetClass = Long.class, fetch = FetchType.EAGER)
    @CollectionTable(name = "user_bookmarks", joinColumns = @JoinColumn(name = "user_id"))
    private Collection<Long> bookmarks = new ArrayList<>();

//    С корзиной все работает нормально - в таблице user_cart два столбца: user_id и cart
//    В cart лежат id книжек
    @ElementCollection(targetClass = Long.class, fetch = FetchType.EAGER)
    @CollectionTable(name = "user_cart", joinColumns = @JoinColumn(name = "user_id"))
    private Collection<Long> cart = new ArrayList<>();

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
        this.bonuses = 0;
        this.cashbackLevel = 0;
        this.totalCost = 0D;
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
                bonuses,
                cashbackLevel,
                totalCost,
                orders,
                cart,
                comments,
                bookmarks
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
                ", bonuses=" + bonuses +
                ", cashbackLevel=" + cashbackLevel +
                ", totalCost=" + totalCost +
                ", orders=" + orders +
                ", bookmarks=" + bookmarks +
                ", comments=" + comments +
                '}';
    }

    public boolean isAdmin() {
        return roles.contains(Role.ROLE_ADMIN);
    }

    public boolean isModer() {
        return roles.contains(Role.ROLE_MODERATOR);
    }
}
