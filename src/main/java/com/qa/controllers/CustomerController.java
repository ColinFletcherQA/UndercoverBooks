package com.qa.controllers;

import com.qa.models.*;
import com.qa.repositories.BookRequestRepository;
import com.qa.services.AddressService;
import com.qa.services.BookService;
import com.qa.services.CustomerService;
import com.qa.services.PurchaseHistoryService;
import com.qa.util.PasswordHasher;
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
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
@SessionAttributes(names = {"cart_items", "logged_in_customer"})
public class CustomerController {

	@Autowired
	private BookService bookService;

	@Autowired
    private BookRequestRepository requestRepository;
	
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
	public ModelAndView login(HttpSession session) {
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

		customer.setPassword(PasswordHasher.getInstance().encrypt(customer.getPassword()));

		try {
            if (customerService.saveCustomer(customer) != null) {
                Customer c = customerService.loginProcess(customer.getEmail(), customer.getPassword());
               
                if (c != null) {
                	ModelAndView modelAndView = indexPage(request);
                	request.getSession().setAttribute("logged_in_customer", c);
                    return modelAndView;
                } else {
                    ModelAndView modelAndView = new ModelAndView("register");
                    modelAndView.addObject("registration_flag", new Flag("Could Not Login", 0));
                    return modelAndView;
                }
            } else {
                ModelAndView modelAndView = new ModelAndView("register");
                modelAndView.addObject("registration_flag", new Flag("Registration Failed", 0));
                return modelAndView;
            }
        } catch (Exception e) {
		    System.out.println(e.getLocalizedMessage());
            ModelAndView modelAndView = new ModelAndView("register");
            modelAndView.addObject("registration_flag", new Flag("Email Already In Use", 0));
            return modelAndView;
        }
	}
	
	@RequestMapping("/loginProcess")
	public ModelAndView loginProcess(HttpServletRequest request, @RequestParam("email") String email, @RequestParam("password") String password) {
		System.out.println("Email is " + email);
		System.out.println("Password is " + password);
		
		Customer c = customerService.loginProcess(email, PasswordHasher.getInstance().encrypt(password));

		if (c != null) {
			System.out.println("Success");
            Map<Book, Integer> cartItems = (Map<Book, Integer>) request.getSession().getAttribute("cart_items");
            if(cartItems.size() > 0) {
                return new ModelAndView("cart_details", "logged_in_customer", c);
            }
			return new ModelAndView("customer_home", "logged_in_customer", c);
		} else {
			System.out.println("Failure");
			ModelAndView modelAndView = new ModelAndView("login");
			modelAndView.addObject("login_flag", new Flag("Incorrect Username or Password", 0));
			return modelAndView;
		}
	}
	
	@RequestMapping("/customerHome")
	public ModelAndView customerHome(HttpServletRequest request) {
	    if(request.getSession().getAttribute("logged_in_customer") == null){
	        return new ModelAndView("login");
        }
        Customer customer = (Customer) request.getSession().getAttribute("logged_in_customer");
		ModelAndView modelAndView = new ModelAndView("customer_home","logged_in_customer",request.getSession().getAttribute("logged_in_customer"));
		modelAndView.addObject("Address", addressService.getCustomerAddress(customer.getCustomerId()));
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

            ModelAndView modelAndView = new ModelAndView("customer_home", "logged_in_customer", c);
			modelAndView.addObject("profile_flag", new Flag("Profile Updated", 1));
			return modelAndView;
		}
		
		return new ModelAndView("customer_home", "logged_in_customer", loggedInCustomer);
	}

    @RequestMapping("/updateAddress")
    public ModelAndView updateAddress(@ModelAttribute("logged_in_customer") Customer loggedInCustomer, @ModelAttribute("Address") Address address) {
        ModelAndView modelAndView = new ModelAndView("customer_home", "logged_in_customer",loggedInCustomer);

        if (addressService.getCustomerAddress(loggedInCustomer.getCustomerId()) != null) {
            int recordsUpdated = addressService.updateBillingAddress(address.getAddressLine1(), address.getAddressLine2(), address.getCity(),
                    address.getPostcode(), address.getState(), address.getCountry(), address.getPhoneNumber(),
                    loggedInCustomer.getCustomerId());
            
            if (recordsUpdated > 0) {
                //Success
                modelAndView.addObject("shipping_flag", new Flag("Address Updated", 1));
            } else {
                //Failure
                modelAndView.addObject("shipping_flag", new Flag("Update Failed", 0));
            }
        } else {
            if (addressService.saveAddress(address) != null) {
                modelAndView.addObject("shipping_flag", new Flag("Address Updated", 1));
            } else {
                //Failure
                modelAndView.addObject("shipping_flag", new Flag("Address Failed", 0));
            }
        }
        
        modelAndView.addObject("Address", address);
        
        return modelAndView;
    }

	@RequestMapping("/updatePassword")
	public ModelAndView updatePassword(@ModelAttribute("logged_in_customer") Customer loggedInCustomer, @RequestParam("current_password") String currentPassword, @RequestParam("new_password") String newPassword){
		System.out.println(currentPassword);
		newPassword = PasswordHasher.getInstance().encrypt(newPassword);
		System.out.println(newPassword);
		System.out.println(loggedInCustomer.getCustomerId());
		ModelAndView modelAndView = new ModelAndView("customer_home");

		if(loggedInCustomer.getPassword().equals(PasswordHasher.getInstance().encrypt(currentPassword))) {
			if (currentPassword.equals(newPassword)) {
				modelAndView.addObject("password_flag", new Flag("Passwords Cannot Match", 0));
			} else {
				customerService.updatePassword(loggedInCustomer.getCustomerId(), newPassword);
				loggedInCustomer.setPassword(newPassword);
				modelAndView.addObject("logged_in_customer", loggedInCustomer);
                modelAndView.addObject("password_flag", new Flag("Updated", 1));
			}
		} else {
            modelAndView.addObject("password_flag", new Flag("Incorrect Current Password", 0));
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

	@RequestMapping("/sendUsAMessage")
    public ModelAndView sendUsAMessage(HttpServletRequest request){
        ModelAndView contactModel = new ModelAndView("contact");
        contactModel.addObject("message_flag", new Flag("Message Sent", 1));
	    return contactModel;
    }

	@RequestMapping("/requestBook")
	public ModelAndView requestBook(@ModelAttribute("BookRequest")BookRequest bookRequest){
	    ModelAndView contactModel = new ModelAndView("contact");
	    System.out.println(bookRequest);
	    if(bookRequest != null) {
			try {
				requestRepository.save(bookRequest);
				contactModel.addObject("request_flag", new Flag("Request Submitted", 1));
			} catch (Exception ignored) {
				contactModel.addObject("request_flag", new Flag("Error Submitting", 0));
			}
		}
	    return contactModel;
	}

	@RequestMapping("/about")
	public ModelAndView aboutPage() {
		return new ModelAndView("about_us");
	}


}
