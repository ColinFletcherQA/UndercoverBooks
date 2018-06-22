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

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.Map;

@Controller
@SessionAttributes(names = {"cart_items"})
public class BookController {

	@Autowired
	BookRepository bookService;
	
	@PersistenceContext
	EntityManager em;
	
	@RequestMapping("/bookDetails")
	public ModelAndView bookDetails(@RequestParam("bookId") int bookId) {
		// TODO - Jacob: We don't want a null book.
		Book book = em.find(Book.class, bookId);

		if (book == null) {
			// TODO: Change to valid book-not-found page.
		    return null;
        }
        
		return new ModelAndView("book_details", "book", book);
	}
	
	@RequestMapping("/addToCart")
	public ModelAndView addToCart(@RequestParam("bookId") int bookId, @ModelAttribute("cart_items") Map<Book, Integer> cartItems) {
		Book book = em.find(Book.class, bookId);
		
		if (book == null) {
			// TODO: Change to valid book-not-found page.
			return null;
		}
		
		cartItems.merge(book, 1, Integer::sum);
		
        ModelAndView modelAndView = new ModelAndView("redirect:/bookDetails?bookId=" + bookId, "book", book);
		modelAndView.addObject("cart_items", cartItems);
		return modelAndView;
	}
	
	@RequestMapping("/viewCart")
	public ModelAndView viewCart(@ModelAttribute("cart_items") Map<Book, Integer> cartItems) {
		return new ModelAndView("cart_details", "cart_items", cartItems);
	}

	@RequestMapping("/removeFromCart")
	public ModelAndView removeFromCart(@ModelAttribute("cart_items") Map<Book, Integer> cartItems, @RequestParam("bookId") int bookId) {
		Book book = em.find(Book.class, bookId);
		
		if (book == null) {
			// TODO: Change to valid book-not-found page.
			return null;
		}
		
		cartItems.remove(book);

		if (!cartItems.isEmpty()) {
		    return new ModelAndView("cart_details", "cart_items", cartItems);
		}
		
		return new ModelAndView("cart_details", "cart_items", cartItems);
	}

	@RequestMapping(value="/search")
	public ModelAndView Search(@RequestParam(value = "searchTerm", required = false) String pSearchTerm) {
		ModelAndView modelAndView = new ModelAndView("search_result");

		modelAndView.addObject("search_term", pSearchTerm);
		modelAndView.addObject("search_result", bookService.findBookByPartOfTitle(pSearchTerm));

		return modelAndView;
	}

	@RequestMapping("/bestSellers")
	public ModelAndView bestSellers() {
		return new ModelAndView("best_sellers");
	}

	@RequestMapping("newReleases")
	public ModelAndView newReleases() {
		return new ModelAndView("new_releases");
	}
	
}
