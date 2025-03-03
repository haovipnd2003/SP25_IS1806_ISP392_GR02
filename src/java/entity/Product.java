package entity;

import java.util.List;

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
    private String image;
    private String[] zoneIds;

    public Product() {
    }

    public Product(String id, String name, String describe, double price, double quantity) {
        this.id = id;
        this.name = name;
        this.describe = describe;
        this.price = price;
        this.quantity = quantity;
    }

    public Product(String id, String name, String describe, double price, double quantity, boolean isActive, String image) {
        this.id = id;
        this.name = name;
        this.describe = describe;
        this.price = price;
        this.quantity = quantity;
        this.isActive = isActive;
        this.image = image;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
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

    public String[] getZoneIds() {
        return zoneIds;
    }

    public void setZoneIds(String[] zoneIds) {
        this.zoneIds = zoneIds;
    }

    public String getZoneNames(List<Zone> allZones) {
        if (zoneIds == null || zoneIds.length == 0) {
            return "";
        }
        
        StringBuilder zoneNames = new StringBuilder();
        for (int i = 0; i < zoneIds.length; i++) {
            String zoneId = zoneIds[i];
            for (Zone zone : allZones) {
                if (zone.getId().equals(zoneId)) {
                    if (zoneNames.length() > 0) {
                        zoneNames.append(", ");
                    }
                    zoneNames.append(zone.getName());
                    break;
                }
            }
        }
        return zoneNames.toString();
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
