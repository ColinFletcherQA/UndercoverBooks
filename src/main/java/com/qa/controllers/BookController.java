package com.qa.controllers;

import com.qa.models.*;
import com.qa.repositories.BookRepository;
import com.qa.repositories.TagRespository;
import com.qa.services.ReviewService;
import com.qa.services.SeriesService;
import com.qa.services.TagService;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import javax.jws.WebParam;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;
import java.time.Instant;
import java.util.List;
import java.util.Map;
import java.util.*;

@Controller
@SessionAttributes(names = {"cart_items"})
public class BookController {

	@Autowired
	BookRepository bookService;

	@Autowired
	private TagService tagService;

	@Autowired
	private SeriesService seriesService;

    @Autowired
    private ReviewService reviewService;
	
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
							   @RequestParam(value = "searchOption") String searchOption,
							   @RequestParam(value = "page", required = false) Integer page) {

		ModelAndView modelAndView = new ModelAndView("search_result");
		modelAndView.addObject("search_term", searchTerm);
		modelAndView.addObject("search_option", searchOption);
		List<Book> booksFound = null;

		switch (searchOption) {
			case "title":
				booksFound = bookService.findAllBooksByPartOfTitle(searchTerm);
				break;
			case "isbn":
				booksFound = bookService.findAllBooksByIsbn(searchTerm);
				booksFound.addAll(bookService.findAllBooksByPaperISBN(searchTerm));
				booksFound.addAll(bookService.findAllBooksByEBookISBN(searchTerm));
				break;
			case "author":
				booksFound = bookService.findAllBooksByAuthorsName(searchTerm);
				break;
			case "publisher":
				booksFound = bookService.findAllBooksByPartOfPublisher(searchTerm);
				break;
			case "description":
				String[] searchTerms = searchTerm.split(" ");
				booksFound = bookService.findAllBooksByPartOfDescription(searchTerms[0]);
				for (String term : searchTerms) {
					List<Book> newBooksFound = bookService.findAllBooksByPartOfDescription(term);
					booksFound.removeIf(b -> !newBooksFound.contains(b));
				}
				break;
		}

		Set<Book> uniqueValues = new HashSet<>();
		List<Book> booksFoundUnique = new ArrayList<Book>();
		if (booksFound != null) {
			for (Book book : booksFound) {
				if (uniqueValues.add(book)) {
					booksFoundUnique.add(book);
				}
			}
		}

		PagedListHolder<Book> pagedListHolder = new PagedListHolder<>(booksFoundUnique);
		pagedListHolder.setPageSize(12);
		modelAndView.addObject("maxPages", pagedListHolder.getPageCount());

		page = setPage(page, modelAndView, pagedListHolder, "search_result");

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

		page = setPage(page, modelAndView, pagedListHolder, "books_found");

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

		page = setPage(page, modelAndView, pagedListHolder, "books_found");

		modelAndView.addObject("page", page);

		return modelAndView;
	}

	@RequestMapping("/genres")
	public ModelAndView genres() {
		ModelAndView modelAndView = new ModelAndView("genres");
		List<Tag> tagList = (List<Tag>) tagService.getTags();
		modelAndView.addObject("tag_list", tagList);
		return modelAndView;
	}

	@RequestMapping("/genreResults")
	public ModelAndView genreResults(@RequestParam("tagName") String tagName,
									 @RequestParam(value = "page", required = false) Integer page) {
		ModelAndView modelAndView = new ModelAndView("genre_results");

		List<Book> booksFound = new ArrayList<>();

		if (tagName.equals("Best Seller")) {
			booksFound = bookService.getBestSellers();
		}
		else {
			booksFound = bookService.findAllBooksByTagName(tagName);
		}
		PagedListHolder<Book> pagedListHolder = new PagedListHolder<>(booksFound);
		pagedListHolder.setPageSize(12);
		modelAndView.addObject("maxPages", pagedListHolder.getPageCount());

		page = setPage(page, modelAndView, pagedListHolder, "books_found");

		modelAndView.addObject("page", page);
		modelAndView.addObject("tagName", tagName);
		return modelAndView;
	}

	@RequestMapping("/series")
	public ModelAndView series() {
		ModelAndView modelAndView = new ModelAndView("series");
		List<Series> seriesList = (List<Series>) seriesService.getSeries();
		modelAndView.addObject("series_list", seriesList);
		return modelAndView;
	}

	@RequestMapping("/seriesResults")
	public ModelAndView seriesResults(@RequestParam("seriesName") String seriesName) {
		ModelAndView modelAndView = new ModelAndView("series_results", "seriesName", seriesName);
		List<Book> bookSeriesList = bookService.findAllBooksBySeriesName(seriesName);
		modelAndView.addObject("book_series_list", bookSeriesList);
		return modelAndView;
	}

	private Integer setPage(@RequestParam(value = "page", required = false) Integer page, ModelAndView modelAndView, PagedListHolder<Book> pagedListHolder, String attribute) {
		if(page == null || page < 1 || page > pagedListHolder.getPageCount()) {
			page = 1;
			pagedListHolder.setPage(0);
			modelAndView.addObject(attribute, pagedListHolder.getPageList());
		}
		else if(page <= pagedListHolder.getPageCount()) {
			pagedListHolder.setPage(page-1);
			modelAndView.addObject(attribute, pagedListHolder.getPageList());
		}
		return page;
	}

	@org.springframework.transaction.annotation.Transactional
	@RequestMapping("/postReview")
	public ModelAndView postReview(HttpServletRequest request, @RequestParam("bookId") int bookId,
                                   @RequestParam("review") String review){

        Book book = em.find(Book.class, bookId);

        Customer customer = (Customer) request.getSession().getAttribute("logged_in_customer");

        Review reviewRequest = new Review(customer, review, 5, (int) (Instant.now().toEpochMilli()/1000));

        ModelAndView modelAndView = new ModelAndView("redirect:/bookDetails?bookId=" + bookId);
        Review reviewResponse = reviewService.postReview(reviewRequest);
        if(reviewResponse != null){
            modelAndView.addObject("review_flag", new Flag("Review Submitted", 1));
            reviewService.associateReview(reviewResponse.getReviewId(), bookId);
            em.merge(book);

        } else {
            modelAndView.addObject("review_flag", new Flag("Review Error", 0));
        }

        return modelAndView;
	}
	
}
