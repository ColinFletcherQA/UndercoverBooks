package com.qa.services;

import com.qa.models.Book;
import com.qa.models.Customer;
import com.qa.models.Purchase;
import com.qa.repositories.PurchaseRepository;
import org.hibernate.annotations.Synchronize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.TransactionCallbackWithoutResult;
import org.springframework.transaction.support.TransactionTemplate;

import javax.persistence.EntityManager;
import javax.persistence.FlushModeType;
import javax.persistence.Query;
import javax.transaction.Transactional;
import java.util.List;
import java.util.Map;
import java.util.function.BiConsumer;

@Service
public class PurchaseHistoryService {

    @Autowired
    private PurchaseRepository purchaseRepository;

    @Autowired
    private EntityManager em;

    @Autowired
    private PlatformTransactionManager platformTransactionManager;

    public Purchase makePurchase(Purchase purchase, Map<Book, Integer> quantityMap){
       Purchase purchaseResponse = purchaseRepository.save(purchase);

       if(purchaseResponse != null){
            quantityMap.forEach((book, quantity) ->
                   updateBookPurchaseQuantity(
                           new TransactionCallbackWithoutResult() {
                               @Override
                               protected void doInTransactionWithoutResult(TransactionStatus transactionStatus) {
                                   Query query = em.createNativeQuery("UPDATE purchase_books p set p.quantity =? WHERE p.purchase_order_id =? AND p.books_book_id =? ;");
                                   query.setParameter(1, quantity);
                                   query.setParameter(2, purchaseResponse.getOrderId());
                                   query.setParameter(3, book.getBookId());
                                   query.executeUpdate();
                               }
                           }
                   )
            );
       }
       return purchaseResponse;
    }

    public List<Purchase> getCustomerPurchaseHistory(Customer customer){
        return purchaseRepository.getCustomerPurchaseHistory(customer.getCustomerId());
    }

    public Purchase getPurchaseInformationById(int orderId){
        return purchaseRepository.findOne(orderId);
    }

    @org.springframework.transaction.annotation.Transactional
    private void updateBookPurchaseQuantity(TransactionCallbackWithoutResult callbackWithoutResult){
        TransactionTemplate transactionTemplate = new TransactionTemplate(platformTransactionManager);
        transactionTemplate.execute(callbackWithoutResult);
    }
}
