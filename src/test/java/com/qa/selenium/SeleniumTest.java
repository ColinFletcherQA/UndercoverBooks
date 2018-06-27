package com.qa.selenium;

import org.junit.AfterClass;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.Select;

public class SeleniumTest {

	static {
		System.setProperty("webdriver.chrome.driver", "/Users/todd1/Downloads/chromedriver");
	}

	private static WebDriver driver = new ChromeDriver();

	@Test
	public void navigateToHomePage() throws InterruptedException {
		System.setProperty("webdriver.chrome.driver", "src/main/resources/chromedriver");
		WebDriver driver = new ChromeDriver();
		openPage();
	}
  
	@Test
	public void navigateToBestSellers() throws InterruptedException {
		openPage();
		WebElement bestSellers = driver.findElement(By.id("bestSellers"));
		bestSellers.click();
		Thread.sleep(3000);
		driver.findElement(By.className("breadcrumb"));
	}
  
	@Test
	public void navigateToNewReleases() throws InterruptedException {
		openPage();
		WebElement newReleases = driver.findElement(By.id("newReleases"));
		newReleases.click();
		Thread.sleep(3000);
		driver.findElement(By.className("breadcrumb"));
	}
  
	@Test
	public void navigateToGenres() throws InterruptedException {
		openPage();
		WebElement genres = driver.findElement(By.id("genres"));
		genres.click();
		Thread.sleep(3000);
		driver.findElement(By.className("breadcrumb"));
	}
  
	@Test
	public void navigateToSeries() throws InterruptedException {
		openPage();
		WebElement genres = driver.findElement(By.id("series"));
		genres.click();
		Thread.sleep(3000);
		driver.findElement(By.className("breadcrumb"));
	}
  
	@Test
	public void navigateToAboutUs() throws InterruptedException {
		openPage();
		WebElement aboutUs = driver.findElement(By.id("aboutUs"));
		aboutUs.click();
		Thread.sleep(3000);
		driver.findElement(By.className("breadcrumb"));
	}
  
	@Test
	public void navigateToContactUs() throws InterruptedException {
		openPage();
		WebElement contactUs = driver.findElement(By.id("contactUs"));
		contactUs.click();
		Thread.sleep(3000);
		driver.findElement(By.className("breadcrumb"));
	}
  
	@Test
	public void navigateToViewCart() throws InterruptedException {
		openPage();
		WebElement viewCart = driver.findElement(By.id("viewCart"));
		viewCart.click();
		Thread.sleep(3000);
		driver.findElement(By.className("breadcrumb"));
	}
  
	@Test
	public void navigateToLogin() throws InterruptedException {
		openPage();
		WebElement navbar = driver.findElement(By.id("navbarDropdown"));
		navbar.click();
		Thread.sleep(1000);
		WebElement login = driver.findElement(By.id("login"));
		login.click();
		Thread.sleep(3000);
		driver.findElement(By.className("breadcrumb"));
	}
  
	@Test
	public void navigateToRegister() throws InterruptedException {
		openPage();
		WebElement navbar = driver.findElement(By.id("navbarDropdown"));
		navbar.click();
		Thread.sleep(1000);
		WebElement register = driver.findElement(By.id("register"));
		register.click();
		Thread.sleep(3000);
		driver.findElement(By.className("breadcrumb"));
	}
  
	@Test
	public void navigateToBookDetails() throws InterruptedException {
		openPage();
		WebElement cardImg = driver.findElement(By.className("card-img-top"));
		cardImg.click();
		Thread.sleep(3000);
		driver.findElement(By.className("breadcrumb"));
	}
  
	@Test
	public void login() throws InterruptedException {
		navigateToLogin();
		WebElement email = driver.findElement(By.id("email"));
		WebElement password = driver.findElement(By.id("password"));
		email.sendKeys("test@gmail.com");
		password.sendKeys("12345");
		Thread.sleep(1000);
		WebElement submit = driver.findElement(By.id("loginButton"));
		submit.click();
		Thread.sleep(2000);
		driver.findElement(By.id("customerHome"));
	}
  
	@Test
	public void testSearchTitle() throws InterruptedException {
		openPage();
		WebElement searchBox = driver.findElement(By.name("searchTerm"));
		searchBox.sendKeys("harry");
		searchBox.sendKeys(Keys.ENTER);
		Thread.sleep(3000);
		driver.findElement(By.className("breadcrumb"));
	}
  
	@Test
	public void testSearchAuthor() throws InterruptedException {
		openPage();
		Select dropdown = new Select(driver.findElement(By.name("searchOption")));
		dropdown.selectByVisibleText("Author");
		Thread.sleep(1000);
		WebElement searchBox = driver.findElement(By.name("searchTerm"));
		searchBox.sendKeys("chandler");
		searchBox.sendKeys(Keys.ENTER);
		Thread.sleep(3000);
		driver.findElement(By.className("breadcrumb"));
	}
	@Test
	public void testSearchDescription() throws InterruptedException {
		openPage();
		Select dropdown = new Select(driver.findElement(By.name("searchOption")));
		dropdown.selectByVisibleText("Description");
		Thread.sleep(1000);
		WebElement searchBox = driver.findElement(By.name("searchTerm"));
		searchBox.sendKeys("vampire");
		searchBox.sendKeys(Keys.ENTER);
		Thread.sleep(3000);
		driver.findElement(By.className("breadcrumb"));
	}


	public void openPage() throws InterruptedException {
		driver.get("http://localhost:4444");
		Thread.sleep(3000);
	}

	@AfterClass
	public static void tearDown() {
		driver.close();
		driver.quit();
	}
}

