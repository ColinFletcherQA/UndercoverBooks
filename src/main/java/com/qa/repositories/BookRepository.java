package com.qa.repositories;

import com.qa.models.Book;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BookRepository extends CrudRepository<Book, Integer> {

    @Query("SELECT b FROM Book b WHERE b.title LIKE CONCAT('%',:searchTerm,'%')")
    List<Book> findBookByPartOfTitle(@Param("searchTerm") String title);

    List<Book> findDistinctBookByTitle(String title);
}
