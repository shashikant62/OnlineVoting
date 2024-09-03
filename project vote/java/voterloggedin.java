import java.sql.* ;
import java.io.* ;
import javax.servlet.* ;
import javax.servlet.http.* ;

public class voterloggedin extends HttpServlet
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
            String mail = request.getParameter ( "mail" ) ;
            Statement st = con.createStatement () ;
            ResultSet rs = st.executeQuery ( "SELECT * FROM voter WHERE email = '" + mail + "'" ) ;
            rs.next () ;
            String pt = "<h3> YOUR DETAILS </h3> <table cellpadding='3'  cellspacing='8' style='text-align:center'> <tr> <td> VOTER ID </td> <td> " + rs.getInt (1) + " </td> </tr> " ;
            pt = pt.concat ( "<tr> <td> FIRST NAME </td> <td> " + rs.getString (2) + " </td> </tr> " ) ;
            pt = pt.concat ( "<tr> <td> LAST NAME </td> <td> " + rs.getString (3) + " </td> </tr> " ) ;
            pt = pt.concat ( "<tr> <td> GENDER </td> <td> " + rs.getString (5) + " </td> </tr> " ) ;
            pt = pt.concat ( "<tr> <td> DEPARTMENT </td> <td> " + rs.getString (7) + " </td> </tr> </table> " ) ;
            ResultSet rst = st.executeQuery ( "SELECT EXISTS ( SELECT * FROM election )" ) ;
            rst.next() ;
            int exist = rst.getInt (1) ;
            String candids = "" ;
            String stdt = "" ;
            String enddt = "" ;
            String title = "" ;
            int candidates = 0 ;
            if ( exist != 0 )
            {
                ResultSet rs3 = st.executeQuery ( "SELECT startdate , enddate , name FROM election" ) ;
                rs3.next () ;
                stdt = stdt + rs3.getString (1) ;
                enddt = enddt + rs3.getString (2) ;
                title = title + rs3.getString (3) ;
                ResultSet rsc = st.executeQuery ( "SELECT COUNT(*) FROM candidates" ) ;
                rsc.next () ;
                candidates = rsc.getInt (1) ;
            } 
            request.setAttribute ( "mail" , mail ) ;
            request.setAttribute ( "pt" , pt ) ;
            request.setAttribute ( "stdt" , stdt ) ;
            request.setAttribute ( "enddt" , enddt ) ;
            request.setAttribute ( "title" , title ) ;
            request.setAttribute ( "exist" , exist ) ;
            request.setAttribute ( "candidates" , candidates ) ;
            HttpSession session = request.getSession () ;
            RequestDispatcher reqd = request.getRequestDispatcher ( "./voterloggedin.jsp" ) ;
            reqd.forward ( request , response ) ;
            st.close () ;
            out.close () ;
        } 
        catch ( Exception e ) 
        { 
            PrintWriter out = response.getWriter () ;
            e.printStackTrace () ; 
            out.println ( "VOTERLOGGEDIN" ) ; 
        }
    }
}
