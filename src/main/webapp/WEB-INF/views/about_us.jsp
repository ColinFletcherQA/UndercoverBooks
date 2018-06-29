<%@page import="java.util.*"%>
<%@page import="com.qa.models.*"%>
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
            <a class="nav-link active" href="/about">About Us</a>
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

  <div class="container-fluid px-5 mt-5 mt-xl-0 mt-lg-0 mt-md-0 mt-sm-0">
    <div class="row">

    </div>

    <!-- Page Heading/Breadcrumbs -->
    <h1 class="mt-5 mt-xl-1 mt-lg-1 mt-md-1 mt-sm-1">About Us
    </h1>

    <ol class="breadcrumb">
      <li class="breadcrumb-item">
        <a href="/"><span>Home</span></a>
      </li>
      <li class="breadcrumb-item active">About Us</li>
    </ol>

    <!-- Intro Content -->
    <div class="row">
      <div class="col-lg-6">
        <img class="img-fluid rounded mb-4" src="http://tvland.mtvnimages.com/uri/mgid:file:gsp:entertainment-assets:/tvl/images/shows/the_golden_girls/site/golden_girls_Series_Main_Landscape_1920x460.png?quality=0.85&width=1024&height=460&crop=true" alt="">
      </div>
      <div class="col-lg-6">
        <h2>About Undercover Books</h2>
        <p>Undercover Books is the new PREMIERE retail site for all your book and book related needs (limited only to books).
        Built and deployed using Amazon provided services, Undercover Books seeks to overthrow the retail giant with
        a quality selection and unbeatable prices. </p>
        <p>The team of Chandler Todd, Colin Fletcher, Jacob Glickman, and Jack McGinnis worked long thankless hours
        to produce this masterpiece. Their brilliance and teamwork is at the heart of what Undercover Books stands for.
        Read more about the individual team members below. </p>
      </div>
    </div>
    <!-- /.row -->

    <!-- Team Members -->
    <h2>Our Team</h2>

    <div class="row">
      <div class="col-lg-3 mb-3">
        <div class="card h-100 text-center card_color">
          <img class="card-img-top" src="http://popvinyls.com/wp-content/uploads/2017/06/bobross-750x450.jpg" alt="">
          <div class="card-body">
            <h4 class="card-title">Chandler Todd</h4>
            <h6 class="card-subtitle mb-2">Front End Designer</h6>
            <p class="card-text">The Bob Ross of Undercover Books </p>
          </div>
          <div class="card-footer">
            <span>c.todd@elsevier.com</span>
          </div>
        </div>
      </div>
      <div class="col-lg-3 mb-3">
        <div class="card h-100 text-center card_color">
          <img class="card-img-top" src="http://images.performgroup.com/di/library/omnisport/53/d3/mr-t-02242018-usnews-getty-ftr_h4a9qflymh1o1e93e92qubm9k.jpg?t=-970871431&w=960&quality=70" alt="">
          <div class="card-body">
            <h4 class="card-title">Jack McGinnis</h4>
            <h6 class="card-subtitle mb-">Developer</h6>
            <p class="card-text">I pity the fool who commits to master </p>
          </div>
          <div class="card-footer">
            <span>j.mcginnis@elsevier.com</span>
          </div>
        </div>
      </div>
      <div class="col-lg-3 mb-3">
        <div class="card h-100 text-center card_color">
          <img class="card-img-top" src="https://s-media-cache-ak0.pinimg.com/originals/48/6e/40/486e40659620da6cbdf9dcd5858da314.jpg" alt="">
          <div class="card-body">
            <h4 class="card-title">Colin Fletcher</h4>
            <h6 class="card-subtitle mb-2">Database Wizard</h6>
            <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Possimus aut mollitia eum
              ipsum fugiat odio officiis odit.</p>
          </div>
          <div class="card-footer">
            <span>c.fletcher@elsevier.com</span>
          </div>
        </div>
      </div>
      <div class="col-lg-3 mb-3">
        <div class="card h-100 text-center card_color">
          <img class="card-img-top" src="http://bloody-disgusting.com/wp-content/uploads/2017/07/CGI-egon-.jpg" alt="">
          <div class="card-body">
            <h4 class="card-title">Jacob Glickman</h4>
            <h6 class="card-subtitle mb-2">Developer</h6>
            <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Possimus aut mollitia eum
              ipsum fugiat odio officiis odit.</p>
          </div>
          <div class="card-footer">
            <span>j.glickman@elsevier.com</span>
          </div>
        </div>
      </div>
    </div>
    <!-- /.row -->

    <!-- Our Customers -->
    <h2>Our Customers</h2>
    <div class="row">
      <div class="col-lg-2 col-sm-4 mb-4">
        <img class="img-fluid" src="images/sally.png" alt="">
      </div>
      <div class="col-lg-2 col-sm-4 mb-4">
        <img class="img-fluid" src="images/sally.png" alt="">
      </div>
      <div class="col-lg-2 col-sm-4 mb-4">
        <img class="img-fluid" src="images/sally.png" alt="">
      </div>
      <div class="col-lg-2 col-sm-4 mb-4">
        <img class="img-fluid" src="images/sally.png" alt="">
      </div>
      <div class="col-lg-2 col-sm-4 mb-4">
        <img class="img-fluid" src="images/sally.png" alt="">
      </div>
      <div class="col-lg-2 col-sm-4 mb-4">
        <img class="img-fluid" src="images/sally.png" alt="">
      </div>
    </div>
    <!-- /.row -->

  </div>

  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

</body>
</html>