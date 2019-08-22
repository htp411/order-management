package org.htp.order.entity;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class Inventory {
    private String linkSku;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private Date updateTime;
    private Integer stock;
    private Integer weekSale;
    private Integer monthSale;
    private Product product;

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public String getLinkSku() {
        return linkSku;
    }

    public void setLinkSku(String linkSku) {
        this.linkSku = linkSku;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public Integer getStock() {
        return stock;
    }

    public void setStock(Integer stock) {
        this.stock = stock;
    }

    public Integer getWeekSale() {
        return weekSale;
    }

    public void setWeekSale(Integer weekSale) {
        this.weekSale = weekSale;
    }

    public Integer getMonthSale() {
        return monthSale;
    }

    public void setMonthSale(Integer monthSale) {
        this.monthSale = monthSale;
    }
    public Inventory(){}
    public Inventory(String linkSku, Date updateTime, Integer stock, Integer weekSale, Integer monthSale, Product product) {
        this.linkSku = linkSku;
        this.updateTime = updateTime;
        this.stock = stock;
        this.weekSale = weekSale;
        this.monthSale = monthSale;
        this.product = product;
    }
}
