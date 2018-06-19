package com.qa.models;

import lombok.Getter;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;

import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.math.BigDecimal;
import java.util.List;

@Entity
public class Book {
	
	@Id @Getter @Setter
	private int bookId;
	
	@Getter @Setter
	private int pageCount;
	
	@Getter @Setter
	private String bookImage;
	
	@Getter @Setter
	private String description;
	
	@Getter @Setter
	private String eBookISBN;
	
	@Getter @Setter
	private String format;
	
	@Getter @Setter
	private String paperISBN;
	
	@Getter @Setter
	private BigDecimal price;
	
	@Getter @Setter
	private String publishedDate;
	
	@Getter @Setter
	private String publisher;
	
	@Getter @Setter
	private String tableOfContents;
	
	@Getter @Setter
	private String title;
	
	@Autowired @ElementCollection @Getter @Setter
	private List<Author> authors;
	
}
