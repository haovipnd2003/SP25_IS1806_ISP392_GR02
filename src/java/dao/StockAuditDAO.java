package dao;

import context.DBContext;
import entity.Product;
import entity.StockAudit;
import entity.Zone;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class StockAuditDAO extends DBContext {

    private Connection cnn;
    private PreparedStatement stm;
    private ResultSet rs;

    public StockAuditDAO() {
        connect();
    }

    private void connect() {
        try {
            cnn = super.connection;
            if (cnn != null) {
                System.out.println("StockAuditDAO: Connect success");
            } else {
                System.out.println("StockAuditDAO: Connect fail");
            }
        } catch (Exception e) {
            System.out.println("StockAuditDAO Connect error: " + e.getMessage());
        }
    }

    public StockAudit getFromResultSet(ResultSet rs) throws SQLException {
        StockAudit audit = new StockAudit();
        audit.setId(rs.getInt("id"));
        audit.setAuditDate(rs.getDate("audit_date"));
        audit.setZoneId(rs.getString("zone_id"));
        audit.setStaffId(rs.getString("staff_id"));
        audit.setProductId(rs.getString("product_id"));
        audit.setExpectedQuantity(rs.getDouble("expected_quantity"));
        audit.setActualQuantity(rs.getDouble("actual_quantity"));
        audit.setDifference(rs.getDouble("difference"));
        audit.setNote(rs.getString("note"));
        audit.setCreatedAt(rs.getDate("created_at"));
        
        // Thêm thông tin từ các bảng khác nếu có join
        try {
            audit.setZoneName(rs.getString("zone_name"));
            audit.setStaffName(rs.getString("staff_name"));
            audit.setProductName(rs.getString("product_name"));
        } catch (SQLException e) {
            // Bỏ qua nếu không có các cột này
        }
        
        return audit;
    }

    public int insert(StockAudit audit) {
        String sql = "INSERT INTO stock_audit (audit_date, zone_id, staff_id, product_id, " +
                "expected_quantity, actual_quantity, difference, note, created_at) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW())";

        try {
            stm = cnn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stm.setDate(1, audit.getAuditDate());
            stm.setString(2, audit.getZoneId());
            stm.setString(3, audit.getStaffId());
            stm.setString(4, audit.getProductId());
            stm.setDouble(5, audit.getExpectedQuantity());
            stm.setDouble(6, audit.getActualQuantity());
            stm.setDouble(7, audit.getDifference());
            stm.setString(8, audit.getNote());

            int affectedRows = stm.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating stock audit failed, no rows affected.");
            }

            rs = stm.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                throw new SQLException("Creating stock audit failed, no ID obtained.");
            }
        } catch (SQLException ex) {
            System.out.println("Error inserting stock audit: " + ex.getMessage());
            return -1;
        } finally {
            closeResources();
        }
    }

    public List<StockAudit> getAllAudits(int page, int pageSize) {
        List<StockAudit> auditList = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        String sql = "SELECT sa.*, z.name as zone_name, u.fullname as staff_name, p.name as product_name " +
                     "FROM stock_audit sa " +
                     "JOIN zone z ON sa.zone_id = z.id " +
                     "JOIN user u ON sa.staff_id = u.id " +
                     "JOIN product p ON sa.product_id = p.id " +
                     "ORDER BY sa.audit_date DESC, sa.id DESC " +
                     "LIMIT ? OFFSET ?";

        try {
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, pageSize);
            stm.setInt(2, offset);
            rs = stm.executeQuery();

            while (rs.next()) {
                auditList.add(getFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println("Get All Audits: " + e.getMessage());
        } finally {
            closeResources();
        }

        return auditList;
    }

    public int getTotalAudits() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM stock_audit";

        try {
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Get Total Audits: " + e.getMessage());
        } finally {
            closeResources();
        }

        return count;
    }

    public List<StockAudit> getAuditsByZone(String zoneId, int page, int pageSize) {
        List<StockAudit> auditList = new ArrayList<>();
        int offset = (page - 1) * pageSize;

        String sql = "SELECT sa.*, z.name as zone_name, u.fullname as staff_name, p.name as product_name " +
                     "FROM stock_audit sa " +
                     "JOIN zone z ON sa.zone_id = z.id " +
                     "JOIN user u ON sa.staff_id = u.id " +
                     "JOIN product p ON sa.product_id = p.id " +
                     "WHERE sa.zone_id = ? " +
                     "ORDER BY sa.audit_date DESC, sa.id DESC " +
                     "LIMIT ? OFFSET ?";

        try {
            stm = cnn.prepareStatement(sql);
            stm.setString(1, zoneId);
            stm.setInt(2, pageSize);
            stm.setInt(3, offset);
            rs = stm.executeQuery();

            while (rs.next()) {
                auditList.add(getFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println("Get Audits By Zone: " + e.getMessage());
        } finally {
            closeResources();
        }

        return auditList;
    }

    public int getTotalAuditsByZone(String zoneId) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM stock_audit WHERE zone_id = ?";

        try {
            stm = cnn.prepareStatement(sql);
            stm.setString(1, zoneId);
            rs = stm.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Get Total Audits By Zone: " + e.getMessage());
        } finally {
            closeResources();
        }

        return count;
    }

    public List<StockAudit> getAuditsByDate(java.sql.Date date) {
        List<StockAudit> auditList = new ArrayList<>();

        String sql = "SELECT sa.*, z.name as zone_name, u.fullname as staff_name, p.name as product_name " +
                     "FROM stock_audit sa " +
                     "JOIN zone z ON sa.zone_id = z.id " +
                     "JOIN user u ON sa.staff_id = u.id " +
                     "JOIN product p ON sa.product_id = p.id " +
                     "WHERE sa.audit_date = ? " +
                     "ORDER BY sa.id";

        try {
            stm = cnn.prepareStatement(sql);
            stm.setDate(1, date);
            rs = stm.executeQuery();

            while (rs.next()) {
                auditList.add(getFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println("Get Audits By Date: " + e.getMessage());
        } finally {
            closeResources();
        }

        return auditList;
    }

    public Map<String, List<StockAudit>> getAuditsByDateGroupedByZone(java.sql.Date date) {
        Map<String, List<StockAudit>> auditsByZone = new HashMap<>();

        String sql = "SELECT sa.*, z.name as zone_name, u.fullname as staff_name, p.name as product_name " +
                     "FROM stock_audit sa " +
                     "JOIN zone z ON sa.zone_id = z.id " +
                     "JOIN user u ON sa.staff_id = u.id " +
                     "JOIN product p ON sa.product_id = p.id " +
                     "WHERE sa.audit_date = ? " +
                     "ORDER BY sa.zone_id, sa.id";

        try {
            stm = cnn.prepareStatement(sql);
            stm.setDate(1, date);
            rs = stm.executeQuery();

            while (rs.next()) {
                StockAudit audit = getFromResultSet(rs);
                String zoneId = audit.getZoneId();
                
                if (!auditsByZone.containsKey(zoneId)) {
                    auditsByZone.put(zoneId, new ArrayList<>());
                }
                
                auditsByZone.get(zoneId).add(audit);
            }
        } catch (SQLException e) {
            System.out.println("Get Audits By Date Grouped By Zone: " + e.getMessage());
        } finally {
            closeResources();
        }

        return auditsByZone;
    }

    public List<StockAudit> getAuditDetails(int auditId) {
        List<StockAudit> auditDetails = new ArrayList<>();

        String sql = "SELECT sa.*, z.name as zone_name, u.fullname as staff_name, p.name as product_name " +
                     "FROM stock_audit sa " +
                     "JOIN zone z ON sa.zone_id = z.id " +
                     "JOIN user u ON sa.staff_id = u.id " +
                     "JOIN product p ON sa.product_id = p.id " +
                     "WHERE sa.id = ?";

        try {
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, auditId);
            rs = stm.executeQuery();

            while (rs.next()) {
                auditDetails.add(getFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.out.println("Get Audit Details: " + e.getMessage());
        } finally {
            closeResources();
        }

        return auditDetails;
    }
    
    public List<java.sql.Date> getDistinctAuditDates() {
        List<java.sql.Date> dates = new ArrayList<>();
        
        String sql = "SELECT DISTINCT audit_date FROM stock_audit ORDER BY audit_date DESC";
        
        try {
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            
            while (rs.next()) {
                dates.add(rs.getDate("audit_date"));
            }
        } catch (SQLException e) {
            System.out.println("Get Distinct Audit Dates: " + e.getMessage());
        } finally {
            closeResources();
        }
        
        return dates;
    }
    
    private void closeResources() {
        try {
            if (rs != null && !rs.isClosed()) {
                rs.close();
            }
            if (stm != null && !stm.isClosed()) {
                stm.close();
            }
        } catch (SQLException ex) {
            System.out.println("Error closing resources: " + ex.getMessage());
        }
    }
} 