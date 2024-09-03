import java.sql.* ;
import java.io.* ;
import javax.servlet.* ;
import javax.servlet.http.* ;

public class adminlogincheck extends HttpServlet
{
    protected void doPost ( HttpServletRequest request , HttpServletResponse response ) 
    throws ServletException , IOException
    {
        try
        {
            response.setContentType ( "text/html" ) ;
            PrintWriter out = response.getWriter () ;
            Class.forName ( "com.mysql.cj.jdbc.Driver" ) ;  
            Connection con = DriverManager.getConnection ( "jdbc:mysql://localhost:1017/voting_system" , "root" , "1017" ) ;  
            Statement st = con.createStatement () ;
            String mail = request.getParameter ( "Admin-id" ) ;
            String pwd = request.getParameter ( "password" ) ;
            ResultSet rs = st.executeQuery ( "SELECT email , password FROM admin" ) ;
            rs.next () ;
            if ( ( (rs.getString (1)).equals (mail) ) && ( (rs.getString (2)).equals (pwd) ) )
            {
                HttpSession session = request.getSession () ;
                request.setAttribute ( "mail" , mail ) ;
                RequestDispatcher reqd = request.getRequestDispatcher("loginotpemail") ;
                reqd.forward ( request , response ) ;
            }
            else
            {
                String adminerror = "wrong" ;
                request.setAttribute ( "adminerror" , adminerror ) ;
                RequestDispatcher reqd = request.getRequestDispatcher("/adminlogin.jsp") ;
                reqd.forward ( request , response ) ;
            }
            st.close () ;
            out.close () ;
        } 
        catch (Exception e) { e.printStackTrace () ; }
    }
}   