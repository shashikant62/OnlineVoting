<%@ page contentType = "text/html" %>
<%@ page import = " java.sql.* , java.io.* " %>

<!DOCTYPE html>
<html lang = "en">
  <head>
      <meta charset = "UTF-8">
      <meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1">
      <meta name = "viewport" content = "width = device-width , initial-scale = 1.0">
      <title> VOTE-register </title>
      <script src="https://www.google.com/recaptcha/api.js"> </script>
      <link rel = "stylesheet" href = "./css/register.css">
      <link rel = "stylesheet" href = "./css/style.css">
  </head>

  <%
      Class.forName ( "com.mysql.cj.jdbc.Driver" ) ;  
      Connection con = DriverManager.getConnection ( "jdbc:mysql://localhost:1017/voting_system" , "root" , "1017" ) ;
      Statement st = con.createStatement () ;
      ResultSet rse = st.executeQuery ( "SELECT EXISTS ( SELECT * FROM election )" ) ;
      rse.next () ;
      int exist = rse.getInt (1) ;
      String title = "" ;
      String enddt = "" ;
      if ( exist != 0 )
      {
        ResultSet rst = st.executeQuery ( "SELECT name FROM election" ) ;
        rst.next () ;
        title = title.concat ( rst.getString (1) ) ;
        ResultSet rsd = st.executeQuery ( "SELECT enddate FROM election" ) ;
        rsd.next () ;
        enddt = enddt.concat ( rsd.getString (1) ) ;
      }
      st.close () ;
  %>

  <script>

    setInterval ( loaded , 1000 ) ;

    function loaded ()
    {
      dt = new Date () ;
      day = dt.getDate () ;
      month = dt.getMonth () + 1 ;
      year = dt.getFullYear () ;
      if ( day < 10 )
      {
        day = "0" + day ;
      } 
      if ( month < 10 )
      {
        month = "0" + month ;
      } 
      ordate = year + "-" + month + "-" + day ;
      enddate = "<%= enddt %>" ;
      exist = <%= exist %> ;
      if ( exist != 0 )
      {
        document.getElementById ("regform").style.display = "block" ;
        document.getElementById ("currelec").innerHTML = "LIVE ELECTION : " + "<%= title %>" + "<br /> CREATE ACCOUNT";
      }
      else
      {
        <%
          try
          {
            if ( ( exist == 0 ) )
            {
              String noelec = "yes" ;
              request.setAttribute ( "noelec" , noelec ) ;
              RequestDispatcher reqd = request.getRequestDispatcher ( "./voterlogin.jsp" );
              reqd.forward ( request , response ) ;
            }
          }
          catch (Exception e) { e.printStackTrace () ; }
        %>
      }
    }

  </script>

  <body>

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
      <img src = "./image/register.png" alt = "register pic">
    </div>

    <form class = "register-form" method = "post" action = "/registerotpemail" id = "regform" style = "display : none">

      <div class = "form-header">
        <h2 id = "currelec"> </h2>
      </div>

      <!-- Firstname and Lastname -->
      <div class = "horizontal-group">
        <div class = "form-group left">
          <label for = "fname" class = "label-title"> First name * </label>
            <input type = "text" id = "fname" name = "fname" class = "form-input" placeholder = "enter your first name" required = "required" />
        </div>
        <div class = "form-group right">
          <label for = "lname" class = "label-title"> Last name </label>
          <input type = "text" id = "lname" name = "lname" class = "form-input" placeholder = "enter your last name" />
        </div>
      </div>

      <!-- Email -->
      <div class = "form-group">
        <label for = "email" class = "label-title"> Email* </label>
        <input type = "email" id = "email" name = "email" class = "form-input" placeholder = "enter your email" required = "required" />
      </div>

      <!-- Password and confirm password -->
      <div class = "horizontal-group">
        <div class = "form-group left">
          <label for = "password" class = "label-title"> Password * </label>
          <input type = "password" id = "password" name = "password" class = "form-input" placeholder = "enter your password" required = "required" onkeyup = "check ()" />
        </div>
        <div class="form-group right">
          <label for = "confirm-password" class = "label-title"> Confirm Password * </label>
          <input type = "password" class = "form-input" id = "confirm-password" placeholder = "enter your password again" required = "required" onkeyup = "check ()" />
          <span id = "message"></span>
        </div>
      </div>

      <!-- Gender -->
      <div class = "horizontal-group">
        <div class = "form-group left">
          <label class = "label-title"> Gender : </label>
          <div class = "input-group">
            <label for = "male" style = "font-size : 20px;"> <input type = "radio" name = "gender" value = "Male" id = "male"> Male </label>
            <label for = "female" style = "font-size : 20px;"> <input type = "radio" name = "gender" value = "Female" id = "female"> Female </label>
          </div>
        </div>
      </div>

      <!-- DEPT -->
      <div class = "horizontal-group">
        <div class = "form-group left">
          <label for = "dept" class = "dept"> Choose department : </label>
          <select name = "dept" id = "dept">
            <option value = "CT"> Department of Computer Technology </option>
            <option value = "ECE"> Department of Electrical Communication Engineering </option>
            <option value = "MECH"> Department of Mechanical Engineering </option>
            <option value = "EEE"> Department of Electrical and Electronic Engineering </option>
          </select>
        </div>
      </div>

      <!-- dob -->
      <div class = "form-group right">
        <label for = "dob" class = "dob"> Date of birth : </label>
        <input type = "date" id = "dob" name = "dob" required>
      </div>

      <!-- form-footer -->
      <div class = "form-footer">
        <span> * required </span>
        <button type = "submit" class = "btn" id = "formsubmit" style = "display : none"> Create </button>
      </div>

    </form>

  </body>

  <script>

    var check = function () {
      if ( document.getElementById ('password').value ==
      document.getElementById ('confirm-password').value ) 
      {
        document.getElementById ( 'message' ).style.color = 'green' ;
        document.getElementById ( 'message' ).innerHTML = '' ;
        document.getElementById ( 'formsubmit' ).style.display = "block" ;
      } 
      else 
      {
        document.getElementById ( 'message' ).style.color = 'red' ;
        document.getElementById ( 'message' ).innerHTML = 'not matching' ;
        document.getElementById ( 'formsubmit' ).style.display = "none" ;
      }
    }

    function My_Date () 
    {
      var date = new Date () ;
      var year = date.getFullYear () - 18 ;
      var month = date.getMonth () + 1 ;
      var day = date.getDate () ;
      if ( day < 10 )
      {
        day = '0' + day ;
      } 
      if ( month < 10 )
      {
        month = '0' + month ;
      }
      var datepattern = year + '-' + month + '-' + day ;
      document.getElementById ("dob").max = datepattern ;
    }
    My_Date () ;

  </script>

</html>