/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dao.DashboardDAO;
import entity.Revenue;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
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
@WebServlet(name = "RevenueStatistics", urlPatterns = {"/revenuestatistics"})
public class RevenueStatistics extends HttpServlet {

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
            out.println("<title>Servlet RevenueStatistics</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RevenueStatistics at " + request.getContextPath() + "</h1>");
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
        String currentDate = dateFormat.format(cal.getTime());

        // Xử lý doanh thu theo ngày (7 ngày gần nhất)
        List<Revenue> revenueByDate = new ArrayList<>();
        List<Revenue> rawRevenueByDate = dao.getRevenueByDate();
        Map<String, Double> dateRevenueMap = new HashMap<>();
        for (Revenue r : rawRevenueByDate) {
            dateRevenueMap.put(r.getDate(), r.getRevenue()); // "YYYY-MM-DD"
        }
        double todayRevenue = 0;
        double previousDayRevenue = 0;
        for (int i = 0; i < 7; i++) {
            cal.setTime(new Date());
            cal.add(Calendar.DATE, -i);
            String dateKey = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
            String displayDate = dateFormat.format(cal.getTime()); // "DD/MM/YYYY"
            double revenue = dateRevenueMap.getOrDefault(dateKey, 0.0);
            revenueByDate.add(0, new Revenue(displayDate, revenue));
            if (i == 0) todayRevenue = revenue;
            if (i == 1) previousDayRevenue = revenue;
        }

        // Tính dailyGrowth
        double dailyGrowth;
        if (previousDayRevenue == 0) {
            if (todayRevenue > 0) {
                dailyGrowth = 100; // Tăng trưởng 100% nếu hôm qua không có doanh thu, hôm nay có
            } else {
                dailyGrowth = 0; // Cả hai ngày đều không có doanh thu
            }
        } else {
            dailyGrowth = ((todayRevenue - previousDayRevenue) / previousDayRevenue) * 100;
        }

        // Xử lý doanh thu theo tuần (4 tuần gần nhất)
        List<Revenue> revenueByWeek = new ArrayList<>();
        List<Revenue> rawRevenueByWeek = dao.getRevenueByWeek();
        Map<String, Double> weekRevenueMap = new HashMap<>();
        for (Revenue r : rawRevenueByWeek) {
            weekRevenueMap.put(r.getDate(), r.getRevenue()); // "YYYY-Www"
        }
        cal = Calendar.getInstance();
        int currentWeek = cal.get(Calendar.WEEK_OF_YEAR);
        double currentWeekRevenue = 0;
        double previousWeekRevenue = 0;
        for (int i = 0; i < 4; i++) {
            cal.set(Calendar.WEEK_OF_YEAR, currentWeek - i);
            cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY); // Tuần bắt đầu từ thứ Hai
            int year = cal.get(Calendar.YEAR);
            int week = cal.get(Calendar.WEEK_OF_YEAR);
            String weekKey = String.format("%d-W%02d", year, week);
            double revenue = weekRevenueMap.getOrDefault(weekKey, 0.0);
            revenueByWeek.add(0, new Revenue(String.valueOf(week), revenue));
            if (i == 0) currentWeekRevenue = revenue;
            if (i == 1) previousWeekRevenue = revenue;
        }

        // Tính weeklyGrowth
        double weeklyGrowth;
        if (previousWeekRevenue == 0) {
            if (currentWeekRevenue > 0) {
                weeklyGrowth = 100; // Tăng trưởng 100% nếu tuần trước không có doanh thu, tuần này có
            } else {
                weeklyGrowth = 0; // Cả hai tuần đều không có doanh thu
            }
        } else {
            weeklyGrowth = ((currentWeekRevenue - previousWeekRevenue) / previousWeekRevenue) * 100;
        }

        // Xử lý doanh thu theo tháng (12 tháng gần nhất)
        List<Revenue> revenueByMonth = new ArrayList<>();
        List<Revenue> rawRevenueByMonth = dao.getRevenueByMonth();
        Map<String, Double> monthRevenueMap = new HashMap<>();
        for (Revenue r : rawRevenueByMonth) {
            monthRevenueMap.put(r.getDate(), r.getRevenue()); // "YYYY-MM"
        }
        cal = Calendar.getInstance();
        double currentMonthRevenue = 0;
        double previousMonthRevenue = 0;
        for (int i = 0; i < 12; i++) {
            cal.setTime(new Date());
            cal.add(Calendar.MONTH, -i);
            String monthKey = new SimpleDateFormat("yyyy-MM").format(cal.getTime());
            String displayMonth = new SimpleDateFormat("MM/yyyy").format(cal.getTime()); // "MM/YYYY"
            double revenue = monthRevenueMap.getOrDefault(monthKey, 0.0);
            revenueByMonth.add(0, new Revenue(displayMonth, revenue));
            if (i == 0) currentMonthRevenue = revenue;
            if (i == 1) previousMonthRevenue = revenue;
        }

        // Tính monthlyGrowth
        double monthlyGrowth;
        if (previousMonthRevenue == 0) {
            if (currentMonthRevenue > 0) {
                monthlyGrowth = 100; // Tăng trưởng 100% nếu tháng trước không có doanh thu, tháng này có
            } else {
                monthlyGrowth = 0; // Cả hai tháng đều không có doanh thu
            }
        } else {
            monthlyGrowth = ((currentMonthRevenue - previousMonthRevenue) / previousMonthRevenue) * 100;
        }

        request.setAttribute("revenueByDate", revenueByDate);
        request.setAttribute("revenueByWeek", revenueByWeek);
        request.setAttribute("revenueByMonth", revenueByMonth);
        request.setAttribute("todayRevenue", todayRevenue);
        request.setAttribute("dailyGrowth", dailyGrowth);
        request.setAttribute("weeklyGrowth", weeklyGrowth);
        request.setAttribute("monthlyGrowth", monthlyGrowth);
        
        request.getRequestDispatcher("view/page/revenuestatistics.jsp").forward(request, response);
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
