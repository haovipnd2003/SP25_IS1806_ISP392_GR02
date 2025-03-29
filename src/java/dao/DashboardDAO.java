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
            + "SUM(o.customerPay) AS revenue "
            + "FROM orders o "
            + "WHERE o.isactive = 1 AND o.createdAt IS NOT NULL "
            + "GROUP BY DATE(o.createdAt) "
            + "ORDER BY order_date DESC";
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
            + "SUM(o.customerPay) AS revenue "
            + "FROM orders o "
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
            + "SUM(o.customerPay) AS revenue "
            + "FROM orders o "
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
    // Tổng giá trị hóa đơn nhập

    public double getTotalPurchaseRevenue() {
        double totalPurchaseRevenue = 0.0;
        String sql = "SELECT SUM(totalAmount) AS total_purchase_revenue "
                + "FROM orders "
                + "WHERE orderType = 1 AND isactive = 1";
        try (PreparedStatement ps = cnn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                totalPurchaseRevenue = rs.getDouble("total_purchase_revenue");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return totalPurchaseRevenue;
    }

   public List<Revenue> getPurchaseByWeek() {
    List<Revenue> list = new ArrayList<>();
    String sql = "SELECT CONCAT(YEAR(o.createdAt), '-W', LPAD(WEEK(o.createdAt, 1), 2, '0')) AS order_week, "
            + "SUM(o.totalAmount) AS total_purchase "
            + "FROM orders o "
            + "WHERE o.orderType = 1 AND o.isactive = 1 AND o.createdAt IS NOT NULL "
            + "GROUP BY CONCAT(YEAR(o.createdAt), '-W', LPAD(WEEK(o.createdAt, 1), 2, '0')) "
            + "ORDER BY order_week DESC";
    try (PreparedStatement ps = cnn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            list.add(new Revenue(rs.getString("order_week"), rs.getDouble("total_purchase")));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}

    public List<Revenue> getPurchaseByMonth() {
        List<Revenue> list = new ArrayList<>();
        String sql = "SELECT DATE_FORMAT(o.createdAt, '%Y-%m') AS order_month, "
                + "SUM(o.totalAmount) AS total_purchase "
                + "FROM orders o "
                + "WHERE o.orderType = 1 AND o.isactive = 1 AND o.createdAt IS NOT NULL "
                + "GROUP BY DATE_FORMAT(o.createdAt, '%Y-%m') "
                + "ORDER BY order_month DESC";
        try (PreparedStatement ps = cnn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Revenue(rs.getString("order_month"), rs.getDouble("total_purchase")));
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
