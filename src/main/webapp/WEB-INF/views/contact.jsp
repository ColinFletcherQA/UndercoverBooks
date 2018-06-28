<!doctype html>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.qa.models.Book"%>
<%@page import="com.qa.models.Author"%>
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
  %>
  <%
    try {
            c = (Customer) session.getAttribute("logged_in_customer");
        } catch(Exception e){
            c = null;
        }
  %>

  <!-- Start Top Bar -->
  <nav class="navbar navbar-expand-xl navbar-expand-lg navbar-dark fixed-top navbar_color">
    <div class="container-fluid px-4">
      <a class="navbar-brand" href="/">Undercover Books</a>
      <form class="form-inline" action="/search">
        <input name="searchTerm" class="form-control mr-1" type="text" placeholder="Search" aria-label="Search">
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
            <a class="nav-link active" href="/contact">Contact Us</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/viewCart">View Cart</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <br>

  <div class="container-fluid px-5 mt-5 mt-xl-0 mt-lg-0 mt-md-0 mt-sm-0">
    <div class="row">

    </div>

    <!-- Page Heading/Breadcrumbs -->
    <h1 class="mt-5 mt-xl-1 mt-lg-1 mt-md-1 mt-sm-1">Contact Us
    </h1>
    <ol class="breadcrumb">
      <li class="breadcrumb-item">
        <a href="/"><span>Home</span></a>
      </li>
      <li class="breadcrumb-item active">Contact Us</li>
    </ol>

    <!-- Content Row -->
    <!-- Contact Form -->
    <!-- In order to set the email address and subject line for the contact form go to the bin/contact_me.php file. -->
    <div class="row">
      <div class="col-lg-6 mb-4">
        <div class="card card_color">
          <div class="card-body">
            <h3 class="card-title">Send us a Message</h3>
            <form>
              <div class="form-group">
                <label for="fullName">Full Name:</label>
                <input type="text" class="form-control" id="fullName" name="fullName">
              </div>
              <div class="form-group">
                <label for="email">Email Address:</label>
                <input type="email" class="form-control" id="email" name="email">
              </div>
              <div class="form-group">
                <label for="subject">Subject:</label>
                <input type="text" class="form-control" id="subject" name="subject">
              </div>
              <div class="form-group">
                <label for="message">Message:</label>
                <textarea class="form-control" id="message" name="message" rows="3"></textarea>
              </div>
              <button type="submit" class="btn button_color">
                <span>Send Message</span>
              </button>
            </form>
          </div>
        </div>
      </div>
      <div class="col-lg-6">
        <div class="card card_color">
          <div class="card-body">
            <h3 class="card-title">Request a Book</h3>
            <form action="/requestBook" method="post">
              <div class="form-group">
                <label for="bookTitle">Book Title:</label>
                <input type="text" class="form-control" id="bookTitle" name="bookTitle">
              </div>
              <div class="form-group">
                <label for="bookAuthor">Book Author:</label>
                <input type="text" class="form-control" id="bookAuthor" name="bookAuthor">
              </div>
              <div>
                ${request_flag.getMessage()}
              </div>
              <button type="submit" class="btn button_color">
                <span>Request Book</span>
              </button>
            </form>
          </div>
        </div>
      </div>

    </div>
    <!-- /.row -->
  </div>


  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
  <script src="js/validator.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>