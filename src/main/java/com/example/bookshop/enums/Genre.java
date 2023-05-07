package com.example.bookshop.model;

public enum Genre {
    GENRE_COMEDY,
    GENRE_DRAMA,
    GENRE_THRILLER,
    GENRE_DETECTIVE,
    GENRE_FANTASY,
    GENRE_MELODRAMA,
    GENRE_SCIENCE_FICTION;

    public String toRussian(Genre genre){
        return switch (genre) {
            case GENRE_COMEDY -> "Комедия";
            case GENRE_DRAMA -> "Драма";
            case GENRE_FANTASY -> "Фентэзи";
            case GENRE_THRILLER -> "Триллер";
            case GENRE_DETECTIVE -> "Детектив";
            case GENRE_MELODRAMA -> "Мелодрама";
            case GENRE_SCIENCE_FICTION -> "Научная фантастика";
        };
    }
}
