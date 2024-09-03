import java.sql.* ;
import java.io.* ;
import javax.servlet.* ;
import javax.servlet.http.* ;

public class createelection extends HttpServlet
{
    protected void doPost ( HttpServletRequest request , HttpServletResponse response ) 
    throws ServletException , IOException
    {
        try
        {
            String title = request.getParameter ( "title" ) ;
            int candidates = Integer.parseInt ( request.getParameter ( "nocand" ) ) ;
            String stdt = request.getParameter ( "start" ) ;
            String enddt = request.getParameter ( "end" ) ;
            Class.forName ( "com.mysql.cj.jdbc.Driver" ) ;  
            Connection con = DriverManager.getConnection ( "jdbc:mysql://localhost:1017/voting_system" , "root" , "1017" ) ;
            Statement st = con.createStatement () ;
            st.executeUpdate ( "DELETE FROM election" ) ;
            st.executeUpdate ( "DELETE FROM candidates" ) ;
            st.executeUpdate ( "DELETE FROM voter" ) ;
            st.executeUpdate ( "ALTER TABLE candidates AUTO_INCREMENT = 1" ) ;
            st.executeUpdate ( "INSERT INTO election ( name , candidates , startdate , enddate ) VALUES ( '" + title + "' , '" + candidates + 
                               "' , '" + stdt + "' , '" + enddt + "' ) " ) ;
            RequestDispatcher reqd = request.getRequestDispatcher ( "adminloggedin" ) ;
            reqd.forward ( request , response ) ;
            st.close () ;
        }
        catch (Exception e) { e.printStackTrace () ; }
    }
}
            

