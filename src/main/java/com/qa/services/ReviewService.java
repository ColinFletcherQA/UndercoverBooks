package com.qa.services;

import com.qa.models.Review;
import com.qa.repositories.ReviewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.TransactionCallbackWithoutResult;
import org.springframework.transaction.support.TransactionTemplate;

import javax.persistence.EntityManager;
import javax.persistence.Query;

@Service
public class ReviewService {

    @Autowired
    ReviewRepository reviewRepository;

    @Autowired
    private EntityManager em;

    @Autowired
    private PlatformTransactionManager platformTransactionManager;

    public Review postReview(Review review){
        return reviewRepository.save(review);
    }

    public void associateReview(int reviewId, int bookId){
        updateBookReviewTable(new TransactionCallbackWithoutResult() {
            @Override
            protected void doInTransactionWithoutResult(TransactionStatus transactionStatus) {
                Query query = em.createNativeQuery("INSERT INTO book_review (book_book_id, review_review_id) values (?, ?)");
                query.setParameter(1, bookId);
                query.setParameter(2, reviewId);
                query.executeUpdate();
            }
        });
    }

    @org.springframework.transaction.annotation.Transactional
    private void updateBookReviewTable(TransactionCallbackWithoutResult callbackWithoutResult){
        TransactionTemplate transactionTemplate = new TransactionTemplate(platformTransactionManager);
        transactionTemplate.execute(callbackWithoutResult);
    }
}
