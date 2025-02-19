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
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Admin
 */
public class DAO extends DBContext {

    public DAO() {
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

    public boolean isAccountExists(String account) {
        try {
            String strSQL = "SELECT COUNT(*) FROM user WHERE email = ?";
            stm = cnn.prepareStatement(strSQL);
            stm.setString(1, account);
            rs = stm.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                return count >= 1;
            }
        } catch (Exception e) {
            System.out.println("isAccountExists: " + e.getMessage());
            return true; // Return true in case of an exception (to indicate account exists or an error occurred)
        }
        return false; // Return false if no exception occurred (account doesn't exist)
    }

    public void addUser(User c) {
        String sql = "INSERT INTO user (name, password, email, roletype, isActive) VALUES (?, ?, ?, ?,1)";
        try (PreparedStatement stm = cnn.prepareStatement(sql)) {
            stm.setString(1, c.getName());
            stm.setString(2, c.getPassword());
            stm.setString(3, c.getEmail());
            stm.setString(4, c.getRoletype());

            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }

    }

    public void update(String email, String password) {
        try {
            String strSQL = "update User set password=? where email=?";
            stm = cnn.prepareStatement(strSQL);
            stm.setString(1, password);
            stm.setString(2, email);
            stm.execute();
        } catch (Exception e) {
            System.out.println("update: " + e.getMessage());
        }
    }

    public ArrayList<User> getAccount() {
        String sql = "SELECT id, name, email, password,phone,address, roletype,Isactive FROM User";
        ArrayList<User> list = new ArrayList<>();
        try {
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                User c = new User();
                c.setId(rs.getString(1));
                c.setName(rs.getString(2));
                c.setEmail(rs.getString(3));
                c.setPassword(rs.getString(4));
                c.setPhone(rs.getString(5));
                c.setAddress(rs.getString(6));
                c.setRoletype(rs.getString(7));
                c.setIsactive(rs.getString(8));
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public void updateAccount(String id, String name, String email, String phone, String address, String roletype, String isactive) {
        String query = "UPDATE user SET name = ?, email = ?, phone = ?, address = ?, roletype = ?, isactive = ? WHERE id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, address);
            ps.setInt(5, Integer.parseInt(roletype));
            ps.setInt(6, Integer.parseInt(isactive));
            ps.setInt(7, Integer.parseInt(id));
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
