<!doctype html>
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
    Customer c;
  %>
  <%
    c = (Customer) session.getAttribute("logged_in_customer");
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
    <!-- End Top Bar -->

    <div class="container">

      <div class="row">

        <div class="col-lg-3">

          <h1 class="my-4">Undercover Books</h1>
          <div class="list-group" ">
            <a href="#" class="list-group-item secondary_color"><span>Best Sellers</span></a>
            <a href="#" class="list-group-item secondary_color"><span>New Releases</span></a>
            <a href="#" class="list-group-item secondary_color"><span>Category 3</span></a>
          </div>

        </div>
        <!-- /.col-lg-3 -->

        <div class="col-lg-9">
          <div id="carouselExampleIndicators" class="carousel slide my-4" data-ride="carousel">
            <ol class="carousel-indicators">
              <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
              <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
              <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner" role="listbox">
              <div class="carousel-item active">
                <img class="d-block img-fluid" src="images/cover1.png" alt="First slide">
              </div>
              <div class="carousel-item">
                <img class="d-block img-fluid" src="images/cover2.png" alt="Second slide">
              </div>
              <div class="carousel-item">
                <img class="d-block img-fluid" src="images/cover3.png" alt="Third slide">
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

          <div class="row">

            <%
              List<Book> books = (List<Book>) session.getAttribute("books");
              Collections.shuffle(books);
              for (int i = 0; i < 6 && i < books.size(); i++) {
                Book book = books.get(i);
            %>

            <div class="col-lg-4 col-md-6 mb-4">
              <div class="card h-100 third_color">
                <a href="/bookDetails?bookId=<%=book.getBookId()%>"><img class="card-img-top" src="<%=book.getBookImage()%>" alt=""></a>
                <div class="card-body" >
                  <h4 class="card-title ">
                    <a href="/bookDetails?bookId=<%=book.getBookId()%>"><div><%= book.getTitle()%></div></a>
                  </h4>
                  <h5>$<%= book.getPrice()%></h5>
                   <%
                     for (Author author : book.getAuthors()) {
                   %>
                       <p class="card-subtitle mb-2 text-muted"> <%= author.getAuthorName() %> </p>
                   <%
                     }
                   %>
                  <p class="card-text"><%=book.getDescription()%></p>
                </div>
                <div class="card-footer">
                  <small class="text-muted">&#9733; &#9733; &#9733; &#9733; &#9734;</small>
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

    </div>
    <!-- /.container -->

    <hr>

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
