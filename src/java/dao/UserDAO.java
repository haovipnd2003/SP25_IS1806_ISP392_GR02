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

import java.sql.*;

/**
 *
 * @author Admin
 */
public class UserDAO extends DBContext {

    private Connection conn;

    public UserDAO() {
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

    public void updateInfo(User u, String timeUpdate) {
        try {
            String strSQL = "UPDATE user SET name= ?,email = ?,phone = ?, address=?, updateAt = ? WHERE id = ? and isactive = 1;";
            stm = cnn.prepareStatement(strSQL);
            stm.setString(1, u.getName());
            stm.setString(2, u.getEmail());
            stm.setString(3, u.getPhone());
            stm.setString(4, u.getAddress());
            stm.setString(5, timeUpdate);
            stm.setString(6, u.getId());
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("update: " + e.getMessage());
        }
    }
    public User Relogin(String id) {

        try {
            String query = "select * from user where id = ?";
            stm = cnn.prepareStatement(query);
            stm.setString(1, id);

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
            System.out.println("update: " + e.getMessage());
        }
        return null;
    }

    public User checkLogin(String email, String password) {
        try {
            String sql = "SELECT * FROM user WHERE email = ? AND password = ? AND isactive = 1";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setId(rs.getString("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRoletype(rs.getString("roletype"));
                user.setIsactive(rs.getString("isactive"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();

        }
        return null;
    }

    public void updatePassword(String newPass,String name) {
        try {
            String strSQL = "update user\n"
                    + "SET password =?\n"
                    + "WHERE name = ?";
            stm = cnn.prepareStatement(strSQL);
            stm.setString(1, newPass);
            stm.setString(2, name);
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("update: " + e.getMessage());
        }
    }
}
