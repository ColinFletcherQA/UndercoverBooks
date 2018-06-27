package com.qa.services;

import com.qa.models.Review;
import com.qa.repositories.ReviewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReviewService {

    @Autowired
    ReviewRepository reviewRepository;

    public Review postReview(Review review){
        return reviewRepository.save(review);
    }
}
