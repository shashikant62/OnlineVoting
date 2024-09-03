import java.io.* ;
import javax.servlet.* ;
import javax.servlet.http.* ;

public class voterlogout extends HttpServlet
{
    protected void doGet ( HttpServletRequest request , HttpServletResponse response ) 
    throws ServletException , IOException
    {
        try
        {
            HttpSession session = request.getSession () ;
            session.invalidate () ;
            response.sendRedirect ( "./voterlogin.jsp" ) ;
        }
        catch (Exception e) { e.printStackTrace () ; }
    }
}