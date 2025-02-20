/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import context.DBContext;
import entity.Debenture;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author vietanhdang
 */
public class DebentureDAO extends DBContext{
    private int noOfRecords; 
    
    public boolean insertDebenture(Debenture debenture) {
        boolean success = false;
        try {
            String query = "insert into debenture(note, amount, debtor_id, created_date) values(?,?,?,?)";
            
            PreparedStatement stm = connection.prepareStatement(query);
            stm.setString(1, debenture.getNote());
            stm.setDouble(2, debenture.getAmount());
            stm.setInt(3, debenture.getDebtorId());
            java.sql.Date sqlDate = new java.sql.Date(debenture.getCreatedDate().getTime());
            stm.setDate(4, sqlDate);
            
            int res = stm.executeUpdate();
            if (res != 0) success = true;
        }
        catch (Exception e) {
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
    
    public List<Debenture> viewAllDebenturesByDebtorId(int debtorId, int offset, int noOfRecords) 
    { 
        String query = "select SQL_CALC_FOUND_ROWS * from debenture where debtor_id = ? limit " + offset + ", " + noOfRecords; 
        List<Debenture> list = new ArrayList<Debenture>(); 
        Debenture debenture = null; 
        try { 
            PreparedStatement stm = connection.prepareStatement(query);
            stm.setInt(1, debtorId);
            ResultSet rs = stm.executeQuery(); 
            while (rs.next()) { 
                debenture = new Debenture(); 
                debenture.setId(rs.getInt(1)); 
                debenture.setNote(rs.getString(2)); 
                debenture.setAmount(rs.getDouble(3)); 
                debenture.setDebtorId(rs.getInt(4)); 
                debenture.setCreatedDate(rs.getDate(6)); 
                list.add(debenture); 
            } 
  
            rs.close(); 
            rs = stm.executeQuery("SELECT FOUND_ROWS()"); 
  
            if (rs.next()) 
               this.noOfRecords = rs.getInt(1); 
        } 
        catch (SQLException e) { 
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
        return list; 
    } 
    
    public int getNoOfRecords() { return noOfRecords; } 
}
