package context;

import dao.DAO;
import entity.User;
//import entity.Product;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * DBContext class for managing database connections.
 */
public class DBContext {

    protected Connection connection;

    public DBContext() {
        //@Students: You are allowed to edit user, pass, url variables to fit 
        //your system configuration
        //You can also add more methods for Database Interaction tasks. 
        //But we recommend you to do it in another class
        // For example : StudentDBContext extends DBContext , 
        //where StudentDBContext is located in dal package, 
//        try {
//            String user = "shopcards"; // Change to your MySQL username
//            String pass = "SK2cwWkRXbytiPdL"; // Change to your MySQL password
//            String url = "jdbc:mysql://162.243.172.83:3306/shopcards"; // Update the URL to fit MySQL format
//            Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL JDBC driver
//            connection = DriverManager.getConnection(url, user, pass);
//        } catch (ClassNotFoundException | SQLException ex) {
//            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
//        }

//        DB LOCALHOST:
        try {
            String user = "root"; // Change to your MySQL username
            String pass = "1234"; // Change to your MySQL password
            String url = "jdbc:mysql://localhost:3306/ricemanagement"; // Update the URL to fit MySQL format
            Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL JDBC driver
            connection = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static void main(String[] args) {
        DAO d = new DAO();
        ArrayList<User> accounts = d.getAccount(); 

    for (User u : accounts) {
        System.out.println("ID: " + u.getId() +
                           ", Name: " + u.getName() +
                           ", Email: " + u.getEmail() +
                           ", Role: " + u.getRoletype() +
                           ", Active: " + u.getIsactive());
    }
    }

}
