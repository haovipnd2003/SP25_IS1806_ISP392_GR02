/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author binh2
 */
public class Orders {
    private String id,customerID,userID,totalAmount,customerPay,createdAt,createdBy;
    private String cusName,userName;
    public Orders() {
    }

    public Orders(String id, String customerID, String userID, String totalAmount, 
            String customerPay, String createdAt, String createdBy, String cusName, String userName) {
        this.id = id;
        this.customerID = customerID;
        this.userID = userID;
        this.totalAmount = totalAmount;
        this.customerPay = customerPay;
        this.createdAt = createdAt;
        this.createdBy = createdBy;
        this.cusName = cusName;
        this.userName = userName;
    }

 

    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCustomerID() {
        return customerID;
    }

    public void setCustomerID(String customerID) {
        this.customerID = customerID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(String totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getCustomerPay() {
        return customerPay;
    }

    public void setCustomerPay(String customerPay) {
        this.customerPay = customerPay;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public String getCusName() {
        return cusName;
    }

    public void setCusName(String cusName) {
        this.cusName = cusName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    @Override
    public String toString() {
        return "Orders{" + "id=" + id + ", customerID=" + customerID + ", userID=" + userID + ", totalAmount=" + totalAmount + ", customerPay=" + customerPay + ", createdAt=" + createdAt + ", createdBy=" + createdBy + ", cusName=" + cusName + ", userName=" + userName + '}';
    }

    
    
    
}
