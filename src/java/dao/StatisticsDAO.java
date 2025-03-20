package dao;

import context.DBContext;
import entity.ProductStatistics;
import entity.TimeStatistics;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Data Access Object for statistics
 */
public class StatisticsDAO extends DBContext {

    private Connection cnn;
    private PreparedStatement stm;
    private ResultSet rs;

    public StatisticsDAO() {
        connectDB();
    }

    private void connectDB() {
        cnn = connection;
        if (cnn != null) {
            System.out.println("StatisticsDAO: Connect Success");
        } else {
            System.out.println("StatisticsDAO: Connect Fail");
        }
    }

    /**
     * Get top selling products for a specific time period
     *
     * @param limit Number of products to return
     * @param startDate Start date in format YYYY-MM-DD
     * @param endDate End date in format YYYY-MM-DD
     * @return List of ProductStatistics
     */
    public List<ProductStatistics> getTopSellingProducts(int limit, String startDate, String endDate) {
        List<ProductStatistics> statistics = new ArrayList<>();

        try {
            connection = getConnection();
            String sql = "SELECT p.id, p.name, "
                    + "SUM(oi.quantityInput * CAST(REPLACE(oi.packaging, 'kg', '') AS DECIMAL(10,2))) as total_quantity, "
                    + "SUM(oi.amountMoney) as total_revenue "
                    + "FROM orderitems oi "
                    + "JOIN product p ON oi.productid = p.id "
                    + "JOIN orders o ON oi.orderid = o.id "
                    + "WHERE o.isactive = 1 "
                    + "AND o.createdAt BETWEEN ? AND ? "
                    + "GROUP BY p.id, p.name "
                    + "ORDER BY total_quantity DESC "
                    + "LIMIT ?";

            stm = connection.prepareStatement(sql);
            stm.setString(1, startDate);
            stm.setString(2, endDate);
            stm.setInt(3, limit);

            rs = stm.executeQuery();

            while (rs.next()) {
                ProductStatistics stat = new ProductStatistics(
                        rs.getString("id"),
                        rs.getString("name"),
                        rs.getInt("total_quantity"),
                        rs.getDouble("total_revenue")
                );
                statistics.add(stat);
            }
        } catch (SQLException e) {
            System.out.println("getTopSellingProducts: " + e.getMessage());
        } finally {
            closeResources();
        }

        return statistics;
    }

    /**
     * Get top selling products for the current week
     *
     * @param limit Number of products to return
     * @return List of ProductStatistics
     */
    public List<ProductStatistics> getTopSellingProductsThisWeek(int limit) {
        // Calculate current week's start (Monday) and end (Sunday)
        LocalDate today = LocalDate.now();
        LocalDate startOfWeek = today.with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY));
        LocalDate endOfWeek = today.with(TemporalAdjusters.nextOrSame(DayOfWeek.SUNDAY));

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String startDate = startOfWeek.format(formatter);
        String endDate = endOfWeek.format(formatter);

        List<ProductStatistics> stats = getTopSellingProducts(limit, startDate, endDate);
        for (ProductStatistics stat : stats) {
            stat.setTimeFrame("This Week");
        }

        return stats;
    }

    /**
     * Get top selling products for the current month
     *
     * @param limit Number of products to return
     * @return List of ProductStatistics
     */
    public List<ProductStatistics> getTopSellingProductsThisMonth(int limit) {
        // Calculate current month's start and end
        LocalDate today = LocalDate.now();
        LocalDate startOfMonth = today.withDayOfMonth(1);
        LocalDate endOfMonth = today.withDayOfMonth(today.lengthOfMonth());

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String startDate = startOfMonth.format(formatter);
        String endDate = endOfMonth.format(formatter);

        List<ProductStatistics> stats = getTopSellingProducts(limit, startDate, endDate);
        for (ProductStatistics stat : stats) {
            stat.setTimeFrame("This Month");
        }

        return stats;
    }

    /**
     * Get order statistics by hour of day
     *
     * @return List of TimeStatistics
     */
    public List<TimeStatistics> getOrderStatisticsByHour() {
        List<TimeStatistics> statistics = new ArrayList<>();

        try {
            connection = getConnection();
            String sql = "SELECT HOUR(STR_TO_DATE(o.createdAt, '%Y-%m-%d %H:%i:%s')) as hour_of_day, "
                    + "COUNT(o.id) as order_count, "
                    + "SUM(CAST(o.totalAmount AS DECIMAL)) as total_revenue "
                    + "FROM orders o "
                    + "WHERE o.isactive = 1 "
                    + "GROUP BY hour_of_day "
                    + "ORDER BY hour_of_day";

            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();

            while (rs.next()) {
                int hour = rs.getInt("hour_of_day");
                String timeSlot = String.format("%02d:00 - %02d:00", hour, (hour + 1) % 24);

                TimeStatistics stat = new TimeStatistics(
                        timeSlot,
                        rs.getInt("order_count"),
                        rs.getDouble("total_revenue")
                );
                statistics.add(stat);
            }
        } catch (SQLException e) {
            System.out.println("getOrderStatisticsByHour: " + e.getMessage());
        }

        return statistics;
    }

    /**
     * Get order statistics by day of week
     *
     * @return List of TimeStatistics
     */
    public List<TimeStatistics> getOrderStatisticsByDayOfWeek() {
        List<TimeStatistics> statistics = new ArrayList<>();

        try {
            // Sử dụng kết nối từ DBContext
            connection = getConnection();

            String sql = "SELECT DAYOFWEEK(o.createdAt) as day_of_week, "
                    + "COUNT(o.id) as order_count, "
                    + "SUM(o.totalAmount) as total_revenue "
                    + "FROM orders o "
                    + "WHERE o.isactive = 1 "
                    + "GROUP BY day_of_week "
                    + "ORDER BY day_of_week";

            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();

            String[] dayNames = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};

            while (rs.next()) {
                int dayIndex = rs.getInt("day_of_week") - 1;
                String dayName = dayNames[dayIndex];

                TimeStatistics stat = new TimeStatistics(
                        dayName,
                        rs.getInt("order_count"),
                        rs.getDouble("total_revenue")
                );
                statistics.add(stat);
            }
        } catch (SQLException e) {
            System.out.println("getOrderStatisticsByDayOfWeek: " + e.getMessage());
        } finally {
            // Đóng kết nối
            closeResources();
        }

        return statistics;
    }

    /**
     * Get order statistics by month
     *
     * @return List of TimeStatistics
     */
    public List<TimeStatistics> getOrderStatisticsByMonth() {
        List<TimeStatistics> statistics = new ArrayList<>();

        try {
            // Sử dụng kết nối từ DBContext
            connection = getConnection();

            String sql = "SELECT MONTH(STR_TO_DATE(o.createdAt, '%Y-%m-%d %H:%i:%s')) as month, "
                    + "COUNT(o.id) as order_count, "
                    + "SUM(CAST(o.totalAmount AS DECIMAL)) as total_revenue "
                    + "FROM orders o "
                    + "WHERE o.isactive = 1 "
                    + "GROUP BY month "
                    + "ORDER BY month";

            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();

            String[] monthNames = {"January", "February", "March", "April", "May", "June",
                "July", "August", "September", "October", "November", "December"};

            while (rs.next()) {
                int monthIndex = rs.getInt("month") - 1;
                String monthName = monthNames[monthIndex];

                TimeStatistics stat = new TimeStatistics(
                        monthName,
                        rs.getInt("order_count"),
                        rs.getDouble("total_revenue")
                );
                statistics.add(stat);
            }
        } catch (SQLException e) {
            System.out.println("getOrderStatisticsByMonth: " + e.getMessage());
        } finally {
            // Đóng kết nối
            closeResources();
        }

        return statistics;
    }

    /**
     * Get trending products (products with significant sales increase)
     *
     * @param limit Number of products to return
     * @return List of ProductStatistics with growth percentage
     */
    public List<ProductStatistics> getTrendingProducts(int limit) {
        List<ProductStatistics> trending = new ArrayList<>();

        try {
            connection = getConnection();
            // Get sales for current week and previous week for comparison
            LocalDate today = LocalDate.now();
            LocalDate startOfCurrentWeek = today.with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY));
            LocalDate endOfCurrentWeek = today.with(TemporalAdjusters.nextOrSame(DayOfWeek.SUNDAY));
            LocalDate startOfPreviousWeek = startOfCurrentWeek.minusWeeks(1);
            LocalDate endOfPreviousWeek = endOfCurrentWeek.minusWeeks(1);

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

            String sql = "SELECT p.id, p.name, "
                    + "SUM(CASE WHEN o.createdAt BETWEEN ? AND ? THEN oi.quantityInput * CAST(REPLACE(oi.packaging, 'kg', '') AS DECIMAL(10,2)) ELSE 0 END) as current_week_sales, "
                    + "SUM(CASE WHEN o.createdAt BETWEEN ? AND ? THEN oi.quantityInput * CAST(REPLACE(oi.packaging, 'kg', '') AS DECIMAL(10,2)) ELSE 0 END) as previous_week_sales "
                    + "FROM product p "
                    + "LEFT JOIN orderitems oi ON p.id = oi.productid "
                    + "LEFT JOIN orders o ON oi.orderid = o.id AND o.isactive = 1 "
                    + "GROUP BY p.id, p.name "
                    + "HAVING current_week_sales > 0 OR previous_week_sales > 0 "
                    + "ORDER BY (current_week_sales - previous_week_sales) DESC "
                    + "LIMIT ?";

            stm = connection.prepareStatement(sql);
            stm.setString(1, startOfCurrentWeek.format(formatter));
            stm.setString(2, endOfCurrentWeek.format(formatter));
            stm.setString(3, startOfPreviousWeek.format(formatter));
            stm.setString(4, endOfPreviousWeek.format(formatter));
            stm.setInt(5, limit);

            rs = stm.executeQuery();

            while (rs.next()) {
                double currentWeekSales = rs.getDouble("current_week_sales");
                double previousWeekSales = rs.getDouble("previous_week_sales");

                // Calculate growth percentage
                double growthPercentage = 0;
                if (previousWeekSales > 0) {
                    growthPercentage = ((currentWeekSales - previousWeekSales) / previousWeekSales) * 100;
                } else if (currentWeekSales > 0) {
                    growthPercentage = 100; // If no previous sales, consider it 100% growth
                }

                ProductStatistics stat = new ProductStatistics(
                        rs.getString("id"),
                        rs.getString("name"),
                        (int) currentWeekSales,
                        growthPercentage
                );

                trending.add(stat);
            }
        } catch (SQLException e) {
            System.out.println("getTrendingProducts: " + e.getMessage());
        }

        return trending;
    }

    private void closeResources() {
        try {
            if (rs != null && !rs.isClosed()) {
                rs.close();
            }
            if (stm != null && !stm.isClosed()) {
                stm.close();
            }
            if (cnn != null && !cnn.isClosed()) {
                cnn.close();
            }
        } catch (SQLException e) {
            System.out.println("Error closing resources: " + e.getMessage());
        }
    }

    /**
     * Main method for testing getTopSellingProducts
     */
    public static void main(String[] args) {
        // Create instance of StatisticsDAO
        StatisticsDAO statisticsDAO = new StatisticsDAO();

        // Define date range for testing
        String startDate = "2025-03-01";
        String endDate = "2025-03-31";
        int limit = 5;

        // Test getTopSellingProducts with custom date range
        List<ProductStatistics> topProducts = statisticsDAO.getTopSellingProducts(limit, startDate, endDate);

        // Print results
        System.out.println("Top selling products from " + startDate + " to " + endDate + ":");
        System.out.println("--------------------------------");
        for (ProductStatistics product : topProducts) {
            System.out.println("Product ID: " + product.getProductId());
            System.out.println("Product Name: " + product.getProductName());
            System.out.println("Total Quantity: " + product.getTotalQuantity());
            System.out.println("Total Revenue: " + product.getTotalRevenue());
            System.out.println("--------------------------------");
        }

        // Test getOrderStatisticsByDayOfWeek
        List<TimeStatistics> dailyStats = statisticsDAO.getOrderStatisticsByDayOfWeek();

        // Print results
        System.out.println("Order Statistics by Day of Week:");
        System.out.println("--------------------------------");
        for (TimeStatistics stat : dailyStats) {
            System.out.println("Day: " + stat.getTimeSlot());
            System.out.println("Order Count: " + stat.getOrderCount());
            System.out.println("Total Revenue: " + stat.getTotalRevenue());
            System.out.println("--------------------------------");
        }

        // Test getOrderStatisticsByMonth
        List<TimeStatistics> monthlyStats = statisticsDAO.getOrderStatisticsByMonth();

        // Print results
        System.out.println("Order Statistics by Month:");
        System.out.println("--------------------------------");
        for (TimeStatistics stat : monthlyStats) {
            System.out.println("Month: " + stat.getTimeSlot());
            System.out.println("Order Count: " + stat.getOrderCount());
            System.out.println("Total Revenue: " + stat.getTotalRevenue());
            System.out.println("--------------------------------");
        }
    }

}
