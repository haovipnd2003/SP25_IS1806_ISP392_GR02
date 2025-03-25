/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.sql.Timestamp;

/**
 *
 * @author FPTSHOP
 */
public class Zone {

    private int id;
    private String name;
    private boolean isActive;
    private int productCount;
    private String description;
    private String createBy;
    private Timestamp createdAt;
    private Timestamp updateAt;
    private String deleteBy;
    private Timestamp deleteAt;

    public Zone() {
    }

    public Zone(int id, String name, boolean isActive) {
        this.id = id;
        this.name = name;
        this.isActive = isActive;
    }

    public Zone(int id, String name, boolean isActive, int productCount) {
        this.id = id;
        this.name = name;
        this.isActive = isActive;
        this.productCount = productCount;
    }

    public Zone(int id, String name, boolean isActive, String description) {
        this.id = id;
        this.name = name;
        this.isActive = isActive;
        this.description = description;
    }

    public Zone(int id, String name, boolean isActive, int productCount, String description) {
        this.id = id;
        this.name = name;
        this.isActive = isActive;
        this.productCount = productCount;
        this.description = description;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public int getProductCount() {
        return productCount;
    }

    public void setProductCount(int productCount) {
        this.productCount = productCount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(Timestamp updateAt) {
        this.updateAt = updateAt;
    }

    public String getDeleteBy() {
        return deleteBy;
    }

    public void setDeleteBy(String deleteBy) {
        this.deleteBy = deleteBy;
    }

    public Timestamp getDeleteAt() {
        return deleteAt;
    }

    public void setDeleteAt(Timestamp deleteAt) {
        this.deleteAt = deleteAt;
    }
}
