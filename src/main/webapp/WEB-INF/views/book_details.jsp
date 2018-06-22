<!doctype html>
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
      c = (Customer) session.getAttribute("logged_in_customer");
    %>

    <!-- Start Top Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top nav_background">
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
    <br>
    <!-- Breadcrumb -->
    <div class="container">
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="/"><span>Home</span></a>
        </li>
        <li class="breadcrumb-item active" aria-current="page"><%=book.getTitle()%></li>
      </ol>

     <!-- Book Information -->
      <div class="row">
        <div class="col-lg-4">
          <div class="card mt-4">
            <img class="card-img-top img-fluid" style="width: 100%; height: auto;" src="<%=book.getBookImage()%>" alt="<%=book.getTitle()%>">
            <div class="card-body">
              <h3 class="card-title"><%=book.getTitle()%></h3>
              <h4>$<%=book.getPrice()%></h4>
              <span class="text-warning">&#9733; &#9733; &#9733; &#9733; &#9734;</span>
              4.0 stars
            </div>
          </div>
        </div>
        <div class="col-lg-4">
          <div class="card card-outline-secondary my-4">
            <div class="card-header">
              Book Description
            </div>
            <div class="card-body">
              <p class="card-text"><%=book.getDescription()%></p>
            </div>
          </div>
        </div>
        <!-- Add to card -->
        <div class="col-lg-4">
          <div class="card mt-4">
            <div class="card-body">
              <h3 class="card-title"><%=book.getTitle() %></h3>

                <%
                    for(Author author : book.getAuthors())
                    {
                %>

                  <h6 class="card-subtitle mb-2 text-muted"><%= author.getAuthorName() %></h6>

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

                <a id="add-to-cart-anchor" href="/addToCart?bookId=<%=book.getBookId()%>" class="btn secondary_color"><span>Add to Cart</span></a>
                <a id="view-cart-anchor" href="/viewCart"><span id="view-cart-span"></span></a>
              </form>
            </div>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-lg-12">
          <div class="card card-outline-secondary my-4">
            <div class="card-header">
              Book Description
            </div>
              <div class="card-body">
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis et enim aperiam inventore, similique necessitatibus neque non! Doloribus, modi sapiente laboriosam aperiam fugiat laborum. Sequi mollitia, necessitatibus quae sint natus.</p>
                <small class="text-muted">Posted by Anonymous on 3/1/17</small>
                <hr>
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis et enim aperiam inventore, similique necessitatibus neque non! Doloribus, modi sapiente laboriosam aperiam fugiat laborum. Sequi mollitia, necessitatibus quae sint natus.</p>
                <small class="text-muted">Posted by Anonymous on 3/1/17</small>
                <hr>
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis et enim aperiam inventore, similique necessitatibus neque non! Doloribus, modi sapiente laboriosam aperiam fugiat laborum. Sequi mollitia, necessitatibus quae sint natus.</p>
                <small class="text-muted">Posted by Anonymous on 3/1/17</small>
                <hr>
                <a href="#" class="btn btn-success">Leave a Review</a>
              </div>
          </div>
      </div>
    </div>

    <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
    <%--<script src="js/elsevier.js"></script>--%>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="js/book_details_handler.js"></script>
    <script>
      $(document).foundation();
    </script>
    <script>
      function alertSuccess() {
          alert(<div class="alert alert-success" role="alert">
              This is a success alert—check it out!
          </div>);
      }
    </script>
  </body>
</html>


    