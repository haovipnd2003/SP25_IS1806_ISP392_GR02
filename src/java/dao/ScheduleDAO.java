/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import context.DBContext;
import entity.Schedule;
import entity.Shift;
import entity.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 *
 * @author Admin
 */
public class ScheduleDAO extends DBContext {

    //Khai báo các thành phần sử lí DB
    Connection cnn;//Kết nối DB;
    PreparedStatement stm;// Thực hiện các câu lệnh SQL
    ResultSet rs;//Lưu trữ và xử lí dữ liệu lấy về từ select

    public ScheduleDAO() {
        connectDB();
    }

    private void connectDB() {
        cnn = connection;
        if (cnn != null) {
            System.out.println("Connect Success");
        } else {
            System.out.println("Connect Fail");
        }
    }

    // Lấy danh sách nhân viên có roletype = 3
    public List<User> getEmployees() {
        List<User> employees = new ArrayList<>();
        String sql = "SELECT id, fullname FROM user WHERE roletype = 3";
        try {
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                employees.add(new User(rs.getString("id"), rs.getString("fullname")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return employees;
    }

    // Lấy danh sách ca làm việc
    public List<Shift> getShifts() {
        List<Shift> shifts = new ArrayList<>();
        String sql = "SELECT id, name, start_time, end_time FROM shift";
        try {
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                shifts.add(new Shift(rs.getInt("id"), rs.getString("name"), rs.getString("start_time"), rs.getString("end_time")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return shifts;
    }

    // Lấy lịch làm việc của nhân viên theo tuần
    public List<Schedule> getScheduleByWeek(String startDate, String endDate) {
        List<Schedule> schedules = new ArrayList<>();
        String sql = "SELECT s.id, s.user_id, u.fullname, s.shift_id, sh.name AS shift_name, s.date "
                + "FROM schedule s "
                + "JOIN user u ON s.user_id = u.id "
                + "JOIN shift sh ON s.shift_id = sh.id "
                + "WHERE s.date BETWEEN ? AND ? AND u.roletype = 3";
        try {
            stm = cnn.prepareStatement(sql);
            stm.setString(1, startDate);
            stm.setString(2, endDate);
            rs = stm.executeQuery();
            while (rs.next()) {
                schedules.add(new Schedule(
                        rs.getString("id"),
                        rs.getString("user_id"),
                        rs.getString("fullname"),
                        rs.getString("shift_id"),
                        rs.getString("shift_name"),
                        rs.getString("date")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return schedules;
    }

    // Kiểm tra xem ca làm việc đã tồn tại chưa
    public boolean isShiftExist(String userId, String shiftId, String date) {
        String sql = "SELECT id FROM schedule WHERE user_id = ? AND shift_id = ? AND date = ?";
        try {
            stm = cnn.prepareStatement(sql);
            stm.setString(1, userId);
            stm.setString(2, shiftId);
            stm.setString(3, date);
            rs = stm.executeQuery();
            return rs.next(); // Trả về true nếu đã tồn tại
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Thêm ca làm việc vào lịch
    public void addShiftToSchedule(String userId, String shiftId, String date) {
        // Kiểm tra xem ca này đã tồn tại cho nhân viên và ngày này chưa
        if (!isShiftExist(userId, shiftId, date)) {
            String sql = "INSERT INTO schedule (user_id, shift_id, date) VALUES (?, ?, ?)";
            try {
                stm = cnn.prepareStatement(sql);
                stm.setString(1, userId);
                stm.setString(2, shiftId);
                stm.setString(3, date);
                stm.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (stm != null) {
                        stm.close();
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }

}
