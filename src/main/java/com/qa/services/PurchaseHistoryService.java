package com.qa.services;

import com.qa.models.Customer;
import com.qa.models.Purchase;
import com.qa.repositories.PurchaseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PurchaseHistoryService {

    @Autowired
    private PurchaseRepository purchaseRepository;

    public Purchase makePurchase(Purchase purchase){
       return purchaseRepository.save(purchase);
    }

    public List<Purchase> getCustomerPurchaseHistory(Customer customer){

        return purchaseRepository.getCustomerPurchaseHistory(customer.getCustomerId());
    }

    public Purchase getPurchaseInformationById(int orderId){
        return purchaseRepository.findOne(orderId);
    }
}
