package com.qa.models;

import lombok.Getter;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.List;

@Entity
public class Book {
	
	@Id @Getter @Setter
	private int bookId;
	
	@Getter @Setter @Column(name = "num_pages")
	private int pageCount;

	@Getter @Setter @Column(name = "image_l")
	private String bookImage;

	@Getter @Setter @Column(name = "image_m")
	private String bookImageM;

	@Getter @Setter @Column(name = "image_s")
	private String bookImageS;
	
	@Getter @Setter
	private String description;
	
	@Getter @Setter @Column(name = "kindle_asin")
	private String eBookISBN;

	@Getter @Setter @Column(name = "isbn13")
	private String paperISBN;

	@Getter @Setter @Column(name = "isbn")
	private String isbn;
	
	@Getter @Setter
	private BigDecimal price;
	
	@Getter @Setter @Column(name = "original_publication_year")
	private String publishedDate;
	
	@Getter @Setter
	private String publisher;
	
	@Getter @Setter
	private String title;
	
	@Autowired @ElementCollection @Getter @Setter @OneToMany(fetch = FetchType.LAZY)
	private List<Author> authors;

	@Autowired @ElementCollection @Getter @Setter
	private List<Book> related_books;
	
	@Override
	public boolean equals(Object o) {
		if (!(o instanceof Book)) {
			return false;
		}
		
		return bookId == ((Book) o).bookId;
	}
	
	@Override
	public int hashCode() {
		return bookId;
	}
	
}
