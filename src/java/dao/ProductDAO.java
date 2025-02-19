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
public class ProductDAO extends DBContext{
    
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
            stm.setString(1, "%"+name+"%");
            stm.setString(2, "%"+describe+"%");    
            rs = stm.executeQuery();

            while (rs.next()) {
                Product pro = new Product(rs.getString("id"), rs.getString("name"),
                        rs.getString("describe"), rs.getString("image"), 
                        rs.getString("price"), rs.getString("quantity"));
                 list.add(pro);
            }
            return list;
        } catch (Exception e) {
        }
        return null;
    }
        
       public static void main(String[] args) {
        ProductDAO DAO = new ProductDAO();
        ArrayList<Product> list = DAO.searchProductByNameNDescribe("A", "A");
           for (Product pro : list) {
               System.out.println(list);
           }
    }
}
