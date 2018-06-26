package com.qa;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = {"com.qa.controllers", "com.qa.restful.controllers", "com.qa.models", "com.qa.services"})
public class ElsevierProjectApplication extends SpringBootServletInitializer {
	
	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(ElsevierProjectApplication.class);
	}
	
	public static void main(String[] args) {
		SpringApplication.run(ElsevierProjectApplication.class, args);
	}

}
