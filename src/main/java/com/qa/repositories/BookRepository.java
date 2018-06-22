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
    
	@Query(value = "SELECT * FROM Book WHERE image_l != 'https://s.gr-assets.com/assets/nophoto/book/111x148-bcc042a9c91a29c1d680899eff700a03.png' ORDER BY RAND() LIMIT 6", nativeQuery = true)
	List<Book> getSixRandomBooks();

	@Query("SELECT b FROM Book b WHERE b.title NOT LIKE '%Harry Potter%' ORDER BY b.ratings_5 DESC")
    List<Book> getBestSellers();

}
