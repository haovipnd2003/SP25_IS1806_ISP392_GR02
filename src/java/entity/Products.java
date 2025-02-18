package entity;

/**
 * Class representing a product entity.
 */
public class Products {

    private String id;
    private String name;
    private String describe;
    private double price;
    private int quantity;
    private String zoneId;
    private boolean isActive;

    public Products(String id, String name, String describe, double price, int quantity, String zoneId, boolean isActive) {
        this.id = id;
        this.name = name;
        this.describe = describe;
        this.price = price;
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
        return "Product{"
                + "id='" + id + '\''
                + ", name='" + name + '\''
                + ", describe='" + describe + '\''
                + ", price=" + price
                + ", quantity=" + quantity
                + ", zoneId='" + zoneId + '\''
                + ", isActive=" + isActive
                + '}';
    }
}
