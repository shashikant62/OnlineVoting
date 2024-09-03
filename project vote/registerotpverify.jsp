<%@ page contentType = "text/html" %>
<%@ page import = " java.sql.* , java.io.* " %>

<html>
<link rel="stylesheet" href="./css/verify.css">
    <%
        String mail = (String) request.getAttribute ( "mail" ) ;
        int otp = (int) request.getAttribute ( "otp" ) ;
        String fnm = (String) request.getAttribute ( "fname" ) ;
        String lnm = (String) request.getAttribute ( "lname" ) ;
        String dob = (String) request.getAttribute ( "dob" ) ;
        String gen = (String) request.getAttribute ( "gender" ) ;
        String dept = (String) request.getAttribute ( "dept" ) ;
        String pwd = (String) request.getAttribute ( "password" ) ;
    %>

    <script>

        setInterval ( runpage , 1000 ) ;

        function runpage ()
        {
            document.getElementById ( "mail" ).value = "<%= mail %>" ;
            document.getElementById ( "fname" ).value = "<%= fnm %>" ;
            document.getElementById ( "lname" ).value = "<%= lnm %>" ;
            document.getElementById ( "dob" ).value = "<%= dob %>" ;
            document.getElementById ( "gender" ).value = "<%= gen %>" ;
            document.getElementById ( "dept" ).value = "<%= dept %>" ;
            document.getElementById ( "password" ).value = "<%= pwd %>" ;
        }

        function preventBack () 
        {
            window.history.forward (); 
        }
          
        setTimeout("preventBack()", 0);
        window.onunload = function () { null } ;

    </script>

    <body>

        <div id="msg"> OTP has been sent successfully to your E-mail ID ! </div>
        <div class="btn"></div>
<div class="regdet">
     <form action = "/voterregistration" method = "post" id = "otpform" onkeydown = "return event.key != 'Enter' ;">
    <p> VERIFY YOUR DETAILS <br/> REGISTRATION </p>
    <ul>
         <li><label> E-mail ID : <input type = "text" id = "mail" name = "mail" readonly /> </label></li>
         <li><label> First Name : <input type = "text" id = "fname" name = "fname" readonly /> </label></li>
         <li><label> Last Name : <input type = "text" id = "lname" name = "lname" readonly /> </label></li>
         <li><label> DOB : <input type = "text" id = "dob" name = "dob" readonly /> </label></li>
         <li><label> Gender : <input type = "text" id = "gender" name = "gender" readonly /> </label></li>
         <li><label> Department : <input type = "text" id = "dept" name = "dept" readonly /> </label></li>
         <li><label> Password : <input type = "password" id = "password" name = "password" readonly /> </label></li>
    </ul>
</div>
<div class="otp">
    <label> Enter the OTP to Complete Registration : <input type = "password" id = "mailotp" onkeyup = "check ()" /> </label>
    <span id = "mismatch"> </span>
   <input type = "submit" id = "otpsubmit" value = "SUBMIT" style = "display : none" />
</div>

</form>

    </body>

    <script>

    var check = function() 
    {
        inputotp = document.getElementById ( "mailotp" ).value ;
        sentotp = <%= otp %> ;
        if ( inputotp == sentotp ) 
        {
            document.getElementById ( "mismatch" ).style.color = "Green" ;
            document.getElementById ( "mismatch" ).innerHTML = "Correct OTP !" ;
            document.getElementById ( "otpsubmit" ).style.display = "block" ;
        }
        else 
        {
            document.getElementById ( "mismatch" ).style.color = "Crimson" ;
            document.getElementById ( "mismatch" ).innerHTML = "Incorrect OTP !!" ;
            document.getElementById ( "otpsubmit" ).style.display = "none" ;
        }
    }

    </script>

</html>