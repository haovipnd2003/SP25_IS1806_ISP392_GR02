/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.text.NumberFormat;
import java.util.Locale;

/**
 *
 * @author vietanhdang
 */
public class Debtor {
    private int id;
    private String name;
    private String phone;
    private String email;
    private String address;
    private double totalDebt;

    public Debtor() {
    }

    public Debtor(String name, String phone, String email, String address, double totalDebt) {
        this.name = name;
        this.phone = phone;
        this.email = email;
        this.address = address;
        this.totalDebt = totalDebt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public double getTotalDebt() {
        return totalDebt;
    }

    public void setTotalDebt(double totalDebt) {
        this.totalDebt = totalDebt;
    }
    
    public String getTotalDebtString() {
        return NumberFormat.getNumberInstance(Locale.US).format(this.getTotalDebt());
    }
}
