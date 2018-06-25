package com.qa.controllers;

import com.qa.models.Address;
import com.qa.models.Customer;
import com.qa.services.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AddressBookController {

	@Autowired
	private AddressService addressService;
	
	@RequestMapping("/updateAddress")
	public ModelAndView updateAddress(@ModelAttribute("logged_in_customer") Customer loggedInCustomer, @ModelAttribute("Address") Address address) {
		ModelAndView modelAndView;

		if (addressService.getAddressIfAlreadyExists(address) != null) {
			int recordsUpdated = addressService.updateBillingAddress(address.getAddressLine1(), address.getAddressLine2(), address.getCity(),
					address.getPostcode(), address.getState(), address.getCountry(), address.getPhoneNumber(),
					loggedInCustomer.getCustomerId(), address.getAddressType());
		} else {
			Address updatedAddress = addressService.saveAddress(address);
			System.out.println("New Address Line 1: " + updatedAddress.getAddressLine1());
		}


		modelAndView = new ModelAndView("customer_home", "logged_in_customer",loggedInCustomer);
		modelAndView.addObject("Address", address);
		return modelAndView;

	}
	
}
