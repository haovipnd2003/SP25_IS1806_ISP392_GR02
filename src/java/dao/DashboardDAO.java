/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import context.DBContext;
import entity.Revenue;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class DashboardDAO extends DBContext {

    public DashboardDAO() {
        connectDB();
    }
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

    public List<Revenue> getRevenueByDate() {
        List<Revenue> list = new ArrayList<>();
        String sql = "SELECT DATE(o.createdAt) AS order_date, "
                + "SUM((oi.price1kg - oi.discount)* oi.quantityInput) AS revenue "
                + "FROM orders o "
                + "JOIN orderitems oi ON o.id = oi.orderid "
                + "JOIN product p ON oi.productid = p.id "
                + "WHERE o.isactive = 1 AND o.createdAt IS NOT NULL "
                + "GROUP BY DATE(o.createdAt) "
                + "ORDER BY order_date";
        try (PreparedStatement ps = cnn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Revenue(rs.getString("order_date"), rs.getDouble("revenue")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Revenue> getRevenueByWeek() {
        List<Revenue> list = new ArrayList<>();
        String sql = "SELECT YEARWEEK(o.createdAt, 1) AS order_week, "
                + "SUM((oi.price1kg - oi.discount)* oi.quantityInput) AS revenue "
                + "FROM orders o "
                + "JOIN orderitems oi ON o.id = oi.orderid "
                + "JOIN product p ON oi.productid = p.id "
                + "WHERE o.isactive = 1 AND o.createdAt IS NOT NULL "
                + "GROUP BY YEARWEEK(o.createdAt,1) "
                + "ORDER BY order_week";
        try (PreparedStatement ps = cnn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                String orderWeek = rs.getString("order_week");
                list.add(new Revenue(orderWeek.substring(0, 4) + "-W" + orderWeek.substring(4), rs.getDouble("revenue")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Revenue> getRevenueByMonth() {
        List<Revenue> list = new ArrayList<>();
        String sql = "SELECT DATE_FORMAT(o.createdAt, '%Y-%m') AS order_month, "
                + "SUM((oi.price1kg - oi.discount) * oi.quantityInput) AS revenue "
                + "FROM orders o "
                + "JOIN orderitems oi ON o.id = oi.orderid "
                + "JOIN product p ON oi.productid = p.id "
                + "WHERE o.isactive = 1 AND o.createdAt IS NOT NULL "
                + "GROUP BY DATE_FORMAT(o.createdAt, '%Y-%m') "
                + "ORDER BY order_month DESC";
        try (PreparedStatement ps = cnn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Revenue(rs.getString("order_month"), rs.getDouble("revenue")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

   public static void main(String[] args) {
    DashboardDAO dao = new DashboardDAO();
//    List<Revenue> revenueByDate = dao.getRevenueByDate();
//    for (Revenue r : revenueByDate) {
//        System.out.println("Date: " + r.getDate() + ", Revenue: " + r.getRevenue());
//    }
}
}
