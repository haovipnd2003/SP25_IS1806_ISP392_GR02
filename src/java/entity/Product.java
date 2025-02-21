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
    private double quantity;
    private boolean isActive;

    public Product() {
    }


    public Product(String id, String name, String describe, double price, double quantity) {
        this.id = id;
        this.name = name;
        this.describe = describe;
        this.price = price;
        this.quantity = quantity;
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

    public double getQuantity() {
        return quantity;
    }

    public void setQuantity(double quantity) {
        this.quantity = quantity;
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
                + ", isActive=" + isActive
                + '}';
    }
}
