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
import entity.Product;

/**
 *
 * @author FPTSHOP
 */
public class ZoneDAO extends DBContext {

    private Connection cnn;
    private PreparedStatement stm;
    private ResultSet rs;

    public ZoneDAO() {
        connect();
    }

    public void connect() {
        try {
            cnn = super.connection;
            if (cnn != null) {
                System.out.println("Connect success");
            } else {
                System.out.println("Connect fail");
            }
        } catch (Exception e) {
            System.out.println("Connect error: " + e.getMessage());
        }
    }

    public List<Zone> getAllZones(int page, int pageSize) {
        List<Zone> zoneList = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        try {
            String sql = "SELECT * FROM zone LIMIT ? OFFSET ?";
            PreparedStatement stm = cnn.prepareStatement(sql);
            stm.setInt(1, pageSize);
            stm.setInt(2, offset);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Zone zone = new Zone();
                zone.setId(rs.getString("id"));
                zone.setName(rs.getString("name"));
                zone.setIsActive(rs.getBoolean("isactive"));
                zoneList.add(zone);
            }
        } catch (SQLException e) {
            System.out.println("Get All Zones: " + e.getMessage());
        }

        return zoneList;
    }

    public List<Zone> getActiveZones() {
        List<Zone> zoneList = new ArrayList<>();
        String query = "SELECT * FROM zone WHERE isactive = 1";
        try {
            stm = cnn.prepareStatement(query);
            rs = stm.executeQuery();
            while (rs.next()) {
                Zone zone = new Zone(
                        rs.getString("id"),
                        rs.getString("name"),
                        rs.getBoolean("isactive")
                );
                zoneList.add(zone);
            }
        } catch (SQLException e) {
            System.out.println("Get Active Zones: " + e.getMessage());
        }
        return zoneList;
    }

    public int getTotalZones() {
        int count = 0;

        try {
            String sql = "SELECT COUNT(*) FROM zone";
            PreparedStatement stm = cnn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Get Total Zones: " + e.getMessage());
        }

        return count;
    }

    public Zone getZoneById(String id) {
        String query = "SELECT * FROM zone WHERE id = ?";
        try {
            stm = cnn.prepareStatement(query);
            stm.setString(1, id);
            rs = stm.executeQuery();
            if (rs.next()) {
                return new Zone(
                        rs.getString("id"),
                        rs.getString("name"),
                        rs.getBoolean("isactive")
                );
            }
        } catch (SQLException e) {
            System.out.println("Get Zone By ID: " + e.getMessage());
        }
        return null;
    }

    public void insert(Zone zone) throws SQLException {
        String query = "INSERT INTO zone (name, isactive) VALUES (?, ?)";
        try {
            stm = cnn.prepareStatement(query);
            stm.setString(1, zone.getName());
            stm.setBoolean(2, zone.isIsActive());
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Insert Zone: " + e.getMessage());
            throw e;
        }
    }

    public boolean update(Zone zone) throws SQLException {
        String query = "UPDATE zone SET name = ?, isactive = ? WHERE id = ?";
        try {
            stm = cnn.prepareStatement(query);
            stm.setString(1, zone.getName());
            stm.setBoolean(2, zone.isIsActive());
            stm.setString(3, zone.getId());

            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Update Zone: " + e.getMessage());
            throw e;
        }
    }

    public void delete(String id) {
        String query = "DELETE FROM zone WHERE id = ?";
        try {
            stm = cnn.prepareStatement(query);
            stm.setString(1, id);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Delete Zone: " + e.getMessage());
        }
    }

    public boolean isZoneUsedByProducts(String zoneId) {
        String query = "SELECT COUNT(*) FROM product_zone WHERE zone_id = ?";
        try {
            stm = cnn.prepareStatement(query);
            stm.setString(1, zoneId);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println("Check Zone Used: " + e.getMessage());
        }
        return false;
    }

    public List<Zone> searchZones(String keyword) {
        List<Zone> zoneList = new ArrayList<>();
        String query = "SELECT * FROM zone WHERE name LIKE ? OR id LIKE ?";
        try {
            stm = cnn.prepareStatement(query);
            stm.setString(1, "%" + keyword + "%");
            stm.setString(2, "%" + keyword + "%");
            rs = stm.executeQuery();
            while (rs.next()) {
                Zone zone = new Zone(
                        rs.getString("id"),
                        rs.getString("name"),
                        rs.getBoolean("isactive")
                );
                zoneList.add(zone);
            }
        } catch (SQLException e) {
            System.out.println("Search Zones: " + e.getMessage());
        }
        return zoneList;
    }

    public List<Zone> filterZonesByActive(String isActive) {
        List<Zone> zoneList = new ArrayList<>();
        String query = "SELECT * FROM zone WHERE 1=1";

        if (!isActive.equals("default")) {
            query += " AND isactive = " + (isActive.equals("true") ? "1" : "0");
        }

        try {
            stm = cnn.prepareStatement(query);
            rs = stm.executeQuery();
            while (rs.next()) {
                Zone zone = new Zone(
                        rs.getString("id"),
                        rs.getString("name"),
                        rs.getBoolean("isactive")
                );
                zoneList.add(zone);
            }
        } catch (SQLException e) {
            System.out.println("Filter Zones: " + e.getMessage());
        }
        return zoneList;
    }

    private String generateZoneId() {
        String query = "SELECT id FROM zone ORDER BY id DESC LIMIT 1";
        try {
            stm = cnn.prepareStatement(query);
            rs = stm.executeQuery();
            if (rs.next()) {
                String lastId = rs.getString("id");
                int number = Integer.parseInt(lastId.substring(1)) + 1;
                return "Z" + String.format("%03d", number);
            } else {
                return "Z001";
            }
        } catch (SQLException e) {
            System.out.println("Generate Zone ID: " + e.getMessage());
            return "Z001";
        }
    }

    public static void main(String[] args) {
        ZoneDAO zoneDAO = new ZoneDAO();

        // Test getAllZones()
        List<Zone> zones = zoneDAO.getAllZones(1, 10);

        // Hiển thị kết quả
        System.out.println("Danh sách các Zone:");
        for (Zone zone : zones) {
            System.out.println("ID: " + zone.getId()
                    + ", Name: " + zone.getName()
                    + ", Active: " + zone.isIsActive());
        }
    }

    public Zone getZoneByName(String name) {
        String query = "SELECT * FROM zone WHERE name = ?";
        try {
            stm = cnn.prepareStatement(query);
            stm.setString(1, name);
            rs = stm.executeQuery();
            if (rs.next()) {
                return new Zone(
                        rs.getString("id"),
                        rs.getString("name"),
                        rs.getBoolean("isactive")
                );
            }
        } catch (SQLException e) {
            System.out.println("Get Zone By Name: " + e.getMessage());
        }
        return null;
    }

    public List<Zone> searchZones(String keyword, int page, int pageSize) {
        List<Zone> zoneList = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        try {
            String sql = "SELECT * FROM zone WHERE id LIKE ? OR name LIKE ? LIMIT ? OFFSET ?";
            PreparedStatement stm = cnn.prepareStatement(sql);
            stm.setString(1, "%" + keyword + "%");
            stm.setString(2, "%" + keyword + "%");
            stm.setInt(3, pageSize);
            stm.setInt(4, offset);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Zone zone = new Zone();
                zone.setId(rs.getString("id"));
                zone.setName(rs.getString("name"));
                zone.setIsActive(rs.getBoolean("isactive"));
                zoneList.add(zone);
            }
        } catch (SQLException e) {
            System.out.println("Search Zones: " + e.getMessage());
        }

        return zoneList;
    }

    public int getTotalSearchResults(String keyword) {
        int count = 0;

        try {
            String sql = "SELECT COUNT(*) FROM zone WHERE id LIKE ? OR name LIKE ?";
            PreparedStatement stm = cnn.prepareStatement(sql);
            stm.setString(1, "%" + keyword + "%");
            stm.setString(2, "%" + keyword + "%");
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Get Total Search Results: " + e.getMessage());
        }

        return count;
    }

    public List<Zone> filterZonesByActive(String isActive, int page, int pageSize) {
        List<Zone> zoneList = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        try {
            String sql;
            PreparedStatement stm;

            if (isActive != null && !isActive.equals("default")) {
                sql = "SELECT * FROM zone WHERE isactive = ? LIMIT ? OFFSET ?";
                stm = cnn.prepareStatement(sql);
                stm.setBoolean(1, Boolean.parseBoolean(isActive));
                stm.setInt(2, pageSize);
                stm.setInt(3, offset);
            } else {
                sql = "SELECT * FROM zone LIMIT ? OFFSET ?";
                stm = cnn.prepareStatement(sql);
                stm.setInt(1, pageSize);
                stm.setInt(2, offset);
            }

            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Zone zone = new Zone();
                zone.setId(rs.getString("id"));
                zone.setName(rs.getString("name"));
                zone.setIsActive(rs.getBoolean("isactive"));
                zoneList.add(zone);
            }
        } catch (SQLException e) {
            System.out.println("Filter Zones: " + e.getMessage());
        }

        return zoneList;
    }

    public int getTotalFilterResults(String isActive) {
        int count = 0;

        try {
            String sql;
            PreparedStatement stm;

            if (isActive != null && !isActive.equals("default")) {
                sql = "SELECT COUNT(*) FROM zone WHERE isactive = ?";
                stm = cnn.prepareStatement(sql);
                stm.setBoolean(1, Boolean.parseBoolean(isActive));
            } else {
                sql = "SELECT COUNT(*) FROM zone";
                stm = cnn.prepareStatement(sql);
            }

            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Get Total Filter Results: " + e.getMessage());
        }

        return count;
    }

    public int countProductsInZone(String zoneId) {
        int count = 0;
        String query = "SELECT COUNT(*) FROM product_zone WHERE zone_id = ?";
        try {
            stm = cnn.prepareStatement(query);
            stm.setString(1, zoneId);
            rs = stm.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Count Products In Zone: " + e.getMessage());
        }
        return count;
    }

    public List<Product> getProductsInZone(String zoneId) {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT p.* FROM product p JOIN product_zone pz ON p.id = pz.product_id WHERE pz.zone_id = ?";
        try {
            stm = cnn.prepareStatement(query);
            stm.setString(1, zoneId);
            rs = stm.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getString("id"));
                product.setName(rs.getString("name"));
                product.setDescribe(rs.getString("describe"));
                product.setPrice(rs.getDouble("price"));
                product.setQuantity(rs.getDouble("quantity"));
                product.setIsActive(rs.getBoolean("isactive"));
                product.setImage(rs.getString("image"));
                product.setPackaging(rs.getString("packaging"));
                productList.add(product);
            }
        } catch (SQLException e) {
            System.out.println("Get Products In Zone: " + e.getMessage());
        }
        return productList;
    }
}
