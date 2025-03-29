package entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class CashManager {
    private long id;
    private String employeeName;
    private Date time;
    private String details;
    private List<Cash> cashlist = new ArrayList<>();
private double totalQuythu;
private double totalQuychi;
private double totalQuydauky;
private double totalQuy;

    public CashManager() {
    }

    public double getTotalQuythu() {
        return totalQuythu;
    }

    public void setTotalQuythu(double totalQuythu) {
        this.totalQuythu = totalQuythu;
    }

    public double getTotalQuychi() {
        return totalQuychi;
    }

    public void setTotalQuychi(double totalQuychi) {
        this.totalQuychi = totalQuychi;
    }

    public double getTotalQuydauky() {
        return totalQuydauky;
    }

    public void setTotalQuydauky(double totalQuydauky) {
        this.totalQuydauky = totalQuydauky;
    }

    public double getTotalQuy() {
        return totalQuy;
    }

    public void setTotalQuy(double totalQuy) {
        this.totalQuy = totalQuy;
    }

    public CashManager(long id, String employeeName, Date time, String details) {
        this.id = id;
        this.employeeName = employeeName;
        this.time = time;
        this.details = details;
        this.cashlist = new ArrayList<>();
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getEmployeeName() {
        return employeeName;
    }

    public void setEmployeeName(String employeeName) {
        this.employeeName = employeeName;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public List<Cash> getCashlist() {
        return cashlist;
    }

    public void setCashlist(List<Cash> cashlist) {
        this.cashlist = cashlist;
    }

    // Thêm Cash vào danh sách
    public void addCash(Cash cash) {
        this.cashlist.add(cash);
    }
}
