package org.htp.order.entity;


import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.Date;

public class Orders {
    private String id;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private Date createTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private Date deliveryTime;
    private String channel;
    private String trackingNumber;
    private String orderStatus;
    private String productName;
    private String productOnlineSku;
    private String productLinkSku;
    private BigDecimal productPrice;
    private Integer productQuantity;
    private String productImageUrl;
    private String username;
    private String tel;
    private String country;
    private String state;
    private String city;
    private String address;
    private String zipCode;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getDeliveryTime() {
        return deliveryTime;
    }

    public void setDeliveryTime(Date deliveryTime) {
        this.deliveryTime = deliveryTime;
    }

    public String getChannel() {
        return channel;
    }

    public void setChannel(String channel) {
        this.channel = channel;
    }

    public String getTrackingNumber() {
        return trackingNumber;
    }

    public void setTrackingNumber(String trackingNumber) {
        this.trackingNumber = trackingNumber;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductOnlineSku() {
        return productOnlineSku;
    }

    public void setProductOnlineSku(String productOnlineSku) {
        this.productOnlineSku = productOnlineSku;
    }

    public String getProductLinkSku() {
        return productLinkSku;
    }

    public void setProductLinkSku(String productLinkSku) {
        this.productLinkSku = productLinkSku;
    }

    public BigDecimal getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(BigDecimal productPrice) {
        this.productPrice = productPrice;
    }

    public Integer getProductQuantity() {
        return productQuantity;
    }

    public void setProductQuantity(Integer productQuantity) {
        this.productQuantity = productQuantity;
    }

    public String getProductImageUrl() {
        return productImageUrl;
    }

    public void setProductImageUrl(String productImageUrl) {
        this.productImageUrl = productImageUrl;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }
    public Orders(){}

    public Orders(String id, Date createTime, Date deliveryTime, String channel, String trackingNumber, String orderStatus, String productName, String productOnlineSku, String productLinkSku, BigDecimal productPrice, Integer productQuantity, String productImageUrl, String username, String tel, String country, String state, String city, String address, String zipCode) {
        this.id = id;
        this.createTime = createTime;
        this.deliveryTime = deliveryTime;
        this.channel = channel;
        this.trackingNumber = trackingNumber;
        this.orderStatus = orderStatus;
        this.productName = productName;
        this.productOnlineSku = productOnlineSku;
        this.productLinkSku = productLinkSku;
        this.productPrice = productPrice;
        this.productQuantity = productQuantity;
        this.productImageUrl = productImageUrl;
        this.username = username;
        this.tel = tel;
        this.country = country;
        this.state = state;
        this.city = city;
        this.address = address;
        this.zipCode = zipCode;
    }

    @Override
    public String toString() {
        return "Orders{" +
                "id='" + id + '\'' +
                ", createTime=" + createTime +
                ", deliveryTime=" + deliveryTime +
                ", channel='" + channel + '\'' +
                ", trackingNumber='" + trackingNumber + '\'' +
                ", orderStatus='" + orderStatus + '\'' +
                ", productName='" + productName + '\'' +
                ", productOnlineSku='" + productOnlineSku + '\'' +
                ", productLinkSku='" + productLinkSku + '\'' +
                ", productPrice=" + productPrice +
                ", productQuantity=" + productQuantity +
                ", productImageUrl='" + productImageUrl + '\'' +
                ", username='" + username + '\'' +
                ", tel='" + tel + '\'' +
                ", country='" + country + '\'' +
                ", state='" + state + '\'' +
                ", city='" + city + '\'' +
                ", address='" + address + '\'' +
                ", zipCode='" + zipCode + '\'' +
                '}'+"\n\n\n\n\n";
    }
}
