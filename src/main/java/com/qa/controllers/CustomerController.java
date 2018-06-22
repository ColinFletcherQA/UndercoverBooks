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

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
@SessionAttributes(names = {"cart_items", "logged_in_customer", "Address", "flag"})
public class CustomerController {

	@Autowired
	private BookService bookService;
	
	@Autowired
	private CustomerService customerService;
	
	// List#contains is more efficient than Set#contains for small collections.
	private List<String> BLANK_BOOK_IMAGES = Arrays.asList(
		"https://s.gr-assets.com/assets/nophoto/book/50x75-a91bf249278a81aabab721ef782c4a74.png",
		"https://s.gr-assets.com/assets/nophoto/book/111x148-bcc042a9c91a29c1d680899eff700a03.png"
	);
	
	@RequestMapping("/")
	public ModelAndView indexPage(HttpServletRequest request) {
		HttpSession session = request.getSession();
		
		Object items = session.getAttribute("cart_items");
		
		Map<Book, Integer> cartItems;
		
		if (items != null) {
			cartItems = (Map<Book, Integer>) items;
		} else {
			cartItems = new LinkedHashMap<>();
		}
		
		ModelAndView modelAndView = new ModelAndView("index", "books", bookService.getSixRandomBooks());
		modelAndView.addObject("cart_items", cartItems);
		return modelAndView;
	}

	@RequestMapping("/login")
	public ModelAndView login() {
		return new ModelAndView("login");
	}

	@RequestMapping("/logout")
	public ModelAndView logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.removeAttribute("cart_items");
		return indexPage(request);
	}
	
	@RequestMapping("/register")
	public ModelAndView register() {
		return new ModelAndView("register");
	}

	@RequestMapping("/registered_user_agreement")
	public ModelAndView registeredUserAgreement(){
		return new ModelAndView("registered_user_agreement");
	}
	
	@RequestMapping("/registerProcess")
	public ModelAndView registerProcess(@ModelAttribute("Customer") Customer customer) {
		System.out.println("Customer First name is " + customer.getFirstName());
		System.out.println("Customer Password is " + customer.getPassword());

		try {
            if (customerService.saveCustomer(customer) != null) {
                Customer c = customerService.loginProcess(customer.getEmail(), customer.getPassword());
               
                if(c != null) {
                    return new ModelAndView("index", "logged_in_customer", c);
                } else {
                    ModelAndView modelAndView = new ModelAndView("register");
                    modelAndView.addObject("flag", "Registration Failed!");
                    return modelAndView;
                }
            } else {
                ModelAndView modelAndView = new ModelAndView("register");
                modelAndView.addObject("flag", "Registration Failed!");
                return modelAndView;
            }
        } catch (Exception e) {
		    System.out.println(e.getLocalizedMessage());
            ModelAndView modelAndView = new ModelAndView("register");
            modelAndView.addObject("flag", "Registration Failed!");
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
	public ModelAndView customerHome(@ModelAttribute("logged_in_customer") Customer loggedInCustomer) {
		return new ModelAndView("customer_home","logged_in_customer",loggedInCustomer);
	}
	
	@Deprecated
	@RequestMapping("/profile")
	public ModelAndView profile(@ModelAttribute("logged_in_customer") Customer loggedInCustomer) {
		return new ModelAndView("profile", "logged_in_customer", loggedInCustomer);
	}
	
	@RequestMapping("/updateProfile")
	public ModelAndView updateProfile(@ModelAttribute("logged_in_customer") Customer loggedInCustomer, @ModelAttribute("Customer") Customer customer) {
		System.out.println("Before update ");
		System.out.println("ID " + loggedInCustomer.getCustomerId());
		System.out.println("Name" + loggedInCustomer.getFirstName() + loggedInCustomer.getLastName());
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
	
	@Deprecated
	@RequestMapping("/addressBook")
	public ModelAndView addressBook(@ModelAttribute("logged_in_customer") Customer loggedInCustomer) {
		return new ModelAndView("address_book", "logged_in_customer", loggedInCustomer);
	}
	
	@Deprecated
	@RequestMapping("/change_password")
	public ModelAndView changePassword(@ModelAttribute("logged_in_customer") Customer loggedInCustomer){
		return new ModelAndView("change_password", "logged_in_customer", loggedInCustomer);
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

	@RequestMapping("/contact")
	public ModelAndView contactPage() {
		return new ModelAndView("contact");
	}

	@RequestMapping("/about")
	public ModelAndView aboutPage() {
		return new ModelAndView("about_us");
	}


}
