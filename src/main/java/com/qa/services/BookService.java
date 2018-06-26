package com.qa.services;

import com.qa.models.Book;
import com.qa.models.BookRequest;
import com.qa.repositories.BookRepository;
import com.qa.repositories.BookRequestRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookService {
	
	@Autowired
	private BookRepository bookRepository;

    @Autowired
    private BookRequestRepository requestRepository;
	
	public List<Book> getSixRandomBooks() {
		return bookRepository.getSixRandomBooks();
	}
}
