<!doctype html>
<%@page import="java.math.*"%>
<%@page import="java.util.*"%>
<%@page import="com.qa.models.Book"%>
<%@page import="com.qa.models.Customer"%>
<html class="no-js" lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Undercover Books</title>
    <link rel="stylesheet" href="css/bootstrap.css"/>
    <link rel="stylesheet" href="css/shop-homepage.css"/>
  </head>
  <body>
    
    <%!
      Customer c;
      Map<Book, Integer> bookCounts;
    %>

    <%
      try {
              c = (Customer) session.getAttribute("logged_in_customer");
          } catch(Exception e){
              c = null;
          }
      bookCounts = (Map<Book, Integer>) session.getAttribute("cart_items");

      BigDecimal totalPrice = BigDecimal.ZERO;
      BigDecimal cartTotal = BigDecimal.ZERO;
      BigDecimal orderTotal = BigDecimal.ZERO;
      BigDecimal totalTax = BigDecimal.ZERO;
    %>

<!-- Start Top Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top nav_background">
      <div class="container">
        <a class="navbar-brand" href="/">Undercover Books</a>
        <form class="form-inline" action="/search">
          <input name="searchTerm" class="form-control" type="text" placeholder="Search" aria-label="Search">
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
              <a class="nav-link active" href="/viewCart">View Cart</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>
    <!-- End Top Bar -->
    <br>
    <!-- You can now combine a row and column if you just need a 12 column row -->
    <div class="container">
      <h1 class="mb-3">Cart Details
      </h1>
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="/"><span>Home</span></a>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Cart Details</li>
      </ol>
        <div class="row">
          <div class="col-lg-9">
            <div class="card-deck">
              <%
              int i = 0;

              for (Map.Entry<Book, Integer> entry : bookCounts.entrySet()) {
              	  i++;
              	  Book book = entry.getKey();
                  int quantity = entry.getValue();
                  BigDecimal price = book.getPrice();
                  totalPrice = price.multiply(BigDecimal.valueOf(quantity));
                  cartTotal = cartTotal.add(totalPrice);
              %>
              <div class="card col-lg-3 col-md-4 col-sm-6 third_color">
                <img class="card-img-top" src="<%=book.getBookImage()%>"/>
                <div class="card-body">
                  <form name="f1">
                    <input type="hidden" name="price" value="<%=price%>"/>
                    <input type="hidden" name="cart_total" value="<%=cartTotal%>"/>
                    <label id="price_label<%=i%>">Price: $<%=totalPrice%></label>
                    <br>
                    <label>Quantity</label>
                    <a class="btn minus" onclick="decreaseQuantity(<%=price%>, price_label<%=i%>, quantity<%=i%>);">-</a>
                      <label id="quantity<%=i%>"><%=quantity%></label>
                    <a class="btn plus" onclick="increaseQuantity(<%=price%>, price_label<%=i%>, quantity<%=i%>);">+</a>
                  </form>
                  <br>
                  <a class="btn secondary_color" href="/removeFromCart?bookId=<%=book.getBookId() %>"><span>Remove</span></a>
                </div>
              </div>
              <%
              }
              System.out.println("Cart Total " + cartTotal);
              %>

          </div>
        </div>
        <div class="col-lg-3">
          <div class="card third_color">
            <div class="card-header">
              <h3>Order Summary </h3>
            </div>
            <div class="card-body">
              <div class="row">
                <div class="col-lg-6">
                  <label>Cart Total</label>
                </div>
                <div class="col-lg-6">
                  <input type="hidden" name="order_total" id="cart_total" value="<%=cartTotal%>"/>
                  <label class="middle" id="cart_total_label">$<%=cartTotal %></label>
                </div>
              </div>
              <%
                totalTax = cartTotal.multiply(BigDecimal.valueOf(0.08));
                orderTotal = totalTax.add(cartTotal);
                totalTax = totalTax.setScale(2, RoundingMode.HALF_UP);
                orderTotal = orderTotal.setScale(2, RoundingMode.HALF_EVEN);
              %>
              <div class="row">
                <div class="col-lg-6">
                  <label>Total Tax</label>
                </div>
                <div class="col-lg-6">
                  <input type="hidden" name="tax_total" id="cart_tax" value="<%=totalTax%>"/>
                  <label class="middle" id="cart_tax_label">$<%=totalTax %></label>
                </div>
              </div>
              <div class="row">
                <div class="col-lg-6">
                  <label>Order Total</label>
                </div>
                <div class="col-lg-6">
                  <input type="hidden" name="order_total" id="order_total" value="<%=orderTotal %>"/>
                  <label class="middle" id="order_total_label">$<%=orderTotal%></label>
                </div>
              </div>
              <div class="card-footer">
                <form action="/checkout" method="post" id="checkout_form">
                  <input type="hidden" name="tax_total" value="<%=totalTax%>"/>
                  <input type="hidden" name="order_total" value="<%=orderTotal%>"/>
                  <%
                    if (bookCounts.isEmpty()) {
                  %>
                      <button type="button" class="btn secondary_color" disabled><span>Proceed to Checkout</span></button>
                  <%
                    } else if (c != null) {
                  %>
                      <button type="submit" class="btn secondary_color"><span>Proceed to Checkout</span></button>
                  <%
                    } else {
                  %>
                      <a href="/login" class="btn secondary_color"><span>Login or Register</span></a>
                  <%
                    }
                  %>

                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>


    <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
    <script src="js/elsevier.js"></script>
    <script src="js/update_cart.js"></script>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script>
      $(document).foundation();
    </script> 
  </body>
</html>


    