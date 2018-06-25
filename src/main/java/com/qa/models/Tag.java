package com.qa.models;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Tag {

	@Id @Getter @Setter
	private int tagId;
	
	@Getter @Setter
	private String tagName;

	@Getter @Setter
	private String tagImage;
	
}
