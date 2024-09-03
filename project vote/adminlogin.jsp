<%@ page contentType = "text/html" %>
<%@ page import = " java.io.* " %>

<!DOCTYPE html>
<html>

  <head>
    <meta name = "viewport" content = "width = device-width , initial-scale = 1.0">
    <meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1">
    <title> VOTE-ADMINLOGIN </title>
    <link rel = "stylesheet" type = "text/css" href = "./css/style.css">
    <link rel = "stylesheet" href = "./css/adlogin.css">
  </head>
  <%
  String adminerror = (String) request.getAttribute ( "adminerror" ) ;
  if ( adminerror == null )
    adminerror = " " ;
%>

<script src = 'https://unpkg.com/sweetalert/dist/sweetalert.min.js'> </script>
<script> 

  function load ()
  {
    adminerror = "<%= adminerror %>" ;
    if ( adminerror == "wrong" )
      swal ( 'OOPS !! ADMIN LOGIN FAILED !' , 'Incorrect USERNAME or PASSWORD ! TRY AGAIN !!' , 'error' ) ;
  }

</script>

<body onload = "load ()">
    <header>
      <nav>

        <div class = "logo">
          <a href = "./home.html">
            <img src = "./image/logo.png" alt = "logo" >
          </a>
        </div>

        <div class = "menu"> 
          <ul>
            <li> <a href = "./home.html"> HOME </a> </li>
            <li> <a href = "./about.html"> ABOUT </a> </li>
            <li> <a href = "./voterlogin.jsp"> LOGIN </a> </li>
            <li> <a href = "./voterregister.jsp"> REGISTER </a> </li>
          </ul>
        </div>

      </nav>
    </header>

    <div class = "side">
      <img src = "./image/admin pic.jpg" alt = "side pic">
    </div>

    <form action = "/adminlogincheck" method = "post">
      <h1> ADMIN LOGIN </h1>
      <div class = "container"> 
        <label> Admin (E-mail ID) : </label> 
        <input type = "email" placeholder = "Enter Admin ID" name = "Admin-id" id = "username" required>
        <label>Password : </label> 
        <input type = "password" placeholder = "Enter Password" name = "password" id = "password" required>
        <button type = "submit"> Login </button> 
      </div>
    </form>

    <footer>

      <div class = "logo">
        <a href = "./adminlogin.jsp">
          <img src = "./image/logo.png" alt = "logo" >
        </a>
      </div>

      <div class = "addr">   
        <h3> ADDRESS </h3>
        <p> MIT Rd, Radha Nagar, Chromepet, Chennai, Tamil Nadu 600044 </p>
      </div>

      <div class = "ph">  
        <h3 >PHONE </h3>
        <P> 044 2251 6002 </P>
      </div>

    </footer>

  </body>
</html>
