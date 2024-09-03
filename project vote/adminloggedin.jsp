<%@ page contentType = "text/html" %>
<%@ page import = " java.sql.* , java.io.* " %>

<html>
    <link rel="stylesheet" href="./css/voterlogin.css">
    <link rel="stylesheet" href="./css/style.css">
    <script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
    <%
        response.setHeader ( "Cache-Control" , "no-cache , must-revalidate" ) ;
        String candids = (String) request.getAttribute ( "candids" ) ;
        String electitle = (String) request.getAttribute ( "title" ) ;
        String startdate = (String) request.getAttribute ( "stdt" ) ;
        String enddate = (String) request.getAttribute ( "enddt" ) ;
        int exist = (int) request.getAttribute ( "exist" ) ; 
        int candidates = (int) request.getAttribute ( "candidates" ) ;
        int added=0;
        try
        {
            Class.forName ( "com.mysql.cj.jdbc.Driver" ) ;  
            Connection con = DriverManager.getConnection ( "jdbc:mysql://localhost:1017/voting_system" , "root" , "1017" ) ;
            Statement st = con.createStatement () ;
            ResultSet rsu = st.executeQuery ( "SELECT COUNT(*) FROM candidates" ) ;
            rsu.next () ;
            added = rsu.getInt (1) ;
        }
        catch (Exception e) { e.printStackTrace () ; }
    %>

    <script>

        setInterval ( eleclive , 1000 ) ;

        function eleclive ()
        {
            date = new Date () ;
            day = date.getDate () ;
            month = date.getMonth () + 1 ;
            year = date.getFullYear () ;
            if ( day < 10 )
            {
                day = "0" + day ;
            } 
            if ( month < 10 )
            {
                month = "0" + month ;
            } 
            today = year + "-" + month + "-" + day ;
            elecstatus = <%= exist %> ;
            strdt = "<%= startdate %>" ;
            enddt = "<%= enddate %>" ;
            if ( elecstatus != 0 )
            {
                elections1 = "<table cellspacing='13' style='border:1px solid black;'> <tr> <th> Live Elections </th> <th> Start Date </th> <th> End Date </th> </tr>" ;
                elections1 = elections1.concat ( " <tr> <td> " + "<%= electitle %>" + " </td> <td> " + "<%= startdate %>" + 
                                                " </td> <td> " + "<%= enddate %>" + " </td> </tr> </table>" ) ;
                elections2 = "<%= candids %>"
                document.getElementById ("createbutton").style.display = "none" ;
                if ( today < strdt )
                {
                    document.getElementById ( "addcands" ).style.display = "block" ;
                }
                else if ( ( today >= strdt ) && ( today < enddt ) )
                {
                    document.getElementById ( "addcands" ).style.display = "none" ;
                }
                else if ( today >= enddt )
                {
                    document.getElementById ("oldresults").style.display = "block" ;
                    document.getElementById ("createbutton").style.display = "block" ;
                    elections2 = elections2.concat ( "<b> The above mentioned election has ended!! Create a new election by clicking button given below </b>" ) ;
                }
                document.getElementById ("elecinfo").innerHTML = elections1.concat ( elections2 ) ;
            }
            else
            {
                st = "<h3> No Live Elections </h3>";
                document.getElementById ("elecinfo").innerHTML = st ;
                document.getElementById ("createbutton").style.display = "block" ;
            }
            candidates = <%= candidates %> ;
            addedcands = <%= added %> ;
            if ( addedcands >= candidates )
                document.getElementById ( "addcands" ).style.display = "none" ;
        }

        function election_date ()
        {
            date = new Date () ;
            day = date.getDate () + 1 ;
            month = date.getMonth () + 1 ;
            year = date.getFullYear () ;
            if ( day < 10 )
            {
                day = "0" + day ;
            } 
            if ( month < 10 )
            {
                month = "0" + month ;
            } 
            mindate = year + "-" + month + "-" + day ;
            document.getElementById ( "start" ).min = mindate ;
        }

        function set_mindate ()
        {
            document.getElementById ("createelec").style.display = "block" ;
            election_date () ;
        }
        $(document).ready(function(){
  $(window).scroll(function(){
  	var scroll = $(window).scrollTop();
	  if (scroll > 300) {
	    $("header").css("background" , "rgba(0, 0, 0, 0.7);");
	  }

	  else{
		  $("header").css("background" , "rgba(0, 0, 0, 0.1);");  	
	  }
  })
})
    </script>

    <body>
        <header>
            <nav>
              <div class = "logo">
                <a href="javascript:void(0);">
                    <img src = "./image/logo.png" alt = "logo" >
                </a>
              </div>
              <div class = "menu"> 
                <ul>
                  <li> <a href = "./about1.html" target="_blank" rel="noopener noreferrer"> ABOUT </a> </li>
                  <li><form action = "/adminlogout" method = "post"> <input id = "logout" type = "submit" value = "LOGOUT" />  </form></li>
                  <li><button " id = "createbutton" onclick = "set_mindate ()"> CREATE ELECTION </button></li>
                  <li><button id = "addcands" onclick = "candidsinfo () " style="display: none;"> ADD CANDIDATES </button></li>
                </ul>
              </div>
            </nav>
          </header>
        <h1 style="position: fixed;
        top: -1%;
        left: 32%;
        font-size: 60px;
        font-weight: bolder;
        color: white;">WELCOME ADMIN</h1>
        <div id = "elecinfo" class="elecinfo"> </div>

        <form action = "./results.jsp" id = "oldresults" style = "display : none;" method = "post">
            <div class="result">
                <button> VIEW RESULTS </button>
            </div>
        </form>

        <div id = "createelec" style = "display : none;position: fixed;top: 30%;left:60%;background-color: bisque;font-size: larger;border-radius: 1rem;padding: 2%;height: 30%;width: 30%;text-align: justify;">

            <form action = "/createelection" method = "post">
                <label> ELECTION TITLE&nbsp;&emsp;&emsp;:&nbsp;<input type = "text" id = "title" name = "title" placeholder = "Election Name" required style="padding: 1%;font-size: large;" /> </label>
                <br/><br/>
                <label> NO. OF CANDIDATES :&nbsp; <input type = "number" id = "nocand" name = "nocand" min = "2" max = "10" required
                    style="padding: 1%;font-size: large;" /></label>
                <br/><br/>
                <label> START DATE &emsp;&emsp;&emsp;&nbsp;&nbsp;&nbsp;:&nbsp; <input type = "date" id = "start" name = "start" onchange = "end_date ()" required 
                    style="padding: 1%;font-size: large;"/> </label>
                <br/><br/>
                <label> END DATE &emsp;&emsp;&emsp;&emsp;&nbsp;&nbsp;: &nbsp;<input type = "date" id = "end" name = "end" required readonly style="padding: 1%;font-size: large;" /> </label>
                <input type = "submit" value = "SUBMIT" style="position: fixed;left: 88%;top: 60%;border-radius: 1rem;font-size: large;padding: 0.5%;"/>
            </form>

        </div>

        <button id = "addcands" style = "display : none;position: fixed;top: 20%;right:20%;padding: 2%;border-radius: 1rem;font-size: larger;overscroll-behavior-block: azure;" onclick = "candidsinfo ()"> ADD CANDIDATES </button>

        <div id = "candinfo" style="flex-direction: column;margin: 10%;"> </div>
        <footer>

            <div class = "logo">
              <a href = "javascript:void(0);">
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

    <script>

        function candidsinfo ()
        {
            candform = "" ;
            cid = "candid" ; 
            candform = candform.concat ( "<br /> <br /><div class='addcad'> <h3>CANDIDATE INFO </h3>" + " <br /><form id = '" + cid + "' action = '/addcandidates' " ) ;
            candform = candform.concat ( "method = 'post'><label> FIRST NAME : <input type = 'text' id = 'fname' name = 'fname' placeholder = 'Firstname' " ) ; 
            candform = candform.concat ( "maxlength = 50 required /> </label><br /> <br /><label> LAST NAME : <input type = 'text' id = 'lname' name = 'lname' placeholder = 'Lastname' " ) ;
            candform = candform.concat ( "maxlength = 50 required /> </label> <br /><br /><label> E-MAIL :&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp; <input type = 'email' id = 'mailid' name = 'mailid' placeholder = 'E-mail' " ) ;
            candform = candform.concat ( "required /><br /><br /> </label> <label>GENDER :&nbsp; &nbsp; Male <input type = 'radio' name = 'gender' value = 'Male' " ) ;
            candform = candform.concat ( "checked = 'checked' /> &nbsp; &nbsp; Female <input type = 'radio' name = 'gender' value = 'Female' /><br /><br /></label>" ) ; 
            candform = candform.concat ( "<input type = 'submit' value = 'SUBMIT'/ style='border: none;padding: 2%;  left:80%;position:relative;color: red;background: wheat;'></form></div>" ) ;
            document.getElementById ( "candinfo" ).innerHTML = candform ;
        }

    </script>

    <script>

        function end_date ()
        {
            startdate = document.getElementById ("start").value ;
            enddate = new Date () ;
            enddate = startdate ;
            document.getElementById ( "end" ).value = enddate ; 
            document.getElementById ("end").stepUp (1);
        }

    </script>

</html> 