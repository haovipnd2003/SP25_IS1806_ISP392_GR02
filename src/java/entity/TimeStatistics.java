package entity;

/**
 * Entity class for time-based order statistics
 */
public class TimeStatistics {
    private String timeSlot;
    private int orderCount;
    private double totalRevenue;
    
    public TimeStatistics() {
    }
    
    public TimeStatistics(String timeSlot, int orderCount, double totalRevenue) {
        this.timeSlot = timeSlot;
        this.orderCount = orderCount;
        this.totalRevenue = totalRevenue;
    }

    public String getTimeSlot() {
        return timeSlot;
    }

    public void setTimeSlot(String timeSlot) {
        this.timeSlot = timeSlot;
    }

    public int getOrderCount() {
        return orderCount;
    }

    public void setOrderCount(int orderCount) {
        this.orderCount = orderCount;
    }

    public double getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(double totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    @Override
    public String toString() {
        return "TimeStatistics{" + "timeSlot=" + timeSlot + ", orderCount=" + orderCount + 
                ", totalRevenue=" + totalRevenue + '}';
    }
} 