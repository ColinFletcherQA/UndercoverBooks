<!doctype html>
<%@page import="java.util.Map"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.qa.models.*"%>
<%@ page import="java.math.BigDecimal" %>
<html class="no-js" lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Undercover Books</title>
    <link rel="stylesheet" href="css/bootstrap.css"/>
    <link rel="stylesheet" href="css/shop-homepage.css"/>
  </head>
  <body>

     <%
    BigDecimal orderTotal = (BigDecimal) request.getAttribute("order_total");
    BigDecimal taxTotal = (BigDecimal) request.getAttribute("tax_total");

    ArrayList<Book> books;
    books  = (ArrayList<Book>) session.getAttribute("cart_items");
    %>

     <%!
       Customer c;
     %>
     <%
       c = (Customer) session.getAttribute("logged_in_customer");
     %>

     <!-- Start Top Bar -->
     <nav class="navbar navbar-expand-lg navbar-dark fixed-top nav_background">
       <div class="container">
         <a class="navbar-brand" href="">Undercover Books</a>
         <form class="form-inline" action="/search">
           <input class="form-control" type="text" placeholder="Search" aria-label="Search">
         </form>
         <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
           <span class="navbar-toggler-icon"></span>
         </button>
         <div class="collapse navbar-collapse" id="navbarResponsive">
           <ul class="navbar-nav ml-auto">
             <%
               if (c != null) {
             %>
             <li class="nav-item">
               <a class="nav-link" href="/customerHome">Customer Home</a>
             </li>
             <%
             } else {
             %>
             <li class="nav-item dropdown">
               <a class="nav-link dropdown-toggle" href="" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                 Account
               </a>
               <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                 <a class="dropdown-item" href="/login">Login</a>
                 <a class="dropdown-item" href="/register">Register</a>
               </div>
             </li>
             <%
               }
             %>

             <li class="nav-item">
               <a class="nav-link" href="/about">About Us</a>
             </li>
             <li class="nav-item">
               <a class="nav-link" href="/contact">Contact Us</a>
             </li>
             <li class="nav-item">
               <a class="nav-link" href="/viewCart">View Cart</a>
             </li>
           </ul>
         </div>
       </div>
     </nav>
    <!-- End Top Bar -->
     <br>
    <!-- You can now combine a row and column if you just need a 12 column row -->
    <div class="container" style="padding-bottom: 25px;">
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="/"><span>Home</span></a>
        </li>
        <li class="breadcrumb-item">
          <a href="/viewCart"><span>Cart Details</span></a>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Checkout</li>
      </ol>
      <div class="row">
        <div class="col-lg-4 order-lg-2">
          <div class="card third_color">
            <div class="card-body">
              <h4 class="d-flex justify-content-between align-items-center mb-3">
                <span class="text-muted">Your cart</span>
                <span class="badge badge-secondary badge-pill"><%=books.size()%></span>
              </h4>
              <ul class="list-group mb-3">
                <%
                  for(Book book: books)
                  {
                %>
                <li class="list-group-item d-flex justify-content-between lh-condensed">
                  <div>
                    <h6><%=book.getTitle()%></h6>
                    <small class="text-muted">Authors</small>
                  </div>
                  <span class="text-muted">$<%=book.getPrice()%></span>
                </li>
                <%
                  }
                %>
                <li class="list-group-item d-flex justify-content-between">
                  <span>Tax </span>
                  <strong>$<%=taxTotal%></strong>
                </li>
                <li class="list-group-item d-flex justify-content-between">
                  <span>Total (USD)</span>
                  <strong>$<%=orderTotal%></strong>
                </li>
              </ul>
            </div>
          </div>
        </div>
        <div class="col-lg-8 order-lg-1">
          <div class="card third_color">
            <div class="card-body">
              <form action="/checkoutProcess" method="post">
                <h2>Shipping Information</h2>
                <div class="form-row">
                  <div class="form-group col-lg-6">
                    <label for="firstName">First Name</label>
                    <input name="firstName" type="text" class="form-control" id="firstName" placeholder="First Name">
                  </div>
                  <div class="form-group col-lg-6">
                    <label for="lastName">Last Name</label>
                    <input name="lastName" type="text" class="form-control" id="lastName" placeholder="Last Name">
                  </div>
                </div>
                <div class="form-row">
                  <div class="form-group col-lg-12">
                    <label for="addressLine1">Address</label>
                    <input name="addressLine1" type="text" class="form-control" id="addressLine1" placeholder="123 Main St">
                  </div>
                </div>
                <div class="form-row">
                  <div class="form-group col-lg-12">
                    <label for="addressLine2">Address 2</label>
                    <input name="addressLine2" type="text" class="form-control" id="addressLine2" placeholder="Apartment, studio, or floor">
                  </div>
                </div>
                <div class="form-row">
                  <div class="form-group col-lg-4">
                    <label for="city">City</label>
                    <input type="text" class="form-control" id="city" name="city">
                  </div>
                  <div class="form-group col-lg-2">
                    <label for="postcode">Zip</label>
                    <input type="text" class="form-control" id="postcode" name="postcode">
                  </div>
                  <div class="form-group col-lg-2">
                    <label for="state">State</label>
                    <input type="text" class="form-control" id="state" placeholder="PA" name="state">
                  </div>
                  <div class="form-group col-lg-4">
                    <label for="country">Country</label>
                    <input type="text" class="form-control" id="country" name="country">
                  </div>
                </div>
                <div class="form-row">
                  <div class="form-group col-lg-6">
                    <label for="phoneNumber">Phone Number</label>
                    <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber">
                  </div>
                  <div class="form-group col-lg-6">
                    <label for="email">Email</label>
                    <input type="email" class="form-control" id="email" name="email">
                  </div>
                </div>
                <div class="form-group col-lg-12">
                  <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="gridCheck" onclick="myFunction()">
                    <label class="form-check-label" for="gridCheck">
                      Billing Address is the same as Shipping
                    </label>
                  </div>
                </div>
            <div id="billing">
              <br>
              <h2>Billing Address</h2>
              <div class="form-row">
                <div class="form-group col-lg-6">
                  <label for="firstName1">First Name</label>
                  <input type="text" class="form-control" id="firstName1" placeholder="First Name">
                </div>
                <div class="form-group col-lg-6">
                  <label for="lastName1">Last Name</label>
                  <input type="text" class="form-control" id="lastName1" placeholder="Last Name">
                </div>
              </div>
              <div class="form-row">
                <div class="form-group col-lg-12">
                  <label for="inputAddress1">Address</label>
                  <input type="text" class="form-control" id="inputAddress1" placeholder="123 Main St">
                </div>
              </div>
              <div class="form-row">
                <div class="form-group col-lg-12">
                  <label for="inputAddress21">Address 2</label>
                  <input type="text" class="form-control" id="inputAddress21" placeholder="Apartment, studio, or floor">
                </div>
              </div>
              <div class="form-row">
                <div class="form-group col-lg-4">
                  <label for="city1">City</label>
                  <input type="text" class="form-control" id="city1">
                </div>
                <div class="form-group col-lg-2">
                  <label for="postcode1">Zip</label>
                  <input type="text" class="form-control" id="postcode1">
                </div>
                <div class="form-group col-lg-2">
                  <label for="state1">State</label>
                  <input type="text" class="form-control" id="state1" placeholder="PA">
                </div>
                <div class="form-group col-lg-4">
                  <label for="country1">Country</label>
                  <input type="text" class="form-control" id="country1">
                </div>
              </div>
              <div class="form-row">
                <div class="form-group col-lg-6">
                  <label for="phone1">Phone Number</label>
                  <input type="tel" class="form-control" id="phone1">
                </div>
                <div class="form-group col-lg-6">
                  <label for="email1">Email</label>
                  <input type="email" class="form-control" id="email1">
                </div>
              </div>
            </div>
            <br>
            <h2>Payment</h2>
            <div class="form-row">
              <div class="form-group col-lg-12">
                <div class="form-check">
                  <label class="form-check-label">
                    <input class="form-check-input" type="radio" name="cardType" value="Credit Card" required>Credit Card
                  </label>
                </div>
                <div class="form-check">
                  <label class="form-check-label">
                    <input class="form-check-input" type="radio" name="cardType" value="Debit Card">Debit Card
                  </label>
                </div>
              </div>
            </div>
            <div class="form-row">
              <div class="form-group col-lg-6">
                <label for="cardName">Name on Card</label>
                <input type="text" class="form-control" id="cardName" name="cardName">
              </div>
              <div class="form-group col-lg-6">
                <label for="cardNumber">Card Number</label>
                <input type="number" class="form-control" id="cardNumber" name="cardNumber">
              </div>
            </div>
            <div class="form-row">
              <div class="form-group col-lg-3">
                <label for="cardExpiration">Expiration *</label>
                <input type="number" class="form-control" id="cardExpiration" placeholder="dd/mm">
              </div>
              <div class="form-group col-lg-3">
                <label for="cardCVV">CVV *</label>
                <input type="number" class="form-control" id="cardCVV">
              </div>
            </div>
            <input type="hidden" name="totalPrice" value="<%=orderTotal %>"/>
            <%--<input type="hidden" name="order_total" value="<%=orderTotal %>"/>--%>
            <%--<input type="hidden" name="books" value="<%=books%>"/>--%>
            <button type="submit" class="btn secondary_color"><span>Checkout</span></button>
          </form>
          </div>
        </div>
      </div>
    </div>
  </div>

   <script>
     function myFunction() {
         var x = document.getElementById("billing");
         if (x.style.display === "none") {
             x.style.display = "block";
         } else {
             x.style.display = "none";
         }
     }
   </script>

    <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
    <script src="js/elsevier.js"></script>
    <script src="js/update_cart.js"></script>
    
    <script src="js/validations.js"></script>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    <script>
      $(document).foundation();
    </script>
  </body>
</html>


    