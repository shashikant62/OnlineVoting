import java.util.* ;
import java.sql.* ;
import java.io.* ;
import javax.servlet.* ;
import javax.servlet.http.* ;
import javax.mail.* ;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.Session;

public class loginotpemail extends HttpServlet
{
   protected void doPost ( HttpServletRequest request , HttpServletResponse response ) 
   throws ServletException , IOException
   {
      try
      {
         HttpSession session = request.getSession () ;
         String to = request.getAttribute ( "mail" ).toString () ;
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
         message.setSubject ( "USER LOGIN VERIFICATION - OTP" ) ;
         message.setContent ( "<span style = 'font-size : 20px'> The OTP for Login is <b> " + otp + " </b> </span>" , "text/html" ) ;
         Transport.send ( message ) ;
         request.setAttribute ( "otp" , otp ) ;
         request.setAttribute ( "mail" , to ) ;
         RequestDispatcher reqd = request.getRequestDispatcher ("/loginotpverify.jsp") ;
         reqd.forward ( request , response ) ;
      } 
      catch ( MessagingException e ) { throw new RuntimeException (e) ; }
   }
}