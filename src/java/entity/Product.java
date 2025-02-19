package entity;

/**
 * Class representing a product entity.
 */
public class Product {
    private String id;
    private String name;
    private String describe;
    private double price;
    private String zone;
    private int quantity;
    private String zoneId;
    private boolean isActive;

    public Product(String id, String name, String describe, double price, String zone, int quantity, String zoneId, boolean isActive) {
        this.id = id;
        this.name = name;
        this.describe = describe;
        this.price = price;
        this.zone = zone;
        this.quantity = quantity;
        this.zoneId = zoneId;
        this.isActive = isActive;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getZone() {
        return zone;
    }

    public void setZone(String zone) {
        this.zone = zone;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getZoneId() {
        return zoneId;
    }

    public void setZoneId(String zoneId) {
        this.zoneId = zoneId;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    @Override
    public String toString() {
        return "Product{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", describe='" + describe + '\'' +
                ", price=" + price +
                ", zone='" + zone + '\'' +
                ", quantity=" + quantity +
                ", zoneId='" + zoneId + '\'' +
                ", isActive=" + isActive +
                '}';
    }
}
