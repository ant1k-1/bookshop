package com.example.bookshop.service;

import com.example.bookshop.model.Comment;
import com.example.bookshop.repository.CommentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Comparator;
import java.util.List;

@Service
public class CommentService {
    private final CommentRepository commentRepository;
    private final BookService bookService;

    @Autowired
    public CommentService(CommentRepository commentRepository, BookService bookService) {
        this.commentRepository = commentRepository;
        this.bookService = bookService;
    }

    public boolean isExisted(Long id) {
        return commentRepository.existsById(id);
    }

    public void create(Comment comment) {
        commentRepository.save(comment);
    }

    public Comment getById(Long id) {
        return commentRepository.findCommentById(id).orElse(null);
    }

    public List<Comment> getAll() {
        return commentRepository.findAll();
    }

    public List<Comment> getByAllUserId(Long id) {
        return commentRepository.findAllByUserId(id);
    }

    public List<Comment> getByAllBookId(Long id) {
        return commentRepository.findAllByBook_Id(id);
    }

    public void deleteById(Long id) {
        commentRepository.deleteById(id);
    }

    public List<Comment> getUnModerated() {
        return commentRepository.findAllByIsModeratedFalse()
                .stream().sorted(Comparator.comparing(Comment::getCreationDate)).toList();
    }

    public void update(Comment comment) {
        commentRepository.save(comment);
    }

}
