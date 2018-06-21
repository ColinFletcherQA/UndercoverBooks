package com.qa.models;


import lombok.Getter;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;

import javax.persistence.*;
import java.math.BigInteger;
import java.util.List;

@Entity
@Table(name = "Purchase")
public class Purchase {

    @Id @GeneratedValue @Getter
    private int orderId;

    @Getter @Setter
    @ManyToOne
    @JoinColumn(name = "customerId")
    private Customer customer;

    @Getter @Setter
    @ManyToOne
    @JoinColumn(name = "addressId")
    private Address shippingAddress;

    @Autowired @ElementCollection(targetClass = Book.class) @Getter @Setter
    private List<Book> books;

    @Getter @Setter
    private BigInteger totalPrice;

    @Getter @Setter
    private int time;

}
