/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author Viet Duc
 */
public class Revenue {

    private String date;
    private double revenue;

    public Revenue() {
    }

    public Revenue(String date, double revenue) {
        this.date = date;
        this.revenue = revenue;
    }

    public String getDate() {
        return date;
    }

    public double getRevenue() {
        return revenue;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public void setRevenue(double revenue) {
        this.revenue = revenue;
    }
   

}
