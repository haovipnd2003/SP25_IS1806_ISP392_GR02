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
 * @author dung.nvan
 */
public class DebtDAO extends DBContext {
    Statement stmt; 
    private int noOfRecords; 
    
    public boolean insertDebtor(Debtor debtor) {
        boolean success = false;
        try {
            String query = "insert into customer(name, phone, email, address, totaldebt) values(?,?,?,?,?)";
            
            PreparedStatement stm = connection.prepareStatement(query);
            stm.setString(1, debtor.getName());
            stm.setString(2, debtor.getPhone());
            stm.setString(3, debtor.getEmail());
            stm.setString(4, debtor.getAddress());
            stm.setDouble(5, debtor.getTotalDebt());
            
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
    
    public List<Debtor> viewAllDebtors(int offset, int noOfRecords) 
    { 
        String query = "select SQL_CALC_FOUND_ROWS * from customer limit " + offset + ", " + noOfRecords; 
        List<Debtor> list = new ArrayList<Debtor>(); 
        Debtor debtor = null; 
        try { 
            stmt = connection.createStatement(); 
            ResultSet rs = stmt.executeQuery(query); 
            while (rs.next()) { 
                debtor = new Debtor(); 
                debtor.setId(rs.getInt(1)); 
                debtor.setName(rs.getString(2)); 
                debtor.setPhone(rs.getString(3)); 
                debtor.setEmail(rs.getString(4)); 
                debtor.setAddress(rs.getString(5)); 
                debtor.setTotalDebt(rs.getDouble(6)); 
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
}
