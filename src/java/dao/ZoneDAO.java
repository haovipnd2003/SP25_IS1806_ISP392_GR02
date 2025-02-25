/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Zone;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import context.DBContext;

/**
 *
 * @author FPTSHOP
 */
public class ZoneDAO extends DBContext {
    
    private Connection conn;
    private PreparedStatement stm;
    
    public ZoneDAO() {
        connectDB();
    }
    
    private void connectDB() {
        conn = connection;
        if (conn != null) {
            System.out.println("Connect Success");
        } else {
            System.out.println("Connect Fail");
        }
    }

    public boolean insert(Zone zone) {
        String sql = "INSERT INTO Zone (id, name, isActive) VALUES (?, ?, ?)";
        try (PreparedStatement stm = conn.prepareStatement(sql)) {
            stm.setString(1, zone.getId());
            stm.setString(2, zone.getName());
            stm.setBoolean(3, zone.isIsActive());
            return stm.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean update(Zone zone) {
        String sql = "UPDATE Zone SET name = ?, isActive = ? WHERE id = ?";
        try (PreparedStatement stm = conn.prepareStatement(sql)) {
            stm.setString(1, zone.getName());
            stm.setBoolean(2, zone.isIsActive());
            stm.setString(3, zone.getId());
            return stm.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Zone> getAllZones() {
        List<Zone> zones = new ArrayList<>();
        String sql = "SELECT * FROM Zone";
        try (PreparedStatement stm = conn.prepareStatement(sql);
             ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                Zone zone = new Zone(
                    rs.getString("id"),
                    rs.getString("name"),
                    rs.getBoolean("isActive")
                );
                zones.add(zone);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return zones;
    }

    public List<Zone> getActiveZones() {
        List<Zone> zones = new ArrayList<>();
        String sql = "SELECT * FROM Zone WHERE isActive = true";
        try (PreparedStatement stm = conn.prepareStatement(sql);
             ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                Zone zone = new Zone(
                    rs.getString("id"),
                    rs.getString("name"),
                    rs.getBoolean("isActive")
                );
                zones.add(zone);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return zones;
    }

    public static void main(String[] args) {
        ZoneDAO zoneDAO = new ZoneDAO();
        
        // Test getAllZones()
        List<Zone> zones = zoneDAO.getAllZones();
        
        // Hiển thị kết quả
        System.out.println("Danh sách các Zone:");
        for (Zone zone : zones) {
            System.out.println("ID: " + zone.getId() + 
                             ", Name: " + zone.getName() + 
                             ", Active: " + zone.isIsActive());
        }
    }
}
