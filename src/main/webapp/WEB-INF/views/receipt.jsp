<!doctype html>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.qa.models.*" %>
<%@ page import="java.time.LocalTime" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="sun.security.util.Length" %>
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
    Address address;
    BigDecimal orderTotal;
    Map<Integer, Integer> bookCounts;
    Purchase p;
    ArrayList<Book> books;

  %>
  <%
    try {
            c = (Customer) session.getAttribute("logged_in_customer");
        } catch(Exception e){
            c = null;
        }
    address = (Address) request.getAttribute("shipping_address");
    orderTotal = (BigDecimal) session.getAttribute("order_total");
    bookCounts = (Map<Integer, Integer>) request.getAttribute("book_counts");
    p = (Purchase) request.getAttribute("purchase");
    books  = (ArrayList<Book>) session.getAttribute("cart_items");

  %>

  <!-- Start Top Bar -->
  <nav class="navbar navbar-expand-lg navbar-dark fixed-top nav_background">
    <div class="container">
      <a class="navbar-brand" href="/">Undercover Books</a>
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

  <br>

  <div class="container">
    <div class="card third_color">
      <div class="card-title ml-2">
        <h2>Invoice</h2><h3 class="pull-right">Order # <%=p.getOrderId()%></h3>
      </div>
      <div class="row">
        <div class="col-lg-3 ml-2">
          <address>
            <strong>Billed To:</strong><br>
            <%=c.getFirstName()%> <%=c.getLastName()%><br>
            <%=address.getAddressLine1()%><br>
            <%=address.getAddressLine2()%><br>
            <%=address.getCity()%>, <%=address.getState()%> <%=address.getPostcode()%>
          </address>
        </div>
        <div class="col-lg-3">
          <address>
            <strong>Shipped To:</strong><br>
            <%=c.getFirstName()%> <%=c.getLastName()%><br>
            <%=address.getAddressLine1()%><br>
            <%=address.getAddressLine2()%><br>
            <%=address.getCity()%>, <%=address.getState()%> <%=address.getPostcode()%>
          </address>
        </div>
        <div class="col-lg-3">
          <address>
            <strong>Payment Method:</strong><br>
            <%=p.getCardType()%> ending in <%=p.getCardNumber().substring(p.getCardNumber().length() - 4)%><br>
            <%=c.getEmail()%>
          </address>
        </div>
        <div class="col-lg-2">
          <address>
            <strong>Order Date:</strong><br>
            <%=LocalDate.now()%>
            <br><br>
          </address>

        </div>
      </div>
      <div class="row">
        <div class="col-md-12">
          <div class="panel panel-default">
            <div class="panel-heading">
              <h3 class="panel-title ml-2"><strong>Order summary</strong></h3>
            </div>
            <div class="panel-body">
              <div class="table-responsive">
                <table class="table table-condensed">
                  <thead>
                  <tr>
                    <td><strong>Item</strong></td>
                    <td class="text-center"><strong>Price</strong></td>
                    <td class="text-center"><strong>Quantity</strong></td>
                    <td class="text-right"><strong>Totals</strong></td>
                  </tr>
                  </thead>
                  <tbody>
                  <%
                    for (Book book : books) {
                      BigDecimal bookprice = book.getPrice();
                      Integer bookCount = bookCounts.get(book.getBookId());
                      BigDecimal totalPrice = bookprice.multiply(BigDecimal.valueOf(bookCount));

                  %>
                    <tr>
                      <td><%=book.getTitle()%></td>
                      <td class="text-center">$<%=book.getPrice()%></td>
                      <td class="text-center"><%=bookCounts.get(book.getBookId())%></td>
                      <td class="text-right">$<%=totalPrice%></td>
                    </tr>
                  <%
                    }
                  %>

                  <tr>
                    <td class="thick-line"></td>
                    <td class="thick-line"></td>
                    <td class="thick-line text-center"><strong>Subtotal</strong></td>
                    <td class="thick-line text-right">$<%=p.getTotalPrice()%></td>
                  </tr>
                  <tr>
                    <td class="no-line"></td>
                    <td class="no-line"></td>
                    <td class="no-line text-center"><strong>Shipping</strong></td>
                    <td class="no-line text-right">$15</td>
                  </tr>
                  <%
                    BigDecimal finalTotal = p.getTotalPrice().add(BigDecimal.valueOf(15));
                  %>
                  <tr>
                    <td class="no-line"></td>
                    <td class="no-line"></td>
                    <td class="no-line text-center"><strong>Total</strong></td>
                    <td class="no-line text-right">$<%=finalTotal%></td>
                  </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>


<script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
  <script src="js/elsevier.js"></script>
  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  <script>
      $(document).foundation();
  </script>
</body>
</html>