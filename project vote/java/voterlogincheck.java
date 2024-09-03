import java.sql.* ;
import java.io.* ;
import javax.servlet.* ;
import javax.servlet.http.* ;

public class voterlogincheck extends HttpServlet
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
            String mail = request.getParameter ( "email" ) ;
            String pwd = request.getParameter ( "password" ) ;  
            request.setAttribute ( "mail" , mail ) ;
            Statement st = con.createStatement () ;
            boolean find = false ;
            ResultSet rs2 = st.executeQuery ( "SELECT email , password FROM voter" ) ; 
            while ( rs2.next () ) 
            {
                out.println ( "  dbmail : " + rs2.getString (1) + "  ipmail : " + mail + "  dbpwd : " + rs2.getString (2) + "  ippwd : " + pwd ) ;
                if ( ( rs2.getString (1).equals ( mail ) ) && ( rs2.getString (2).equals ( pwd ) ) )
                {
                    find = true ;
                    RequestDispatcher reqd = request.getRequestDispatcher ("loginotpemail") ;
                    reqd.forward ( request , response ) ;
                    break ;
                }
            } 
            if ( !find )
            {
                String votererror = "wrong" ;
                request.setAttribute ( "votererror" , votererror ) ;
                RequestDispatcher reqd = request.getRequestDispatcher ("/voterlogin.jsp") ;
                reqd.forward ( request , response ) ;
            }
            st.close () ;
            con.close () ;
            out.close () ;
        }
        catch ( Exception e ) 
        {
            
            e.printStackTrace () ; 
             
        }
    }
}