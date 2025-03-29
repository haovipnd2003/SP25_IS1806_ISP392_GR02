package control.Admin;

import dao.StatisticsDAO;
import entity.ProductStatistics;
import entity.TimeStatistics;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Controller for statistics dashboard
 */
@WebServlet(name = "StatisticsController", urlPatterns = {"/statistics"})
public class StatisticsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null || action.isEmpty()) {
            action = "dashboard"; // Default action
        }
        
        switch (action) {
            case "dashboard":
                showDashboard(request, response);
                break;
            case "top-products":
                showTopProducts(request, response);
                break;
            case "time-analysis":
                showTimeAnalysis(request, response);
                break;
            case "trends":
                showTrends(request, response);
                break;
            default:
                showDashboard(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null || action.isEmpty()) {
            action = "dashboard"; // Default action
        }
        
        switch (action) {
//            case "custom-date-range":
//                handleCustomDateRange(request, response);
//                break;
            default:
                doGet(request, response);
                break;
        }
    }
    
    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        StatisticsDAO dao = new StatisticsDAO();
        
        // Get top selling products for this week
        List<ProductStatistics> topWeeklyProducts = dao.getTopSellingProductsThisWeek(5);
        request.setAttribute("topWeeklyProducts", topWeeklyProducts);
        
        // Get top selling products for this month
        List<ProductStatistics> topMonthlyProducts = dao.getTopSellingProductsThisMonth(5);
        request.setAttribute("topMonthlyProducts", topMonthlyProducts);
        
        // Get order statistics by day of week
        List<TimeStatistics> dailyStats = dao.getOrderStatisticsByDayOfWeek();
        request.setAttribute("dailyStats", dailyStats);
        
        // Get trending products
        List<ProductStatistics> trendingProducts = dao.getTrendingProducts(5);
        request.setAttribute("trendingProducts", trendingProducts);
        
        // Set current date for reference
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        request.setAttribute("currentDate", today.format(formatter));
        
        // Thêm attribute mới cho đơn vị
        request.setAttribute("unit", "kg");
        
        // Forward to dashboard JSP
        request.getRequestDispatcher("/view/admin/statistics-dashboard.jsp").forward(request, response);
    }
    
    private void showTopProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        StatisticsDAO dao = new StatisticsDAO();
        
        // Get top selling products for this week
        List<ProductStatistics> topWeeklyProducts = dao.getTopSellingProductsThisWeek(10);
        request.setAttribute("topWeeklyProducts", topWeeklyProducts);
        
        // Get top selling products for this month
        List<ProductStatistics> topMonthlyProducts = dao.getTopSellingProductsThisMonth(10);
        request.setAttribute("topMonthlyProducts", topMonthlyProducts);
        
        // Set current date for reference
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        request.setAttribute("currentDate", today.format(formatter));
        
        // Thêm attribute mới cho đơn vị
        request.setAttribute("unit", "kg");
        
        // Forward to top products JSP
        request.getRequestDispatcher("/view/admin/statistics-top-products.jsp").forward(request, response);
    }
    
    private void showTimeAnalysis(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        StatisticsDAO dao = new StatisticsDAO();
        
        // Get order statistics by day of week
        List<TimeStatistics> dailyStats = dao.getOrderStatisticsByDayOfWeek();
        request.setAttribute("dailyStats", dailyStats);
        
        // Get order statistics by month
        List<TimeStatistics> monthlyStats = dao.getOrderStatisticsByMonth();
        request.setAttribute("monthlyStats", monthlyStats);
        
        // Thêm attribute mới cho đơn vị
        request.setAttribute("unit", "kg");
        
        // Forward to time analysis JSP
        request.getRequestDispatcher("/view/admin/statistics-time-analysis.jsp").forward(request, response);
    }
    
    private void showTrends(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        StatisticsDAO dao = new StatisticsDAO();
        
        // Get trending products
        List<ProductStatistics> trendingProducts = dao.getTrendingProducts(10);
        request.setAttribute("trendingProducts", trendingProducts);
        
        // Forward to trends JSP
        request.getRequestDispatcher("/view/admin/statistics-trends.jsp").forward(request, response);
    }
    
} 