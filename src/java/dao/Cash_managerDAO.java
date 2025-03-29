package dao;

import context.DBContext;
import entity.Cash;
import entity.CashManager;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Cash_managerDAO extends DBContext {

   public List<CashManager> getAllCashManagers() {
    List<CashManager> list = new ArrayList<>();

    String query = """
  SELECT cm.id,  
            cm.employee_name AS cm_employee_name, 
            cm.time, 
            cm.details, 
            SUM(CASE WHEN c.amount > 0 THEN c.amount ELSE 0 END) AS totalQuythu,   -- Tổng thu
            SUM(CASE WHEN c.amount < 0 THEN c.amount ELSE 0 END) AS totalQuychi,   -- Tổng chi
            0 AS totalQuydauky,   -- Giá trị cố định là 0
            (SUM(CASE WHEN c.amount > 0 THEN c.amount ELSE 0 END) + 
             SUM(CASE WHEN c.amount < 0 THEN c.amount ELSE 0 END)) AS totalQuy  -- Tổng quỹ
     FROM cash_management cm
     LEFT JOIN cash c ON cm.id = c.cash_manage_id AND c.time > cm.time  -- Thêm điều kiện vào ON
     GROUP BY cm.id, cm.employee_name, cm.time, cm.details;
    """;

    try (PreparedStatement stm = connection.prepareStatement(query);
         ResultSet rs = stm.executeQuery()) {

        while (rs.next()) {
            CashManager cm = new CashManager();
            cm.setId(rs.getLong("id"));
            cm.setEmployeeName(rs.getString("cm_employee_name"));
            cm.setTime(rs.getTimestamp("time"));
            cm.setDetails(rs.getString("details"));
            cm.setTotalQuythu(rs.getDouble("totalQuythu"));
            cm.setTotalQuychi(rs.getDouble("totalQuychi"));
            cm.setTotalQuydauky(rs.getDouble("totalQuydauky"));
            cm.setTotalQuy(rs.getDouble("totalQuy"));

            list.add(cm);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return list;
}



    public List<Cash> getAllCashRecords() {
        List<Cash> list = new ArrayList<>();

        String query = """
            SELECT cs.id, cs.time AS cash_time, cs.type_id, cs.type_name, cs.amount, 
                   cs.cash_manage_id, cm.time AS cash_manage_time, 
                   u.id AS employee_id, u.name AS employee_name, 
                   c.id AS customer_id, c.name AS customer_name, cs.note, 
                   cs.created_date, cs.created_by, cs.modified_date, cs.modified_by 
            FROM cash cs 
            LEFT JOIN cash_management cm ON cs.cash_manage_id = cm.id 
            LEFT JOIN customer c ON cs.customer_id = c.id 
            LEFT JOIN user u ON cs.employee_id = u.id 
            WHERE cm.time IS NOT NULL AND cs.created_date > cm.time 
            ORDER BY cs.modified_date DESC
        """;

        try (PreparedStatement stm = connection.prepareStatement(query);
             ResultSet rs = stm.executeQuery()) {

            while (rs.next()) {
                Cash cash = new Cash();
                cash.setId(rs.getLong("id"));
                cash.setTime(rs.getTimestamp("cash_time"));
                cash.setTypeId(rs.getInt("type_id"));
                cash.setTypeName(rs.getString("type_name"));
                cash.setAmount(rs.getDouble("amount"));
                cash.setCash_manage_id(rs.getLong("cash_manage_id"));
                cash.setEmployeeId(rs.getLong("employee_id"));
                cash.setEmployeeName(rs.getString("employee_name"));
                cash.setCustomerId(rs.getLong("customer_id"));
                cash.setCustomerName(rs.getString("customer_name"));
                cash.setNote(rs.getString("note"));
                cash.setCreatedDate(rs.getTimestamp("created_date"));
                cash.setCreatedBy(rs.getString("created_by"));
                cash.setModifiedDate(rs.getTimestamp("modified_date"));
                cash.setModifiedBy(rs.getString("modified_by"));

                list.add(cash);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching all cash records: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }
public boolean updateCashManager(CashManager cashmanager) {
    String query = """
        UPDATE cash_management 
        SET employee_name = ?, time = ?, details = ? 
        WHERE id = 1 -- Cập nhật cho ID = 1
    """;

    try (PreparedStatement stm = connection.prepareStatement(query)) {
        stm.setString(1, cashmanager.getEmployeeName());
        stm.setTimestamp(2, new Timestamp(System.currentTimeMillis())); // Lấy thời gian hiện tại
        stm.setString(3, cashmanager.getDetails());

        int rowUpdated = stm.executeUpdate();
        return rowUpdated > 0;
    } catch (SQLException e) {
        System.out.println("Lỗi khi cập nhật CashManager: " + e.getMessage());
        e.printStackTrace();
        return false;
    }
}



   
}
