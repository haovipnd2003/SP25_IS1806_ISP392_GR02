/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;

/**
 *
 * @author vietanhdang
 */
public class Debenture {
    private int id;

    public int getId() {
        return id;
    }

    public Debenture() {
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public int getDebtorId() {
        return debtorId;
    }

    public void setDebtorId(int debtorId) {
        this.debtorId = debtorId;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Debenture(String note,double amount, int debtorId, Date createdDate) {
        this.note = note;
        this.amount = amount;
        this.debtorId = debtorId;
        this.createdDate = createdDate;
    }
    private String note;
    private double amount;
    private int debtorId;
    private Date createdDate;
    
}
