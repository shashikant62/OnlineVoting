import java.sql.* ;
import java.io.* ;
import javax.servlet.* ;
import javax.servlet.http.* ;

public class voterregistration extends HttpServlet
{
    protected void doPost ( HttpServletRequest request , HttpServletResponse response ) 
    throws ServletException , IOException
    {
        try 
        {
            response.setContentType ( "text/html" ) ;
            Class.forName ( "com.mysql.cj.jdbc.Driver" ) ;  
            PrintWriter out = response.getWriter () ;
            Connection con = DriverManager.getConnection ( "jdbc:mysql://localhost:1017/voting_system" , "root" , "1017" ) ;  
            Statement st = con.createStatement ();
            String fnm = request.getParameter ( "fname" ) ;
            String lnm = request.getParameter ( "lname" ) ;
            String dob = request.getParameter ( "dob" ) ;
            String gen = request.getParameter ( "gender" ) ;
            String mail = request.getParameter ( "mail" ) ;
            String dept = request.getParameter ( "dept" ) ;
            String pwd = request.getParameter ( "password" ) ;
            int check = 1;
            String regr = "" ;
            ResultSet rsv = st.executeQuery ( "SELECT email FROM voter" ) ;
            while ( rsv.next () )
            {
                if ( mail.equals ( rsv.getString (1) ) )
                {
                    check = 0 ;
                    break ;
                }
            }
            if ( check == 1 )
            {
                st.executeUpdate ( "INSERT INTO voter ( firstname , lastname , dob , gender , email , dept , password ) " + 
                                "VALUES ( '" + fnm + "' , '" + lnm + "' , '" + dob + "' , '" + gen + "' , '" + mail + "' , '" + dept + "' , '" + pwd + "' )" ) ;
                regr = "pass" ;
            }
            else
                regr = "fail";
            request.setAttribute ( "regr" , regr ) ;
            RequestDispatcher reqd = request.getRequestDispatcher("./voterlogin.jsp") ;
            reqd.forward ( request , response ) ;
            st.close () ;
            con.close () ;
        }
        catch (Exception e) { e.printStackTrace () ; }
   }
}