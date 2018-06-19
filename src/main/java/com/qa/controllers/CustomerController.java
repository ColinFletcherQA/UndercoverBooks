package com.qa.controllers;

import com.qa.models.Book;
import com.qa.models.Customer;
import com.qa.services.BookService;
import com.qa.services.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@SessionAttributes(names = {"books", "cart_items", "logged_in_customer", "Address"})
public class CustomerController {

	@Autowired
	private BookService bookService;
	
	@Autowired
	private CustomerService customerService;
	
	@RequestMapping("/")
	public ModelAndView indexPage(HttpServletRequest request) {
		List<Book> cartItems;
		HttpSession session = request.getSession();
		Object items = session.getAttribute("cart_items");
		
		if (items != null) {
			cartItems = (ArrayList<Book>) items;
		} else {
			cartItems = new ArrayList<>();
		}
		
		ModelAndView modelAndView = new ModelAndView("index", "books", bookService.findAllBooks());
		modelAndView.addObject("cart_items", cartItems);
		return modelAndView;
	}

	@RequestMapping("/login")
	public ModelAndView login() {
		return new ModelAndView("login");
	}
	
	@RequestMapping("/register")
	public ModelAndView register() {
		return new ModelAndView("register");
	}
	
	@RequestMapping("/registerProcess")
	public ModelAndView registerProcess(@ModelAttribute("Customer") Customer customer) {
		System.out.println("Customer Firstname is " + customer.getFirstName());
		System.out.println("Customer Password is " + customer.getPassword());

		if (customerService.saveCustomer(customer) != null) {
			return new ModelAndView("registration_success");
		}

		return new ModelAndView("registration_failed");
	}
	
	@RequestMapping("/loginProcess")
	public ModelAndView loginProcess(@RequestParam("email") String email, @RequestParam("password") String password) {
		System.out.println("Email is " + email);
		System.out.println("Password is " + password);
		
		Customer c = customerService.loginProcess(email, password);

		if (c != null) {
			System.out.println("Success");
			return new ModelAndView("customer_home", "logged_in_customer", c);
		}
		
		System.out.println("Failure");
		return new ModelAndView("login_failed");
	}
	
	@RequestMapping("/profile")
	public ModelAndView profile(@ModelAttribute("logged_in_customer") Customer loggedInCustomer) {
		return new ModelAndView("profile", "logged_in_customer", loggedInCustomer);
	}
	
	@RequestMapping("/updateProfile")
	public ModelAndView updateProfile(@ModelAttribute("logged_in_customer") Customer loggedInCustomer, @ModelAttribute("Customer") Customer customer) {
		System.out.println("Before update ");
		System.out.println("ID " + loggedInCustomer.getCustomerId());
		System.out.println("Name" + loggedInCustomer.getFirstName());
		System.out.println("Email" + loggedInCustomer.getEmail());
		
		int recordsUpdated = customerService.updateCustomer(loggedInCustomer.getFirstName(), loggedInCustomer.getLastName(), loggedInCustomer.getEmail(), loggedInCustomer.getCustomerId());
		
		if (recordsUpdated > 0) {
			Customer c = customerService.findCustomerById(loggedInCustomer.getCustomerId());
			
			System.out.println("After update ");
			System.out.println("ID " + c.getCustomerId());
			System.out.println("Name" + c.getFirstName());
			System.out.println("Email" + c.getEmail());
			
			return new ModelAndView("profile", "logged_in_customer", c);
		}
		
		return new ModelAndView("profile", "logged_in_customer", loggedInCustomer);
	}
	
	@RequestMapping("/addressBook")
	public ModelAndView addressBook(@ModelAttribute("logged_in_customer") Customer loggedInCustomer) {
		return new ModelAndView("address_book", "logged_in_customer", loggedInCustomer);
	}

}
