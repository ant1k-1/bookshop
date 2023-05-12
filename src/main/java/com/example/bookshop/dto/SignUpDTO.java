package com.example.bookshop.dto;

public record SignUpDTO(String username,
                        String password,
                        String email,
                        String name,
                        String birthDate) {
}
