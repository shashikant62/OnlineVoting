<%@ page contentType = "text/html" %>
<%@ page import = " java.sql.* , java.io.* " %>

<html>
<link rel="stylesheet" href="./css/voterlogin.css">
<link rel="stylesheet" href="./css/style.css">
<script src="./css/voterlogin.js"></script>

    <%
        response.setHeader("Cache-Control", "no-cache, must-revalidate") ;
        String mail = (String) request.getAttribute ( "mail" ) ;
        String pt = (String) request.getAttribute ( "pt" ) ;
        String stdt = (String) request.getAttribute ( "stdt" ) ;
        String enddt = (String) request.getAttribute ( "enddt" ) ;
        String title = (String) request.getAttribute ( "title" ) ;
        int exist = (int) request.getAttribute ( "exist" ) ;
        int candidates = (int) request.getAttribute ( "candidates" ) ;
        String candids = "" ;
        String voted = "" ;
        try
        {
            if ( exist != 0 )
            {
                Class.forName ( "com.mysql.cj.jdbc.Driver" ) ;  
                Connection con = DriverManager.getConnection ( "jdbc:mysql://localhost:1017/voting_system" , "root" , "1017" ) ;
                Statement st = con.createStatement () ;
                ResultSet rs1 = st.executeQuery ( "SELECT votestatus FROM voter WHERE email = '" + mail + "'" ) ;
                rs1.next () ;
                voted = voted + rs1.getString (1) ;
                ResultSet rs2 = st.executeQuery ( "SELECT id , firstname , lastname , gender FROM candidates" ) ;
                while ( rs2.next () )
                {
                    int candidateid = rs2.getInt (1) ;
                    String cid = "c" + candidateid ;
                    String vid = "v" + candidateid ;
                    candids = candids.concat ("<div class='card'> <div class='face face1'> <div class='content'><div id = '"+ cid +"'><h2 class='info'> CANDIDATE DETAILS </h2><p class='info'><div class='face face2'>ID " + rs2.getInt (1) + "</div><br /> FIRSTNAME &nbsp; &nbsp;" ) ;
                    candids = candids.concat ( rs2.getString (2) + "<br /> <br /> LASTNAME &nbsp; &nbsp;" + rs2.getString (3) + "<br /><br /> GENDER &nbsp; &nbsp; &nbsp; &nbsp;" ) ;
                    candids = candids.concat ( rs2.getString (4) + "</p><br /> </div> </div> </div> </div>") ;
                }
            }
        }
        catch ( Exception e ) { e.printStackTrace () ; }
    %>

    <script type = "text/javascript">

        setInterval ( date_time , 1000 ) ;

        function date_time ()
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
            votestatus = "<%= voted %>" ;
            startdate = "<%= stdt %>" ;
            enddate = "<%= enddt %>" ;
            elecstatus = "<%= exist %>" ;
            electitle = "<%= title %>" ;
            voterinfo = "<%= pt %>" ;
            document.getElementById ( "votestatus" ).innerHTML = "VOTESTATUS : " + votestatus ;
            document.getElementById ("voterinfo").innerHTML = voterinfo ;
            if ( (elecstatus != 0 ) && ( ordate >=  startdate ) && ( ordate < enddate ) )
            {
                document.getElementById ("candidinfo").innerHTML = "<%= candids %>" ;
                if ( votestatus == "no" )
                {
                    document.getElementById ( "votenow" ).style.display = "block" ;
                    document.getElementById ( "votebtn" ).style.display = "block" ;
                    document.getElementById ( "mail" ).value = "<%= mail %>" ;
                    document.getElementById ( "voted" ).value = "<%= voted %>" ;
                }
            }
            else if ( ( elecstatus != 0 ) && ( ordate < startdate ) )
            {
                document.getElementById ( "elecinfo" ).style.display = "block" ;
                elections1 = "<table style='font-size: 22px;' cellpadding='3'  cellspacing='15'> <tr style='width:3%'> <th> Live Elections </th> <th> Start Date </th> <th> End Date </th> </tr>" ;
                elections1 = elections1.concat ( " <tr> <td> " + electitle + " </td> <td> " + startdate + " </td> <td> " + enddate + " </td> </tr> </table>" ) ;
                document.getElementById ("elecinfo").innerHTML = elections1;
            }
            else
            {
                document.getElementById ( "elresults" ).style.display = "block" ;
            }
        }

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
                  <li><form action = "/voterlogout" method = "GET"> <input id = "logout" type = "submit" value = "LOGOUT" /> </form></li>
                  <li><button onmouseover="openNav()" onmouseout="closeNav()">USER PROFILE</button></li>
                  <li><button onclick="vote()" id="votebtn" style="display:none;">VOTE</button></li>
                </ul>
              </div>
            </nav>
          </header>
            <div id = "elecinfo" class = "elecinfo" style = "display : none"></div>

       <div class="container">
           <div id = "candidinfo"> </div>
        </div>
        <div id = "form">
            <form onsubmit = "alert ( 'Click OK to confirm your vote. After successfully casting your vote, you will be LOGGED OUT !' )" action = "/updatecandidate" method = "post" id="votenow" style = "display : none">
         <label style="display: none;"> YOUR E-MAIL : <input type = "text" id = "mail" name = "mail" style="display: none;"readonly/> </label>
         <label style="display: none;"> YOUR VOTESTATUS : <input type = "text" id = "voted" name = "voted" readonly style="display: none;"/> </label>
         <label> Enter CANDIDATE ID to Vote : <input type = "number" id = "candidate" name = "candidate" min = "1" max = "<%= candidates %>" required /> </label>
         <input type = "submit" value = "VOTE" id = "votebutton" />
            </form>
            </div>
        <div id = "voterinfo" class = "voterinfo"></div>
        <div id = "votestatus" class = "votestatus" style="display:none;"></div>
        <form action = "./results.jsp" id = "elresults" style = "display : none">
            <div id = "btn"><button> VIEW ELECTION RESULTS </button>
              <img src = "https://www.pbevents.com.au/media/1173/download-results-button_272x360.jpg">
            </div>
        </form> 
        <script>
            function openNav() {
              document.getElementById("voterinfo").style.width = "170px";
              document.getElementById("votestatus").style.width = "170px";
            }
            function closeNav() {
              document.getElementById("voterinfo").style.width = "0px";
              document.getElementById("votestatus").style.width = "0px";
            }
            function vote(){
                document.getElementById("form").style.display="block";
            }
            </script>
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

</html>