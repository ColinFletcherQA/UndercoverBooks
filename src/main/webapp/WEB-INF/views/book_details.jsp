<!doctype html>
<%@ page import="com.qa.models.*" %>
<%@ page import="java.time.LocalTime" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="sun.security.util.Length" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.ZoneOffset" %>
<%@ page import="java.util.*" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<html class="no-js" lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />
    <title>Undercover Books</title>
    <link rel="stylesheet" href="css/bootstrap.css"/>
    <link rel="stylesheet" href="css/shop-homepage.css"/>

    <!-- Add the slick-theme.css if you want default styling -->
    <link rel="stylesheet" type="text/css" href="css/slick/slick.css"/>
    <!-- Add the slick-theme.css if you want default styling -->
    <link rel="stylesheet" type="text/css" href="css/slick/slick-theme.css"/>
    <%--<link rel="stylesheet" href="css/style.css">--%>
  </head>
  <body>
    
    <%!
      Book book;
    %>

    <%
     book = (Book) request.getAttribute("book");
    %>
    <script>
        var cartItems = "${cart_items}";
        var currentBook = "${book}";
    </script>
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
    <nav class="navbar navbar-expand-lg navbar-expand-xl navbar-dark fixed-top navbar_color">
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
    <!-- End Top Bar -->
    <!-- Breadcrumb -->
    <div class="container-fluid px-5 mt-5 mt-xl-0 mt-lg-0 mt-md-0 mt-sm-0">
      <div class="row">

      </div>
      <h1 class="mt-5 mt-xl-1 mt-lg-1 mt-md-1 mt-sm-1">Book Details</h1>
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="/"><span>Home</span></a>
        </li>
        <li class="breadcrumb-item active" aria-current="page"><%=book.getTitle()%></li>
      </ol>

     <!-- Book Information -->
      <div class="row">
        <div class="col-xl-8 col-lg-8 col-md-8 col-sm-12">
          <div class="row">
            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 pb-4">
              <div class="card card_color">
                <img class="card-img-top front_page_img mx-auto d-block img-fluid pt-4" src="<%=book.getBookImage()%>" alt="<%=book.getTitle()%>">
                <div class="card-body">
                  <h3 class="card-title"><%=book.getTitle()%></h3>
                  <%
                    Integer topValue = ((1* book.getRatings_1()) + (2*book.getRatings_2()) + (3*book.getRatings_3()) + (4*book.getRatings_4()) + (5*book.getRatings_5()));
                    Integer bottomValue = (book.getRatings_1()+book.getRatings_2()+book.getRatings_3()+book.getRatings_4()+book.getRatings_5());
                    Integer weightedAverage = (topValue / bottomValue);
                  %>
                  <% if (weightedAverage == 5) {%>
                  <small class="text-warning">&#9733; &#9733; &#9733; &#9733; &#9733;</small>
                  <%} else if (weightedAverage >= 4) {%>
                  <small class="text-warning">&#9733; &#9733; &#9733; &#9733; &#9734;</small>
                  <%} else if (weightedAverage >= 3) {%>
                  <small class="text-warning">&#9733; &#9733; &#9733; &#9734; &#9734;</small>
                  <%} else if (weightedAverage >= 2) {%>
                  <small class="text-warning">&#9733; &#9733; &#9734; &#9734; &#9734;</small>
                  <%} else if (weightedAverage >= 1) {%>
                  <small class="text-warning">&#9733; &#9734; &#9734; &#9734; &#9734;</small>
                  <%} else if (weightedAverage >= 0) {%>
                  <small class="text-warning">&#9734; &#9734; &#9734; &#9734; &#9734;</small>
                  <%}%>
                  <% if (book.getSeries().size() > 0) {
                    for (Series s : book.getSeries()) {
                  %><h6 class="pt-2" style="font-family: Helvetica Neue, Helvetica, Roboto, Arial, sans-serif">Part of <a href="/seriesResults?seriesName=<%=s.getSeriesName()%>"><span><u><%=s.getSeriesName()%></u></span></a> Series</h6><%
                    }
                  }%>
                  <h4 style="font-family: Helvetica Neue, Helvetica, Roboto, Arial, sans-serif">$<%=book.getPrice()%></h4>
                </div>
              </div>
            </div>
            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 pb-4">
              <div class="card card-outline-secondary card_color">
                <div class="card-body">
                  <h3 class="card-title">Book Description</h3>
                  <p class="card-text" style="font-family: Helvetica Neue, Helvetica, Roboto, Arial, sans-serif"><%=book.getDescription()%></p>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- Add to card -->
        <div class="col-xl-4 col-lg-4 col-md-4 col-sm-10">
          <div class="col-lg-12 col-md-12">
            <div class="card card_color">
              <div class="card-body">
                <h3 class="card-title"><%=book.getTitle() %></h3>
                  <%
                      for(Author author : book.getAuthors())
                      {
                  %>
                    <h6 class="card-subtitle mb-2"><%= author.getAuthorName() %></h6>

                  <%
                      }
                  %>
                <form>
                  <div class="form-group">
                    <label for="bookType">Select Book Type</label>
                    <select class="form-control" id="bookType">
                      <option value="print">Paperback</option>
                      <option value="eBook">eBook</option>
                      <option value="printAndeBook">PrintBook & eBook</option>
                    </select>
                  </div>
                  <a id="add-to-cart-anchor" href="/addToCart?bookId=<%=book.getBookId()%>" class="btn button_color"><span>Add to Cart</span></a>
                  <a id="view-cart-anchor" href="/viewCart"><span id="view-cart-span"></span></a>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
      <%
        if (book.getSimilar_books().isEmpty()) {
      %>
      <div class="row">
        <div class="col-lg-12">
          <h3 class="text-center"></h3>
        </div>
      </div>
      <%
        } else {
      %>
      <h2 class="text-center mt-2">Related Books</h2>
      <div class="multiple-items">
          <%
            for(Book relatedBook : book.getSimilar_books()) {
          %>
              <div class="col">
                  <div class="card h-100 card_color" style="min-height: 375px;">
                      <div class="card-body">
                        <a href="/bookDetails?bookId=<%=relatedBook.getBookId()%>"><img class="card-img-top mx-auto d-block front_page_img img-fluid" src="<%=relatedBook.getBookImage()%>" alt=""></a>
                      </div>
                      <div class="card-footer">
                        <h4><%=relatedBook.getTitle()%></h4>
                        <p>$<%=relatedBook.getPrice()%></p>
                      </div>
                  </div>
              </div>
          <%
              }
              %>
      </div>
        <%
            }
           %>
      <div class="row mt-5">
        <div class="col-lg-6">
          <div class="card card_color mb-5">
            <div class="card-body">
              <form action="/postReview?bookId=<%=book.getBookId()%>" method="post">
                <div class="row">
                  <div class="col-xl-12">
                    <div class="form-group">
                      <label for="review">Enter your comments here!</label>
                      <textarea class="form-control" name="review" id="review" rows="5"></textarea>
                    </div>
                  </div>
                </div>
                <button type="submit" class="btn button_color"><span>Leave a Review</span></button>
              </form>
            </div>
          </div>
        </div>

        <div class="col-lg-6">

          <%
            if (book.getReview().isEmpty()) {
          %>

          <%
            } else {
          %>
          <div class="card card-outline-secondary card_color">
              <div class="card-body">
                <h3 style="font-family: Helvetica Neue, Helvetica, Roboto, Arial, sans-serif">Book Reviews</h3>
                <hr>
                <%
                  int counter = 0;
                  for (Review review : book.getReview()) {
                        if (counter++ == 5) {
                            break;
                        }
                    %>
                      <p style="font-size: 20px"><%=review.getReview()%></p>
                    <%
                      if(review.getCustomer() != null) {
                    %>
                      <small>-- <%=review.getCustomer().getFirstName()%> <%=review.getCustomer().getLastName()%>,</small>
                    <%
                    } else {
                    %>
                      <small>-- anonymous,</small>
                    <%
                        }
                    %>
                    <%
                      if(review.getTime() > 0) {
                    %>
                      <small>    <%=LocalDateTime.ofEpochSecond(review.getTime(),0,ZoneOffset.UTC).format(DateTimeFormatter.ofPattern("MMMM dd, yyyy"))%></small>
                    <%
                        }
                    %>
                    <hr>
                <%}%>
            </div>
          </div>
          <%
            }
          %>
        </div>
      </div>
    </div>


    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="js/book_details_handler.js"></script>
    <script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
    <script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <script type="text/javascript" src="css/slick/slick.min.js"></script>
    <script type="text/javascript" src="js/multipleItemsSlick.js"></script>
  </body>
</html>