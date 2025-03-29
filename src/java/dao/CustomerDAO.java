/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import context.DBContext;
import entity.Customer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author Admin
 */
public class CustomerDAO extends DBContext {

    public CustomerDAO() {
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

    public ArrayList<Customer> getAllCustomers() {
        ArrayList<Customer> list = new ArrayList<>();
        try {
            String query = "SELECT * FROM customer ";
            stm = cnn.prepareStatement(query);
            rs = stm.executeQuery();
            while (rs.next()) {
                Customer cus = new Customer(
                        String.valueOf(rs.getInt("id")),
                        rs.getString("name"),
                        String.valueOf(rs.getBigDecimal("phone")),
                        rs.getString("email"),
                        rs.getString("address")
                );
                list.add(cus);
            }
        } catch (Exception e) {
            System.out.println("Error getting all customers: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    //
    public ArrayList<Customer> getPaginatedCustomers(int page, int recordsPerPage) {
        ArrayList<Customer> list = new ArrayList<>();
        try {
            String query = "SELECT * FROM customer WHERE isactive = 1 ORDER BY id ASC LIMIT ? OFFSET ?";
            stm = cnn.prepareStatement(query);
            int offset = (page - 1) * recordsPerPage;
            stm.setInt(1, recordsPerPage);
            stm.setInt(2, offset);
            rs = stm.executeQuery();
            while (rs.next()) {
                Customer cus = new Customer(
                        String.valueOf(rs.getInt("id")),
                        rs.getString("name"),
                        String.valueOf(rs.getBigDecimal("phone")),
                        rs.getString("email"),
                        rs.getString("address")
                );
                list.add(cus);
            }
        } catch (Exception e) {
            System.out.println("Error getting paginated customers: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    //
//
    public int getTotalCustomers() {
        try {
            String query = "SELECT COUNT(*) AS total FROM customer WHERE isactive = 1";
            stm = cnn.prepareStatement(query);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (Exception e) {
            System.out.println("Error counting customers: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }
//

    public ArrayList<Customer> viewCustomer() {
        ArrayList<Customer> list = new ArrayList<>();
        try {
            String query = "SELECT * FROM customer";
            stm = cnn.prepareStatement(query);
            rs = stm.executeQuery();
            while (rs.next()) {
                Customer cus = new Customer(
                        String.valueOf(rs.getInt("id")),
                        rs.getString("name"),
                        String.valueOf(rs.getBigDecimal("phone")),
                        rs.getString("email"),
                        rs.getString("address")
                );
                list.add(cus);
            }
            return list;
        } catch (Exception e) {
            System.out.println("Error viewing customers: " + e.getMessage());
        }
        return null;
    }

    public Customer getCustomerById(String id) {
        try {
            String query = "SELECT * FROM customer WHERE id = ? AND isactive = 1";
            stm = cnn.prepareStatement(query);
            stm.setInt(1, Integer.parseInt(id));
            rs = stm.executeQuery();
            if (rs.next()) {
                return new Customer(
                        String.valueOf(rs.getInt("id")),
                        rs.getString("name"),
                        String.valueOf(rs.getBigDecimal("phone")),
                        rs.getString("email"),
                        rs.getString("address")
                );
            }
        } catch (Exception e) {
            System.out.println("Error getting customer by ID: " + e.getMessage());
        }
        return null;
    }

    public boolean addCustomer(Customer customer) {
        try {
            String query = "INSERT INTO customer (name, phone, email, address, isactive) VALUES (?, ?, ?, ?, 1)";
            stm = cnn.prepareStatement(query);
            stm.setString(1, customer.getName());
            stm.setBigDecimal(2, new java.math.BigDecimal(customer.getPhone()));
            stm.setString(3, customer.getEmail());
            stm.setString(4, customer.getAddress());

            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            System.out.println("Error adding customer: " + e.getMessage());
            return false;
        }
    }

    public boolean updateCustomer(String id, Customer customer) {
        try {
            String query = "UPDATE customer SET name = ?, phone = ?, email = ?, address = ? WHERE id = ? AND isactive = 1";
            stm = cnn.prepareStatement(query);
            stm.setString(1, customer.getName());
            stm.setString(2, customer.getPhone());
            stm.setString(3, customer.getEmail());
            stm.setString(4, customer.getAddress());
            stm.setInt(5, Integer.parseInt(customer.getId()));
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            System.out.println("Error updating customer: " + e.getMessage());
            return false;
        }
    }

    public boolean banCustomer(String id) {
        try {
            String query = "UPDATE customer SET isactive = 0 WHERE id = ?";
            stm = cnn.prepareStatement(query);
            stm.setInt(1, Integer.parseInt(id));

            int rowsAffected = stm.executeUpdate();
            System.out.println("Ban customer affected rows: " + rowsAffected);
            return rowsAffected > 0;
        } catch (Exception e) {
            System.out.println("Error deleting customer: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public ArrayList<Customer> searchCustomerByNameNPhone(String name, String phone) {
        ArrayList<Customer> list = new ArrayList<>();
        try {
            String query = "SELECT * FROM customer WHERE (name LIKE ? OR phone LIKE ?) and isactive = 1";
            stm = cnn.prepareStatement(query);
            stm.setString(1, "%" + name + "%");
            stm.setString(2, "%" + phone + "%");
            rs = stm.executeQuery();

            while (rs.next()) {
                Customer cus = new Customer(rs.getString("id"), rs.getString("name"),
                        rs.getString("phone"), rs.getString("address"));
                list.add(cus);
            }
            return list;
        } catch (Exception e) {
        }
        return null;
    }

    public ArrayList<Customer> searchCustomers(String id, String name, String phone, String email, String address) {
        ArrayList<Customer> list = new ArrayList<>();
        try {
            StringBuilder query = new StringBuilder("SELECT * FROM customer WHERE isactive = 1");
//
            if (id != null && !id.isEmpty()) {
                try {
                    int customerId = Integer.parseInt(id);
                    query.append(" AND id = ?");
                } catch (NumberFormatException e) {
                    System.out.println("Invalid ID format: " + id);
                }
            }
//
            if (name != null && !name.isEmpty()) {
                query.append(" AND name LIKE ?");
            }
            if (phone != null && !phone.isEmpty()) {
                query.append(" AND phone LIKE ?");
            }
            if (email != null && !email.isEmpty()) {
                query.append(" AND email LIKE ?");
            }
            if (address != null && !address.isEmpty()) {
                query.append(" AND address LIKE ?");
            }

            stm = cnn.prepareStatement(query.toString());

            int index = 1;
//
            if (id != null && !id.isEmpty()) {
                try {
                    int customerId = Integer.parseInt(id);
                    stm.setInt(index++, customerId);
                } catch (NumberFormatException e) {
                }
            }
//
            if (name != null && !name.isEmpty()) {
                stm.setString(index++, "%" + name + "%");
            }
            if (phone != null && !phone.isEmpty()) {
                stm.setString(index++, "%" + phone + "%");
            }
            if (email != null && !email.isEmpty()) {
                stm.setString(index++, "%" + email + "%");
            }
            if (address != null && !address.isEmpty()) {
                stm.setString(index++, "%" + address + "%");
            }

            rs = stm.executeQuery();

            while (rs.next()) {
                Customer cus = new Customer(
                        String.valueOf(rs.getInt("id")),
                        rs.getString("name"),
                        String.valueOf(rs.getBigDecimal("phone")),
                        rs.getString("email"),
                        rs.getString("address")
                );
                list.add(cus);
            }
        } catch (Exception e) {
            System.out.println("Error searching customers: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public void addCustomerByNamenPhone(String name, String phone) {
        try {
            String query = "INSERT INTO customer (name, phone, isactive) VALUES (?, ?, 1)";
            stm = cnn.prepareStatement(query);
            stm.setString(1, name);
            stm.setString(2, phone);
            int rowsAffected = stm.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error adding customer: " + e.getMessage());
        }
    }

    public Customer getCustomerForInvoice(String name, String phone) {
        try {
            String query = "SELECT * FROM customer WHERE (name LIKE ? AND phone LIKE ?) and isactive = 1";
            stm = cnn.prepareStatement(query);
            stm.setString(1, "%" + name + "%");
            stm.setString(2, "%" + phone + "%");
            rs = stm.executeQuery();
            if (rs.next()) {
                return new Customer(
                        String.valueOf(rs.getInt("id")),
                        rs.getString("name"),
                        String.valueOf(rs.getBigDecimal("phone")),
                        rs.getString("address")
                );
            }
        } catch (Exception e) {
            System.out.println("Error getting customer by ID: " + e.getMessage());
        }
        return null;
    }

    public static void main(String[] args) {
        CustomerDAO DAO = new CustomerDAO();
        Customer cus = DAO.getCustomerForInvoice("hao12", "2331");
        System.out.println(cus);
    }
}
