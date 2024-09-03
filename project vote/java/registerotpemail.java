import java.util.* ;
import java.sql.* ;
import java.io.* ;
import javax.servlet.* ;
import javax.servlet.http.* ;
import javax.mail.* ;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.Session;

public class registerotpemail extends HttpServlet
{
   protected void doPost ( HttpServletRequest request , HttpServletResponse response ) 
   throws ServletException , IOException
   {
      try
      {
         HttpSession session = request.getSession () ;
         String fnm = request.getParameter ( "fname" ) ;
         String lnm = request.getParameter ( "lname" ) ;
         String dob = request.getParameter ( "dob" ) ;
         String gen = request.getParameter ( "gender" ) ;
         String dept = request.getParameter ( "dept" ) ;
         String pwd = request.getParameter ( "password" ) ;
         String to = request.getParameter ( "email" ).toString () ;
         String from = "adpelectionvotingsystem@gmail.com" ;
         String password = "evoting123" ;
         Random rand = new Random () ;
         int otp = rand.nextInt ( 1000000 ) ;

         Properties props = new Properties();
         props.setProperty ( "mail.smtp.auth" , "true" );
         props.setProperty ( "mail.smtp.starttls.enable" , "true" );
         props.setProperty ( "mail.smtp.host" , "smtp.gmail.com" );
         props.setProperty ( "mail.smtp.port" , "587" ) ;

         Session seession = Session.getInstance ( props , new Authenticator () { 
            protected PasswordAuthentication getPasswordAuthentication ()
            {
               return new PasswordAuthentication ( from , password ) ;
            }
         } ) ;

         Message message = new MimeMessage ( seession ) ;
         message.setFrom ( new InternetAddress ( from ) ) ;
         message.setRecipient ( Message.RecipientType.TO , new InternetAddress (to) ) ;
         message.setSubject ( "USER REGISTRATION - OTP" );
         message.setContent ( "<span style = 'font-size : 30px'> The OTP for Verification is <b> " + otp + " </b> </span>" , "text/html" ) ;
         Transport.send ( message ) ;
         request.setAttribute ( "otp" , otp ) ;
         request.setAttribute ( "mail" , to ) ;
         request.setAttribute ( "fname" , fnm ) ;
         request.setAttribute ( "lname" , lnm ) ;
         request.setAttribute ( "dob" , dob ) ;
         request.setAttribute ( "gender" , gen ) ;
         request.setAttribute ( "dept" , dept ) ;
         request.setAttribute ( "password" , pwd ) ;
         RequestDispatcher reqd = request.getRequestDispatcher ("/registerotpverify.jsp") ;
         reqd.forward ( request , response ) ;
      } 
      catch ( MessagingException e ) { throw new RuntimeException (e) ; }
   }
}