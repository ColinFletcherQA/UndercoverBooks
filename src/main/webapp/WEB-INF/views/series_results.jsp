<!DOCTYPE html>
<%@page import="java.util.*"%>
<%@page import="com.qa.models.*"%>
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
    List<Book> seriesBooks;
    Customer c;
    String seriesName;
  %>
  <%
    seriesName = (String) request.getAttribute("seriesName");
    seriesBooks = (List<Book>) request.getAttribute("book_series_list");
    c = (Customer) session.getAttribute("logged_in_customer");
  %>

  <!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-expand-xl navbar-dark fixed-top navbar_color">
    <div class="container-fluid px-4">
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

  <!-- Page Content -->
  <div class="container-fluid px-5 mt-5 mt-xl-0 mt-lg-0 mt-md-0 mt-sm-0">
    <div class="row">

    </div>

    <!-- Page Heading/Breadcrumbs -->
    <h1 class="mt-5 mt-xl-1 mt-lg-1 mt-md-1 mt-sm-1">Series Results
    </h1>
    <ol class="breadcrumb">
      <li class="breadcrumb-item">
        <a href="/"><span>Home</span></a>
      </li>
      <li class="breadcrumb-item">
        <a href="/series"><span>Series</span></a>
      </li>
      <li class="breadcrumb-item active" aria-current="page"><%=seriesName%></li>
    </ol>
    <div class="row">
      <%
        for (Book book : seriesBooks) {

          String description = book.getDescription().replaceAll("<[^>]*>", "");
          description = description.substring(0, Math.min(100, book.getDescription().length())) + "...";

          Integer topValue = ((1* book.getRatings_1()) + (2*book.getRatings_2()) + (3*book.getRatings_3()) + (4*book.getRatings_4()) + (5*book.getRatings_5()));
          Integer bottomValue = (book.getRatings_1()+book.getRatings_2()+book.getRatings_3()+book.getRatings_4()+book.getRatings_5());
          Integer weightedAverage = (topValue / bottomValue);
      %>

      <div class="col-xl-2 col-lg-3 col-md-4 col-sm-6 mb-4">
        <div class="card h-100 card_color">
          <a href="/bookDetails?bookId=<%=book.getBookId()%>"><img class="card-img-top mx-auto d-block front_page_img img-fluid pt-4" src="<%=book.getBookImage()%>" alt=""></a>
          <div class="card-body">
            <h4 class="card-title">
              <%=book.getTitle()%>
            </h4>
            <p class="card-subtitle mb-2"> <%=book.getAuthors().get(0).getAuthorName()%></p>

            <p class="card-text"><i><%=book.getPublisher()%></i></p>

            <p class="card-text"><%=description%></p>
          </div>
          <div class="card-footer">
            <% if (weightedAverage == 5) {%>
            <small>&#9733; &#9733; &#9733; &#9733; &#9733;</small>
            <%} else if (weightedAverage >= 4) {%>
            <small>&#9733; &#9733; &#9733; &#9733; &#9734;</small>
            <%} else if (weightedAverage >= 3) {%>
            <small>&#9733; &#9733; &#9733; &#9734; &#9734;</small>
            <%} else if (weightedAverage >= 2) {%>
            <small>&#9733; &#9733; &#9734; &#9734; &#9734;</small>
            <%} else if (weightedAverage >= 1) {%>
            <small>&#9733; &#9734; &#9734; &#9734; &#9734;</small>
            <%} else if (weightedAverage >= 0) {%>
            <small>&#9734; &#9734; &#9734; &#9734; &#9734;</small>
            <%}%>
          </div>
        </div>
      </div>
      <%
        }
      %>
    </div>

  </div>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>

</html>