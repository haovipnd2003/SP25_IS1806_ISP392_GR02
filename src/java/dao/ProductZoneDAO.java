package dao;

import context.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for product_zone junction table
 */
public class ProductZoneDAO extends DBContext {

    private Connection cnn;
    private PreparedStatement stm;
    private ResultSet rs;

    public ProductZoneDAO() {
        connectDB();
    }

    private void connectDB() {
        cnn = connection;
        if (cnn != null) {
            System.out.println("ProductZoneDAO: Connect Success");
        } else {
            System.out.println("ProductZoneDAO: Connect Fail");
        }
    }

    /**
     * Get all zone IDs for a product
     *
     * @param productId The product ID
     * @return List of zone IDs
     */
    public List<Integer> getZoneIdsByProductId(int productId) {
        List<Integer> zoneIds = new ArrayList<>();
        try {
            String sql = "SELECT zone_id FROM product_zone WHERE product_id = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, productId);
            rs = stm.executeQuery();

            while (rs.next()) {
                zoneIds.add(rs.getInt("zone_id"));
            }
        } catch (SQLException e) {
            System.out.println("getZoneIdsByProductId: " + e.getMessage());
        }
        return zoneIds;
    }

    /**
     * Get all product IDs for a zone
     *
     * @param zoneId The zone ID
     * @return List of product IDs
     */
    public List<Integer> getProductIdsByZoneId(int zoneId) {
        List<Integer> productIds = new ArrayList<>();
        try {
            String sql = "SELECT product_id FROM product_zone WHERE zone_id = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, zoneId);
            rs = stm.executeQuery();

            while (rs.next()) {
                productIds.add(rs.getInt("product_id"));
            }
        } catch (SQLException e) {
            System.out.println("getProductIdsByZoneId: " + e.getMessage());
        }
        return productIds;
    }

    /**
     * Add a product-zone relationship
     *
     * @param productId The product ID
     * @param zoneId The zone ID
     * @return true if successful, false otherwise
     */
    public boolean addProductZone(int productId, int zoneId) {
        try {
            String sql = "INSERT INTO product_zone (product_id, zone_id) VALUES (?, ?)";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, productId);
            stm.setInt(2, zoneId);
            return stm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("addProductZone: " + e.getMessage());
            return false;
        }
    }

    /**
     * Remove a product-zone relationship
     *
     * @param productId The product ID
     * @param zoneId The zone ID
     * @return true if successful, false otherwise
     */
    public boolean removeProductZone(int productId, int zoneId) {
        try {
            String sql = "DELETE FROM product_zone WHERE product_id = ? AND zone_id = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, productId);
            stm.setInt(2, zoneId);
            return stm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("removeProductZone: " + e.getMessage());
            return false;
        }
    }

    /**
     * Remove all zone relationships for a product
     *
     * @param productId The product ID
     * @return true if successful, false otherwise
     */
    public boolean removeAllZonesForProduct(int productId) {
        try {
            String sql = "DELETE FROM product_zone WHERE product_id = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, productId);
            return stm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("removeAllZonesForProduct: " + e.getMessage());
            return false;
        }
    }

    /**
     * Check if a product-zone relationship exists
     *
     * @param productId The product ID
     * @param zoneId The zone ID
     * @return true if exists, false otherwise
     */
    public boolean existsProductZone(int productId, int zoneId) {
        try {
            String sql = "SELECT COUNT(*) FROM product_zone WHERE product_id = ? AND zone_id = ?";
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, productId);
            stm.setInt(2, zoneId);
            rs = stm.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println("existsProductZone: " + e.getMessage());
        }
        return false;
    }
}
