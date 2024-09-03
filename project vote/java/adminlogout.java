import java.io.* ;
import javax.servlet.* ;
import javax.servlet.http.* ;

public class adminlogout extends HttpServlet
{
    protected void doPost ( HttpServletRequest request , HttpServletResponse response ) 
    throws ServletException , IOException
    {
        try
        {
            HttpSession session = request.getSession () ;
            session.invalidate () ;
            response.sendRedirect ( "./adminlogin.jsp" ) ;
        }
        catch (Exception e) { e.printStackTrace () ; }
    }
}