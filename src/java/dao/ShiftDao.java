/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import context.DBContext;
import entity.Shift;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class ShiftDao extends DBContext {

    public ShiftDao() {
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

    public void addShift(Shift shift) {
        try {
            String sql = "INSERT INTO shift (name, start_time, end_time, total_time, isactive) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stm = cnn.prepareStatement(sql);
            stm.setString(1, shift.getName());
            stm.setString(2, shift.getStart_time());
            stm.setString(3, shift.getEnd_time());
            stm.setDouble(4, shift.getTotal_time());
            stm.setInt(5, shift.getIsactive());
            stm.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Shift> getAllShifts() {
        List<Shift> shiftList = new ArrayList<>();
        String query = "SELECT * FROM Shift";
        try (Connection conn = connection; PreparedStatement stm = conn.prepareStatement(query); ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                Shift shift = new Shift(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("start_time"),
                        rs.getString("end_time"),
                        rs.getDouble("total_time"),
                        rs.getInt("isactive")
                );
                shiftList.add(shift);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return shiftList;
    }

    public void updateShift(Shift shift) {
        try {
            String sql = "UPDATE shift SET name=?, start_time=?, end_time=?, total_time=?, isactive=? WHERE id=?";
            PreparedStatement stm = cnn.prepareStatement(sql);
            stm.setString(1, shift.getName());
            stm.setString(2, shift.getStart_time());
            stm.setString(3, shift.getEnd_time());
            stm.setDouble(4, shift.getTotal_time());
            stm.setInt(5, shift.getIsactive());
            stm.setInt(6, shift.getId());
            stm.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteShift(int id) {
        try {
            String sql = "DELETE FROM shift WHERE id=?";
            PreparedStatement stm = cnn.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
