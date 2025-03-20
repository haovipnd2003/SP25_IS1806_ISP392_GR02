package entity;

/**
 * Entity class for product statistics
 */
public class ProductStatistics {

    private String productId;
    private String productName;
    private int salesCount;
    private int totalQuantity;
    private double totalRevenue;
    private String timeFrame;
    private String zoneId;
    private String zoneName;

    public ProductStatistics() {
    }

    public ProductStatistics(String productId, String productName, int salesCount, double totalRevenue) {
        this.productId = productId;
        this.productName = productName;
        this.salesCount = salesCount;
        this.totalRevenue = totalRevenue;
    }

    public ProductStatistics(String productId, String productName, int salesCount, double totalRevenue, String timeFrame) {
        this.productId = productId;
        this.productName = productName;
        this.salesCount = salesCount;
        this.totalRevenue = totalRevenue;
        this.timeFrame = timeFrame;
    }

    public ProductStatistics(String productId, String productName, int salesCount, double totalRevenue, String zoneId, String zoneName) {
        this.productId = productId;
        this.productName = productName;
        this.salesCount = salesCount;
        this.totalRevenue = totalRevenue;
        this.zoneId = zoneId;
        this.zoneName = zoneName;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getSalesCount() {
        return salesCount;
    }

    public void setSalesCount(int salesCount) {
        this.salesCount = salesCount;
    }

    public double getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(double totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    public String getTimeFrame() {
        return timeFrame;
    }

    public void setTimeFrame(String timeFrame) {
        this.timeFrame = timeFrame;
    }

    public String getZoneId() {
        return zoneId;
    }

    public void setZoneId(String zoneId) {
        this.zoneId = zoneId;
    }

    public String getZoneName() {
        return zoneName;
    }

    public void setZoneName(String zoneName) {
        this.zoneName = zoneName;
    }

    public int getTotalQuantity() {
        return totalQuantity;
    }

    public void setTotalQuantity(int totalQuantity) {
        this.totalQuantity = totalQuantity;
    }

    @Override
    public String toString() {
        return "ProductStatistics{" + "productId=" + productId + ", productName=" + productName
                + ", salesCount=" + salesCount + ", totalRevenue=" + totalRevenue
                + ", timeFrame=" + timeFrame + ", zoneId=" + zoneId + ", zoneName=" + zoneName + '}';
    }
}
