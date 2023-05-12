package com.example.bookshop.service;

import com.example.bookshop.dto.OrderDTO;
import com.example.bookshop.model.Order;
import com.example.bookshop.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class OrderService {
    private final OrderRepository orderRepository;

    private final BookService bookService;

    @Autowired
    public OrderService(OrderRepository orderRepository,BookService bookService) {
        this.orderRepository = orderRepository;
        this.bookService = bookService;
    }

    public Order getById(Long id) {
        return orderRepository.getOrderById(id).orElse(null);
    }

    public List<Order> getByCustomerId(Long id) {
        return orderRepository.getOrdersByCustomer_Id(id);
    }

    public List<Order> getByCustomerUsername(String username) {
        return orderRepository.getOrdersByCustomer_Username(username);
    }

    public List<Order> getDeliveredByCustomerId(Long id, Boolean isDelivered) {
        return orderRepository.getOrdersByCustomer_IdAndIsDelivered(id, isDelivered);
    }

    public List<Order> getDeliveredByCustomerUsername(String username, Boolean isDelivered) {
        return orderRepository.getOrdersByCustomer_UsernameAndIsDelivered(username, isDelivered);
    }

    public Boolean isExisted(Long id) {
        return orderRepository.existsById(id);
    }

    public void create(Order order) {
        orderRepository.save(order);
    }

    public void closeById(Long id) {
        Order order = orderRepository.getOrderById(id).orElse(null);
        if (order == null) {
            return;
        }
        order.setIsDelivered(true);
        orderRepository.save(order);
    }

    public OrderDTO makeDTO(Order order) {
        return new OrderDTO(
                order.getId(),
                order.getCreationDate(),
                order.getDeliverDate(),
                order.getAddress(),
                order.getPrice(),
                order.getFinalPrice(),
                order.getIsDelivered(),
                order.getBooks()
                        .stream().map(bookService::getById).collect(Collectors.toList()),
                order.getCustomer()
        );
    }
}
