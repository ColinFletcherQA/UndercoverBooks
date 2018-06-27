package com.qa.models;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
public class Review {

    @Id @GeneratedValue @Getter
    private int reviewId;

    @ManyToOne
    @JoinColumn(name = "customerId")
    @Setter @Getter
    public Customer customer;

    @Getter @Setter
    private String review;

    @Getter @Setter
    private int rating;

    @Getter @Setter
    private int time;

    public Review(){}

    public Review(Customer customer, String review, int rating, int time){
        this.customer = customer;
        this.review = review;
        this.rating = rating;
        this.time = time;
    }

}
