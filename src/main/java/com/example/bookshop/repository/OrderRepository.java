package com.example.bookshop.repository;

import com.example.bookshop.model.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
    Optional<Order> getOrderById(Long id);
    List<Order> getOrdersByCustomer_Id(Long id);

    List<Order> getOrdersByCustomer_Username(String username);

    List<Order> getOrdersByCustomer_IdAndIsDelivered(Long id, Boolean isDelivered);

    List<Order> getOrdersByCustomer_UsernameAndIsDelivered(String username, Boolean isDelivered);
}
