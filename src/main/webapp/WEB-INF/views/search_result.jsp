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
    Customer c;
    List<Book> books;
    String searchTerm;
  %>
  <%
    books = (List<Book>) request.getAttribute("search_result");
    searchTerm = (String) request.getAttribute("search_term");
    c = (Customer) session.getAttribute("logged_in_customer");
  %>

<!-- Navigation -->
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

<!-- Page Content -->
<div class="container">

  <!-- Page Heading/Breadcrumbs -->
  <h1 class="mt-4 mb-3">Search Result
  </h1>

  <ol class="breadcrumb">
    <li class="breadcrumb-item">
      <a href="/">Home</a>
    </li>
    <li class="breadcrumb-item active">Search Result</li>
  </ol>

  <div class="row">
    <%
      int counter = 0;
      for (Book book : books) {

        if (counter == 12) {
          break;
        }
        counter++;
        String description = book.getDescription().replaceAll("<[^>]*>", "");
        description = description.substring(0, Math.min(100, book.getDescription().length())) + "...";
    %>

    <div class="col-lg-3 col-md-4 col-sm-6 portfolio-item">
      <div class="card h-100 third_color">
        <a href="/bookDetails?bookId=<%=book.getBookId()%>"><img class="card-img-top" src="<%=book.getBookImage()%>" alt=""></a>
        <div class="card-body">
          <h4 class="card-title">
            <div><%=book.getTitle()%></div>
          </h4>
          <p class="card-text"><%=book.getAuthors().get(0).getAuthorName()%></p>
          <p class="card-text"><%=book.getPublisher()%></p>
          <p class="card-text"><%=description%></p>
        </div>
      </div>
    </div>
    <%
      }
    %>
  </div>

  <!-- Pagination -->
  <ul class="pagination justify-content-center">
    <li class="page-item">
      <a class="page-link" href="#" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
        <span class="sr-only">Previous</span>
      </a>
    </li>
    <li class="page-item">
      <a class="page-link" href="#">1</a>
    </li>
    <li class="page-item">
      <a class="page-link" href="#">2</a>
    </li>
    <li class="page-item">
      <a class="page-link" href="#">3</a>
    </li>
    <li class="page-item">
      <a class="page-link" href="#" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
        <span class="sr-only">Next</span>
      </a>
    </li>
  </ul>

</div>
<!-- /.container -->

<!-- Footer -->
<%--<footer class="py-5 bg-dark">--%>
  <%--<div class="container">--%>
    <%--<p class="m-0 text-center text-white">Copyright &copy; Your Website 2018</p>--%>
  <%--</div>--%>
  <%--<!-- /.container -->--%>
<%--</footer>--%>

<!-- Bootstrap core JavaScript -->
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