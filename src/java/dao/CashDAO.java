/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import context.DBContext;
import entity.Cash;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.ResultSet;
import java.util.List;

/**
 *
 * @author anhdv
 */
public class CashDAO extends DBContext {
    public boolean insertCash(Cash cash) throws SQLException {
        boolean success = false;
        try {
            connection.setAutoCommit(false);
            String query = "insert into cash(time, type_id, type_name, amount, employee_id, employee_name,"
                    + "customer_id, customer_name, note,cash_manage_id) values(?,?,?,?,?,?,?,?,?,?)";
            
            PreparedStatement stm = connection.prepareStatement(query);
            stm.setDate(1, new java.sql.Date(cash.getTime().getTime()));
            stm.setLong(2, cash.getTypeId());
            stm.setString(3, cash.getTypeName());
            stm.setDouble(4, cash.getAmount());
            stm.setLong(5, cash.getEmployeeId());
            stm.setString(6, cash.getEmployeeName());
            stm.setLong(7, cash.getCustomerId());
            stm.setString(8, cash.getCustomerName());
            stm.setString(9, cash.getNote());
            stm.setLong(10, cash.getCash_manage_id());
            stm.executeUpdate();
//            char operator = debenture.getAmount() > 0 ? '+' : ' ';
//            String queryU = "update customer set totaldebt=totaldebt" + operator + debenture.getAmount() + " where id=?";
//            PreparedStatement stmU = connection.prepareStatement(queryU);
//            stmU.setInt(1, debenture.getDebtorId());
//            stmU.executeUpdate();
            
            connection.commit();
            success = true;
        }
        catch (SQLException e) {
            connection.rollback();
            e.printStackTrace();
        }
        finally
        { 
            try { 
                if (connection != null) 
                    connection.close(); 
            } 
            catch (SQLException e) { 
                e.printStackTrace(); 
            } 
        } 
        return success;
    }
    
public ArrayList<Cash> searchCashsWithPagination(
        String cashId, String time, String typeName, String amount, 
        String customerName, String employeeName, String note,
        int page, int recordsPerPage) {

    ArrayList<Cash> list = new ArrayList<>();
    try {
        // Xây dựng câu truy vấn SQL
        StringBuilder query = new StringBuilder(
                "SELECT cs.id, cs.time, cs.type_id, cs.type_name, cs.amount, " +
                "u.id AS employee_id, u.name AS employee_name, " +
                "c.id AS customer_id, c.name AS customer_name, " +
                "cs.note, cs.cash_manage_id " +   // Thêm cash_manage_id vào SELECT
                "FROM cash cs " +
                "JOIN customer c ON cs.customer_id = c.id " +
                "JOIN user u ON cs.employee_id = u.id " +
                "WHERE 1=1 " // Tránh lỗi cú pháp khi thêm điều kiện
        );

        // Danh sách tham số cho PreparedStatement
        ArrayList<Object> params = new ArrayList<>();

        if (cashId != null && !cashId.isEmpty()) {
            query.append(" AND cs.id LIKE ?");
            params.add("%" + cashId + "%");
        }
        if (time != null && !time.isEmpty()) {
            query.append(" AND cs.time LIKE ?");
            params.add("%" + time + "%");
        }
        if (customerName != null && !customerName.isEmpty()) {
            query.append(" AND c.name LIKE ?");
            params.add("%" + customerName + "%");
        }
        if (employeeName != null && !employeeName.isEmpty()) {
            query.append(" AND u.name LIKE ?");
            params.add("%" + employeeName + "%");
        }
        if (amount != null && !amount.isEmpty()) {
            query.append(" AND cs.amount = ?");
            params.add(Double.parseDouble(amount)); // Chuyển đổi sang kiểu double
        }
        if (typeName != null && !typeName.isEmpty()) {
            query.append(" AND cs.type_name LIKE ?");
            params.add("%" + typeName + "%");
        }
        if (note != null && !note.isEmpty()) {
            query.append(" AND cs.note LIKE ?");  // Sửa lại so sánh bằng LIKE
            params.add("%" + note + "%");
        }

        // Thêm phân trang
        query.append(" ORDER BY cs.modified_date DESC LIMIT ? OFFSET ?");
        params.add(recordsPerPage);
        params.add((page - 1) * recordsPerPage);

        // Chuẩn bị PreparedStatement
        PreparedStatement stm = connection.prepareStatement(query.toString());

        // Gán giá trị cho tham số trong PreparedStatement
        for (int i = 0; i < params.size(); i++) {
            if (params.get(i) instanceof String) {
                stm.setString(i + 1, (String) params.get(i));
            } else if (params.get(i) instanceof Double) {
                stm.setDouble(i + 1, (Double) params.get(i));
            } else if (params.get(i) instanceof Integer) {
                stm.setInt(i + 1, (Integer) params.get(i));
            }
        }

        // Thực thi truy vấn
        ResultSet rs = stm.executeQuery();

        while (rs.next()) {
            Cash cs = new Cash(
                rs.getDate("time"),
                rs.getInt("type_id"),
                rs.getString("type_name"),
                rs.getDouble("amount"),
                rs.getLong("employee_id"),
                rs.getString("employee_name"),
                rs.getLong("customer_id"),
                rs.getString("customer_name"),
                rs.getString("note"),
                rs.getLong("cash_manage_id")  // Đọc giá trị cash_manage_id
            );
            cs.setId(rs.getLong("id"));
            list.add(cs);
        }
    } catch (Exception e) {
        System.out.println("Error searching with pagination: " + e.getMessage());
        e.printStackTrace();
    }
    return list;
}

    
    public int getTotalCashsCountAfterSearch(
        String cashId, String time, String typeName, String amount, String customerName, String employeeName, String note,
            int page, int recordsPerPage) {

        int count = 0;
        try {
            StringBuilder query = new StringBuilder(
                    "SELECT COUNT(*) as total FROM cash cs"
                    + " JOIN customer c ON cs.customer_id = c.id"
                    + " JOIN user u ON cs.employee_id = u.id "
            );

            // Danh sách tham số để truyền vào PreparedStatement
            ArrayList<Object> params = new ArrayList<>();

            if (cashId != null && !cashId.isEmpty()) {
                query.append(" AND cs.id LIKE ?");
                params.add("%" + cashId + "%");
            }
            if (time != null && !time.isEmpty()) {
                query.append(" AND cs.time LIKE ?");
                params.add("%" + time + "%");
            }
            if (customerName != null && !customerName.isEmpty()) {
                query.append(" AND c.name LIKE ?");
                params.add("%" + customerName + "%");
            }
            if (employeeName != null && !employeeName.isEmpty()) {
                query.append(" AND u.name LIKE ?");
                params.add("%" + employeeName + "%");
            }
            if (amount != null && !amount.isEmpty()) {
                query.append(" AND cs.amount = ?");
                params.add(amount);
            }
            if (typeName != null && !typeName.isEmpty()) {
                query.append(" AND cs.type = ?");
                params.add(typeName);
            }
            if (note != null && !note.isEmpty()) {
                query.append(" AND cs.note = ?");
                params.add(note);
            }

            // Thêm điều kiện phân trang
            query.append(" ORDER BY cs.id DESC LIMIT ? OFFSET ?");
            params.add(recordsPerPage);
            params.add((page - 1) * recordsPerPage);

            // Chuẩn bị truy vấn an toàn với PreparedStatement
            PreparedStatement stm = connection.prepareStatement(query.toString());

            // Gán giá trị cho các tham số của PreparedStatement
            for (int i = 0; i < params.size(); i++) {
                if (params.get(i) instanceof String) {
                    stm.setString(i + 1, (String) params.get(i));
                } else if (params.get(i) instanceof Double) {
                    stm.setDouble(i + 1, (Double) params.get(i));
                } else if (params.get(i) instanceof Integer) {
                    stm.setInt(i + 1, (Integer) params.get(i));
                }
            }

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt("total");
                }
            }
        } catch (Exception e) {
            System.out.println("Error searching with pagination: " + e.getMessage());
            e.printStackTrace();
        }
        return count;
    }
   public List<Cash> getAllCashs() {
        List<Cash> list = new ArrayList<>();
        
        // Dùng StringBuilder để tạo truy vấn SQL
        StringBuilder query = new StringBuilder();
        query.append("SELECT id, time, typeId, typeName, amount, ");
        query.append("employeeId, employeeName, customerId, customerName, ");
        query.append("note, createdDate, createdBy, modifiedDate, modifiedBy ");
        query.append("FROM cash");

        try (PreparedStatement stm = connection.prepareStatement(query.toString());
             ResultSet rs = stm.executeQuery()) {

            while (rs.next()) {
                Cash cash = new Cash();
                cash.setId(rs.getLong("id"));
                cash.setTime(rs.getTimestamp("time")); // Đảm bảo lấy đầy đủ ngày & giờ
                cash.setTypeId(rs.getInt("typeId"));
                cash.setTypeName(rs.getString("typeName"));
                cash.setAmount(rs.getDouble("amount"));
                cash.setEmployeeId(rs.getLong("employeeId"));
                cash.setEmployeeName(rs.getString("employeeName"));
                cash.setCustomerId(rs.getLong("customerId"));
                cash.setCustomerName(rs.getString("customerName"));
                cash.setNote(rs.getString("note"));
                cash.setCreatedDate(rs.getTimestamp("createdDate"));
                cash.setCreatedBy(rs.getString("createdBy"));
                cash.setModifiedDate(rs.getTimestamp("modifiedDate"));
                cash.setModifiedBy(rs.getString("modifiedBy"));

                list.add(cash);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách cash: " + e.getMessage());
        }
        return list;
    }
   
   
  public ArrayList<Cash> getAllCashRecords() {
    ArrayList<Cash> list = new ArrayList<>();
    try {
        String query = "SELECT \n" +
"    cs.id, \n" +
"    cs.time, \n" +
"    cs.type_id, \n" +
"    cs.type_name, \n" +
"    cs.amount, \n" +
"    u.id AS employee_id, \n" +
"    u.name AS employee_name, \n" +
"    c.id AS customer_id, \n" +
"    c.name AS customer_name, \n" +
"    cs.note,\n" +
"    cm.id AS cash_manage_id\n" +
"FROM \n" +
"    cash cs\n" +
"JOIN \n" +
"    customer c ON cs.customer_id = c.id\n" +
"JOIN \n" +
"    user u ON cs.employee_id = u.id\n" +
"JOIN \n" +
"    cash_management cm ON cs.cash_manage_id = cm.id\n" +
"WHERE \n" +
"    cs.time > cm.time\n" +  // Thêm điều kiện lọc
"ORDER BY \n" +
"    cs.modified_date DESC;";

        // Chuẩn bị truy vấn
        PreparedStatement stm = connection.prepareStatement(query);

        // Thực thi truy vấn
        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
            Cash cs = new Cash(
                rs.getDate("time"),
                rs.getInt("type_id"),
                rs.getString("type_name"),
                rs.getDouble("amount"),
                rs.getLong("employee_id"),
                rs.getString("employee_name"),
                rs.getLong("customer_id"),
                rs.getString("customer_name"),
                rs.getString("note"),
                rs.getLong("cash_manage_id")
            );
            cs.setId(rs.getLong("id"));
            list.add(cs);
        }
    } catch (Exception e) {
        System.out.println("Error fetching all cash records: " + e.getMessage());
        e.printStackTrace();
    }
    return list;
}



}
