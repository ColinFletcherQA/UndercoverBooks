<!doctype html>
<%@page import="com.qa.models.Customer"%>
<html class="no-js" lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Undercover Books</title>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/shop-homepage.css"/>
  </head>
  <body>
  
  <%!
  Customer c;
  %>
  <%
 		c = (Customer) session.getAttribute("logged_in_customer");
  %>
    
    <!-- Start Top Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
      <div class="container">
        <a class="navbar-brand" href="">Undercover Books</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item">
              <a class="nav-link" href="/">Home</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Order History</a>
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
    <div class="container">
      <%--<h3>You have logged in as <%=c.getFirstName() %></h3>--%>
      <div class="m-4">
      <div class="row">
        <div class="col-lg-6">
          <div class="card">
            <div class="card-header">
              <div class="card-title"><h4>Account Details</h4></div>
            </div>
            <form action="/updateProfile" method="post">
              <div class="card-body">
                <div class="form-row">
                  <div class="form-group col-lg-12">
                    <label for="firstName">First Name</label>
                    <input name="firstName" id="firstName" type="text" class="form-control" placeholder="<%=c.getFirstName()%>">
                  </div>
                </div>
                <div class="form-row">
                  <div class="form-group col-lg-12">
                    <label for="lastName">First Name</label>
                    <input name="lastName" id="lastName" type="text" class="form-control" placeholder="<%=c.getLastName()%>">
                  </div>
                </div>
                <div class="form-row">
                  <div class="form-group col-lg-12">
                    <label for="email">Email</label>
                    <input name="email" id="email" type="text" class="form-control" placeholder="<%=c.getEmail()%>">
                  </div>
                </div>
                <button type="submit" class="btn btn-primary">Update Information</button>
              </div>
            </form>
          </div>
        </div>
        <div class="col-lg-6">
          <div class="card">
            <div class="card-header">
              <div class="card-title"><h4>Update Password</h4></div>
            </div>

            <script>
                var model = [];
                model.flag ="${flag}";
                model.message ="${message}";
            </script>

            <form action="/updatePassword" method="post" id="password">
              <div class="card-body">
                <div class="form-row">
                  <div class="form-group col-lg-12">
                    <label for="current_password">Current Password</label>
                    <input name="current_password" id="current_password" class="form-control" type="password" placeholder="Current Password">
                  </div>
                </div>
                <div class="form-row">
                  <div class="form-group col-lg-12">
                    <label for="new_password">New Password</label>
                    <input name="new_password" id="new_password" class="form-control" type="password" placeholder="New Password">
                  </div>
                </div>
                <div class="form-row">
                  <div class="form-group col-lg-12">
                    <label for="new_password1">Confirm New Password</label>
                    <input name="new_password1" id="new_password1" class="form-control" type="password" placeholder="New Password">
                  </div>
                </div>

                <div id="password-flag"></div>

                <button type="submit" class="btn btn-primary">Update Password</button>
              </div>
            </form>
          </div>
        </div>
      </div>

      <br>

      <div class="row">
        <div class="col-lg-6">
          <div class="card">
            <div class="card-header">
              <div class="card-title"><h4>Update Shipping Address</h4></div>
            </div>
            <form action="/updateAddress" method="post">
              <div class="card-body">
                <div class="form-row">
                  <div class="form-group col-lg-12">
                    <label for="addressline1">Address</label>
                    <input type="text" class="form-control" id="addressline1" placeholder="123 Main St">
                  </div>
                </div>
                <div class="form-row">
                  <div class="form-group col-lg-12">
                    <label for="addressline2">Address 2</label>
                    <input type="text" class="form-control" id="addressline2" placeholder="Apartment, studio, or floor">
                  </div>
                </div>
                <div class="form-row">
                  <div class="form-group col-lg-4">
                    <label for="city">City</label>
                    <input type="text" class="form-control" id="city">
                  </div>
                  <div class="form-group col-lg-2">
                    <label for="postcode">Zip</label>
                    <input type="text" class="form-control" id="postcode">
                  </div>
                  <div class="form-group col-lg-2">
                    <label for="state">State</label>
                    <input type="text" class="form-control" id="state" placeholder="PA">
                  </div>
                  <div class="form-group col-lg-4">
                    <label for="country">Country</label>
                    <input type="text" class="form-control" id="country">
                  </div>
                </div>
                <div class="form-row">
                  <div class="form-group col-lg-6">
                    <label for="phone">Phone Number</label>
                    <input type="tel" class="form-control" id="phone">
                  </div>
                </div>
                <button type="submit" class="btn btn-primary">Update Shipping Address</button>
              </div>
            </form>
          </div>
        </div>
        <div class="col-lg-6">
          <div class="card">
            <div class="card-header">
              <div class="card-title"><h4>Update Billing Address</h4></div>
            </div>
            <form action="/updateAddress" method="post">
              <div class="card-body">
                <div class="form-row">
                  <div class="form-group col-lg-12">
                    <label for="addressline1">Address</label>
                    <input type="text" class="form-control" id="addressline1" placeholder="123 Main St">
                  </div>
                </div>
                <div class="form-row">
                  <div class="form-group col-lg-12">
                    <label for="addressline2">Address 2</label>
                    <input type="text" class="form-control" id="addressline2" placeholder="Apartment, studio, or floor">
                  </div>
                </div>
                <div class="form-row">
                  <div class="form-group col-lg-4">
                    <label for="city">City</label>
                    <input type="text" class="form-control" id="city">
                  </div>
                  <div class="form-group col-lg-2">
                    <label for="postcode">Zip</label>
                    <input type="text" class="form-control" id="postcode">
                  </div>
                  <div class="form-group col-lg-2">
                    <label for="state">State</label>
                    <input type="text" class="form-control" id="state" placeholder="PA">
                  </div>
                  <div class="form-group col-lg-4">
                    <label for="country">Country</label>
                    <input type="text" class="form-control" id="country">
                  </div>
                </div>
                <div class="form-row">
                  <div class="form-group col-lg-6">
                    <label for="phone">Phone Number</label>
                    <input type="tel" class="form-control" id="phone">
                  </div>
                </div>
                <button type="submit" class="btn btn-primary">Update Billing Address</button>
              </div>
            </form>
          </div>
        </div>
      </div>
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


    