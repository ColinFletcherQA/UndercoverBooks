package com.qa.models;


import lombok.Getter;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Set;

@Entity
@Table(name = "Purchase")
public class Purchase {

    @Id @GeneratedValue @Getter
    private int orderId;

    @Getter @Setter
    @ManyToOne(cascade = {CascadeType.MERGE})
    @JoinColumn(name = "customerId")
    private Customer customer;

    @Getter @Setter
    @ManyToOne(cascade = {CascadeType.ALL})
    @JoinColumn(name = "addressId")
    private Address shippingAddress;

    @Autowired
    @ElementCollection @Getter @Setter @ManyToMany(fetch = FetchType.LAZY)
    private Set<Book> books;

    @Getter @Setter
    private BigDecimal totalPrice;

    @Getter @Setter
    private String cardNumber;

    @Getter @Setter
    private String cardName;

    @Getter @Setter
    private String cardType;

    @Getter @Setter
    private int time;
}
