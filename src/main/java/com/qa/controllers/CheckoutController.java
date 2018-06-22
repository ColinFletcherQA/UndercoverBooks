package com.qa.controllers;

import com.qa.models.Address;
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

@SessionAttributes(names = {"book_counts"})
@Controller
public class CheckoutController {

	@Autowired
	private PurchaseHistoryService purchaseService;

	@Autowired
	private AddressService addressService;

	@RequestMapping("/checkoutProcess")
	public ModelAndView checkoutProcess(HttpServletRequest request, @ModelAttribute("Purchase") Purchase purchase,
										@ModelAttribute("Address") Address address,
										@ModelAttribute("book_counts") Map<Integer, Integer> bookCounts) {

		Customer customer = (Customer) request.getSession().getAttribute("logged_in_customer");

		Address preparedAddressResponse = prepareAddress(address);
		if(preparedAddressResponse != null){
			System.out.println(preparedAddressResponse.getAddressId());

			//Initial purchase set up
			purchase.setCustomer(customer);
			purchase.setShippingAddress(preparedAddressResponse);

			Purchase preparedPurchaseResponse = preparePurchase(purchase);
			if(preparedPurchaseResponse != null){
				System.out.println(preparedPurchaseResponse.getOrderId());
			} else {
				System.out.println("Purchase not submitted");
			}
		} else {
			System.out.println("Address not submitted");
		}

//		request.getSession().setAttribute("cart_items", new ArrayList<>());
		ModelAndView modelAndView = new ModelAndView("receipt");
		modelAndView.addObject("shipping_address", address);
		modelAndView.addObject("book_counts", bookCounts);
		modelAndView.addObject("purchase", purchase);

		return modelAndView;
	}

	private Address prepareAddress(Address address){
		try {
			return addressService.saveAddress(address);
		} catch (Exception e){
			return null;
		}
	}

	private Purchase preparePurchase(Purchase purchase){
		try {
			return purchaseService.makePurchase(purchase);
		} catch (Exception e){
			throw e;
		}
	}

	@RequestMapping("/loginThroughCheckout")
	public ModelAndView loginThroughCheckout(@ModelAttribute("book_counts") Map<Integer, Integer> bookCounts, @RequestParam("order_total") double orderTotal) {
		ModelAndView modelAndView = new ModelAndView("login_through_checkout", "order_total", orderTotal);
		modelAndView.addObject("order_total", orderTotal);
		modelAndView.addObject("book_counts", bookCounts);
		return modelAndView;
	}
	
}
