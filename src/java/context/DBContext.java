package context;

import dao.DAO;
import dao.ScheduleDAO;
import dao.ShiftDao;
import entity.Schedule;
import entity.Shift;
import entity.User;
//import entity.Product;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
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
            String pass = "123456"; // Change to your MySQL password
            String url = "jdbc:mysql://localhost:3306/ricemanagement"; // Update the URL to fit MySQL format
            Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL JDBC driver
            connection = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void main(String[] args) {
        DAO d = new DAO();
        ShiftDao shiftDAO = new ShiftDao();
        ScheduleDAO ScheduleDAO = new ScheduleDAO();
        ArrayList<User> accounts = d.getAccount();

        for (User u : accounts) {
            System.out.println("ID: " + u.getId()
                    + ", Name: " + u.getName()
                    + ", Email: " + u.getEmail()
                    + ", Role: " + u.getRoletype()
                    + ", Active: " + u.getIsactive()
                    + ", fullname: " + u.getFullname());
        }

        List<Shift> shifts = shiftDAO.getAllShifts();
        List<User> employees = ScheduleDAO.getEmployees();
        List<Shift> shift1 = ScheduleDAO.getShifts();
        List<Schedule> schedule = ScheduleDAO.getScheduleByWeek("2025-03-7", "2025-03-14");
        if (shifts.isEmpty()) {
            System.out.println("Không có ca làm việc nào trong database.");
        } else {
            System.out.println("Danh sách ca làm việc:");
            for (Shift shift : shifts) {
                System.out.println(shift);
            }
        }

        for (Shift shift12 : shift1) {
            System.out.println("ID: " + shift12.getId()
                    + ", Name: " + shift12.getName()
                    + ", Start_time: " + shift12.getStart_time()
                    + ", End_time: " + shift12.getEnd_time());
        }
        for (User emp : employees) {
            System.out.println("ID: " + emp.getId()
                    + ", Name: " + emp.getFullname()
            );
        }
        for (Schedule schedule1 : schedule) {
            System.out.println("ID: " + schedule1.getId()
                    + ", uid: " + schedule1.getUser_id()
                    + ", sid: " + schedule1.getShift_id()
                    + ", sname: " + schedule1.getShiftname()
                    + ", date: " + schedule1.getDate());
        }
    }

}
