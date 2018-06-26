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
    List<Book> findAllBooksByPartOfTitle(@Param("searchTerm") String title);

    List<Book> findAllBooksByIsbn(@Param("searchTerm") String isbn);

    List<Book> findAllBooksByPaperISBN(@Param("searchTerm") String isbn);

    List<Book> findAllBooksByEBookISBN(@Param("searchTerm") String isbn);

    @Query("SELECT b FROM Book b, Author a WHERE a MEMBER OF b.authors AND a.authorName LIKE CONCAT('%',:searchTerm,'%')")
    List<Book> findAllBooksByAuthorsName(@Param("searchTerm") String authorName);

    @Query("SELECT b FROM Book b WHERE b.publisher LIKE CONCAT('%',:searchTerm,'%')")
    List<Book> findAllBooksByPartOfPublisher(@Param("searchTerm") String publisher);

    @Query("SELECT b FROM Book b WHERE b.description LIKE CONCAT('%',:searchTerm,'%')")
    List<Book> findAllBooksByPartOfDescription(@Param("searchTerm") String description);
    
	@Query(value = "SELECT * FROM Book WHERE image_l != 'https://s.gr-assets.com/assets/nophoto/book/111x148-bcc042a9c91a29c1d680899eff700a03.png' ORDER BY RAND() LIMIT 12", nativeQuery = true)
	List<Book> getSixRandomBooks();

    @Query("SELECT b FROM Book b WHERE b.title NOT LIKE '%Harry Potter%' ORDER BY b.ratings_5 DESC")
    List<Book> getBestSellers();

    @Query("SELECT b FROM Book b ORDER BY b.publishedDate DESC")
    List<Book> getNewReleases();

    @Query(value = "SELECT b.* FROM book b, tag t, book_tags bt WHERE t.tag_name = :tag_name " +
            "AND b.book_id = bt.book_book_id AND t.tag_id = bt.tags_tag_id ORDER BY bt.count DESC", nativeQuery = true)
    List<Book> findAllBooksByTagName(@Param("tag_name") String tagName);

}
