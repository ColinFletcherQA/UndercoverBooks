package com.qa.models;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
@ToString
public class Address {

	@Id @GeneratedValue
	@Getter @Setter
	private int addressId;
	
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
	private String phoneNumber;

	@Getter @Setter
	private String addressType;

	@Getter @Setter
	private int customerId;
	
}
