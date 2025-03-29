/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import context.DBContext;
import entity.OrderItems;
import entity.Orders;
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
public class InvoiceDAO extends DBContext {

    public InvoiceDAO() {
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

    public void addPrepareInvoice(String customerID, String userID, String totalAmount, String customerPay, int isactive, String createdAt, String createdBy) {
        String query = "INSERT INTO orders (customerid, userid, totalAmount,customerPay,isactive,createdAt,createdBy) "
                + "VALUES (?,?,?,?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, customerID);
            ps.setString(2, userID);
            ps.setString(3, totalAmount);
            ps.setString(4, customerPay);
            ps.setInt(5, isactive);
            ps.setString(6, createdAt);
            ps.setString(7, createdBy);

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getLatestOrderId() {
        int latestId = -1; // Giá trị mặc định nếu không có bản ghi nào
        try {
            String query = "SELECT id FROM orders ORDER BY id DESC LIMIT 1"; // Lấy id lớn nhất
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                latestId = rs.getInt("id"); // Lấy giá trị cột "id"
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return String.valueOf(latestId);
    }

    public void addOrderItems(String orderID, String productID, String productName, String price1kg,
            String describe, String quantityInput, String packaging, String discount, String amountMoney) {
        String query = " INSERT INTO orderitems (orderid, productid, productname,price1kg,`describe`,quantityInput,packaging,discount,amountMoney) "
                + "VALUES (?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, orderID);
            ps.setString(2, productID);
            ps.setString(3, productName);
            ps.setString(4, price1kg);
            ps.setString(5, describe);
            ps.setString(6, quantityInput);
            ps.setString(7, packaging);
            ps.setString(8, discount);
            ps.setString(9, amountMoney);

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public ArrayList<Orders> getAllOrders() {
        ArrayList<Orders> list = new ArrayList<>();
        try {
            String query = "SELECT o.id AS orderID, o.customerid, totalAmount, customerPay, o.isactive, \n"
                    + "       o.createdAt, o.createdBy, c.name AS customerName, o.userid, u.name AS userName \n"
                    + "FROM orders o \n"
                    + "JOIN customer c ON o.customerid = c.id \n"
                    + "JOIN user u ON o.userid = u.id \n"
                    + "WHERE o.isactive = 1;";
            stm = cnn.prepareStatement(query);
            rs = stm.executeQuery();
            while (rs.next()) {
                Orders o = new Orders(String.valueOf(rs.getInt("orderID")),
                        rs.getString("customerid"),
                        rs.getString("userid"),
                        formatMoney(String.valueOf(rs.getLong("totalAmount"))),
                        rs.getString("customerPay"),
                        rs.getString("createdAt"),
                        rs.getString("createdBy"),
                        rs.getString("customerName"),
                        rs.getString("userName"));
                list.add(o);
            }
        } catch (Exception e) {
            System.out.println("Error getting all customers: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public String formatMoney(String number) {
        StringBuilder result = new StringBuilder();
        int length = number.length();
        int count = 0;

        // Duyệt ngược từ cuối chuỗi về đầu
        for (int i = length - 1; i >= 0; i--) {
            result.append(number.charAt(i));
            count++;

            // Cứ sau 3 chữ số, thêm dấu chấm (trừ khi đó là số đầu tiên)
            if (count % 3 == 0 && i != 0) {
                result.append('.');
            }
        }

        // Đảo ngược chuỗi vì ta đã append từ cuối về đầu
        return result.reverse().toString();
    }

    public ArrayList<Orders> getOrdersWithPagination(int page, int recordsPerPage) {
        ArrayList<Orders> list = new ArrayList<>();
        try {
            String query = "SELECT o.id AS orderID, o.customerid, totalAmount, customerPay, o.isactive, \n"
                    + "       o.createdAt, o.createdBy, c.name AS customerName, o.userid, u.name AS userName \n"
                    + "FROM orders o \n"
                    + "JOIN customer c ON o.customerid = c.id \n"
                    + "JOIN user u ON o.userid = u.id \n"
                    + "WHERE o.isactive = 1 \n"
                    + "ORDER BY o.id DESC \n"
                    + "LIMIT ? OFFSET ?";
            stm = cnn.prepareStatement(query);
            int offset = (page - 1) * recordsPerPage;
            stm.setInt(1, recordsPerPage);
            stm.setInt(2, offset);
            rs = stm.executeQuery();
            while (rs.next()) {
                Orders o = new Orders(String.valueOf(rs.getInt("orderID")),
                        rs.getString("customerid"),
                        rs.getString("userid"),
                        formatMoney(String.valueOf(rs.getLong("totalAmount"))),
                        formatMoney(String.valueOf(rs.getLong("customerPay"))),
                        rs.getString("createdAt"),
                        rs.getString("createdBy"),
                        rs.getString("customerName"),
                        rs.getString("userName"));
                list.add(o);
            }
        } catch (Exception e) {
            System.out.println("Error getting paginated orders: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Get the total number of active orders in the database
     *
     * @return Total number of orders
     */
    public int getTotalOrdersCount() {
        int count = 0;
        try {
            String query = "SELECT COUNT(*) as total FROM orders WHERE isactive = 1";
            stm = cnn.prepareStatement(query);
            rs = stm.executeQuery();
            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (Exception e) {
            System.out.println("Error getting total orders count: " + e.getMessage());
            e.printStackTrace();
        }
        return count;
    }

    public long getTotalAmount() {
        long total = 0;
        try {
            String query = "SELECT SUM(totalAmount) as total FROM orders WHERE isactive = 1";
            stm = cnn.prepareStatement(query);
            rs = stm.executeQuery();
            if (rs.next()) {
                total = rs.getLong("total");
            }
        } catch (Exception e) {
            System.out.println("Error getting total amount: " + e.getMessage());
        }
        return total;
    }

    public long getTotalCustomerPay() {
        long total = 0;
        try {
            String query = "SELECT SUM(customerPay) as total FROM orders WHERE isactive = 1";
            stm = cnn.prepareStatement(query);
            rs = stm.executeQuery();
            if (rs.next()) {
                total = rs.getLong("total");
            }
        } catch (Exception e) {
            System.out.println("Error getting total customer pay: " + e.getMessage());
        }
        return total;
    }

    
    
    
    
    
    
public ArrayList<Orders> searchInvoicesWithPagination(
        String orderID, String createdAt, String customerName, String userName,
        Double totalAmountMin, Double totalAmountMax, Double customerPayMin, Double customerPayMax,
        int page, int recordsPerPage) {

    ArrayList<Orders> list = new ArrayList<>();
    try {
        StringBuilder query = new StringBuilder(
                "SELECT o.id as orderID, o.customerid, totalAmount, customerPay, "
                + "o.isactive, o.createdAt, o.createdBy, c.name as customerName, o.userid, u.name as userName "
                + "FROM orders o "
                + "JOIN customer c ON o.customerid = c.id "
                + "JOIN user u ON o.userid = u.id "
                + "WHERE o.isactive = 1 AND o.orderType = 0"
        );

        // Danh sách tham số để truyền vào PreparedStatement
        ArrayList<Object> params = new ArrayList<>();

        if (orderID != null && !orderID.isEmpty()) {
            query.append(" AND o.id LIKE ?");
            params.add("%" + orderID + "%");
        }
        if (createdAt != null && !createdAt.isEmpty()) {
            query.append(" AND o.createdAt LIKE ?");
            params.add("%" + createdAt + "%");
        }
        if (customerName != null && !customerName.isEmpty()) {
            query.append(" AND c.name LIKE ?");
            params.add("%" + customerName + "%");
        }
        if (userName != null && !userName.isEmpty()) {
            query.append(" AND u.name LIKE ?");
            params.add("%" + userName + "%");
        }
        if (totalAmountMin != null) {
            query.append(" AND o.totalAmount >= ?");
            params.add(totalAmountMin);
        }
        if (totalAmountMax != null) {
            query.append(" AND o.totalAmount <= ?");
            params.add(totalAmountMax);
        }
        if (customerPayMin != null) {
            query.append(" AND o.customerPay >= ?");
            params.add(customerPayMin);
        }
        if (customerPayMax != null) {
            query.append(" AND o.customerPay <= ?");
            params.add(customerPayMax);
        }

        // Thêm điều kiện phân trang
        query.append(" ORDER BY o.id DESC LIMIT ? OFFSET ?");
        params.add(recordsPerPage);
        params.add((page - 1) * recordsPerPage);

        // Chuẩn bị truy vấn an toàn với PreparedStatement
        PreparedStatement stm = cnn.prepareStatement(query.toString());

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

        // Thực thi truy vấn
        ResultSet rs = stm.executeQuery();

        while (rs.next()) {
            Orders o = new Orders(
                    String.valueOf(rs.getInt("orderID")),
                    rs.getString("customerid"),
                    rs.getString("userid"),
                    formatMoney(String.valueOf(rs.getLong("totalAmount"))),
                    formatMoney(String.valueOf(rs.getLong("customerPay"))),
                    rs.getString("createdAt"),
                    rs.getString("createdBy"),
                    rs.getString("customerName"),
                    rs.getString("userName")
            );
            list.add(o);
        }
    } catch (Exception e) {
        System.out.println("Error searching invoices with pagination: " + e.getMessage());
        e.printStackTrace();
    }
    return list;
}


    
    
    
    
    
    
    
    
    
    
    public ArrayList<Orders> searchInvoices(
            String orderID, String createdAt, String customerName, String userName,
            Double totalAmountMin, Double totalAmountMax, Double customerPayMin, Double customerPayMax) {

        ArrayList<Orders> list = new ArrayList<>();
        try {
            StringBuilder query = new StringBuilder(
                    "SELECT o.id as orderID, o.customerid, totalAmount, customerPay, "
                    + "o.isactive, o.createdAt, o.createdBy, c.name as customerName, o.userid, u.name as userName "
                    + "FROM orders o "
                    + "JOIN customer c ON o.customerid = c.id "
                    + "JOIN user u ON o.userid = u.id WHERE o.isactive = 1"
            );

            // Danh sách tham số
            ArrayList<Object> params = new ArrayList<>();

            if (orderID != null && !orderID.isEmpty()) {
                query.append(" AND o.id LIKE ?");
                params.add("%" + orderID + "%");
            }
            if (createdAt != null && !createdAt.isEmpty()) {
                query.append(" AND o.createdAt LIKE ?");
                params.add("%" + createdAt + "%");
            }
            if (customerName != null && !customerName.isEmpty()) {
                query.append(" AND c.name LIKE ?");
                params.add("%" + customerName + "%");
            }
            if (userName != null && !userName.isEmpty()) {
                query.append(" AND u.name LIKE ?");
                params.add("%" + userName + "%");
            }
            if (totalAmountMin != null) {
                query.append(" AND o.totalAmount >= ?");
                params.add(totalAmountMin);
            }
            if (totalAmountMax != null) {
                query.append(" AND o.totalAmount <= ?");
                params.add(totalAmountMax);
            }
            if (customerPayMin != null) {
                query.append(" AND o.customerPay >= ?");
                params.add(customerPayMin);
            }
            if (customerPayMax != null) {
                query.append(" AND o.customerPay <= ?");
                params.add(customerPayMax);
            }

            query.append(" ORDER BY o.id DESC");

            // Chuẩn bị truy vấn
            PreparedStatement stm = cnn.prepareStatement(query.toString());
            for (int i = 0; i < params.size(); i++) {
                if (params.get(i) instanceof String) {
                    stm.setString(i + 1, (String) params.get(i));
                } else if (params.get(i) instanceof Double) {
                    stm.setDouble(i + 1, (Double) params.get(i));
                }
            }

            // Thực thi truy vấn
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Orders o = new Orders(
                        String.valueOf(rs.getInt("orderID")),
                        rs.getString("customerid"),
                        rs.getString("userid"),
                        formatMoney(String.valueOf(rs.getLong("totalAmount"))),
                        formatMoney(String.valueOf(rs.getLong("customerPay"))),
                        rs.getString("createdAt"),
                        rs.getString("createdBy"),
                        rs.getString("customerName"),
                        rs.getString("userName")
                );
                list.add(o);
            }
        } catch (Exception e) {
            System.out.println("Error searching invoices: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

public int getTotalOrdersCountAfterSearch(String orderID, String createdAt, String customerName, String userName,
        String totalAmountMin, String totalAmountMax, String customerPayMin, String customerPayMax) {
    int count = 0;
    StringBuilder query = new StringBuilder(
            "SELECT COUNT(*) as total FROM orders o "
            + "JOIN customer c ON o.customerid = c.id "
            + "JOIN user u ON o.userid = u.id WHERE o.isactive = 1"
    );

    // Danh sách tham số để truyền vào PreparedStatement
    ArrayList<Object> params = new ArrayList<>();

    // Thêm điều kiện tìm kiếm nếu có
    if (orderID != null && !orderID.isEmpty()) {
        query.append(" AND o.id LIKE ?");
        params.add("%" + orderID + "%");
    }
    if (createdAt != null && !createdAt.isEmpty()) {
        query.append(" AND o.createdAt LIKE ?");
        params.add("%" + createdAt + "%");
    }
    if (customerName != null && !customerName.isEmpty()) {
        query.append(" AND c.name LIKE ?");
        params.add("%" + customerName + "%");
    }
    if (userName != null && !userName.isEmpty()) {
        query.append(" AND u.name LIKE ?");
        params.add("%" + userName + "%");
    }
    
    // Xử lý các tham số số tiền
    try {
        if (totalAmountMin != null && !totalAmountMin.isEmpty()) {
            query.append(" AND o.totalAmount >= ?");
            params.add(Double.parseDouble(totalAmountMin));
        }
        if (totalAmountMax != null && !totalAmountMax.isEmpty()) {
            query.append(" AND o.totalAmount <= ?");
            params.add(Double.parseDouble(totalAmountMax));
        }
        if (customerPayMin != null && !customerPayMin.isEmpty()) {
            query.append(" AND o.customerPay >= ?");
            params.add(Double.parseDouble(customerPayMin));
        }
        if (customerPayMax != null && !customerPayMax.isEmpty()) {
            query.append(" AND o.customerPay <= ?");
            params.add(Double.parseDouble(customerPayMax));
        }
    } catch (NumberFormatException e) {
        System.out.println("Error parsing number in count query: " + e.getMessage());
    }

    try (PreparedStatement stm = cnn.prepareStatement(query.toString())) {
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
        System.out.println("Error getting total orders count: " + e.getMessage());
        e.printStackTrace();
    }
    return count;
}

    public long getTotalAmountAfterSearch(String orderID, String createdAt, String customerName, String userName,
            String totalAmountMin, String totalAmountMax, String customerPayMin, String customerPayMax) {
        long total = 0;
        StringBuilder query = new StringBuilder(
                "SELECT SUM(o.totalAmount) as total FROM orders o "
                + "JOIN customer c ON o.customerid = c.id "
                + "JOIN user u ON o.userid = u.id WHERE o.isactive = 1"
        );

        // Thêm điều kiện tìm kiếm nếu có
        if (orderID != null && !orderID.isEmpty()) {
            query.append(" AND o.id LIKE ?");
        }
        if (createdAt != null && !createdAt.isEmpty()) {
            query.append(" AND o.createdAt LIKE ?");
        }
        if (customerName != null && !customerName.isEmpty()) {
            query.append(" AND c.name LIKE ?");
        }
        if (userName != null && !userName.isEmpty()) {
            query.append(" AND u.name LIKE ?");
        }
        if (totalAmountMin != null && !totalAmountMin.isEmpty()) {
            query.append(" AND o.totalAmount >= ?");
        }
        if (totalAmountMax != null && !totalAmountMax.isEmpty()) {
            query.append(" AND o.totalAmount <= ?");
        }
        if (customerPayMin != null && !customerPayMin.isEmpty()) {
            query.append(" AND o.customerPay >= ?");
        }
        if (customerPayMax != null && !customerPayMax.isEmpty()) {
            query.append(" AND o.customerPay <= ?");
        }

        try (PreparedStatement stm = cnn.prepareStatement(query.toString())) {
            int index = 1;
            if (orderID != null && !orderID.isEmpty()) {
                stm.setString(index++, "%" + orderID + "%");
            }
            if (createdAt != null && !createdAt.isEmpty()) {
                stm.setString(index++, "%" + createdAt + "%");
            }
            if (customerName != null && !customerName.isEmpty()) {
                stm.setString(index++, "%" + customerName + "%");
            }
            if (userName != null && !userName.isEmpty()) {
                stm.setString(index++, "%" + userName + "%");
            }
            if (totalAmountMin != null && !totalAmountMin.isEmpty()) {
                stm.setDouble(index++, Double.parseDouble(totalAmountMin));
            }
            if (totalAmountMax != null && !totalAmountMax.isEmpty()) {
                stm.setDouble(index++, Double.parseDouble(totalAmountMax));
            }
            if (customerPayMin != null && !customerPayMin.isEmpty()) {
                stm.setDouble(index++, Double.parseDouble(customerPayMin));
            }
            if (customerPayMax != null && !customerPayMax.isEmpty()) {
                stm.setDouble(index++, Double.parseDouble(customerPayMax));
            }

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    total = rs.getLong("total");
                }
            }
        } catch (Exception e) {
            System.out.println("Error getting total amount: " + e.getMessage());
        }
        return total;
    }

    public long getTotalCustomerPayAfterSearch(String orderID, String createdAt, String customerName, String userName,
            String totalAmountMin, String totalAmountMax, String customerPayMin, String customerPayMax) {
        long total = 0;
        StringBuilder query = new StringBuilder(
                "SELECT SUM(o.customerPay) as total FROM orders o "
                + "JOIN customer c ON o.customerid = c.id "
                + "JOIN user u ON o.userid = u.id WHERE o.isactive = 1"
        );

        // Thêm điều kiện tìm kiếm nếu có
        if (orderID != null && !orderID.isEmpty()) {
            query.append(" AND o.id LIKE ?");
        }
        if (createdAt != null && !createdAt.isEmpty()) {
            query.append(" AND o.createdAt LIKE ?");
        }
        if (customerName != null && !customerName.isEmpty()) {
            query.append(" AND c.name LIKE ?");
        }
        if (userName != null && !userName.isEmpty()) {
            query.append(" AND u.name LIKE ?");
        }
        if (totalAmountMin != null && !totalAmountMin.isEmpty()) {
            query.append(" AND o.totalAmount >= ?");
        }
        if (totalAmountMax != null && !totalAmountMax.isEmpty()) {
            query.append(" AND o.totalAmount <= ?");
        }
        if (customerPayMin != null && !customerPayMin.isEmpty()) {
            query.append(" AND o.customerPay >= ?");
        }
        if (customerPayMax != null && !customerPayMax.isEmpty()) {
            query.append(" AND o.customerPay <= ?");
        }

        try (PreparedStatement stm = cnn.prepareStatement(query.toString())) {
            int index = 1;
            if (orderID != null && !orderID.isEmpty()) {
                stm.setString(index++, "%" + orderID + "%");
            }
            if (createdAt != null && !createdAt.isEmpty()) {
                stm.setString(index++, "%" + createdAt + "%");
            }
            if (customerName != null && !customerName.isEmpty()) {
                stm.setString(index++, "%" + customerName + "%");
            }
            if (userName != null && !userName.isEmpty()) {
                stm.setString(index++, "%" + userName + "%");
            }
            if (totalAmountMin != null && !totalAmountMin.isEmpty()) {
                stm.setDouble(index++, Double.parseDouble(totalAmountMin));
            }
            if (totalAmountMax != null && !totalAmountMax.isEmpty()) {
                stm.setDouble(index++, Double.parseDouble(totalAmountMax));
            }
            if (customerPayMin != null && !customerPayMin.isEmpty()) {
                stm.setDouble(index++, Double.parseDouble(customerPayMin));
            }
            if (customerPayMax != null && !customerPayMax.isEmpty()) {
                stm.setDouble(index++, Double.parseDouble(customerPayMax));
            }

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    total = rs.getLong("total");
                }
            }
        } catch (Exception e) {
            System.out.println("Error getting total customer pay: " + e.getMessage());
        }
        return total;
    }

    
    
    
    
 public ArrayList<OrderItems> getOrderItemsByOrderID(String orderID) {
        ArrayList<OrderItems> list = new ArrayList<>();
        try {
            String query = "select * from orderItems where orderid = ?";
            stm = cnn.prepareStatement(query);
            stm.setString(1, orderID);
            rs = stm.executeQuery();
            while (rs.next()) {
                OrderItems oi = new OrderItems(null, rs.getString("orderid"), 
                        rs.getString("productid"), rs.getString("productname"), 
                        rs.getString("price1kg"), null, 
                        rs.getString("quantityInput"), rs.getString("packaging"), 
                        rs.getString("discount"), rs.getString("amountMoney"));
                list.add(oi);
            }
        } catch (Exception e) {
            System.out.println("Error getting paginated orders: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }
    
 
 //trừ tồn kho 
     public void updateStock(String id, String quantity) {
        try {
            String query = "UPDATE product \n" +
"SET quantity = ? \n" +
"WHERE id = ?;";
            stm = cnn.prepareStatement(query);
            stm.setString(1, quantity);
            stm.setString(2, id);
            int rowsAffected = stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("Error updating customer: " + e.getMessage());
        }
    }
     
     
     
     
         public void addImportInvoice(String customerID, String userID, String totalAmount, String customerPay, int isactive, String createdAt, String createdBy) {
        String query = "INSERT INTO orders (customerid, userid, totalAmount,customerPay,isactive,createdAt,createdBy,orderType) "
                + "VALUES (?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, customerID);
            ps.setString(2, userID);
            ps.setString(3, totalAmount);
            ps.setString(4, customerPay);
            ps.setInt(5, isactive);
            ps.setString(6, createdAt);
            ps.setString(7, createdBy);
            ps.setString(8, "1");

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
         
         
         
         public ArrayList<Orders> searchInvoicesImportWithPagination(
        String orderID, String createdAt, String customerName, String userName,
        Double totalAmountMin, Double totalAmountMax, Double customerPayMin, Double customerPayMax,
        int page, int recordsPerPage) {

    ArrayList<Orders> list = new ArrayList<>();
    try {
        StringBuilder query = new StringBuilder(
                "SELECT o.id as orderID, o.customerid, totalAmount, customerPay, "
                + "o.isactive, o.createdAt, o.createdBy, c.name as customerName, o.userid, u.name as userName "
                + "FROM orders o "
                + "JOIN customer c ON o.customerid = c.id "
                + "JOIN user u ON o.userid = u.id "
                + "WHERE o.isactive = 1 AND o.orderType = 1"
        );

        // Danh sách tham số để truyền vào PreparedStatement
        ArrayList<Object> params = new ArrayList<>();

        if (orderID != null && !orderID.isEmpty()) {
            query.append(" AND o.id LIKE ?");
            params.add("%" + orderID + "%");
        }
        if (createdAt != null && !createdAt.isEmpty()) {
            query.append(" AND o.createdAt LIKE ?");
            params.add("%" + createdAt + "%");
        }
        if (customerName != null && !customerName.isEmpty()) {
            query.append(" AND c.name LIKE ?");
            params.add("%" + customerName + "%");
        }
        if (userName != null && !userName.isEmpty()) {
            query.append(" AND u.name LIKE ?");
            params.add("%" + userName + "%");
        }
        if (totalAmountMin != null) {
            query.append(" AND o.totalAmount >= ?");
            params.add(totalAmountMin);
        }
        if (totalAmountMax != null) {
            query.append(" AND o.totalAmount <= ?");
            params.add(totalAmountMax);
        }
        if (customerPayMin != null) {
            query.append(" AND o.customerPay >= ?");
            params.add(customerPayMin);
        }
        if (customerPayMax != null) {
            query.append(" AND o.customerPay <= ?");
            params.add(customerPayMax);
        }

        // Thêm điều kiện phân trang
        query.append(" ORDER BY o.id DESC LIMIT ? OFFSET ?");
        params.add(recordsPerPage);
        params.add((page - 1) * recordsPerPage);

        // Chuẩn bị truy vấn an toàn với PreparedStatement
        PreparedStatement stm = cnn.prepareStatement(query.toString());

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

        // Thực thi truy vấn
        ResultSet rs = stm.executeQuery();

        while (rs.next()) {
            Orders o = new Orders(
                    String.valueOf(rs.getInt("orderID")),
                    rs.getString("customerid"),
                    rs.getString("userid"),
                    formatMoney(String.valueOf(rs.getLong("totalAmount"))),
                    formatMoney(String.valueOf(rs.getLong("customerPay"))),
                    rs.getString("createdAt"),
                    rs.getString("createdBy"),
                    rs.getString("customerName"),
                    rs.getString("userName")
            );
            list.add(o);
        }
    } catch (Exception e) {
        System.out.println("Error searching invoices with pagination: " + e.getMessage());
        e.printStackTrace();
    }
    return list;
}
         
         
         
    
    public static void main(String[] args) {
        InvoiceDAO dao = new InvoiceDAO();
//        dao.addPrepareInvoice("1", "1", "2", "2", 0, "2025-03-04 13:18:18", "binh");
//dao.addOrderItems("2", "1", "a", "1", "1", "1", "1", "1", "1");
//        ArrayList<Orders> list = dao.getOrdersWithPagination(6, 5);
//        for (int i = 0; i < list.size(); i++) {
//            System.out.println(list.get(i));
//        }

//        ArrayList<Orders> list = dao.searchInvoicesWithPagination(null, "2025-03-04 22:09", null, null,
//                null, null, null, null, 1, 10);
ArrayList<OrderItems>list = dao.getOrderItemsByOrderID("98");
        for (int i = 0; i < list.size(); i++) {
            System.out.println(list.get(i));
        }

    }
}
