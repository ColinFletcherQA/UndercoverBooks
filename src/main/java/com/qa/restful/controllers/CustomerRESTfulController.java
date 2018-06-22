package com.qa.restful.controllers;

import com.qa.models.Customer;
import com.qa.services.BookService;
import com.qa.services.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@SessionAttributes(names = {"books", "cart_items", "logged_in_customer", "Address"})
public class CustomerRESTfulController {

	@Autowired
	private BookService bookService;
	
	@Autowired
	private CustomerService customerService;

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
