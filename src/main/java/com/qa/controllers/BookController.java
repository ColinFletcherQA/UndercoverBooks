package com.qa.controllers;

import com.qa.models.Book;
import com.qa.repositories.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;
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
	public ModelAndView Search(@RequestParam(value = "searchTerm", required = false) String searchTerm,
							   @RequestParam(value = "page", required = false) Integer page) {

		ModelAndView modelAndView = new ModelAndView("search_result");
		modelAndView.addObject("search_term", searchTerm);
		List<Book> booksFound = bookService.findBookByPartOfTitle(searchTerm);

		PagedListHolder<Book> pagedListHolder = new PagedListHolder<>(booksFound);
		pagedListHolder.setPageSize(12);
		modelAndView.addObject("maxPages", pagedListHolder.getPageCount());

		if(page == null || page < 1 || page > pagedListHolder.getPageCount()) {
			page = 1;
			pagedListHolder.setPage(0);
			modelAndView.addObject("search_result", pagedListHolder.getPageList());
		}
		else if(page <= pagedListHolder.getPageCount()) {
			pagedListHolder.setPage(page-1);
			modelAndView.addObject("search_result", pagedListHolder.getPageList());
		}

		modelAndView.addObject("page", page);

		return modelAndView;
	}

	@RequestMapping("/bestSellers")
	public ModelAndView bestSellers(@RequestParam(value = "page", required = false) Integer page) {

		ModelAndView modelAndView = new ModelAndView("best_sellers");
		List<Book> booksFound = bookService.getBestSellers();

		PagedListHolder<Book> pagedListHolder = new PagedListHolder<>(booksFound);
		pagedListHolder.setPageSize(12);
		modelAndView.addObject("maxPages", pagedListHolder.getPageCount());

		if(page == null || page < 1 || page > pagedListHolder.getPageCount()) {
			page = 1;
			pagedListHolder.setPage(0);
			modelAndView.addObject("books_found", pagedListHolder.getPageList());
		}
		else if(page <= pagedListHolder.getPageCount()) {
			pagedListHolder.setPage(page-1);
			modelAndView.addObject("books_found", pagedListHolder.getPageList());
		}

		modelAndView.addObject("page", page);

		return modelAndView;
	}

	@RequestMapping("/newReleases")
	public ModelAndView newReleases(@RequestParam(value = "page", required = false) Integer page) {

	ModelAndView modelAndView = new ModelAndView("new_releases");
	List<Book> booksFound = bookService.getNewReleases();

	PagedListHolder<Book> pagedListHolder = new PagedListHolder<>(booksFound);
		pagedListHolder.setPageSize(12);
		modelAndView.addObject("maxPages", pagedListHolder.getPageCount());

		if(page == null || page < 1 || page > pagedListHolder.getPageCount()) {
		page = 1;
		pagedListHolder.setPage(0);
		modelAndView.addObject("books_found", pagedListHolder.getPageList());
	}
		else if(page <= pagedListHolder.getPageCount()) {
		pagedListHolder.setPage(page-1);
		modelAndView.addObject("books_found", pagedListHolder.getPageList());
	}

		modelAndView.addObject("page", page);

		return modelAndView;
	}
	
}
