package com.example.bookshop.dto;

public record BookDTO(Long id,
                      String title,
                      Double price,
                      Integer sale,
                      Double finalPrice,
                      String image,
                      Integer soldAmount,
                      Double rating) {
}
