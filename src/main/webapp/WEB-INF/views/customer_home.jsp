<!doctype html>
<%@page import="com.qa.models.Customer"%>
<%@page import="com.qa.models.Address"%>
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
  %>
  <%
  try {
        c = (Customer) session.getAttribute("logged_in_customer");
      } catch(Exception e){
        c = null;
      }
  address = (Address) request.getAttribute("Address");
  %>
    
    <!-- Start Top Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark second_color fixed-top">
      <div class="container">
        <a class="navbar-brand" href="/">Undercover Books</a>
        <form class="form-inline" action="/search">
          <input name="searchTerm" class="form-control" type="text" placeholder="Search" aria-label="Search">
          <select name = "searchOption" class="custom-select">
            <option value="title">Title</option>
            <option value="isbn">ISBN / Kindle ASIN</option>
            <option value="author">Author</option>
            <option value="publisher">Publisher</option>
            <option value="description">Description</option>
          </select>
        </form>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
            <%
              if (c != null) {
            %>
            <li class="nav-item active">
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
    <!-- End Top Bar -->
    <div class="container mt-5 mt-xl-0 mt-lg-0 mt-md-0 mt-sm-5">
      <h1 class="mt-5 mt-xl-1 mt-lg-1 mt-md-1 mt-sm-1">Customer Home
      </h1>
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="/"><span>Home</span></a>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Customer Home</li>
      </ol>
      <div class="m-4">
        <div class="row">
          <div class="col-lg-2"></div>
          <div class="col-lg-8">
            <div class="card forth_color">
              <form action="/updateProfile" method="post">
                <div class="card-body">
                  <h4 class="card-title text-center">Account Details</h4>
                  <div class="form-row">
                    <div class="form-group col-lg-12">
                      <label for="firstName">First Name</label>
                      <input name="firstName" id="firstName" type="text" class="form-control" placeholder="<%=c.getFirstName()%>" value="<%=c.getFirstName()%>">
                    </div>
                  </div>
                  <div class="form-row">
                    <div class="form-group col-lg-12">
                      <label for="lastName">First Name</label>
                      <input name="lastName" id="lastName" type="text" class="form-control" placeholder="<%=c.getLastName()%>" value="<%=c.getLastName()%>">
                      <div class="invalid-feedback">Please enter a last name</div>
                    </div>
                  </div>
                  <div class="form-row">
                    <div class="form-group col-lg-12">
                      <label for="email">Email</label>
                      <input name="email" id="email" type="text" class="form-control" placeholder="<%=c.getEmail()%>" value="<%=c.getEmail()%>">
                      <div class="invalid-feedback">Please enter a valid email</div>
                    </div>
                  </div>
                  <div>
                    ${profile_flag.getMessage()}
                  </div>
                  <button type="submit" class="btn third_color"><span>Update Information</span></button>
                </div>
              </form>
            </div>
          </div>
        </div>

        <br>
        <div class="row">
          <div class="col-lg-2"></div>
          <div class="col-lg-8">
            <div class="card forth_color">
              <form action="/updatePassword" method="post" id="password">
                <div class="card-body">
                  <h4 class="card-title text-center">Update Password</h4>
                  <div class="form-row">
                    <div class="form-group col-lg-12">
                      <label for="current_password">Current Password</label>
                      <input name="current_password" id="current_password" class="form-control" type="password" placeholder="Current Password" required>
                    </div>
                  </div>
                  <div class="form-row">
                    <div class="form-group col-lg-12">
                      <label for="new_password">New Password</label>
                      <input name="new_password" id="new_password" class="form-control" type="password" placeholder="New Password" required>
                    </div>
                  </div>
                  <div class="form-row">
                    <div class="form-group col-lg-12">
                      <label for="new_password1">Confirm New Password</label>
                      <input name="new_password1" id="new_password1" class="form-control" type="password" placeholder="New Password" required>
                    </div>
                  </div>
                  <div>
                    ${password_flag.getMessage()}
                  </div>
                  <button type="submit" class="btn third_color"><span>Update Password</span></button>
                </div>
              </form>
            </div>
          </div>
        </div>
        <br>
        <div class="row">
          <div class="col-lg-2"></div>
          <div class="col-lg-8">
            <div class="card forth_color">
              <form action="/updateAddress" method="post">
                <div class="card-body">
                  <h4 class="card-title text-center">Update Shipping Address</h4>
                  <div class="form-row">
                    <div class="form-group col-lg-12">
                      <label for="addressLine1">Address</label>
                      <input type="text" class="form-control" name="addressLine1" id="addressLine1" value="<% if (address != null) { address.getAddressLine1();}%>" required>
                    </div>
                  </div>
                  <div class="form-row">
                    <div class="form-group col-lg-12">
                      <label for="addressLine2">Address 2</label>
                      <input type="text" class="form-control" name="addressLine2" id="addressLine2" value="<% if (address != null) {address.getAddressLine2();}%>" required>
                    </div>
                  </div>
                  <div class="form-row">
                    <div class="form-group col-lg-4">
                      <label for="city">City</label>
                      <input type="text" class="form-control" name="city" id="city" value="<% if (address != null) {address.getCity();}%>" required>
                    </div>
                    <div class="form-group col-lg-2">
                      <label for="postcode">Zip</label>
                      <input type="text" class="form-control" name="postcode" id="postcode" value="<% if (address != null) {address.getPostcode();}%>" required>
                    </div>
                    <div class="form-group col-lg-2">
                      <label for="state">State</label>
                      <input type="text" class="form-control" name="state" id="state" placeholder="PA" value="<% if (address != null) {address.getState();}%>" required>
                    </div>
                    <div class="form-group col-lg-4">
                      <label for="country">Country</label>
                      <input type="text" class="form-control" name="country" id="country" value="<% if (address != null) {address.getCountry();}%>" required>
                    </div>
                  </div>
                  <div class="form-row">
                    <div class="form-group col-lg-6">
                      <label for="phone">Phone Number</label>
                      <input type="tel" class="form-control" name="phoneNumber" id="phone" value="<% if (address != null) {address.getPhoneNumber();}%>" required>
                    </div>
                  </div>
                  <input type="hidden" name="addressType" value="shipping">
                  <input type="hidden" name="customerId" value="<%=c.getCustomerId()%>">
                  <div>
                    ${shipping_flag.getMessage()}
                  </div>
                  <button type="submit" class="btn third_color"><span>Update Shipping Address</span></button>
                </div>
              </form>
            </div>
          </div>
        </div>
        <br>

        <%--<div class="row">--%>
          <%--<div class="col-lg-2"></div>--%>
          <%--<div class="col-lg-8">--%>
            <%--<div class="card pale_red_color">--%>
              <%--<form action="/updateAddress" method="post">--%>
                <%--<div class="card-body">--%>
                  <%--<h4 class="card-title text-center">Update Billing Address</h4>--%>
                  <%--<div class="form-row">--%>
                    <%--<div class="form-group col-lg-12">--%>
                      <%--<label for="billingaddressline1">Address</label>--%>
                      <%--<input type="text" class="form-control" id="billingaddressline1" placeholder="123 Main St" required>--%>
                    <%--</div>--%>
                  <%--</div>--%>
                  <%--<div class="form-row">--%>
                    <%--<div class="form-group col-lg-12">--%>
                      <%--<label for="billingaddressline2">Address 2</label>--%>
                      <%--<input type="text" class="form-control" id="billingaddressline2" placeholder="Apartment, studio, or floor" required>--%>
                    <%--</div>--%>
                  <%--</div>--%>
                  <%--<div class="form-row">--%>
                    <%--<div class="form-group col-lg-4">--%>
                      <%--<label for="billingcity">City</label>--%>
                      <%--<input type="text" class="form-control" id="billingcity" required>--%>
                    <%--</div>--%>
                    <%--<div class="form-group col-lg-2">--%>
                      <%--<label for="billingpostcode">Zip</label>--%>
                      <%--<input type="text" class="form-control" id="billingpostcode" required>--%>
                    <%--</div>--%>
                    <%--<div class="form-group col-lg-2">--%>
                      <%--<label for="billingstate">State</label>--%>
                      <%--<input type="text" class="form-control" id="billingstate" placeholder="PA" required>--%>
                    <%--</div>--%>
                    <%--<div class="form-group col-lg-4">--%>
                      <%--<label for="billingcountry">Country</label>--%>
                      <%--<input type="text" class="form-control" id="billingcountry" required>--%>
                    <%--</div>--%>
                  <%--</div>--%>
                  <%--<div class="form-row">--%>
                    <%--<div class="form-group col-lg-6">--%>
                      <%--<label for="billingphone">Phone Number</label>--%>
                      <%--<input type="tel" class="form-control" id="billingphone" required>--%>
                    <%--</div>--%>
                  <%--</div>--%>
                  <%--<button type="submit" class="btn dark_grey_color"><span>Update Billing Address</span></button>--%>
                <%--</div>--%>
              <%--</form>--%>
            <%--</div>--%>
          <%--</div>--%>
        <%--</div>--%>
       </div>
      </div>


  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
  <script src="js/password.js"></script>
  <script src="js/elsevier.js"></script>
    <script>
      $(document).foundation();
    </script>
  </body>
</html>


    