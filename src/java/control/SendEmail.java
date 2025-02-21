package control;

//import java.net.Authenticator;
import entity.User;
import java.util.Properties;
import java.util.Random;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 * SendEmail class handles email sending functionality.
 */
public class SendEmail {

    // Method to generate a random verification code
    public String getRandom() {
        Random rnd = new Random();
        StringBuilder otp = new StringBuilder();
        //string builder can changable (not fixed as string)
        for (int i = 0; i < 6; i++) {
            int digit = rnd.nextInt(10); // Random digit from 0 to 9
            otp.append(digit);
        }

        return otp.toString();
    }

    // Method to send email to the user
    public boolean sendEmail(User user) {
        boolean test = false;

        String toEmail = user.getEmail();
        String fromEmail = "quanlygao@gmail.com";
        String password = "rjyp ggfo aylp fjpp"; // Use an app-specific password

        try {
            Properties pr = new Properties();
            pr.setProperty("mail.smtp.host", "smtp.gmail.com");
            pr.setProperty("mail.smtp.port", "587");
            pr.setProperty("mail.smtp.auth", "true");
            pr.setProperty("mail.smtp.starttls.enable", "true");

            Session session = Session.getInstance(pr, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromEmail, password);
                }
            });

            MimeMessage mess = new MimeMessage(session);

            mess.setFrom(new InternetAddress(fromEmail));
            mess.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));

            mess.setSubject("User Email Verification");
            mess.setText("Please enter the code: " + user.getCode());

            Transport.send(mess);
            test = true;
        } catch (MessagingException me) {
            me.printStackTrace();
        }

        return test;
    }
    public static void main(String[] args) {
        new SendEmail().sendEmail(new User("hailongv2004@gmail.com", "1234"));
    }
}
