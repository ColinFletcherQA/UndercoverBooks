package com.qa.controllers;

import com.qa.models.Address;
import com.qa.models.Book;
import com.qa.models.Customer;
import com.qa.models.Purchase;
import com.qa.services.AddressService;
import com.qa.services.PurchaseHistoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Controller
@SessionAttributes({"cart_items"})
public class CheckoutController {

	@Autowired
	private PurchaseHistoryService purchaseService;

	@Autowired
	private AddressService addressService;

	@RequestMapping("/checkoutProcess")
	public ModelAndView checkoutProcess(HttpServletRequest request, @ModelAttribute("Purchase") Purchase purchase, @ModelAttribute("Address") Address address, @ModelAttribute("cart_items") Map<Book, Integer> cartItems) {
		Customer customer = (Customer) request.getSession().getAttribute("logged_in_customer");

		address.setCustomerId(customer.getCustomerId());
		Address preparedAddressResponse = prepareAddress(address);
		
		if (preparedAddressResponse != null) {
			System.out.println(preparedAddressResponse.getAddressId());

			//Initial purchase injection
			purchase.setCustomer(customer);
			purchase.setShippingAddress(preparedAddressResponse);
			purchase.setBooks(cartItems.keySet());

			Purchase preparedPurchaseResponse = preparePurchase(purchase);
			
			if (preparedPurchaseResponse != null) {
				//Ensure cartItems is built into the Purchase object
				System.out.println(preparedPurchaseResponse.getOrderId());
			} else {
				System.out.println("Purchase not submitted");
			}
		} else {
			System.out.println("Address not submitted");
		}
		
		ModelAndView modelAndView = new ModelAndView("receipt");
		modelAndView.addObject("shipping_address", address);
		modelAndView.addObject("cart_items", cartItems);
		modelAndView.addObject("purchase", purchase);
		return modelAndView;
	}

	private Address prepareAddress(Address address) {
		Address existingAddress = addressService.getAddressIfAlreadyExists(address);

		if(existingAddress != null){
			return existingAddress;
		}

		try {
			return addressService.saveAddress(address);
		} catch (Exception e){
			return null;
		}
	}

	private Purchase preparePurchase(Purchase purchase) {
		try {
			return purchaseService.makePurchase(purchase);
		} catch (Exception e) {
			System.out.println(e.getLocalizedMessage());
			return null;
		}
	}

	@RequestMapping("/loginThroughCheckout")
	public ModelAndView loginThroughCheckout(@ModelAttribute("cart_items") Map<Book, Integer> cartItems, @RequestParam("order_total") double orderTotal) {
		ModelAndView modelAndView = new ModelAndView("login_through_checkout", "order_total", orderTotal);
		modelAndView.addObject("cart_items", cartItems);
		return modelAndView;
	}
	
}
