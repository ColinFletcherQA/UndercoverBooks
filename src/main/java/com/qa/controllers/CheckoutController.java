package com.qa.controllers;

import com.qa.models.Address;
import com.qa.models.Purchase;
import com.qa.models.Shipping;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Map;

@SessionAttributes(names = {"book_counts"})
@Controller
public class CheckoutController {

	@RequestMapping("/checkoutProcess")
	public ModelAndView checkoutProcess(HttpServletRequest request, @ModelAttribute("Purchase") Purchase purchase, @ModelAttribute("Address") Address address, @ModelAttribute("book_counts") Map<Integer, Integer> bookCounts) {
		System.out.println("First name " + address.getFirstName());
//		request.getSession().setAttribute("cart_items", new ArrayList<>());
		ModelAndView modelAndView = new ModelAndView("receipt");
		modelAndView.addObject("shipping_address", address);
		modelAndView.addObject("book_counts", bookCounts);
		modelAndView.addObject("purchase", purchase);
		return modelAndView;
	}

	@RequestMapping("/loginThroughCheckout")
	public ModelAndView loginThroughCheckout(@ModelAttribute("book_counts") Map<Integer, Integer> bookCounts, @RequestParam("order_total") double orderTotal) {
		ModelAndView modelAndView = new ModelAndView("login_through_checkout", "order_total", orderTotal);
		modelAndView.addObject("order_total", orderTotal);
		modelAndView.addObject("book_counts", bookCounts);
		return modelAndView;
	}
	
}
