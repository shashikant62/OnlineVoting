<%@ page contentType = "text/html" %>
<%@ page import = " java.sql.* , java.io.* , java.util.* " %>

<!DOCTYPE html>
<html>
  
  <link rel = "stylesheet" href = "./css/result.css">
  <%
      Class.forName ( "com.mysql.cj.jdbc.Driver" ) ;  
      Connection con = DriverManager.getConnection ( "jdbc:mysql://localhost:1017/voting_system" , "root" , "1017" ) ;
      Statement st = con.createStatement () ;
      List<List> values = new ArrayList<List>();
      List row = new ArrayList();
      row.add ( "'Gender'" ) ;
      row.add ( "'Registered Voters'" ) ;
      values.add ( row ) ;
      ResultSet rs = st.executeQuery ( "SELECT gender , COUNT(gender) FROM voter GROUP BY gender" ) ;
      while ( rs.next () )
      {
          List rows = new ArrayList();
          rows.add ( "'" + rs.getString (1) + "'" ) ;
          rows.add ( rs.getInt (2) ) ;
          values.add ( rows ) ;
      }   
      List<List> votedvalues = new ArrayList<List>();
      List rowv = new ArrayList();
      rowv.add ( "'Gender'" ) ;
      rowv.add ( "'Votes Casted'" ) ;
      votedvalues.add ( rowv ) ;
      ResultSet rsv = st.executeQuery ( "SELECT gender , COUNT(gender) FROM voter WHERE votestatus = 'yes' GROUP BY gender" ) ;
      while ( rsv.next () )
      {
        List rowsv = new ArrayList();
        rowsv.add ( "'" + rsv.getString (1) + "'" ) ;
        rowsv.add ( rsv.getInt (2) ) ;
        votedvalues.add ( rowsv ) ;
      }   
      List<List> candivote = new ArrayList<List>();
        List rowz = new ArrayList();
        rowz.add ( "'CANDIDATE'" ) ;
        rowz.add ( "'Votes Casted'" ) ;
        candivote.add ( rowz ) ;
        ResultSet rsz = st.executeQuery ( "SELECT * from candidates" ) ;
        while ( rsz.next () )
        {
          List rowsz = new ArrayList();
          rowsz.add ( "'" + rsz.getString (2) + "'" ) ;
          rowsz.add ( rsz.getInt (6) ) ;
          candivote.add ( rowsz ) ;
        }
        String win = "<div class = 'container'>" ;
        win = win.concat ( "<div class='text-container'> <table cellspacing='15' cellpadding='6' align='center' style='color:rgb(226, 90, 66);font-size:25px;font-family: Lucida Handwriting, Courier New, monospace;'><h1> WINNING CANDIDATE(S) ! </h1> <tr> <th> ID </th> <th>NAME</th></tr>" ) ;
        ResultSet winner = st.executeQuery ( "SELECT id , firstname , lastname FROM candidates WHERE votes = ( SELECT MAX(votes) FROM candidates ) ; " ) ;
        while ( winner.next () )
        {
          win = win.concat ( "<tr> <td> " + winner.getInt (1) + " </td> <td> " + winner.getString (2) +" "+ winner.getString (3) + " </td> </tr>" ) ;
        }
        win = win.concat ( "</table><div class = 'fading-effect'></div></div></div>" ) ;
      
  %> 

  <script type = "text/javascript" src = "https://www.gstatic.com/charts/loader.js"> </script>

  <body onload = "load ()">

    <%= values %> <br />

    <%= votedvalues %> <br />

    <%= candivote %>

    <div id = "genreg" class = "chart1"> </div>

    <script>

      function load ()
      {
        winning = "<%= win %>" ;
        document.getElementById ( "winner" ).innerHTML = winning ;
      }

      google.charts.load ( 'current' , { 'packages' : ['corechart'] } ) ;
      google.charts.setOnLoadCallback ( drawChart );

      function drawChart () {
      var data = google.visualization.arrayToDataTable ( <%= values %> ) ;

      var options = {
        title : 'TOTAL VOTERS REGISTERED BASED ON GENDER' ,
        is3D : true ,
        width : 600 ,
        height : 500
      } ;

      var chart = new google.visualization.PieChart ( document.getElementById ( 'genreg' ) );
        chart.draw ( data , options ) ;
      }

    </script>

    <br /> 
    
    <div id = "genvote" class = "chart2"> </div>

    <script>

      google.charts.load ( 'current' , { 'packages' : ['corechart'] } ) ;
      google.charts.setOnLoadCallback ( drawChart );

      function drawChart () {
      var data = google.visualization.arrayToDataTable ( <%= votedvalues %> ) ;

      var options = {
        title : 'TOTAL VOTERS VOTED BASED ON GENDER' ,
        is3D : true ,
        width : 600 ,
        height : 500
      } ;
 
      var chart = new google.visualization.PieChart ( document.getElementById ( 'genvote' ) ) ;
        chart.draw ( data , options ) ;
      }

    </script>

    <br />

    <div id = "numvote" class = "chart3"></div>

    <script>

      google.charts.load ( 'current' , { 'packages' : ['corechart' , 'bar'] } ) ;
      google.charts.setOnLoadCallback ( drawChart );
      
      function drawChart () {
      var data = google.visualization.arrayToDataTable ( <%= candivote %> ) ;
      
      var options = {
        title : 'CANDIDATE TRENDS AND RESULT' ,
        colors : ['#e0440e'] ,
        width : 600 ,
        height : 500 ,
        legend : { position : 'none' }
      } ;
      
      var chart = new google.visualization.ColumnChart ( document.getElementById ( 'numvote' ) ) ;
        chart.draw ( data , options ) ;
      }
    
    </script>

    <div class = "block"> <h1> RESULTS HERE!!!!! </h1> </div>
    <ul>
      <li onclick = "numvote ()">DISTRIBUTION</li>
      <li onclick = "genvote ()">VOTED </li>
      <li onclick = "genreg ()">REGISTERED</li>
    </ul>
    <script>

      function numvote () 
      {
        var x = document.getElementById ( "numvote" ) ;
        if ( x.style.display != "block" ) 
        {
          x.style.display = "block" ;
        } 
        else 
        {
          x.style.display = "none" ;
        }
        document.getElementById("genvote").style.display="none";
        document.getElementById("genreg").style.display="none";
      }
      
      function genvote () 
      {
        var x = document.getElementById ( "genvote" ) ;
        if ( x.style.display != "block" ) 
        {
          x.style.display = "block" ;
        } 
        else 
        {
          x.style.display = "none" ;
        }
        document.getElementById("numvote").style.display="none";
        document.getElementById("genreg").style.display="none";
      }

      function genreg () 
      {
        var x = document.getElementById ( "genreg" ) ;
        if ( x.style.display != "block" ) 
        {
          x.style.display = "block" ;
        } 
        else 
        {
          x.style.display = "none" ;
        }
        document.getElementById("genvote").style.display="none";
        document.getElementById("numvote").style.display="none";
      }
    </script>
<br/>
<br/>
<br/>
    <div class="confetti">
      <div class="confetti-piece"></div>
      <div class="confetti-piece"></div>
      <div class="confetti-piece"></div>
      <div class="confetti-piece"></div>
      <div class="confetti-piece"></div>
      <div class="confetti-piece"></div>
      <div id = "winner"> </div>
      <div class="confetti-piece"></div>
      <div class="confetti-piece"></div>
      <div class="confetti-piece"></div>
      <div class="confetti-piece"></div>
      <div class="confetti-piece"></div>
      <div class="confetti-piece"></div>
      <div class="confetti-piece"></div>
  </div>
</body>
</html>