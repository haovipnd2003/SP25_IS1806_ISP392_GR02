/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import context.DBContext;
import entity.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class ProductDAO extends DBContext {

    public ProductDAO() {
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

    public ArrayList<Product> searchProductByNameNDescribe(String name, String describe) {
        ArrayList<Product> list = new ArrayList<>();
        try {
            String query = "Select * from product WHERE (name LIKE ? OR `describe` LIKE ?) and isactive = 1 ;";
            stm = cnn.prepareStatement(query);
            stm.setString(1, "%" + name + "%");
            stm.setString(2, "%" + describe + "%");
            rs = stm.executeQuery();

            while (rs.next()) {
                String id = rs.getString("id");
                String pname = rs.getString("name");
                String pdescribe = rs.getString("describe");
                double price = rs.getDouble("price");
                double quantity = rs.getDouble("quantity");

                Product pro = new Product(id, pname, pdescribe, price, quantity);
                list.add(pro);
            }
            return list;
        } catch (Exception e) {
        }
        return null;
    }

    public void insert(Product product) throws SQLException {
        String sql = "INSERT INTO product (name, `describe`, price, quantity, zoneId, isActive, image) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stm = cnn.prepareStatement(sql)) {
            stm.setString(1, product.getName());
            stm.setString(2, product.getDescribe());
            stm.setDouble(3, product.getPrice());
            stm.setDouble(4, product.getQuantity());
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

    public void update(Product product) throws SQLException {
        String sql = "UPDATE product SET name=?, `describe`=?, price=?, quantity=?, zoneId=?, isActive=?, image=? WHERE id=?";
        try (PreparedStatement stm = cnn.prepareStatement(sql)) {
            stm.setString(1, product.getName());
            stm.setString(2, product.getDescribe());
            stm.setDouble(3, product.getPrice());
            stm.setDouble(4, product.getQuantity());
            stm.setString(5, product.getZoneId());
            stm.setBoolean(6, product.isActive());
            stm.setString(7, product.getImage());
            stm.setString(8, product.getId());
            stm.executeUpdate();
        }
    }

    public Product getProductById(String id) {
        Product product = null;
        try {
            String sql = "SELECT * FROM product WHERE id = ?";
            stm = cnn.prepareStatement(sql);
            stm.setString(1, id);
            rs = stm.executeQuery();

            if (rs.next()) {
                product = new Product(
                    rs.getString("id"),
                    rs.getString("name"),
                    rs.getString("describe"),
                    rs.getDouble("price"),
                    rs.getDouble("quantity"),
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

    public List<Product> searchProducts(String keyword) {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT * FROM product WHERE name LIKE ? OR `describe` LIKE ? OR id LIKE ? OR CAST(price AS CHAR) LIKE ? OR zoneId LIKE ?";
        try {
            stm = cnn.prepareStatement(query);
            stm.setString(1, "%" + keyword + "%");
            stm.setString(2, "%" + keyword + "%");
            stm.setString(3, "%" + keyword + "%");
            stm.setString(4, "%" + keyword + "%");
            stm.setString(5, "%" + keyword + "%");
            rs = stm.executeQuery();

            while (rs.next()) {
                Product product = new Product(
                    rs.getString("id"),
                    rs.getString("name"),
                    rs.getString("describe"),
                    rs.getDouble("price"),
                    rs.getDouble("quantity"),
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

    public List<Product> getAllProducts(int page, int pageSize) {
        List<Product> productList = new ArrayList<>();
        try {
            String sql = "SELECT * FROM product LIMIT ? OFFSET ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, pageSize);
            stm.setInt(2, (page - 1) * pageSize);
            rs = stm.executeQuery();
            while (rs.next()) {
                Product product = new Product(
                        rs.getString("id"),
                        rs.getString("name"),
                        rs.getString("describe"),
                        rs.getDouble("price"),
                        rs.getDouble("quantity"),
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

    public List<Product> filterProductsByActiveAndZone(Boolean isActive, String zoneId) {
        List<Product> productList = new ArrayList<>();
        try {
            StringBuilder sql = new StringBuilder("SELECT * FROM product WHERE 1=1");
            List<Object> params = new ArrayList<>();
            
            if (isActive != null) {
                sql.append(" AND isActive = ?");
                params.add(isActive);
            }
            
            if (zoneId != null) {
                sql.append(" AND zoneId = ?");
                params.add(zoneId);
            }
            
            PreparedStatement stm = cnn.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                stm.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = stm.executeQuery();
            
            while (rs.next()) {
                Product product = new Product(
                    rs.getString("id"),
                    rs.getString("name"),
                    rs.getString("describe"),
                    rs.getDouble("price"),
                    rs.getDouble("quantity"),
                    rs.getString("zoneId"),
                    rs.getBoolean("isActive"),
                    rs.getString("image")
                );
                productList.add(product);
            }
        } catch (SQLException e) {
            System.out.println("Filter Products: " + e.getMessage());
        }
        return productList;
    }

    public static void main(String[] args) {
        ProductDAO productdao = new ProductDAO();
        ArrayList<Product> list = productdao.searchProductByNameNDescribe("gạo", "gạo");

        // Kiểm tra danh sách không rỗng
        for (Product product : list) {
            System.out.println(product); // In từng sản phẩm

        }

    }
}
