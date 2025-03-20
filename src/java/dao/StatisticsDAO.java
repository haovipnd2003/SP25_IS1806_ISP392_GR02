package dao;

import context.DBContext;
import entity.ProductPair;
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
            String sql = "SELECT p.id, p.name, SUM(CAST(oi.quantityInput AS DECIMAL)) as total_quantity, " +
                         "SUM(CAST(oi.amountMoney AS DECIMAL)) as total_revenue " +
                         "FROM orderitems oi " +
                         "JOIN product p ON oi.productid = p.id " +
                         "JOIN orders o ON oi.orderid = o.id " +
                         "WHERE o.isactive = 1 " +
                         "AND o.createdAt BETWEEN ? AND ? " +
                         "GROUP BY p.id, p.name " +
                         "ORDER BY total_quantity DESC " +
                         "LIMIT ?";
            
            stm = cnn.prepareStatement(sql);
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
     * Get top selling products by zone
     * 
     * @param limit Number of products to return per zone
     * @return List of ProductStatistics
     */
    public List<ProductStatistics> getTopSellingProductsByZone(int limit) {
        List<ProductStatistics> statistics = new ArrayList<>();
        
        try {
            String sql = "SELECT z.id as zone_id, z.name as zone_name, p.id as product_id, p.name as product_name, " +
                         "SUM(CAST(oi.quantityInput AS DECIMAL)) as total_quantity, " +
                         "SUM(CAST(oi.amountMoney AS DECIMAL)) as total_revenue " +
                         "FROM orderitems oi " +
                         "JOIN product p ON oi.productid = p.id " +
                         "JOIN orders o ON oi.orderid = o.id " +
                         "JOIN product_zone pz ON p.id = pz.product_id " +
                         "JOIN zone z ON pz.zone_id = z.id " +
                         "WHERE o.isactive = 1 " +
                         "GROUP BY z.id, z.name, p.id, p.name " +
                         "ORDER BY z.id, total_quantity DESC";
            
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            
            Map<String, Integer> zoneProductCount = new HashMap<>();
            
            while (rs.next()) {
                String zoneId = rs.getString("zone_id");
                
                // Check if we've already added the maximum number of products for this zone
                Integer count = zoneProductCount.getOrDefault(zoneId, 0);
                if (count < limit) {
                    ProductStatistics stat = new ProductStatistics(
                        rs.getString("product_id"),
                        rs.getString("product_name"),
                        rs.getInt("total_quantity"),
                        rs.getDouble("total_revenue"),
                        rs.getString("zone_id"),
                        rs.getString("zone_name")
                    );
                    statistics.add(stat);
                    zoneProductCount.put(zoneId, count + 1);
                }
            }
        } catch (SQLException e) {
            System.out.println("getTopSellingProductsByZone: " + e.getMessage());
        }
        
        return statistics;
    }
    
    /**
     * Get order statistics by hour of day
     * 
     * @return List of TimeStatistics
     */
    public List<TimeStatistics> getOrderStatisticsByHour() {
        List<TimeStatistics> statistics = new ArrayList<>();
        
        try {
            String sql = "SELECT HOUR(STR_TO_DATE(o.createdAt, '%Y-%m-%d %H:%i:%s')) as hour_of_day, " +
                         "COUNT(o.id) as order_count, " +
                         "SUM(CAST(o.totalAmount AS DECIMAL)) as total_revenue " +
                         "FROM orders o " +
                         "WHERE o.isactive = 1 " +
                         "GROUP BY hour_of_day " +
                         "ORDER BY hour_of_day";
            
            stm = cnn.prepareStatement(sql);
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
            String sql = "SELECT DAYOFWEEK(STR_TO_DATE(o.createdAt, '%Y-%m-%d %H:%i:%s')) as day_of_week, " +
                         "COUNT(o.id) as order_count, " +
                         "SUM(CAST(o.totalAmount AS DECIMAL)) as total_revenue " +
                         "FROM orders o " +
                         "WHERE o.isactive = 1 " +
                         "GROUP BY day_of_week " +
                         "ORDER BY day_of_week";
            
            stm = cnn.prepareStatement(sql);
            rs = stm.executeQuery();
            
            String[] dayNames = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
            
            while (rs.next()) {
                int dayIndex = rs.getInt("day_of_week") - 1; // MySQL DAYOFWEEK() returns 1 for Sunday
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
            String sql = "SELECT MONTH(STR_TO_DATE(o.createdAt, '%Y-%m-%d %H:%i:%s')) as month, " +
                         "COUNT(o.id) as order_count, " +
                         "SUM(CAST(o.totalAmount AS DECIMAL)) as total_revenue " +
                         "FROM orders o " +
                         "WHERE o.isactive = 1 " +
                         "GROUP BY month " +
                         "ORDER BY month";
            
            stm = cnn.prepareStatement(sql);
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
            closeResources();
        }
        
        return statistics;
    }
    
    /**
     * Get frequently bought together product pairs
     * 
     * @param limit Number of pairs to return
     * @return List of ProductPair
     */
    public List<ProductPair> getFrequentlyBoughtTogether(int limit) {
        List<ProductPair> pairs = new ArrayList<>();
        
        try {
            String sql = "SELECT p1.id as product1_id, p1.name as product1_name, " +
                         "p2.id as product2_id, p2.name as product2_name, " +
                         "COUNT(*) as frequency " +
                         "FROM orderitems oi1 " +
                         "JOIN orderitems oi2 ON oi1.orderid = oi2.orderid AND oi1.productid < oi2.productid " +
                         "JOIN product p1 ON oi1.productid = p1.id " +
                         "JOIN product p2 ON oi2.productid = p2.id " +
                         "JOIN orders o ON oi1.orderid = o.id " +
                         "WHERE o.isactive = 1 " +
                         "GROUP BY p1.id, p1.name, p2.id, p2.name " +
                         "ORDER BY frequency DESC " +
                         "LIMIT ?";
            
            stm = cnn.prepareStatement(sql);
            stm.setInt(1, limit);
            rs = stm.executeQuery();
            
            while (rs.next()) {
                ProductPair pair = new ProductPair(
                    rs.getString("product1_id"),
                    rs.getString("product1_name"),
                    rs.getString("product2_id"),
                    rs.getString("product2_name"),
                    rs.getInt("frequency")
                );
                pairs.add(pair);
            }
        } catch (SQLException e) {
            System.out.println("getFrequentlyBoughtTogether: " + e.getMessage());
        }
        
        return pairs;
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
            // Get sales for current week and previous week for comparison
            LocalDate today = LocalDate.now();
            LocalDate startOfCurrentWeek = today.with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY));
            LocalDate endOfCurrentWeek = today.with(TemporalAdjusters.nextOrSame(DayOfWeek.SUNDAY));
            LocalDate startOfPreviousWeek = startOfCurrentWeek.minusWeeks(1);
            LocalDate endOfPreviousWeek = endOfCurrentWeek.minusWeeks(1);
            
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            
            String sql = "SELECT p.id, p.name, " +
                         "SUM(CASE WHEN o.createdAt BETWEEN ? AND ? THEN CAST(oi.quantityInput AS DECIMAL) ELSE 0 END) as current_week_sales, " +
                         "SUM(CASE WHEN o.createdAt BETWEEN ? AND ? THEN CAST(oi.quantityInput AS DECIMAL) ELSE 0 END) as previous_week_sales " +
                         "FROM product p " +
                         "LEFT JOIN orderitems oi ON p.id = oi.productid " +
                         "LEFT JOIN orders o ON oi.orderid = o.id AND o.isactive = 1 " +
                         "GROUP BY p.id, p.name " +
                         "HAVING current_week_sales > 0 OR previous_week_sales > 0 " +
                         "ORDER BY (current_week_sales - previous_week_sales) DESC " +
                         "LIMIT ?";
            
            stm = cnn.prepareStatement(sql);
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
                    (int)currentWeekSales,
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
    
    public static void main(String[] args) {
        StatisticsDAO dao = new StatisticsDAO();
        
        // Test getTopSellingProductsThisWeek
        System.out.println("Top selling products this week:");
        List<ProductStatistics> weeklyStats = dao.getTopSellingProductsThisWeek(5);
        for (ProductStatistics stat : weeklyStats) {
            System.out.println(stat);
        }
        
        // Test getOrderStatisticsByHour
        System.out.println("\nOrder statistics by hour:");
        List<TimeStatistics> hourlyStats = dao.getOrderStatisticsByHour();
        for (TimeStatistics stat : hourlyStats) {
            System.out.println(stat);
        }
        
        // Test getFrequentlyBoughtTogether
        System.out.println("\nFrequently bought together:");
        List<ProductPair> pairs = dao.getFrequentlyBoughtTogether(5);
        for (ProductPair pair : pairs) {
            System.out.println(pair);
        }
    }
} 