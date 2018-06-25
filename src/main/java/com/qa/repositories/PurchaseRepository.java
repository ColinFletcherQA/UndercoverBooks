package com.qa.repositories;

import com.qa.models.Purchase;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PurchaseRepository extends CrudRepository<Purchase, Integer> {

    @Query("SELECT p from Purchase p WHERE p.customer.customerId = :customerId")
    List<Purchase> getCustomerPurchaseHistory(@Param("customerId") int customerId);
}
