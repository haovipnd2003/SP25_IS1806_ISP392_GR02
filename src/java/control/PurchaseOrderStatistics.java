/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.DashboardDAO;
import entity.Revenue;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Viet Duc
 */
@WebServlet(name = "PurchaseOrderStatistics", urlPatterns = {"/purchaseorderstatistics"})
public class PurchaseOrderStatistics extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PurchaseOrderStatistics</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PurchaseOrderStatistics at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    DashboardDAO dao = new DashboardDAO();
    
    // Lấy ngày hiện tại
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
    Calendar cal = Calendar.getInstance();
    cal.setFirstDayOfWeek(Calendar.MONDAY); // Tuần bắt đầu từ thứ Hai
    cal.setMinimalDaysInFirstWeek(4); // Tuần đầu tiên chứa ít nhất 4 ngày (khớp với WEEK(createdAt, 1))
    String currentDate = dateFormat.format(cal.getTime());

    // Xử lý hóa đơn nhập theo tuần (4 tuần gần nhất)
    List<Revenue> purchaseByWeek = new ArrayList<>();
    List<Revenue> rawPurchaseByWeek = dao.getPurchaseByWeek();
    Map<String, Double> weekPurchaseMap = new HashMap<>();
    for (Revenue r : rawPurchaseByWeek) {
        weekPurchaseMap.put(r.getDate(), r.getRevenue()); // "YYYY-Www"
    }
    cal = Calendar.getInstance();
    cal.setFirstDayOfWeek(Calendar.MONDAY);
    cal.setMinimalDaysInFirstWeek(4);
    int currentWeek = cal.get(Calendar.WEEK_OF_YEAR);
    int currentYear = cal.get(Calendar.YEAR);
    double currentWeekPurchase = 0;
    double previousWeekPurchase = 0;
    for (int i = 0; i < 4; i++) {
        cal.set(Calendar.WEEK_OF_YEAR, currentWeek - i);
        cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY); // Đặt ngày đầu tuần là thứ Hai
        int year = cal.get(Calendar.YEAR);
        int week = cal.get(Calendar.WEEK_OF_YEAR);
        String weekKey = String.format("%d-W%02d", year, week);
        double purchase = weekPurchaseMap.getOrDefault(weekKey, 0.0);
        purchaseByWeek.add(0, new Revenue(String.valueOf(week), purchase));
        if (i == 0) currentWeekPurchase = purchase;
        if (i == 1) previousWeekPurchase = purchase;
    }

    // Tính weeklyGrowth cho hóa đơn nhập
    double weeklyPurchaseGrowth;
    if (previousWeekPurchase == 0) {
        if (currentWeekPurchase > 0) {
            weeklyPurchaseGrowth = 100; 
        } else {
            weeklyPurchaseGrowth = 0; 
        }
    } else {
        weeklyPurchaseGrowth = ((currentWeekPurchase - previousWeekPurchase) / previousWeekPurchase) * 100;
    }

    // Xử lý hóa đơn nhập theo tháng (12 tháng gần nhất)
    List<Revenue> purchaseByMonth = new ArrayList<>();
    List<Revenue> rawPurchaseByMonth = dao.getPurchaseByMonth();
    Map<String, Double> monthPurchaseMap = new HashMap<>();
    for (Revenue r : rawPurchaseByMonth) {
        monthPurchaseMap.put(r.getDate(), r.getRevenue()); // "YYYY-MM"
    }
    cal = Calendar.getInstance();
    double currentMonthPurchase = 0;
    double previousMonthPurchase = 0;
    for (int i = 0; i < 12; i++) {
        cal.setTime(new Date());
        cal.add(Calendar.MONTH, -i);
        String monthKey = new SimpleDateFormat("yyyy-MM").format(cal.getTime());
        String displayMonth = new SimpleDateFormat("MM/yyyy").format(cal.getTime()); // "MM/YYYY"
        double purchase = monthPurchaseMap.getOrDefault(monthKey, 0.0);
        purchaseByMonth.add(0, new Revenue(displayMonth, purchase));
        if (i == 0) currentMonthPurchase = purchase;
        if (i == 1) previousMonthPurchase = purchase;
    }

    // Tính monthlyGrowth cho hóa đơn nhập
    double monthlyPurchaseGrowth;
    if (previousMonthPurchase == 0) {
        if (currentMonthPurchase > 0) {
            monthlyPurchaseGrowth = 100; // Tăng trưởng 100% nếu tháng trước không có hóa đơn nhập, tháng này có
        } else {
            monthlyPurchaseGrowth = 0; // Cả hai tháng đều không có hóa đơn nhập
        }
    } else {
        monthlyPurchaseGrowth = ((currentMonthPurchase - previousMonthPurchase) / previousMonthPurchase) * 100;
    }

    // Tính tổng giá trị hóa đơn nhập
    double totalPurchaseRevenue = dao.getTotalPurchaseRevenue();

    request.setAttribute("purchaseByWeek", purchaseByWeek);
    request.setAttribute("purchaseByMonth", purchaseByMonth);
    request.setAttribute("currentWeekPurchase", currentWeekPurchase);
    request.setAttribute("weeklyPurchaseGrowth", weeklyPurchaseGrowth);
    request.setAttribute("monthlyPurchaseGrowth", monthlyPurchaseGrowth);
    request.setAttribute("totalPurchaseRevenue", totalPurchaseRevenue);
    
    request.getRequestDispatcher("view/page/purchaseorderstatistics.jsp").forward(request, response);
}

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
