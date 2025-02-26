/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import context.DBContext;
import entity.Debtor;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement; 
import java.sql.SQLException; 
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author vietanhdang
 */
public class DebtorDAO extends DBContext {
    Statement stmt; 
    private int noOfRecords; 
    
    public boolean insertDebtor(Debtor debtor) {
        boolean success = false;
        try {
            String query = "insert into customer(name, phone, email, address) values(?,?,?,?)";
            
            PreparedStatement stm = connection.prepareStatement(query);
            stm.setString(1, debtor.getName());
            stm.setString(2, debtor.getPhone());
            stm.setString(3, debtor.getEmail());
            stm.setString(4, debtor.getAddress());
            
            int res = stm.executeUpdate();
            if (res != 0) success = true;
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        finally
        { 
            try { 
                if (stmt != null) 
                    stmt.close(); 
                if (connection != null) 
                    connection.close(); 
            } 
            catch (SQLException e) { 
                e.printStackTrace(); 
            } 
        } 
        return success;
    }
    
    public boolean updateDebtor(Debtor debtor) {
        boolean success = false;
        try {
            String query = "update customer set name=?, phone=?, email=?, address=? where id=?";
            
            PreparedStatement stm = connection.prepareStatement(query);
            stm.setString(1, debtor.getName());
            stm.setString(2, debtor.getPhone());
            stm.setString(3, debtor.getEmail());
            stm.setString(4, debtor.getAddress());
            stm.setInt(5, debtor.getId());
            
            int res = stm.executeUpdate();
            if (res != 0) success = true;
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        finally
        { 
            try { 
                if (stmt != null) 
                    stmt.close(); 
                if (connection != null) 
                    connection.close(); 
            } 
            catch (SQLException e) { 
                e.printStackTrace(); 
            } 
        } 
        return success;
    }
    
    public List<Debtor> viewAllDebtors(String keyword, int offset, int noOfRecords) 
    { 
        StringBuilder query = new StringBuilder();
        query.append("select SQL_CALC_FOUND_ROWS * from customer");
        
        String searchQuery = this.buildSearchQuery(keyword);
        if (!searchQuery.isBlank() && !searchQuery.isEmpty()) {
            query.append(searchQuery);
        }
        
        query.append(" order by createdAt desc limit ").append(offset).append(", ").append(noOfRecords);
        
        List<Debtor> list = new ArrayList<Debtor>(); 
        Debtor debtor = null; 
        try { 
            stmt = connection.createStatement(); 
            ResultSet rs = stmt.executeQuery(query.toString()); 
            while (rs.next()) { 
                debtor = new Debtor(); 
                debtor.setId(rs.getInt(1)); 
                debtor.setName(rs.getString(2)); 
                debtor.setPhone(rs.getString(3)); 
                debtor.setEmail(rs.getString(4)); 
                debtor.setAddress(rs.getString(5)); 
                debtor.setTotalDebt(rs.getDouble(7)); 
                list.add(debtor); 
            } 
  
            rs.close(); 
            rs = stmt.executeQuery("SELECT FOUND_ROWS()"); 
  
            if (rs.next()) 
               this.noOfRecords = rs.getInt(1); 
        } 
        catch (SQLException e) { 
            e.printStackTrace(); 
        } 
        finally
        { 
            try { 
                if (stmt != null) 
                    stmt.close(); 
                if (connection != null) 
                    connection.close(); 
            } 
            catch (SQLException e) { 
                e.printStackTrace(); 
            } 
        } 
        return list; 
    } 
    
    public int getNoOfRecords() { return noOfRecords; } 
    
    private String buildSearchQuery(String keyword) {
        StringBuilder query = new StringBuilder();
        if (keyword != null && !keyword.isBlank() && !keyword.isEmpty()) {
            query.append (" where id like '%");
            query.append (keyword);
            query.append ("%'");
            query.append (" or name like '%");
            query.append (keyword);
            query.append ("%'");
            query.append (" or phone like '%");
            query.append (keyword);
            query.append ("%'");
        }
        return query.toString();
    }
}
