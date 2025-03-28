package entity;

import java.sql.Date;

public class StockAudit {
    private Integer id;
    private Date auditDate;
    private String zoneId;
    private String staffId;
    private String productId;
    private Double expectedQuantity;
    private Double actualQuantity;
    private Double difference;
    private String note;
    private Date createdAt;
    
    // Các trường bổ sung để hiển thị thông tin
    private String zoneName;
    private String staffName;
    private String productName;

    public StockAudit() {
    }

    public StockAudit(Integer id, Date auditDate, String zoneId, String staffId, String productId, 
            Double expectedQuantity, Double actualQuantity, Double difference, String note, Date createdAt) {
        this.id = id;
        this.auditDate = auditDate;
        this.zoneId = zoneId;
        this.staffId = staffId;
        this.productId = productId;
        this.expectedQuantity = expectedQuantity;
        this.actualQuantity = actualQuantity;
        this.difference = difference;
        this.note = note;
        this.createdAt = createdAt;
    }

    public StockAudit(Integer id, Date auditDate, String zoneId, String staffId, String productId, 
            Double expectedQuantity, Double actualQuantity, Double difference, String note, Date createdAt,
            String zoneName, String staffName, String productName) {
        this.id = id;
        this.auditDate = auditDate;
        this.zoneId = zoneId;
        this.staffId = staffId;
        this.productId = productId;
        this.expectedQuantity = expectedQuantity;
        this.actualQuantity = actualQuantity;
        this.difference = difference;
        this.note = note;
        this.createdAt = createdAt;
        this.zoneName = zoneName;
        this.staffName = staffName;
        this.productName = productName;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getAuditDate() {
        return auditDate;
    }

    public void setAuditDate(Date auditDate) {
        this.auditDate = auditDate;
    }

    public String getZoneId() {
        return zoneId;
    }

    public void setZoneId(String zoneId) {
        this.zoneId = zoneId;
    }

    public String getStaffId() {
        return staffId;
    }

    public void setStaffId(String staffId) {
        this.staffId = staffId;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public Double getExpectedQuantity() {
        return expectedQuantity;
    }

    public void setExpectedQuantity(Double expectedQuantity) {
        this.expectedQuantity = expectedQuantity;
    }

    public Double getActualQuantity() {
        return actualQuantity;
    }

    public void setActualQuantity(Double actualQuantity) {
        this.actualQuantity = actualQuantity;
    }

    public Double getDifference() {
        return difference;
    }

    public void setDifference(Double difference) {
        this.difference = difference;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public String getZoneName() {
        return zoneName;
    }

    public void setZoneName(String zoneName) {
        this.zoneName = zoneName;
    }

    public String getStaffName() {
        return staffName;
    }

    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    @Override
    public String toString() {
        return "StockAudit{" + "id=" + id + ", auditDate=" + auditDate + ", zoneId=" + zoneId + 
                ", staffId=" + staffId + ", productId=" + productId + ", expectedQuantity=" + expectedQuantity + 
                ", actualQuantity=" + actualQuantity + ", difference=" + difference + ", note=" + note + 
                ", createdAt=" + createdAt + ", zoneName=" + zoneName + ", staffName=" + staffName + 
                ", productName=" + productName + '}';
    }
} 