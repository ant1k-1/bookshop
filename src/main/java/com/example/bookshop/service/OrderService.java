package com.example.bookshop.service;

import com.example.bookshop.dto.OrderDTO;
import com.example.bookshop.model.Book;
import com.example.bookshop.model.Order;
import com.example.bookshop.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


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

    public List<OrderDTO> getByCustomerId(Long id) {
        return orderRepository.getOrdersByCustomer_Id(id)
                .stream().map(this::makeDTO).toList();
    }

    public List<OrderDTO> getDeliveredByCustomerId(Long id, Boolean isDelivered) {
        return orderRepository.getOrdersByCustomer_IdAndIsDelivered(id, isDelivered)
                .stream().map(this::makeDTO).toList();
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
        Map<Book, Integer> cartMapBooks = new HashMap<>();
        for (Long key : order.getBooks().keySet()) {
            cartMapBooks.put(bookService.getById(key), order.getBooks().get(key));
        }
        return new OrderDTO(
                order.getId(),
                order.getCreationDate(),
                order.getDeliverDate(),
                order.getAddress(),
                order.getPrice(),
                order.getFinalPrice(),
                order.getIsDelivered(),
                cartMapBooks,
                order.getCustomer()
        );
    }
}
