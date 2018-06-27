<!DOCTYPE html>
<%@page import="java.util.*"%>
<%@page import="com.qa.models.*"%>
<%@ page import="org.springframework.beans.support.PagedListHolder" %>
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
    int pageNum;
    int maxPages;
    String searchOption;
  %>
  <%
    books = (List<Book>) request.getAttribute("search_result");
    searchTerm = (String) request.getAttribute("search_term");
    pageNum = (Integer) request.getAttribute("page");
    maxPages = (Integer) request.getAttribute("maxPages");
    searchOption = (String) request.getAttribute("search_option");
    try {
            c = (Customer) session.getAttribute("logged_in_customer");
        } catch(Exception e){
            c = null;
        };
  %>

<!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-expand-xl navbar-dark fixed-top navbar_color">
    <div class="container-fluid px-4">
      <a class="navbar-brand" href="/">Undercover Books</a>
      <form class="form-inline" action="/search">
        <input name="searchTerm" class="form-control" type="text" placeholder="Search" aria-label="Search">
        <select name = "searchOption" class="custom-select">
          <option <%=searchOption.equals("title") ? "selected " : ""%> value="title">Title</option>
          <option <%=searchOption.equals("isbn") ? "selected " : ""%> value="isbn">ISBN / Kindle ASIN</option>
          <option <%=searchOption.equals("author") ? "selected " : ""%> value="author">Author</option>
          <option <%=searchOption.equals("publisher") ? "selected " : ""%> value="publisher">Publisher</option>
          <option <%=searchOption.equals("description") ? "selected " : ""%> value="description">Description</option>
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
    <h1 class="mt-5 mt-xl-1 mt-lg-1 mt-md-1 mt-sm-1">Search Result
    </h1>
    <ol class="breadcrumb">
      <li class="breadcrumb-item">
        <a href="/"><span>Home</span></a>
      </li>
      <li class="breadcrumb-item active" aria-current="page">Search Results for "<%=searchTerm%>"</li>
    </ol>
    <div class="row">
      <%
        if (books.isEmpty()) {
      %>
        <div class="col-lg-1">

        </div>
        <div class="col-lg-10 mb-4">
          <div class="card card_color">
            <div class="card-header">
              <h4 class="card-title text-center">No Results Found</h4>
            </div>
            <div class="card-body text-center">
              <p>Sorry we could not find your book. Submit a request for us to get the book <button class="btn button_color" href="/contact"><span>here</span></button></p>
            </div>
          </div>
        </div>
      <%
        } else {
          int counter = 0;
          for (Book book : books) {

            if (counter++ == 12) {
              break;
            }
            String description = book.getDescription().replaceAll("<[^>]*>", "");
            description = description.substring(0, Math.min(100, book.getDescription().length())) + "...";
      %>

      <div class="col-xl-2 col-lg-3 col-md-4 col-sm-6 mb-4">
        <div class="card h-100 card_color">
          <a href="/bookDetails?bookId=<%=book.getBookId()%>"><img class="card-img-top front_page_img mx-auto d-block img-fluid pt-4" src="<%=book.getBookImage()%>" alt=""></a>
          <div class="card-body">
            <h4 class="card-title">
              <%=book.getTitle()%>
            </h4>
            <p class="card-subtitle mb-2"> <%=book.getAuthors().get(0).getAuthorName()%></p>

            <p class="card-text"><i><%=book.getPublisher()%></i></p>

            <p class="card-text"><%=description%></p>
          </div>
        </div>
      </div>
      <%
          }
        }
      %>
    </div>
    <!-- Pagination -->
    <ul class="pagination justify-content-center">
      <li class="page-item<% if (pageNum <= 1) {%> disabled<%}%>">
          <a class="page-link" href="/search?searchTerm=<%=searchTerm%>&page=<%=(pageNum - 1)%>&searchOption=<%=searchOption%>" aria-label="Previous">
              <span aria-hidden="true" class="page_nav">&laquo;</span>
              <span class="sr-only">Previous</span>
          </a>
      </li>
        <% if (pageNum >= 3) { %>
        <li class="page-item">
            <a class="page-link page_nav" href="/search?searchTerm=<%=searchTerm%>&page=<%=pageNum - 2%>&searchOption=<%=searchOption%>"><%=pageNum - 2%></a>
        </li>
        <%}%>
        <% if (pageNum >= 2) { %>
        <li class="page-item">
            <a class="page-link page_nav" href="/search?searchTerm=<%=searchTerm%>&page=<%=pageNum - 1%>&searchOption=<%=searchOption%>"><%=pageNum - 1%></a>
        </li>
        <%}%>
        <li class="page-item disabled">
            <a class="page-link page_nav" href="/search?searchTerm=<%=searchTerm%>&page=<%=pageNum%>&searchOption=<%=searchOption%>"><%=pageNum%></a>
        </li>
        <% if (maxPages >= pageNum + 1) { %>
        <li class="page-item">
            <a class="page-link page_nav" href="/search?searchTerm=<%=searchTerm%>&page=<%=pageNum + 1%>&searchOption=<%=searchOption%>"><%=pageNum + 1%></a>
        </li>
        <%}%>
        <% if (maxPages >= pageNum + 2) { %>
        <li class="page-item">
            <a class="page-link page_nav" href="/search?searchTerm=<%=searchTerm%>&page=<%=pageNum + 2%>&searchOption=<%=searchOption%>"><%=pageNum + 2%></a>
        </li>
        <%}%>
      <li class="page-item<% if (pageNum == maxPages) {%> disabled<%}%>">
          <a class="page-link" href="/search?searchTerm=<%=searchTerm%>&page=<%=(pageNum + 1)%>&searchOption=<%=searchOption%>" aria-label="Next">
              <span aria-hidden="true" class="page_nav">&raquo;</span>
              <span class="sr-only">Next</span>
          </a>
      </li>
    </ul>

  </div>
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