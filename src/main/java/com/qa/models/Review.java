package com.qa.models;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
public class Review {

    @Id @GeneratedValue @Getter
    private String reviewId;

    @ManyToOne
    @JoinColumn(name = "customerId")
    @Setter @Getter
    public Customer customer;

    @Getter @Setter
    private String review;

    @Getter @Setter
    private int rating;

    public Review(Customer customer, String review, int rating){
        this.customer = customer;
        this.review = review;
        this.rating = rating;
    }

}
