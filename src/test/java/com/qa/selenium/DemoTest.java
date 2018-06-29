package com.qa.selenium;

import org.junit.Ignore;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;

@Ignore
public class DemoTest extends SeleniumTest {

    @Test
    public void demoTest() throws InterruptedException {
        openPage();
        navigateToRegister();
        WebElement firstName = driver.findElement(By.id("firstName"));
        WebElement lastName = driver.findElement(By.id("lastName"));
        WebElement email = driver.findElement(By.id("email"));
        WebElement password = driver.findElement(By.id("password"));
        WebElement registerButton = driver.findElement(By.id("register"));
        firstName.sendKeys("Sally");
        Thread.sleep(1000);
        lastName.sendKeys("Smith");
        Thread.sleep(1000);
        email.sendKeys("sally@aol.com");
        Thread.sleep(1000);
        password.sendKeys("password");
        Thread.sleep(2000);
        registerButton.click();
        Thread.sleep(3000);
        WebElement searchBox = driver.findElement(By.name("searchTerm"));
        searchBox.sendKeys("harry");
        searchBox.sendKeys(Keys.ENTER);
        Thread.sleep(3000);
        WebElement breadcrumb = driver.findElement(By.className("breadcrumb"));
        WebElement book = driver.findElement(By.xpath("/html/body/div/div[2]/div[3]/div/a/img"));
        book.click();
        Thread.sleep(4000);
        JavascriptExecutor js = (JavascriptExecutor) driver;
        js.executeScript("window.scrollBy(0,1000)");
        Thread.sleep(8000);
        WebElement addToCart = driver.findElement(By.xpath("//*[@id=\"add-to-cart-anchor\"]"));
        WebElement bookImg = driver.findElement(By.xpath("/html/body/div/div[2]/div[1]/div/div[1]/div/img"));
        js.executeScript("arguments[0].scrollIntoView();",bookImg);
        Thread.sleep(5000);
        addToCart.click();
        Thread.sleep(2000);
        WebElement viewCart = driver.findElement(By.id("view-cart-anchor"));
        viewCart.click();
        Thread.sleep(3000);
        WebElement proceedButton = driver.findElement(By.id("btn button_color"));
        proceedButton.click();
        Thread.sleep(3000);

        WebElement firstNameShip = driver.findElement(By.id("firstName"));
        WebElement lastNameShip = driver.findElement(By.id("lastName"));
        WebElement address1Ship = driver.findElement(By.id("addressLine1"));
        WebElement address2Ship = driver.findElement(By.id("addressLine2"));
        WebElement cityShip = driver.findElement(By.id("city"));
        WebElement postcodeShip = driver.findElement(By.id("postcode"));
        WebElement stateShip = driver.findElement(By.id("state"));
        WebElement countryShip = driver.findElement(By.id("country"));
        WebElement phoneShip = driver.findElement(By.id("phoneNumber"));
        WebElement emailShip = driver.findElement(By.id("email"));
        WebElement checkShip = driver.findElement(By.id("gridCheck"));
        WebElement creditCard = driver.findElement(By.xpath("/html/body/div/div[2]/div[2]/div/div/form/div[8]/div/div[1]/label/input"));
        WebElement cardName = driver.findElement(By.id("cardName"));
        WebElement cardNumber = driver.findElement(By.id("cardNumber"));
        WebElement cardExp = driver.findElement(By.id("cardExpiration"));
        WebElement cardCVV = driver.findElement(By.id("cardCVV"));

        firstNameShip.sendKeys("Sally");
        Thread.sleep(500);
        lastNameShip.sendKeys("Smith");
        Thread.sleep(500);
        address1Ship.sendKeys("123 Main St");
        Thread.sleep(500);
        address2Ship.sendKeys("Apt 3");
        Thread.sleep(500);
        cityShip.sendKeys("Orlando");
        Thread.sleep(500);
        postcodeShip.sendKeys("34746");
        Thread.sleep(500);
        stateShip.sendKeys("FL");
        Thread.sleep(500);
        countryShip.sendKeys("United States");
        Thread.sleep(500);
        phoneShip.sendKeys("1234567890");
        Thread.sleep(500);
        emailShip.sendKeys("sally@aol.com");
        Thread.sleep(500);
        checkShip.click();
        Thread.sleep(500);
        creditCard.click();
        Thread.sleep(500);
        cardName.sendKeys("Sally Smith");
        Thread.sleep(500);
        cardNumber.sendKeys("111122223333444");
        Thread.sleep(500);
        cardExp.sendKeys("04/11");
        Thread.sleep(500);
        cardCVV.sendKeys("789");
        Thread.sleep(500);

        WebElement checkout = driver.findElement(By.className("btn button_color"));
        Thread.sleep(2000);
        checkout.click();
        Thread.sleep(3000);
        cardNumber.clear();
        Thread.sleep(500);
        cardNumber.sendKeys("1111222233334444");
        Thread.sleep(2000);
        checkout.click();


    }


}
