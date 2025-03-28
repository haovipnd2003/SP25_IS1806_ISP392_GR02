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
        // Insert the product without a primary zone
        String sql = "INSERT INTO product (name, `describe`, price, quantity, isactive, image, packaging) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stm = cnn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stm.setString(1, product.getName());
            stm.setString(2, product.getDescribe());
            stm.setDouble(3, product.getPrice());
            stm.setDouble(4, product.getQuantity());
            stm.setBoolean(5, product.isActive());
            stm.setString(6, product.getImage());
            stm.setString(7, product.getPackaging());
            stm.executeUpdate();
            
            // Get the generated product ID
            ResultSet generatedKeys = stm.getGeneratedKeys();
            int productId = 0;
            if (generatedKeys.next()) {
                productId = generatedKeys.getInt(1);
                product.setId(String.valueOf(productId));
            }
            
            // Now insert all zones into product_zone table
            if (product.getZoneIds() != null && product.getZoneIds().length > 0) {
                insertProductZones(productId, product.getZoneIds());
            }
        }
    }

    // Update method to insert all product-zone relationships
    private void insertProductZones(int productId, String[] zoneIds) throws SQLException {
        if (zoneIds == null || zoneIds.length == 0) return;
        
        ProductZoneDAO productZoneDAO = new ProductZoneDAO();
        for (String zoneId : zoneIds) {
            productZoneDAO.addProductZone(productId, Integer.parseInt(zoneId));
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
        // Update the main product record without zoneid
        String sql = "UPDATE product SET name=?, `describe`=?, price=?, quantity=?, isactive=?, image=?, packaging=? WHERE id=?";
        try (PreparedStatement stm = cnn.prepareStatement(sql)) {
            stm.setString(1, product.getName());
            stm.setString(2, product.getDescribe());
            stm.setDouble(3, product.getPrice());
            stm.setDouble(4, product.getQuantity());
            stm.setBoolean(5, product.isActive());
            stm.setString(6, product.getImage());
            stm.setString(7, product.getPackaging());
            stm.setString(8, product.getId());
            stm.executeUpdate();
            
            // Update the product_zone relationships
            if (product.getZoneIds() != null) {
                // First delete existing relationships
                ProductZoneDAO productZoneDAO = new ProductZoneDAO();
                productZoneDAO.removeAllZonesForProduct(Integer.parseInt(product.getId()));
                
                // Then insert the new ones
                for (String zoneId : product.getZoneIds()) {
                    productZoneDAO.addProductZone(Integer.parseInt(product.getId()), Integer.parseInt(zoneId));
                }
            }
        }
    }

    // Update method to get all zones for a product
    public String[] getZonesForProduct(String productId) {
        List<String> zoneIds = new ArrayList<>();
        
        try {
            // Get zones from the product_zone table
            ProductZoneDAO productZoneDAO = new ProductZoneDAO();
            List<Integer> additionalZoneIds = productZoneDAO.getZoneIdsByProductId(Integer.parseInt(productId));
            for (Integer zoneId : additionalZoneIds) {
                zoneIds.add(String.valueOf(zoneId));
            }
        } catch (Exception e) {
            System.out.println("Get Zones For Product: " + e.getMessage());
        }
        
        return zoneIds.toArray(new String[0]);
    }

    // Modify getProductById to fetch zones from junction table
    public Product getProductById(String id) {
        Product product = null;
        try {
            String sql = "SELECT * FROM product WHERE id = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, Integer.parseInt(id));
            rs = stm.executeQuery();

            if (rs.next()) {
                product = new Product(
                    rs.getString("id"),
                    rs.getString("name"),
                    rs.getString("describe"),
                    rs.getDouble("price"),
                    rs.getDouble("quantity"),
                    rs.getBoolean("isactive"),
                    rs.getString("image")
                );
                
                // Set packaging
                product.setPackaging(rs.getString("packaging"));
                
                // Get all zones for this product
                product.setZoneIds(getZonesForProduct(id));
            }
        } catch (SQLException e) {
            System.out.println("Get Product By ID: " + e.getMessage());
        }
        return product;
    }

    public List<Product> searchProducts(String keyword) {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT * FROM product WHERE name LIKE ? OR `describe` LIKE ? OR id LIKE ? OR CAST(price AS CHAR) LIKE ?";
        try {
            stm = cnn.prepareStatement(query);
            stm.setString(1, "%" + keyword + "%");
            stm.setString(2, "%" + keyword + "%");
            stm.setString(3, "%" + keyword + "%");
            stm.setString(4, "%" + keyword + "%");
            rs = stm.executeQuery();

            while (rs.next()) {
                Product product = new Product(
                    rs.getString("id"),
                    rs.getString("name"),
                    rs.getString("describe"),
                    rs.getDouble("price"),
                    rs.getDouble("quantity"),
                    rs.getBoolean("isactive"),
                    rs.getString("image")
                );
                
                // Set packaging
                product.setPackaging(rs.getString("packaging"));
                
                // Get all zones for this product
                product.setZoneIds(getZonesForProduct(product.getId()));
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
                        rs.getBoolean("isactive"),
                        rs.getString("image")
                );
                
                // Set packaging
                product.setPackaging(rs.getString("packaging"));
                
                // Get all zones for this product
                product.setZoneIds(getZonesForProduct(product.getId()));
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

    // Update filterProductsByActiveAndZone to use only the junction table
    public List<Product> filterProductsByActiveAndZone(Boolean isActive, String zoneId) {
        List<Product> productList = new ArrayList<>();
        try {
            StringBuilder sql = new StringBuilder();
            
            // Kiểm tra xem zoneId có giá trị hợp lệ không (không phải null và không phải "default")
            boolean filterByZone = zoneId != null && !zoneId.equals("default");
            
            if (filterByZone) {
                // Nếu lọc theo zone, sử dụng bảng junction
                sql.append("SELECT DISTINCT p.* FROM product p ");
                sql.append("JOIN product_zone pz ON p.id = pz.product_id ");
                sql.append("WHERE pz.zone_id = ? ");
                
                if (isActive != null) {
                    sql.append("AND p.isactive = ? ");
                }
            } else {
                // Nếu không lọc theo zone, sử dụng truy vấn đơn giản hơn
                sql.append("SELECT * FROM product WHERE 1=1 ");
                
                if (isActive != null) {
                    sql.append("AND isactive = ? ");
                }
            }
            
            PreparedStatement stm = cnn.prepareStatement(sql.toString());
            int paramIndex = 1;
            
            if (filterByZone) {
                stm.setInt(paramIndex++, Integer.parseInt(zoneId));
            }
            
            if (isActive != null) {
                stm.setBoolean(paramIndex++, isActive);
            }
            
            ResultSet rs = stm.executeQuery();
            
            while (rs.next()) {
                Product product = new Product(
                    rs.getString("id"),
                    rs.getString("name"),
                    rs.getString("describe"),
                    rs.getDouble("price"),
                    rs.getDouble("quantity"),
                    rs.getBoolean("isactive"),
                    rs.getString("image")
                );
                
                // Set packaging
                product.setPackaging(rs.getString("packaging"));
                
                // Get all zones for this product
                product.setZoneIds(getZonesForProduct(product.getId()));
                
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
