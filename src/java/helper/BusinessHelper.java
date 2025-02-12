/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package helper;

import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author vanh
 */
public class BusinessHelper {
    public static final Pattern VALID_EMAIL_ADDRESS_REGEX = 
        Pattern.compile("^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,6}$", Pattern.CASE_INSENSITIVE);
    
    public static boolean sendEmail(String toEmail, String randomCode) {
        boolean isSended = false;
        
        // Get properties object
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.port", "465");

        // get Session
        Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("ricemanagementemail@gmail.com", "vfic dshw avyv wumg");
            }
        });
        
        // compose message
        try {
            MimeMessage message = new MimeMessage(session);
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            
            message.setSubject("User email verification");
            message.setText("Sign up successfully. Please verify your account using this code: " + randomCode);

            // send message
            Transport.send(message);
            isSended = true;
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
        
        return isSended;
    }

    public static boolean validateEmail(String emailStr) {
            Matcher matcher = VALID_EMAIL_ADDRESS_REGEX.matcher(emailStr);
            return matcher.matches();
    }
    
    public static boolean validatePassword(String password, String repassword) {
        return password.equals(repassword);
    }
    
    public static boolean isValidFieldSignUp(String username, String email, String password, String repassword) {
        return isValidFieldString(username) && 
                isValidFieldString(email) &&
                isValidFieldString(password) &&
                isValidFieldString(repassword);
    }
    
    private static boolean isValidFieldString(String field) {
        return field != null && !field.isEmpty() && !field.isBlank();
    }
}
