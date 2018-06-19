package com.qa.restful.controllers;

import com.qa.models.Book;
import com.qa.models.Customer;
import com.qa.services.BookService;
import com.qa.services.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@RestController
@SessionAttributes(names = {"books", "cart_items", "logged_in_customer", "Address"})
public class CustomerRESTfulController {

	@Autowired
	private BookService bookService;
	
	@Autowired
	private CustomerService customerService;

	@SuppressWarnings("unchecked")
	@RequestMapping("/loadAllBooks")
	public Iterable<Book> indexPage(HttpServletRequest request) {
		List<Book> cartItems;
		HttpSession session = request.getSession();
		Object items = session.getAttribute("cart_items");
		
		if (items != null) {
			cartItems = (ArrayList<Book>) items;
		} else {
			cartItems = new ArrayList<>();
		}
		
		Iterable<Book> books = bookService.findAllBooks();
		ModelAndView modelAndView = new ModelAndView("index", "books", books);
		modelAndView.addObject("cart_items", cartItems);
		return books;
	}

	@RequestMapping("/addCustomer")
	public Customer registerProcess(@ModelAttribute("Customer") Customer customer) {
		System.out.println("Customer Firstname is " + customer.getFirstName());
		System.out.println("Customer Password is " + customer.getPassword());
		return customerService.saveCustomer(customer);
	}

	@RequestMapping("/loginCustomer")
	public Customer loginProcess(@RequestParam("email") String email, @RequestParam("password") String password) {
		System.out.println("Email is " + email);
		System.out.println("Password is " + password);
		return customerService.loginProcess(email, password);
	}

}
