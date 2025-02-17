/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import context.DBContext;
import entity.Customer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author Admin
 */
public class CustomerDAO extends DBContext{
    
    public CustomerDAO() {
        connectDB();
    }
    //Khai báo các thành phần sử lí DB
    Connection cnn;//Kết nối DB;
    PreparedStatement stm;// Thực hiện các câu lệnh SQL
    ResultSet rs;//Lưu trữ và xử lí dữ liệu lấy về từ select

    private void connectDB() {
        cnn = connection;
        if (cnn != null) {
            System.out.println("Connect Success");
        } else {
            System.out.println("Connect Fail");
        }
    }

       public ArrayList<Customer> getTop3Customer(String name, String phone) {
           ArrayList<Customer> list = new ArrayList<>();
        try {
            String query = "SELECT * FROM customer WHERE name LIKE '%?%' OR phone LIKE '%?%' and isactive = 1;";
            stm = cnn.prepareStatement(query);
            stm.setString(1, name);
            stm.setString(2, phone);
            rs = stm.executeQuery();

            while (rs.next()) {
                return new Customer(rs.getString()
                      
            }
        } catch (Exception e) {
        }
        return null;
    }
        
}
