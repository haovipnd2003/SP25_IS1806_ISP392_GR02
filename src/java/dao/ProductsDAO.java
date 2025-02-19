package dao;

import context.DBContext;
import entity.Products;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.ResultSet;

public class ProductsDAO extends DBContext {

    private Connection conn;

    public ProductsDAO() {
        connectDB();
    }

    Connection cnn;
    PreparedStatement stm;
    ResultSet rs;

    private void connectDB() {
        cnn = connection;
        if (cnn != null) {
            System.out.println("Connect Success");
        } else {
            System.out.println("Connect Fail");
        }
    }

    public void insert(Products p) {
        try {
            // Escape the reserved keyword 'describe' with backticks
            String sql = "INSERT INTO product (id, name, `describe`, price, quantity, zoneId, isActive) VALUES (?, ?, ?, ?, ?, ?, ?)";
            stm = cnn.prepareStatement(sql);
            stm.setString(1, p.getId());
            stm.setString(2, p.getName());
            stm.setString(3, p.getDescribe());
            stm.setDouble(4, p.getPrice());
            stm.setInt(5, p.getQuantity());
            stm.setString(6, p.getZoneId());
            stm.setBoolean(7, p.isActive());
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Insert: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        
    }

    public void update(Products p) {
        try {
            // Escape the reserved keyword 'describe' with backticks
            String sql = "UPDATE product SET name=?, `describe`=?, price=?, quantity=?, zoneId=?, isActive=? WHERE id=?";
            stm = cnn.prepareStatement(sql);
            stm.setString(1, p.getName());
            stm.setString(2, p.getDescribe());
            stm.setDouble(3, p.getPrice());
            stm.setInt(4, p.getQuantity());
            stm.setString(5, p.getZoneId());
            stm.setBoolean(6, p.isActive());
            stm.setString(7, p.getId());
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Update: " + e.getMessage());
        }
    }

    public Products getProductById(String id) {
        Products product = null;
        try {
            String sql = "SELECT * FROM product WHERE id = ?";
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id);
            rs = stm.executeQuery();

            if (rs.next()) {
                product = new Products(
                        rs.getString("id"),
                        rs.getString("name"),
                        rs.getString("describe"),
                        rs.getDouble("price"),
                        rs.getInt("quantity"),
                        rs.getString("zoneId"),
                        rs.getBoolean("isActive")
                );
            }
        } catch (SQLException e) {
            System.out.println("Get Product By ID: " + e.getMessage());
        }
        return product;
    }

    public List<Products> searchProducts(String keyword) {
        List<Products> productList = new ArrayList<>();
        // Sửa câu lệnh SQL để tìm kiếm theo nhiều trường
        String query = "SELECT * FROM product WHERE name LIKE ? OR `describe` LIKE ? OR id LIKE ? OR CAST(price AS CHAR) LIKE ? OR zoneId LIKE ?";

        try {
            stm = cnn.prepareStatement(query);
            // Thêm các tham số tìm kiếm cho từng trường
            stm.setString(1, "%" + keyword + "%");
            stm.setString(2, "%" + keyword + "%");
            stm.setString(3, "%" + keyword + "%");
            stm.setString(4, "%" + keyword + "%");
            stm.setString(5, "%" + keyword + "%");
            rs = stm.executeQuery();

            while (rs.next()) {
                Products product = new Products(
                        rs.getString("id"),
                        rs.getString("name"),
                        rs.getString("describe"),
                        rs.getDouble("price"),
                        rs.getInt("quantity"),
                        rs.getString("zoneId"),
                        rs.getBoolean("isActive")
                );
                productList.add(product);
            }
        } catch (SQLException e) {
            System.out.println("Search Products: " + e.getMessage());
        }
        return productList;
    }

    public void delete(String id) {
        try {
            String sql = "DELETE FROM product WHERE id = ?";
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Delete: " + e.getMessage());
        }
    }

    public List<Products> getAllProducts(int page, int pageSize) {
        List<Products> productList = new ArrayList<>();
        try {
            String sql = "SELECT * FROM product LIMIT ? OFFSET ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, pageSize);
            stm.setInt(2, (page - 1) * pageSize);
            rs = stm.executeQuery();
            while (rs.next()) {
                Products product = new Products(
                        rs.getString("id"),
                        rs.getString("name"),
                        rs.getString("describe"),
                        rs.getDouble("price"),
                        rs.getInt("quantity"),
                        rs.getString("zoneId"),
                        rs.getBoolean("isActive")
                );
                productList.add(product);
            }
        } catch (SQLException e) {
            System.out.println("Get All Products: " + e.getMessage());
        }
        return productList;
    }

    public int getTotalProducts() {
        int total = 0;
        try {
            String sql = "SELECT COUNT(*) FROM product";
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Get Total Products: " + e.getMessage());
        }
        return total;
    }
}
