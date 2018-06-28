package com.qa.services;

import com.qa.models.Address;
import com.qa.repositories.AddressRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AddressService {

	@Autowired
	private AddressRepository addressRespository;
	
	public int updateBillingAddress(String addressLine1, String addressLine2, String city, String postcode, String state, String country, String phoneNumber, int customerId) {
		return addressRespository.updateBillingAddress(addressLine1, addressLine2, city, postcode, state, country, phoneNumber, customerId);
	}

	public Address findAddressByType(int customerId, String addressType) {
		return addressRespository.findAddressByType(customerId, addressType);
	}
	
	public Address saveAddress(Address address) {
		return addressRespository.save(address);
	}

	public Address getAddressIfAlreadyExists(Address address){
		return addressRespository.checkDuplicate(address.getAddressLine1(), address.getCustomerId());
	}

	public Address getCustomerAddress(int customerId) {
		return addressRespository.findAddressByCustomer(customerId);
	}

}
