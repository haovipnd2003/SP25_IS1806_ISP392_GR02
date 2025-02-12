/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import context.DBContext;
import entity.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author vanh
 */
public class UserDAO extends DBContext {
    
    public boolean InsertUser(User user) {
        boolean success = false;
        try {
            String query = "insert into user(name, password, email) values(?,?,?)";
            
            PreparedStatement stm = connection.prepareStatement(query);
            stm.setString(1, user.getName());
            stm.setString(2, user.getPassword());
            stm.setString(3, user.getEmail());
            
            int res = stm.executeUpdate();
            if (res != 0) success = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }
    
    public User GetUserByUsernameOrEmail(String username, String email) {
        User user = null;
        try {
            String query = "select id, name, email from user where name = ? or email = ?";
            PreparedStatement stm = connection.prepareStatement(query);
            stm.setString(1, username);
            stm.setString(2, email);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                user = new User();
                user.setId(rs.getString(1));
                user.setName(rs.getString(2));
                user.setEmail(rs.getString(3));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
}
