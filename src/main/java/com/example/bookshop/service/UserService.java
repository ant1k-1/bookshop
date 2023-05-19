package com.example.bookshop.service;

import com.example.bookshop.dto.UserDTO;
import com.example.bookshop.enums.Role;
import com.example.bookshop.model.User;
import com.example.bookshop.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * Methods with "private" return User entity with private info.
 * Other methods return UserDTO.
 */
@Service
public class UserService {
    private final UserRepository userRepository;
    private final BookService bookService;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public UserService(UserRepository userRepository, BookService bookService, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.bookService = bookService;
        this.passwordEncoder = passwordEncoder;
    }

    public UserDTO getById(Long id){
        return userRepository.getReferenceById(id).makeDTO();
    }

    public Boolean isExisted(Long id) {
        return userRepository.existsById(id);
    }

    public Long isExisted(String username) {
        Optional<User> userOptional = userRepository.findByUsername(username);
        if (userOptional.isPresent()) {
            return userOptional.get().getId();
        }
        return -1L;
    }

    public List<UserDTO> getAll(){
        return userRepository.findAll().stream()
                .map(User::makeDTO)
                .collect(Collectors.toList());
    }

    public List<UserDTO> getAllCommentBlocked() {
        return userRepository.findAllByIsCommentsAllowedFalse()
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
        return userRepository.findByUsername(username).orElse(null);
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
            }
            userRepository.save(user);
        }
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
        if (email != null) {
            if (!email.equals(user.getEmail()) && !email.equals("nochange")) {
                user.setEmail(email);
                changed = true;
            }
        }
        if (name != null) {
            if (!name.equals(user.getName()) && !name.equals("nochange")) {
                user.setName(name);
                changed = true;
            }
        }
        if (changed) {
            userRepository.save(user);
        }
    }

    public void editUserById(
            Long id,
            String username,
            String password,
            String commentsAllowed,
            String activeStatus,
            String isModer,
            String isAdmin
    ) {
        boolean changed = false;
        User user = userRepository.getReferenceById(id);
        if (!username.equals(user.getUsername()) && !userRepository.existsByUsername(username)){
            user.setUsername(username);
            changed = true;
        }
        if (!password.equals("nochange")) {
            if (!passwordEncoder.encode(password).equals(user.getPassword())) {
                user.setPassword(passwordEncoder.encode(password));
                changed = true;
            }
        }
        if (activeStatus != null) {
            user.setIsActiveStatus(false);
            changed = true;
        } else if (!user.getIsActiveStatus()){
            user.setIsActiveStatus(true);
            changed = true;
        }
        if (commentsAllowed != null) {
            user.setIsCommentsAllowed(false);
            changed = true;
        } else if (!user.getIsCommentsAllowed()) {
            user.setIsCommentsAllowed(true);
            changed = true;
        }
        if (isModer != null) {
            user.getRoles().add(Role.ROLE_MODERATOR);
            changed = true;
        } else if (user.isModer()){
            user.getRoles().remove(Role.ROLE_MODERATOR);
            changed = true;
        }
        if (isAdmin != null) {
            user.getRoles().add(Role.ROLE_ADMIN);
            changed = true;
        }
        if (changed) {
            userRepository.save(user);
        }
    }
    public void accessCommentsById(Long userId, boolean access) {
        User user = userRepository.getReferenceById(userId);
        user.setIsCommentsAllowed(access);
        userRepository.save(user);
    }
}
