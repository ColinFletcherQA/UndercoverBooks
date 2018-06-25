package com.qa.controllers;

import com.qa.models.Address;
import com.qa.models.Customer;
import com.qa.models.Purchase;
import com.qa.services.AddressService;
import com.qa.services.PurchaseHistoryService;
import com.qa.repositories.PurchaseRepository;
import com.qa.services.BookService;
import com.qa.services.CustomerService;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.rmi.MarshalledObject;
import java.util.LinkedHashMap;
import java.util.List;

@Controller
@SessionAttributes(names = {"cart_items", "logged_in_customer", "Address"})
public class CustomerController {

	@Autowired
	private BookService bookService;
	
	@Autowired
	private CustomerService customerService;

	@Autowired
	private PurchaseHistoryService purchaseService;

	@Autowired
	private AddressService addressService;
	
	@RequestMapping("/")
	public ModelAndView indexPage(HttpServletRequest request) {
		HttpSession session = request.getSession();
		
		Object items = session.getAttribute("cart_items");
		
		if (items != null) {
			session.setAttribute("cart_items", items);
		} else {
			session.setAttribute("cart_items", new LinkedHashMap<>());
		}
		
		return new ModelAndView("index", "books", bookService.getSixRandomBooks());
	}

	@RequestMapping("/login")
	public ModelAndView login() {
		return new ModelAndView("login");
	}

	@RequestMapping("/logout")
	public ModelAndView logout(SessionStatus status) {
		status.setComplete();
		return new ModelAndView("redirect:/");
	}
	
	@RequestMapping("/register")
	public ModelAndView register() {
		ModelAndView modelAndView = new ModelAndView("register");
		return modelAndView;
	}
	
	@RequestMapping("/registerProcess")
	public ModelAndView registerProcess(HttpServletRequest request, @ModelAttribute("Customer") Customer customer) {
		System.out.println("Customer First name is " + customer.getFirstName());
		System.out.println("Customer Password is " + customer.getPassword());

		try {
            if (customerService.saveCustomer(customer) != null) {
                Customer c = customerService.loginProcess(customer.getEmail(), customer.getPassword());
               
                if (c != null) {
                	ModelAndView modelAndView = indexPage(request);
                	request.getSession().setAttribute("logged_in_customer", c);
                    return modelAndView;
                } else {
                    ModelAndView modelAndView = new ModelAndView("register");
                    modelAndView.addObject("flag", "Registration Failed 3!");
                    return modelAndView;
                }
            } else {
                ModelAndView modelAndView = new ModelAndView("register");
                modelAndView.addObject("flag", "Registration Failed 2!");
                return modelAndView;
            }
        } catch (Exception e) {
		    System.out.println(e.getLocalizedMessage());
            ModelAndView modelAndView = new ModelAndView("register");
            modelAndView.addObject("flag", "Registration Failed 1!");
            return modelAndView;
        }
	}
	
	@RequestMapping("/loginProcess")
	public ModelAndView loginProcess(@RequestParam("email") String email, @RequestParam("password") String password) {
		System.out.println("Email is " + email);
		System.out.println("Password is " + password);
		
		Customer c = customerService.loginProcess(email, password);

		if (c != null) {
			System.out.println("Success");
			return new ModelAndView("customer_home", "logged_in_customer", c);
		} else {
			System.out.println("Failure");
			return new ModelAndView("login");
		}
	}
	
	@RequestMapping("/customerHome")
	public ModelAndView customerHome(HttpServletRequest request) {
	    if(request.getSession().getAttribute("logged_in_customer") == null){
	        return new ModelAndView("login");
        }
        Customer customer = (Customer) request.getSession().getAttribute("logged_in_customer");
		Address customerAddress = (Address) addressService.getCustomerAddress(customer.getCustomerId());
		ModelAndView modelAndView = new ModelAndView("customer_home","logged_in_customer",request.getSession().getAttribute("logged_in_customer"));
		modelAndView.addObject("customer_address", customerAddress);
		return modelAndView;

	}
	
	@RequestMapping("/updateProfile")
	public ModelAndView updateProfile(@ModelAttribute("logged_in_customer") Customer loggedInCustomer, @ModelAttribute("Customer") Customer customer) {
		System.out.println("Before update ");
		System.out.println("ID " + loggedInCustomer.getCustomerId());
		System.out.println("Name " + loggedInCustomer.getFirstName() + loggedInCustomer.getLastName());
		System.out.println("Email" + loggedInCustomer.getEmail());
		
		int recordsUpdated = customerService.updateCustomer(loggedInCustomer.getFirstName(), loggedInCustomer.getLastName(), loggedInCustomer.getEmail(), loggedInCustomer.getCustomerId());
		
		if (recordsUpdated > 0) {
			Customer c = customerService.findCustomerById(loggedInCustomer.getCustomerId());
			
			System.out.println("After update ");
			System.out.println("ID " + c.getCustomerId());
			System.out.println("Name" + c.getFirstName() + c.getLastName());
			System.out.println("Email" + c.getEmail());
			
			return new ModelAndView("customer_home", "logged_in_customer", c);
		}
		
		return new ModelAndView("customer_home", "logged_in_customer", loggedInCustomer);
	}

	@RequestMapping("/updatePassword")
	public ModelAndView updatePassword(@ModelAttribute("logged_in_customer") Customer loggedInCustomer, @RequestParam("current_password") String currentPassword, @RequestParam("new_password") String newPassword){
		System.out.println(currentPassword);
		System.out.println(newPassword);
		System.out.println(loggedInCustomer.getCustomerId());
		ModelAndView modelAndView = new ModelAndView("customer_home");

		if(loggedInCustomer.getPassword().equals(currentPassword)) {
			if (currentPassword.equalsIgnoreCase(newPassword)) {
				modelAndView.addObject("message", "Passwords cannot match");
				modelAndView.addObject("flag", "ERROR");
			} else {
				customerService.updatePassword(loggedInCustomer.getCustomerId(), newPassword);
				modelAndView.addObject("message", "Password updated");
				modelAndView.addObject("flag", "SUCCESS");
			}
		} else {
			modelAndView.addObject("message", "Incorrect current password");
			modelAndView.addObject("flag", "ERROR");
		}

		return modelAndView;
	}

	@RequestMapping("/orderHistory")
	public ModelAndView orderHistory(HttpServletRequest request, @ModelAttribute("logged_in_customer") Customer loggedInCustomer) {
		Customer customer = (Customer) request.getSession().getAttribute("logged_in_customer");

		List<Purchase> orderList = purchaseService.getCustomerPurchaseHistory(customer);
		ModelAndView modelAndView = new ModelAndView("order_history");
		modelAndView.addObject("order_list", orderList);
		System.out.println(orderList.size());
		return modelAndView;
	}

	@RequestMapping("/contact")
	public ModelAndView contactPage() {
		return new ModelAndView("contact");
	}

	@RequestMapping("/about")
	public ModelAndView aboutPage() {
		return new ModelAndView("about_us");
	}


}
