<%@ page contentType = "text/html" %>
<%@ page import = " java.sql.* , java.io.* " %>

<html>
  <link rel="stylesheet" href="./css/verify.css">
    <%
        String mail = (String) request.getAttribute ( "mail" ) ;
        int otp = (int) request.getAttribute ( "otp" ) ;
        int display = 1 ;
        try
        {
            Class.forName ( "com.mysql.cj.jdbc.Driver" ) ;  
            Connection con = DriverManager.getConnection ( "jdbc:mysql://localhost:1017/voting_system" , "root" , "1017" ) ;
            Statement st = con.createStatement () ;
            ResultSet rsa = st.executeQuery ( "SELECT email FROM admin" ) ;
            rsa.next () ;
            if ( rsa.getString (1).equals (mail) )
            {
                display = 2 ;
            }
        }
        catch ( Exception e ) { e.printStackTrace () ; }
    %>

    <script>

        setInterval ( runpage , 1000 ) ;

        function runpage ()
        {
            document.getElementById ( "mail" ).value = "<%= mail %>" ;
            display = <%= display %> ;
            if ( display == 2 )
                document.getElementById ( "otpform2" ).style.display = "block" ;
            else
                document.getElementById ( "otpform1" ).style.display = "block" ;
        }

        function preventBack () 
        {
            window.history.forward (); 
        }
        setTimeout("preventBack()", 0);
        window.onunload = function () { null } ;
    </script>

    <body>

        <div id="msg"> OTP has been sent successfully to your registered E-mail ID ! </div>
           <form action = "/voterloggedin" method = "post" id = "otpform1" style = "display : none" onkeydown = "return event.key != 'Enter' ;" class="verify">
                <label> Your E-mail ID : <input type = "text" id = "mail" name = "mail" readonly /> </label><br/><br/>
                <label> Enter the OTP : <input type = "password" id = "mailotp1" onkeyup = "check1 ()" /> </label>
                <br/>
                <span id = "mismatch1"> </span>
                    <input type = "submit" id = "otpsubmit1" value = "SUBMIT" style = "display : none" />
    </form>
        <form action = "/adminloggedin" method = "post" id = "otpform2" style = "display : none" onkeydown = "return event.key != 'Enter' ;" class="verify">
            <label> Enter the OTP: <input type = "password" id = "mailotp2" onkeyup = "check2 ()" /> </label><br/>
               <span id = "mismatch2"> </span>                    <input type = "submit" id = "otpsubmit2" value = "SUBMIT" style = "display : none" />
    </form>
    </body>
    <script>
    var check1 = function() 
    {
        inputotp = document.getElementById ( "mailotp1" ).value ;
        sentotp = <%= otp %> ;
        if ( inputotp == sentotp ) 
        {
            document.getElementById ( "mismatch1" ).style.color = "LawnGreen" ;
            document.getElementById ( "mismatch1" ).innerHTML = "Correct OTP !" ;
            document.getElementById ( "otpsubmit1" ).style.display = "block" ;
        }
        else 
        {
            document.getElementById ( "mismatch1" ).style.color = "Crimson" ;
            document.getElementById ( "mismatch1" ).innerHTML = "Incorrect OTP !!" ;
            document.getElementById ( "otpsubmit1" ).style.display = "none" ;
        }
    }
    var check2 = function() 
    {
        inputotp2 = document.getElementById ( "mailotp2" ).value ;
        sentotp2 = <%= otp %> ;
        if ( inputotp2 == sentotp2 ) 
        {
            document.getElementById ( "mismatch2" ).style.color = "LawnGreen" ;
            document.getElementById ( "mismatch2" ).innerHTML = "Correct OTP !" ;
            document.getElementById ( "otpsubmit2" ).style.display = "block" ;
        }
        else 
        {
            document.getElementById ( "mismatch2" ).style.color = "Crimson" ;
            document.getElementById ( "mismatch2" ).innerHTML = "Incorrect OTP !!" ;
            document.getElementById ( "otpsubmit2" ).style.display = "none" ;
        }
    }
    </script>
</html>
