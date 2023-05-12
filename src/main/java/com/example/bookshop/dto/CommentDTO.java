package com.example.bookshop.dto;

public record CommentDTO(
        String title,
        String text,
        Integer rate
) {
}
