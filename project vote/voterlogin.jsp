<%@ page contentType = "text/html" %>
<%@ page import = " java.io.* " %>

<!DOCTYPE html>
<html lang = "en">

<head>

    <meta charset = "ISO-8859-1">
    <meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1">
    <meta name = "viewport" content = "width = device-width , initial-scale = 1.0">
    <title> VOTE-login </title>
    <link rel = "stylesheet" href = "./css/login.css">
    <link rel = "stylesheet" href = "./css/style.css">
    <link rel = "preconnect" href = "https://fonts.googleapis.com">
    <script src = 'https://unpkg.com/sweetalert/dist/sweetalert.min.js'> </script>
    <link href = "https://fonts.googleapis.com/css2?family=Aleo:ital,wght@1,700&display=swap" rel = "stylesheet">

</head>

<%
  String noelec = (String) request.getAttribute ( "noelec" ) ;
  if ( noelec == null )
    noelec = "" ;
  String votererror = (String) request.getAttribute ( "votererror" ) ;
  if ( votererror == null )
    votererror = "" ; 
  String register = (String) request.getAttribute ( "regr" ) ;
  if ( register == null )
    register = "" ; 
%>
<script src = 'https://unpkg.com/sweetalert/dist/sweetalert.min.js'> </script>
<script> 

  function load ()
  {
    noelec = "<%= noelec %>" ;
    register = "<%= register %>" ;
    votererror = "<%= votererror %>" ;
    if ( noelec == "yes" )
      swal ( 'OOPS !!' , 'No LIVE ELECTIONS !! Voter Registration is NOT POSSIBLE !' , 'error' ) ;
    if ( register == "pass" )
      swal ( 'SUCCESS !' , 'ACCOUNT CREATED SUCCESSFULLY !' , 'success' ) ;
    else if ( register == "fail" )
    {
      swal ( 'OOPS !! REGISTRATION FAILED !' , 'An account with the given E-mail exists ! TRY AGAIN !!' , 'error' ) ;
    }
    if ( votererror == "wrong" )
      swal ( 'OOPS !! LOGIN FAILED !' , 'Incorrect USERNAME or PASSWORD ! TRY AGAIN !!' , 'error' ) ;
  }

</script>

<body onload = "load ()">
<p>hello</p>
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
    <div class = "register">
    <img src = "./image/login.jpg" alt = "login pic">
    </div>
    <div class="login-box">
    <form action = "/voterlogincheck" method = "post">
      <h2>VOTER LOGIN</h2>
        <div class = "user-box">
            <input type = "email" id = "email" name = "email" required>
            <label> Username</label> 
            </div>
            <br />
            <div class="user-box">
             <input type = "password" id = "password" name = "password" required>
            <label> Password </label>
            <a><button type = "submit">
              <span></span>
                <span></span>
                <span></span>
                <span></span>
              Login 
              </button> </a>
            </div>
    </form>
  </div>
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
        <h3> PHONE </h3>
        <P> 044 2251 6002 </P>
      </div>

    </footer>

  </body>
</html>
