package com.qa.models;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Series {

	@Id @Getter @Setter
	private int seriesId;
	
	@Getter @Setter
	private String seriesName;
	
}
