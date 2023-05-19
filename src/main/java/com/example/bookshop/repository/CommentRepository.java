package com.example.bookshop.repository;

import com.example.bookshop.model.Comment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Long> {
    Optional<Comment> findCommentById(Long id);

    List<Comment> findAllByUserId(Long id);

    List<Comment> findAllByUser_Username(String username);

    List<Comment> findAllByBook_Id(Long id);

    List<Comment> findAllByIsModeratedFalse();
}
