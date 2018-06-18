package com.qa.models;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Author {

	@Id @Getter @Setter
	private int authorId;
	
	@Getter @Setter
	private String authorName;
	
	@Getter @Setter
	private String aboutAuthor;
	
	@Getter @Setter
	private String affiliations;
	
	@Getter @Setter
	private String expertise;
	
}
