<%@ page import="com.qa.models.Customer" %>
<!doctype html>
<html class="no-js" lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Undercover Books</title>
    <link rel="stylesheet" href="css/bootstrap.css"/>
    <link rel="stylesheet" href="css/shop-homepage.css"/>
  </head>
  <body>
    
    <!-- Start Top Bar -->
    <%!
      Customer c;
    %>
    <%
      c = (Customer) session.getAttribute("logged_in_customer");
    %>

    <!-- Start Top Bar -->
    <nav class="navbar navbar-expand-xl navbar-expand-lg navbar-dark fixed-top navbar_color">
      <div class="container-fluid navbar_padding">
        <a class="navbar-brand" href="/">Undercover Books</a>
        <form class="form-inline" action="/search">
          <input class="form-control" type="text" placeholder="Search" aria-label="Search">
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
            <li class="nav-item">
              <a class="nav-link active" href="/customerHome">Customer Home</a>
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
    <div class="container-fluid container_padding mt-5 mt-xl-0 mt-lg-0 mt-md-0 mt-sm-5">
      <h1 class="mt-3 mt-xl-1 mt-lg-1 mt-md-1 mt-sm-1">Login
      </h1>
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="/"><span>Home</span></a>
        </li>
        <li class="breadcrumb-item active" aria-current="page">Login</li>
      </ol>

      <div class="row">
        <div class="col-xl-5 col-lg-5">
          <div class="card card_color mb-4">
            <div class="card-body">
              <form action="/loginProcess" method="post">
                <h3 class="card-title">Please Login with your credentials</h3>
                <div class="form-row">
                  <div class="form-group col-lg-12">
                    <label for="email">Email</label>
                    <input name="email" type="email" class="form-control" id="email" required>
                  </div>
                </div>
                <div class="form-row">
                  <div class="form-group col-lg-12">
                    <label for="password">Password</label>
                    <input name="password" type="password" class="form-control" id="password" required>
                  </div>
                </div>
                <button type="submit" class="btn button_color" id="loginButton"><span>Login</span></button>
                <div>
                    ${login_flag.getMessage()}
                </div>
                <button type="submit" class="btn third_color"><span>Login</span></button>
              </form>
            </div>
          </div>
        </div>
        <div class="col-xl-2 col-lg-2">

        </div>
        <div class="col-xl-5 col-lg-5">
          <div class="card card_color">
            <div class="card-body card_text_color">
              <h3 style="text-align: center" class="card-title">Don't have an account? Register Here</h3>
              <br>
              <a href="/register" class="btn button_color btn-lg btn-block"><span>Register</span></a>
            </div>
          </div>
        </div>
      </div>
    </div>


    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="js/validator.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  </body>
</html>


    