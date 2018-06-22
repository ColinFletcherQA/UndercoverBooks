package com.qa.models;


import lombok.Getter;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;

import javax.persistence.*;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
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
    private BigDecimal totalPrice;

    @Getter @Setter
    private int cardNumber;

    @Getter @Setter
    private String cardName;

    @Getter @Setter
    private String cardType;

    @Getter @Setter
    private int time;

}
