import java.sql.* ;
import java.io.* ;
import javax.servlet.* ;
import javax.servlet.http.* ;

public class adminloggedin extends HttpServlet
{
    protected void doPost ( HttpServletRequest request , HttpServletResponse response ) 
    throws ServletException , IOException
    {
        try
        {
            PrintWriter out = response.getWriter () ;
            Class.forName ( "com.mysql.cj.jdbc.Driver" ) ;  
            Connection con = DriverManager.getConnection ( "jdbc:mysql://localhost:1017/voting_system" , "root" , "1017" ) ;
            Statement st = con.createStatement () ;
            ResultSet rs = st.executeQuery ( "SELECT EXISTS ( SELECT * FROM election )" ) ;
            rs.next() ;
            int exist = rs.getInt (1) ;
            ResultSet rs1 = st.executeQuery ( "SELECT * FROM candidates" ) ;
            String title = "" ;
            String stdt = "" ;
            String enddt = "" ;
            String candids = "" ; 
            int candidates = 0 ;
            while ( rs1.next () )
            {
                int candidateid = rs1.getInt (1) ;
                String cid = "c" + candidateid ;
                candids = candids.concat ( "<div class = 'candinfo'><div id = '<%= cid %>'><br/> ID : " + rs1.getInt (1) + "<br /> FIRST NAME : " + rs1.getString (2) + "<br /> LAST NAME : " + rs1.getString (3) ) ;
                candids = candids.concat ( "<br /> E-MAIL : " + rs1.getString (4) + "<br /> GENDER : " + rs1.getString (5) + "<br /> VOTES : " + rs1.getInt (6) + " </div></div>") ;
            }
            if ( exist != 0 )
            {
                ResultSet rs2 = st.executeQuery ( "SELECT name , candidates , startdate , enddate FROM election" ) ;
                rs2.next () ;
                title = title + rs2.getString (1) ;
                candidates = rs2.getInt (2) ;
                stdt = stdt + rs2.getString (3) ;
                enddt = enddt + rs2.getString (4) ;
            }  
            request.setAttribute ( "candidates" , candidates ) ;
            request.setAttribute ( "exist" , exist ) ;
            request.setAttribute ( "title" , title ) ;
            request.setAttribute ( "stdt" , stdt ) ;
            request.setAttribute ( "enddt" , enddt ) ;
            request.setAttribute ( "candids" , candids ) ;
            RequestDispatcher reqd = request.getRequestDispatcher ( "/adminloggedin.jsp" ) ;
            reqd.forward ( request , response ) ;
            st.close () ;
            out.close () ;
        }
        catch (Exception e) { e.printStackTrace () ; }
    }
}