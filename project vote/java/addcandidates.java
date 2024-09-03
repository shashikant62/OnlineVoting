import java.sql.* ;
import java.io.* ;
import javax.servlet.* ;
import javax.servlet.http.* ;

public class addcandidates extends HttpServlet
{
    protected void doPost ( HttpServletRequest request , HttpServletResponse response ) 
    throws ServletException , IOException
    {
        try
        {
            String fname = request.getParameter ( "fname" ) ;
            String lname = request.getParameter ( "lname" ) ;
            String mail = request.getParameter ( "mailid" ) ;
            String gen = request.getParameter ( "gender" ) ;
            Class.forName ( "com.mysql.cj.jdbc.Driver" ) ;
            Connection con = DriverManager.getConnection ( "jdbc:mysql://localhost:1017/voting_system" , "root" , "1017" ) ;
            Statement st = con.createStatement () ;
            st.executeUpdate ( "INSERT INTO candidates ( firstname , lastname , email , gender ) VALUES ( '" + fname + "' , '" + lname +
                               "' , '" + mail + "' , '" + gen + "' )" ) ;
            RequestDispatcher reqd = request.getRequestDispatcher ( "adminloggedin" ) ;
            reqd.forward ( request , response ) ;
            st.close () ;
        }
        catch (Exception e) { e.printStackTrace () ; }
    }
}
