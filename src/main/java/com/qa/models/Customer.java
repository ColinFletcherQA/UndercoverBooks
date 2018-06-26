package com.qa.models;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnTransformer;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class Customer {

	@Id @GeneratedValue @Getter @Setter
	private int customerId;
	
	@Getter @Setter
	private String firstName;
	
	@Getter @Setter
	private String lastName;
	
	@Getter @Setter @Column(unique = true)
	private String email;
	
	@Getter @Setter
	private String password;
}
