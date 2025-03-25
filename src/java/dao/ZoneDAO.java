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
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import context.DBContext;
import entity.Product;
import java.util.Date;

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
            String sql = "SELECT * FROM zone ORDER BY id DESC LIMIT ? OFFSET ?";
            PreparedStatement stm = cnn.prepareStatement(sql);
            stm.setInt(1, pageSize);
            stm.setInt(2, offset);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Zone zone = new Zone();
                zone.setId(rs.getInt("id"));
                zone.setName(rs.getString("name"));
                zone.setIsActive(rs.getInt("isactive") == 1);
                zone.setDescription(rs.getString("description"));
                zone.setCreateBy(rs.getString("createBy"));
                zone.setCreatedAt(rs.getTimestamp("createdAt"));
                zone.setUpdateAt(rs.getTimestamp("updateAt"));
                zone.setDeleteBy(rs.getString("deleteBy"));
                zone.setDeleteAt(rs.getTimestamp("deleteAt"));
                
                // Count products in this zone
                int productCount = countProductsInZone(zone.getId());
                zone.setProductCount(productCount);
                
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
                Zone zone = new Zone();
                zone.setId(rs.getInt("id"));
                zone.setName(rs.getString("name"));
                zone.setIsActive(rs.getInt("isactive") == 1);
                zone.setDescription(rs.getString("description"));
                zoneList.add(zone);
            }
        } catch (SQLException e) {
            System.out.println("Get Active Zones: " + e.getMessage());
        }
        return zoneList;
    }

    public int getTotalZones() {
        int count = 0;
        String query = "SELECT COUNT(*) FROM zone";
        try {
            stm = cnn.prepareStatement(query);
            rs = stm.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Get Total Zones: " + e.getMessage());
        }
        return count;
    }

    public Zone getZoneById(int id) {
        String query = "SELECT * FROM zone WHERE id = ?";
        try {
            stm = cnn.prepareStatement(query);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            if (rs.next()) {
                Zone zone = new Zone();
                zone.setId(rs.getInt("id"));
                zone.setName(rs.getString("name"));
                zone.setIsActive(rs.getInt("isactive") == 1);
                zone.setDescription(rs.getString("description"));
                zone.setCreateBy(rs.getString("createBy"));
                zone.setCreatedAt(rs.getTimestamp("createdAt"));
                zone.setUpdateAt(rs.getTimestamp("updateAt"));
                zone.setDeleteBy(rs.getString("deleteBy"));
                zone.setDeleteAt(rs.getTimestamp("deleteAt"));
                
                // Count products in this zone
                int productCount = countProductsInZone(zone.getId());
                zone.setProductCount(productCount);
                
                return zone;
            }
        } catch (SQLException e) {
            System.out.println("Get Zone By ID: " + e.getMessage());
        }
        return null;
    }

    public boolean insert(Zone zone) {
        String query = "INSERT INTO zone (name, description, isactive, createBy, createdAt) VALUES (?, ?, ?, ?, ?)";
        try {
            stm = cnn.prepareStatement(query);
            stm.setString(1, zone.getName());
            stm.setString(2, zone.getDescription());
            stm.setInt(3, zone.isIsActive() ? 1 : 0);
            stm.setString(4, zone.getCreateBy());
            stm.setTimestamp(5, zone.getCreatedAt() != null ? zone.getCreatedAt() : new Timestamp(new Date().getTime()));
            
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Insert Zone: " + e.getMessage());
            return false;
        }
    }

    public boolean update(Zone zone) {
        String query = "UPDATE zone SET name = ?, isactive = ?, description = ?, updateAt = ? WHERE id = ?";
        try {
            stm = cnn.prepareStatement(query);
            stm.setString(1, zone.getName());
            stm.setInt(2, zone.isIsActive() ? 1 : 0);
            stm.setString(3, zone.getDescription());
            stm.setTimestamp(4, new Timestamp(new Date().getTime()));
            stm.setInt(5, zone.getId());
            
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Update Zone: " + e.getMessage());
            return false;
        }
    }

    public boolean delete(int id) {
        String query = "UPDATE zone SET isactive = 0, deleteAt = ? WHERE id = ?";
        try {
            stm = cnn.prepareStatement(query);
            stm.setTimestamp(1, new Timestamp(new Date().getTime()));
            stm.setInt(2, id);
            
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Delete Zone: " + e.getMessage());
            return false;
        }
    }

    public Zone getZoneByName(String name) {
        String query = "SELECT * FROM zone WHERE name = ?";
        try {
            stm = cnn.prepareStatement(query);
            stm.setString(1, name);
            rs = stm.executeQuery();
            if (rs.next()) {
                Zone zone = new Zone();
                zone.setId(rs.getInt("id"));
                zone.setName(rs.getString("name"));
                zone.setIsActive(rs.getInt("isactive") == 1);
                zone.setDescription(rs.getString("description"));
                return zone;
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
            String sql = "SELECT * FROM zone WHERE id LIKE ? OR name LIKE ? OR description LIKE ? LIMIT ? OFFSET ?";
            PreparedStatement stm = cnn.prepareStatement(sql);
            stm.setString(1, "%" + keyword + "%");
            stm.setString(2, "%" + keyword + "%");
            stm.setString(3, "%" + keyword + "%");
            stm.setInt(4, pageSize);
            stm.setInt(5, offset);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Zone zone = new Zone();
                zone.setId(rs.getInt("id"));
                zone.setName(rs.getString("name"));
                zone.setIsActive(rs.getInt("isactive") == 1);
                zone.setDescription(rs.getString("description"));
                
                // Count products in this zone
                int productCount = countProductsInZone(zone.getId());
                zone.setProductCount(productCount);
                
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
            String sql = "SELECT COUNT(*) FROM zone WHERE id LIKE ? OR name LIKE ? OR description LIKE ?";
            PreparedStatement stm = cnn.prepareStatement(sql);
            stm.setString(1, "%" + keyword + "%");
            stm.setString(2, "%" + keyword + "%");
            stm.setString(3, "%" + keyword + "%");
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Get Total Search Results: " + e.getMessage());
        }

        return count;
    }

    public List<Zone> filterZones(String isActive, int page, int pageSize) {
        List<Zone> zoneList = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        try {
            String sql;
            PreparedStatement stm;

            if (isActive != null && !isActive.equals("default")) {
                sql = "SELECT * FROM zone WHERE isactive = ? LIMIT ? OFFSET ?";
                stm = cnn.prepareStatement(sql);
                stm.setInt(1, Boolean.parseBoolean(isActive) ? 1 : 0);
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
                zone.setId(rs.getInt("id"));
                zone.setName(rs.getString("name"));
                zone.setIsActive(rs.getInt("isactive") == 1);
                zone.setDescription(rs.getString("description"));
                
                // Count products in this zone
                int productCount = countProductsInZone(zone.getId());
                zone.setProductCount(productCount);
                
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
                stm.setInt(1, Boolean.parseBoolean(isActive) ? 1 : 0);
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

    public int countProductsInZone(int zoneId) {
        int count = 0;
        String query = "SELECT COUNT(*) FROM product_zone WHERE zone_id = ?";
        try {
            stm = cnn.prepareStatement(query);
            stm.setInt(1, zoneId);
            rs = stm.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Count Products In Zone: " + e.getMessage());
        }
        return count;
    }

    public boolean isZoneUsedByProducts(int zoneId) {
        return countProductsInZone(zoneId) > 0;
    }

    public List<Product> getProductsInZone(int zoneId) {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT p.* FROM product p JOIN product_zone pz ON p.id = pz.product_id WHERE pz.zone_id = ?";
        try {
            stm = cnn.prepareStatement(query);
            stm.setInt(1, zoneId);
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
