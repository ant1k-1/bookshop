package com.example.bookshop.service;

import com.example.bookshop.model.Comment;
import com.example.bookshop.repository.CommentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentService {
    private final CommentRepository commentRepository;

    @Autowired
    public CommentService(CommentRepository commentRepository) {
        this.commentRepository = commentRepository;
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

    public List<Comment> getByUserId(Long id) {
        return commentRepository.findAllByUserId(id);
    }

    public List<Comment> getByUsername(String username) {
        return commentRepository.findAllByUser_Username(username);
    }

    public List<Comment> getByBookId(Long id) {
        return commentRepository.findAllByBook_Id(id);
    }
}
