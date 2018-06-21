package com.qa.controllers;

import com.qa.models.Book;
import com.qa.repositories.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@SessionAttributes(names = {"books", "cart_items", "book_counts", "filtered_books"})
public class BookController {

	@Autowired
	BookRepository bookService;
	
	@RequestMapping("/bookDetails")
	public ModelAndView bookDetails(@ModelAttribute("books") Collection<Book> books, @RequestParam("bookId") int bookId) {
		// TODO - Jacob: We don't want a null book.
		Book book = findBookById(books, bookId).orElse(null);
		ModelAndView modelAndView = new ModelAndView("book_details", "book", book);
		modelAndView.addObject("books", books);
		return modelAndView;
	}
	
	@RequestMapping("/addToCart")
	public ModelAndView addToCart(@ModelAttribute("books") Collection<Book> books, @RequestParam("bookId") int bookId, @ModelAttribute("cart_items") List<Book> cartItems) {
		findBookById(books, bookId).ifPresent(cartItems::add);
		Book book = findBookById(books, bookId).orElse(null);
        ModelAndView modelAndView = new ModelAndView("redirect:/bookDetails?bookId=" + Objects.requireNonNull(book).getBookId(), "book", book);
		modelAndView.addObject("cart_items", cartItems);
		modelAndView.addObject("books", books);
		return modelAndView;
	}
	
	@RequestMapping("/viewCart")
	public ModelAndView viewCart(@ModelAttribute("books") Collection<Book> books, @ModelAttribute("cart_items") List<Book> cartItems) {
		ModelAndView modelAndView;
		List<Integer> bookIds = loadBookIds(cartItems);
		Map<Integer, Integer> bookCounts = bookCounts(bookIds);
		List<Book> filteredBooks = filteredBookList(books, bookCounts);

		modelAndView = new ModelAndView("cart_details", "cart_items", cartItems);

		modelAndView.addObject("book_counts", bookCounts);
		modelAndView.addObject("filtered_books", filteredBooks);
		return modelAndView;
	}

	@RequestMapping("/removeFromCart")
	public ModelAndView removeFromCart(@ModelAttribute("filtered_books") List<Book> cartItems, @RequestParam("bookId") int bookId) {
		cartItems = removeBookById(cartItems, bookId);

		if (!cartItems.isEmpty()) {
		    return new ModelAndView("cart_details", "cart_items", cartItems);
		}
		
		return new ModelAndView("cart_details", "cart_items", cartItems);
	}
	
	public List<Integer> loadBookIds(Collection<Book> cartItems) {
		return cartItems.stream()
						.map(Book::getBookId)
						.collect(Collectors.toList());
	}
	
	// Some business methods
	
	public Optional<Book> findBookById(Collection<Book> books, int bookId) {
		return books.stream()
				    .filter(b -> b.getBookId() == bookId)
				    .findFirst();
	}

	public boolean findBookInCart(Collection<Integer> cartItems, int bookId) {
		return cartItems.contains(bookId);
	}

	public List<Book> removeBookById(List<Book> books, int bookId) {
		books.removeIf(b -> b.getBookId() == bookId);
		return books;
	}
	
	// TODO - Jacob: Stream it and collect it to a Map if we want to remove the prints.
	public Map<Integer, Integer> bookCounts(List<Integer> bookIds) {
		Map<Integer, Integer> map = new HashMap<>();
		bookIds.forEach(bookId -> map.merge(bookId, 1, Integer::sum));
		map.forEach((k, v) -> System.out.println("Key : " + k + " Value : " + v));
		return map;
	}
	
	public List<Book> filteredBookList(Collection<Book> books, Map<Integer, Integer> map) {
		List<Book> filteredBooks = books.stream()
										.filter(b -> map.containsKey(b.getBookId()))
										.collect(Collectors.toList());
		System.out.println("Number of filtered items " + filteredBooks.size());
		return filteredBooks;
	}
	
}
