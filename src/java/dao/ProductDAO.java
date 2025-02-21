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
import java.util.ArrayList;

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

    public static void main(String[] args) {
        ProductDAO productdao = new ProductDAO();
        ArrayList<Product> list = productdao.searchProductByNameNDescribe("gạo", "gạo");

        // Kiểm tra danh sách không rỗng
        for (Product product : list) {
            System.out.println(product); // In từng sản phẩm

        }

    }
}