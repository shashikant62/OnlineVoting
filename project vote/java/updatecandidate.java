import java.sql.* ;
import java.io.* ;
import javax.servlet.* ;
import javax.servlet.http.* ;

public class updatecandidate extends HttpServlet
{
    protected void doPost ( HttpServletRequest request , HttpServletResponse response ) 
    throws ServletException , IOException
    {
        try
        {
            int cand = Integer.parseInt ( request.getParameter ( "candidate" ) ) ;
            String mail = request.getParameter ( "mail" ) ;
            String voted = request.getParameter ( "voted" ) ;
            PrintWriter out = response.getWriter () ;
            Class.forName ( "com.mysql.cj.jdbc.Driver" ) ;  
            Connection con = DriverManager.getConnection ( "jdbc:mysql://localhost:1017/voting_system" , "root" , "1017" ) ;
            Statement st = con.createStatement () ;
            if ( voted.equals ("no") )
            {
                st.executeUpdate ( "UPDATE candidates SET votes = ( votes + 1 ) WHERE id = " + cand ) ;
                st.executeUpdate ( "UPDATE voter SET votestatus = 'yes' WHERE email = '" + mail + "'" ) ;
            }
            response.sendRedirect ( "voterlogout" ) ; 
            st.close () ;
        }
        catch (Exception e) { e.printStackTrace () ; }
    }
}