/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;

/**
 *
 * @author anhdv
 */
public class Cash {
    private Long id;
    private Date time;
    private int typeId;
    private String typeName;
    private double amount;
    private Long employeeId;
    private String employeeName;
    private Long customerId;
    private String customerName;
    private String note;
    private Date createdDate;
    private String createdBy;
    private Date modifiedDate;
    private String modifiedBy;
   private Long cash_manage_id;

    public Cash(Date time, int typeId, String typeName, double amount, Long employeeId, String employeeName, Long customerId, String customerName, String note, Long cash_manage_id) {
        this.time = time;
        this.cash_manage_id = cash_manage_id;
         this.typeId = typeId;
        this.typeName = typeName;
        this.amount = amount;
        this.employeeId = employeeId;
        this.employeeName = employeeName;
        this.customerId = customerId;
        this.customerName = customerName;
        this.note = note;
    }

    public Long getCash_manage_id() {
        return cash_manage_id;
    }

    public void setCash_manage_id(Long cash_manage_id) {
        this.cash_manage_id = cash_manage_id;
    }

    public Cash() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public int getTypeId() {
        return typeId;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public Long getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(Long employeeId) {
        this.employeeId = employeeId;
    }

    public String getEmployeeName() {
        return employeeName;
    }

    public void setEmployeeName(String employeeName) {
        this.employeeName = employeeName;
    }

    public Long getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Long customerId) {
        this.customerId = customerId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public Date getModifiedDate() {
        return modifiedDate;
    }

    public void setModifiedDate(Date modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public String getModifiedBy() {
        return modifiedBy;
    }

    public void setModifiedBy(String modifiedBy) {
        this.modifiedBy = modifiedBy;
    }

    public static String mapType(int typeId) {
        String msg = null;
        msg = switch (typeId) {
            case 0 -> "Thu tiền khách trả";
            case 1 -> "Khác";
            case 2 -> "Chi trả NCC";
            case 3 -> "Khác";
            default -> "";
        };
        return msg;
    }
}
