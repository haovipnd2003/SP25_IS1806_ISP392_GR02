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

    public void insert(Products product) throws SQLException {
        String sql = "INSERT INTO product (name, `describe`, price, quantity, zoneId, isActive, image) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stm = cnn.prepareStatement(sql)) {
            stm.setString(1, product.getName());
            stm.setString(2, product.getDescribe());
            stm.setDouble(3, product.getPrice());
            stm.setInt(4, product.getQuantity());
            stm.setString(5, product.getZoneId());
            stm.setBoolean(6, product.isActive());
            stm.setString(7, product.getImage());
            stm.executeUpdate();
        }
    }

    public boolean isProductNameExists(String productName) throws SQLException {
        String sql = "SELECT COUNT(*) FROM product WHERE name = ?";
        try (PreparedStatement stm = cnn.prepareStatement(sql)) {
            stm.setString(1, productName);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    public static void main(String[] args) {
        ProductsDAO dao = new ProductsDAO();

        // Tạo một sản phẩm để test update
        Products product = new Products();
        product.setId("19"); // ID của sản phẩm cần cập nhật
        product.setName("Updated Product Name");
        product.setDescribe("Updated Description");
        product.setPrice(99.99);
        product.setQuantity(50);
        product.setZoneId("1");
        product.setActive(false);
        product.setImage("https://gaost.vn/wp-content/uploads/2020/12/gao-st-25-hanh-trinh-tro-thanh-gao-ngon-nhat-the-gioi.jpg");

        try {
            // Thực hiện update
            dao.update(product);
            System.out.println("Updated product successfully!");
        } catch (SQLException e) {
            System.out.println("Error updating product: " + e.getMessage());
        }
    }

    public void update(Products product) throws SQLException {
        String sql = "UPDATE product SET name=?, `describe`=?, price=?, quantity=?, zoneId=?, isActive=?, image=? WHERE id=?";
        try (PreparedStatement stm = cnn.prepareStatement(sql)) {
            stm.setString(1, product.getName());
            stm.setString(2, product.getDescribe());
            stm.setDouble(3, product.getPrice());
            stm.setInt(4, product.getQuantity());
            stm.setString(5, product.getZoneId());
            stm.setBoolean(6, product.isActive());
            stm.setString(7, product.getImage());
            stm.setString(8, product.getId());
            stm.executeUpdate();
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
                        rs.getBoolean("isActive"),
                        rs.getString("image")
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
                        rs.getBoolean("isActive"),
                        rs.getString("image")
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
                        rs.getBoolean("isActive"),
                        rs.getString("image")
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
