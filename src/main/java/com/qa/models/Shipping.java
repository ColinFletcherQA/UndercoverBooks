package com.qa.models;

import lombok.Getter;
import lombok.Setter;

public class Shipping {
	
	@Getter @Setter
	private int shippingId;
	
	@Getter @Setter
	private String firstName;
	
	@Getter @Setter
	private String lastName;
	
	@Getter @Setter
	private String addressLine1;
	
	@Getter @Setter
	private String addressLine2;
	
	@Getter @Setter
	private String city;
	
	@Getter @Setter
	private String postcode;
	
	@Getter @Setter
	private String state;
	
	@Getter @Setter
	private String country;
	
	@Getter @Setter
	private String phone;
	
	@Getter @Setter
	private String email;

}
