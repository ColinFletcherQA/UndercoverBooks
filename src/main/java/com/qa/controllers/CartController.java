package com.qa.controllers;

import com.qa.models.Book;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import java.math.BigDecimal;
import java.util.Map;

@Controller
@SessionAttributes({"cart_items"})
public class CartController {

	@RequestMapping("/updatePrice")
	public ModelAndView bookDetails(@RequestParam("price") double price, @RequestParam("quantity") int quantity) {
		double totalPrice = price * quantity;
		System.out.println("Total price is " + price);
		return new ModelAndView("return_price", "total_price", totalPrice);
	}
	
	@RequestMapping("/checkout")
	public ModelAndView checkoutForm(@ModelAttribute("cart_items") Map<Book, Integer> cartItems, @RequestParam("order_total") BigDecimal orderTotal, @RequestParam("tax_total") BigDecimal taxTotal) {
		ModelAndView modelAndView = new ModelAndView("checkout", "order_total", orderTotal);
		modelAndView.addObject("cart_items", cartItems);
		modelAndView.addObject("tax_total",taxTotal);
		return modelAndView;
	}

}
