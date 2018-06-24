<%@ page import="com.qa.models.Customer" %>
<%@ page import="com.qa.models.Purchase" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0 ">
  <title>Undercover Books</title>
  <link rel="stylesheet" href="css/bootstrap.css"/>
  <link rel="stylesheet" href="css/shop-homepage.css"/>
</head>
<body>

  <%!
    Customer c;
    List<Purchase> orderList;
  %>
  <%
    try {
      c = (Customer) session.getAttribute("logged_in_customer");
    } catch(Exception e){
      c = null;
    }

//    orderList = (List<Purchase>) session.getAttribute("order_list");
  %>

  <nav class="navbar navbar-expand-lg navbar-dark nav_background fixed-top">
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

          <li class="nav-item active">
            <a class="nav-link" href="/orderHistory">Order History</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/viewCart">View Cart</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/logout">Logout</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <div class="container">
    <h1 class="mt-5 mt-xl-1 mt-lg-1 mt-md-1 mt-sm-1">Order History
    </h1>
    <ol class="breadcrumb">
      <li class="breadcrumb-item">
        <a href="/"><span>Home</span></a>
      </li>
      <li class="breadcrumb-item">
        <a href="/customerHome"><span>Customer Home</span></a>
      </li>
      <li class="breadcrumb-item active" aria-current="page">Order History</li>
    </ol>


    <div class="row">
      <div class="col-lg-1">
       <%--Placeholder --%>
      </div>
      <div class="col-lg-10">
        <div class="card third_color">
            <div class="card-header">
              <div class="row">
                <div class="col-lg-3">
                  <h6>Order Date:</h6>
                  <small class="text-muted">June 10th, 2016</small>
                </div>
                <div class="col-lg-2">
                  <h6>Total:</h6>
                  <small class="text-muted">$7.16</small>
                </div>
                <div class="col-lg-4">
                  <h6>Shipped To:</h6>
                  <small class="text-muted">Chandler Todd</small>
                </div>
                <div class="col-lg-3 text-right">
                  <h6>Order Number: 2</h6>
                  <small class="text-muted"><a href="#">Receipt</a></small>
                </div>
              </div>
            </div>
            <div class="card-body">
              <div class="row">
                <div class="col-4-lg">
                  Picture Placeholder
                </div>
                <div class="col-4-lg">
                </div>
              </div>
            </div>
        </div>
      </div>
    </div>
  </div>

  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  <script>
    $(document).foundation();
  </script>
</body>
</html>