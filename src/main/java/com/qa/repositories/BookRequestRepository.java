package com.qa.repositories;

import com.qa.models.BookRequest;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BookRequestRepository extends CrudRepository<BookRequest, String> {
}
