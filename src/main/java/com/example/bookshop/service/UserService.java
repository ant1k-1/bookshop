package com.example.bookshop.service;

import com.example.bookshop.dto.UserDTO;
import com.example.bookshop.model.User;
import com.example.bookshop.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * Methods with "private" return User entity with private info.
 * Other methods return UserDTO.
 */
@Service
public class UserService {
    private final UserRepository userRepository;
    private final BookService bookService;
    private final OrderService orderService;
    private final CommentService commentService;

    private final PasswordEncoder passwordEncoder;

    @Autowired
    public UserService(UserRepository userRepository,
                       BookService bookService,
                       OrderService orderService,
                       CommentService commentService,
                       PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.bookService = bookService;
        this.orderService = orderService;
        this.commentService = commentService;
        this.passwordEncoder = passwordEncoder;
    }

    public UserDTO getById(Long id){
        return userRepository.getReferenceById(id).makeDTO();
    }

    public List<UserDTO> getAll(){
        return userRepository.findAll()
                .stream()
                .map(User::makeDTO)
                .collect(Collectors.toList());
    }

    public User getPrivateById(Long id) {
        return userRepository.getReferenceById(id);
    }

    public List<User> getPrivateAll() {
        return userRepository.findAll();
    }

    public UserDTO getUserByUsername(String username) {
        return userRepository.findByUsername(username)
                .map(User::makeDTO)
                .orElse(null);
    }

    public User getPrivateUserByUsername(String username) {
        return userRepository.findByUsername(username)
                .orElse(null);
    }

    public void updateUserCartById(Long userId, Long bookId, Integer amount, boolean add) {
        if (bookService.isExisted(bookId)) {
            User user = userRepository.getReferenceById(userId);
            if (add) {
                user.getCart().put(bookId, amount);
            } else {
                user.getCart().remove(bookId);
            }
            userRepository.save(user);
        }
    }

    public void updateUserBookmarksById(Long userId, Long bookId, boolean add) {
        if (bookService.isExisted(bookId)){
            User user = userRepository.getReferenceById(userId);
            if (add && !user.getBookmarks().contains(bookId)) {
                user.getBookmarks().add(bookId);
            } else {
                user.getBookmarks().remove(bookId);
//                user.getBookmarks().clear();
            }
            userRepository.save(user);
        }
    }

    public boolean addCommentById(Long userId, Long commentId) {
        User user = userRepository.getReferenceById(userId);
        if (commentService.isExisted(commentId)) {
            user.getComments().add(commentService.getById(commentId));
            userRepository.save(user);
            return true;
        }
        return false;
    }

    public void clearCartById(Long id) {
        User user = userRepository.getReferenceById(id);
        user.getCart().clear();
        userRepository.save(user);
    }

    public void updateUserById(
            Long id,
            String oldPassword,
            String newPassword,
            String email,
            String name
    ) {
        boolean changed = false;
        User user = userRepository.getReferenceById(id);
        if (!oldPassword.equals("nochange") || !newPassword.equals("nochange")) {
            if (!passwordEncoder.encode(oldPassword).equals(user.getPassword())) {
                user.setPassword(passwordEncoder.encode(newPassword));
                changed = true;
            }
        }
        if (!email.equals(user.getEmail())) {
            user.setEmail(email);
            changed = true;
        }
        if (!name.equals(user.getName())) {
            user.setName(name);
            changed = true;
        }
        if (changed) {
            userRepository.save(user);
        }
    }

}
