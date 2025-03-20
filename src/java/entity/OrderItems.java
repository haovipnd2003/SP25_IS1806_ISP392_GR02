/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author binh2
 */
public class OrderItems {

    String id, orderId, productId, productName, price1kg,
            describe, quantityInput, packaging, discount, amountMoney;

    public OrderItems(String id, String orderId, String productId, String productName, String price1kg, String describe, String quantityInput, String packaging, String discount, String amountMoney) {
        this.id = id;
        this.orderId = orderId;
        this.productId = productId;
        this.productName = productName;
        this.price1kg = price1kg;
        this.describe = describe;
        this.quantityInput = quantityInput;
        this.packaging = packaging;
        this.discount = discount;
        this.amountMoney = amountMoney;
    }

    public OrderItems() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
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

    public String getPrice1kg() {
        return price1kg;
    }

    public void setPrice1kg(String price1kg) {
        this.price1kg = price1kg;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }

    public String getQuantityInput() {
        return quantityInput;
    }

    public void setQuantityInput(String quantityInput) {
        this.quantityInput = quantityInput;
    }

    public String getPackaging() {
        return packaging;
    }

    public void setPackaging(String packaging) {
        this.packaging = packaging;
    }

    public String getDiscount() {
        return discount;
    }

    public void setDiscount(String discount) {
        this.discount = discount;
    }

    public String getAmountMoney() {
        return amountMoney;
    }

    public void setAmountMoney(String amountMoney) {
        this.amountMoney = amountMoney;
    }

    @Override
    public String toString() {
        return "OrderItems{" + "id=" + id + ", orderId=" + orderId + ", productId=" + productId + ", productName=" + productName + ", price1kg=" + price1kg + ", describe=" + describe + ", quantityInput=" + quantityInput + ", packaging=" + packaging + ", discount=" + discount + ", amountMoney=" + amountMoney + '}';
    }

}
