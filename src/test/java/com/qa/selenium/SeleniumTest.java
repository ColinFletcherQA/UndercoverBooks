package com.qa.selenium;

import org.junit.Test;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

public class SeleniumTest {
	
	@Test
	public void navigateToHomePage() throws InterruptedException {
		System.setProperty("webdriver.chrome.driver", "/Users/glickmanj/Downloads/chromedriver");
		WebDriver driver = new ChromeDriver();
		driver.get("http://localhost:4444");
		Thread.sleep(3000);
	}
	
}
