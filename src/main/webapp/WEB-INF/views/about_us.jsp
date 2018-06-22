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

  <div class="container">

    <!-- Page Heading/Breadcrumbs -->
    <h1 class="mt-5">About Us
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
        <img class="img-fluid rounded mb-4" src="http://placehold.it/750x450" alt="">
      </div>
      <div class="col-lg-6">
        <h2>About Undercover Books</h2>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sed voluptate nihil eum consectetur similique?
          Consectetur, quod, incidunt, harum nisi dolores delectus reprehenderit voluptatem perferendis dicta dolorem
          non blanditiis ex fugiat.</p>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Saepe, magni, aperiam vitae illum voluptatum aut
          sequi impedit non velit ab ea pariatur sint quidem corporis eveniet. Odit, temporibus reprehenderit
          dolorum!</p>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Et, consequuntur, modi mollitia corporis ipsa
          voluptate corrupti eum ratione ex ea praesentium quibusdam? Aut, in eum facere corrupti necessitatibus
          perspiciatis quis?</p>
      </div>
    </div>
    <!-- /.row -->

    <!-- Team Members -->
    <h2>Our Team</h2>

    <div class="row">
      <div class="col-lg-3 mb-3">
        <div class="card h-100 text-center third_color">
          <img class="card-img-top" src="http://placehold.it/750x450" alt="">
          <div class="card-body">
            <h4 class="card-title">Chandler Todd</h4>
            <h6 class="card-subtitle mb-2 text-muted">Developer</h6>
            <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Possimus aut mollitia eum
              ipsum fugiat odio officiis odit.</p>
          </div>
          <div class="card-footer">
            <span>c.todd@elsevier.com</span>
          </div>
        </div>
      </div>
      <div class="col-lg-3 mb-3">
        <div class="card h-100 text-center third_color">
          <img class="card-img-top" src="http://placehold.it/750x450" alt="">
          <div class="card-body">
            <h4 class="card-title">Jack McGinnis</h4>
            <h6 class="card-subtitle mb-2 text-muted">Developer</h6>
            <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Possimus aut mollitia eum
              ipsum fugiat odio officiis odit.</p>
          </div>
          <div class="card-footer">
            <span>j.mcginnis@elsevier.com</span>
          </div>
        </div>
      </div>
      <div class="col-lg-3 mb-3">
        <div class="card h-100 text-center third_color">
          <img class="card-img-top" src="http://placehold.it/750x450" alt="">
          <div class="card-body">
            <h4 class="card-title">Colin Fletcher</h4>
            <h6 class="card-subtitle mb-2 text-muted">Developer</h6>
            <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Possimus aut mollitia eum
              ipsum fugiat odio officiis odit.</p>
          </div>
          <div class="card-footer">
            <span>c.fletcher@elsevier.com</span>
          </div>
        </div>
      </div>
      <div class="col-lg-3 mb-3">
        <div class="card h-100 text-center third_color">
          <img class="card-img-top" src="http://placehold.it/750x450" alt="">
          <div class="card-body">
            <h4 class="card-title">Jacob Glickman</h4>
            <h6 class="card-subtitle mb-2 text-muted">Developer</h6>
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
        <img class="img-fluid" src="http://placehold.it/500x300" alt="">
      </div>
      <div class="col-lg-2 col-sm-4 mb-4">
        <img class="img-fluid" src="http://placehold.it/500x300" alt="">
      </div>
      <div class="col-lg-2 col-sm-4 mb-4">
        <img class="img-fluid" src="http://placehold.it/500x300" alt="">
      </div>
      <div class="col-lg-2 col-sm-4 mb-4">
        <img class="img-fluid" src="http://placehold.it/500x300" alt="">
      </div>
      <div class="col-lg-2 col-sm-4 mb-4">
        <img class="img-fluid" src="http://placehold.it/500x300" alt="">
      </div>
      <div class="col-lg-2 col-sm-4 mb-4">
        <img class="img-fluid" src="http://placehold.it/500x300" alt="">
      </div>
    </div>
    <!-- /.row -->

  </div>

  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

  <script>
      $(document).foundation();
  </script>
</body>
</html>