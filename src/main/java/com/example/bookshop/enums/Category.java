package com.example.bookshop.enums;

public enum Category {
    CATEGORY_MANGA,
    CATEGORY_EDUCATION,
    CATEGORY_SCIENCE,
    CATEGORY_COMIC,
    CATEGORY_FICTION,
    CATEGORY_KIDS,
    CATEGORY_SOCIETY,
    CATEGORY_HEALTH,
    CATEGORY_SOUL,
    CATEGORY_ART,
    CATEGORY_HOBBY,
    CATEGORY_BUSINESS;

    public String toRussian(Category category) {
        return switch (category) {
            case CATEGORY_ART -> "Искусство";
            case CATEGORY_SOUL -> "Философия и религия";
            case CATEGORY_KIDS -> "Книги для детей";
            case CATEGORY_HOBBY -> "Увлечения";
            case CATEGORY_COMIC -> "Комиксы";
            case CATEGORY_BUSINESS -> "Деловая литература";
            case CATEGORY_MANGA -> "Манга";
            case CATEGORY_HEALTH -> "Здоровье и красота";
            case CATEGORY_FICTION -> "Художественная литература";
            case CATEGORY_SCIENCE -> "Наука и техника";
            case CATEGORY_SOCIETY -> "Общество";
            case CATEGORY_EDUCATION -> "Образование";
        };
    }

    public String toRussian() {
        return switch (this) {
            case CATEGORY_ART -> "Искусство";
            case CATEGORY_SOUL -> "Философия и религия";
            case CATEGORY_KIDS -> "Книги для детей";
            case CATEGORY_HOBBY -> "Увлечения";
            case CATEGORY_COMIC -> "Комиксы";
            case CATEGORY_BUSINESS -> "Деловая литература";
            case CATEGORY_MANGA -> "Манга";
            case CATEGORY_HEALTH -> "Здоровье и красота";
            case CATEGORY_FICTION -> "Художественная литература";
            case CATEGORY_SCIENCE -> "Наука и техника";
            case CATEGORY_SOCIETY -> "Общество";
            case CATEGORY_EDUCATION -> "Образование";
        };
    }

}
