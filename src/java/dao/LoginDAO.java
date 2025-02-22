 /*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import context.DBContext;
import entity.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Admin
 */
public class LoginDAO extends DBContext{
    
    public LoginDAO() {
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

        public User login(String name) {

        try {
            String query = "select * from user where name = ?";
            stm = cnn.prepareStatement(query);
            stm.setString(1, name);

            rs = stm.executeQuery();

            while (rs.next()) {
                return new User(rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8));
                      
            }
        } catch (Exception e) {
        }
        return null;
    }
    
        
    public User loginByNameNPass(String name, String pass) {

        try {
            String query = "select * from user where name = ? and password = ? and isactive = 1";
            stm = cnn.prepareStatement(query);
            stm.setString(1, name);
            stm.setString(2, pass);
            rs = stm.executeQuery();

            while (rs.next()) {
                return new User(rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8));
                      
            }
        } catch (Exception e) {
        }
        return null;
    }
}
