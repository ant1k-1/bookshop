package com.example.bookshop.enums;

public enum Role {
    ROLE_CUSTOMER, ROLE_ADMIN, ROLE_MODERATOR;
    public String toString(Role role) {
        return switch (role){
            case ROLE_ADMIN -> "Админ";
            case ROLE_CUSTOMER -> "Покупатель";
            case ROLE_MODERATOR -> "Модератор";
        };
    }
}
