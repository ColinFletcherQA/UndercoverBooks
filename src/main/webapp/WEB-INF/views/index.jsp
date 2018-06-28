<!doctype html>
<%@page import="java.util.*"%>
<%@page import="com.qa.models.*"%>

<html lang="en">
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
            <select name="searchOption" class="custom-select">
                <option name="title" value="title">Title</option>
                <option name="isbn" value="isbn">ISBN / Kindle ASIN</option>
                <option name="author" value="author">Author</option>
                <option name="publisher" value="publisher">Publisher</option>
                <option name="description" value="description">Description</option>
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
              <a class="nav-link" id="customerHome" href="/customerHome">Customer Home</a>
            </li>
            <%
            } else {
            %>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                Account
              </a>
              <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                <a class="dropdown-item" id="login" href="/login">Login</a>
                <a class="dropdown-item" id="register" href="/register">Register</a>
              </div>
            </li>
            <%
            }
            %>

            <li class="nav-item">
              <a class="nav-link" id="aboutUs" href="/about">About Us</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" id="contactUs" href="/contact">Contact Us</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" id="viewCart" href="/viewCart">View Cart</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>
    <!-- End Top Bar -->
    <br>

    <div class="container-fluid px-5 mt-5 mt-xl-0 mt-lg-0 mt-md-0 mt-sm-0">

      <div class="row">

        <div class="col-xl-2 col-lg-4">

          <h1 class="mt-5 mt-xl-4 mt-lg-4 mt-md-1 mt-sm-1" id="pageTitle">Undercover Books</h1>
          <div class="list-group">
            <a href="/bestSellers" class="list-group-item categories_color" id="bestSellers"><span>Best Sellers</span></a>
            <a href="/newReleases" class="list-group-item categories_color" id="newReleases"><span>New Releases</span></a>
            <a href="/genres" class="list-group-item categories_color" id="genres"><span>Genres</span></a>
            <a href="/series" class="list-group-item categories_color" id="series"><span>Series</span></a>
          </div>

        </div>
        <!-- /.col-lg-3 -->

        <div class="col-xl-10 col-lg-8">
          <div id="carouselExampleIndicators" class="carousel slide my-4" data-ride="carousel">
            <ol class="carousel-indicators">
              <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
              <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
              <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner" role="listbox">
              <div class="carousel-item active">
                <img class="d-block img-fluid" src="images/cover12.png" alt="First slide">
              </div>
              <div class="carousel-item">
                <img class="d-block img-fluid" src="images/cover13.jpg" alt="Second slide">
              </div>
              <div class="carousel-item">
                <img class="d-block img-fluid" src="images/cover15.jpg" alt="Third slide">
              </div>
            </div>
            <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
              <span class="carousel-control-prev-icon" aria-hidden="true"></span>
              <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
              <span class="carousel-control-next-icon" aria-hidden="true"></span>
              <span class="sr-only">Next</span>
            </a>
          </div>
        </div>
      </div>
      <h2 class="text-center mb-4"><strong>Featured Books</strong></h2>
        <div class="row">
          <%
            List<Book> books = (List<Book>) request.getAttribute("books");

            for (Book book : books) {
              String description = book.getDescription();

              description = description.substring(0, Math.min(150, description.length())) + "...";
              description = description.replaceAll("<[^>]*>", "");

              Integer topValue = ((1* book.getRatings_1()) + (2*book.getRatings_2()) + (3*book.getRatings_3()) + (4*book.getRatings_4()) + (5*book.getRatings_5()));
              Integer bottomValue = (book.getRatings_1()+book.getRatings_2()+book.getRatings_3()+book.getRatings_4()+book.getRatings_5());
              Integer weightedAverage = (topValue / bottomValue);

          %>
          <div class="col-xl-2 col-lg-3 col-md-4 col-sm-6 col-12 mb-4">
            <div class="card h-100 card_color">
              <a href="/bookDetails?bookId=<%=book.getBookId()%>"><img class="card-img-top mx-auto d-block front_page_img img-fluid pt-4" src="<%=book.getBookImage()%>" alt=""></a>
              <div class="card-body">
                <h4 class="card-title ">
                  <div><%= book.getTitle()%></div>
                </h4>
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

                <h5 class="pt-2" style="font-family: Helvetica Neue, Helvetica, Roboto, Arial, sans-serif">$<%= book.getPrice()%></h5>
                 <%
                   List<Author> authors = book.getAuthors();

                   if (!authors.isEmpty()) {
                 %>
                  <p class="card-subtitle mb-2" style="font-family: Helvetica Neue, Helvetica, Roboto, Arial, sans-serif"> <%=authors.get(0).getAuthorName()%></p>
                 <%
                   }
                 %>
                <p style="font-family: Helvetica Neue, Helvetica, Roboto, Arial, sans-serif"><%=description%></p>
              </div>

            </div>
          </div>
          <%
            }
          %>
        <!-- /.row -->
      </div>
      <!-- /.col-lg-9 -->
    </div>
      <!-- /.row -->
    <!-- /.container -->

    <hr>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  </body>
</html>
