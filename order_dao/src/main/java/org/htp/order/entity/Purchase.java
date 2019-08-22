package org.htp.order.entity;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class Purchase {
    private String id;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private Date createTime;
    private String status;
    private String linkSku;
    private Integer quantity;
    private String note;
    private Product product;

    @Override
    public String toString() {
        return "Purchase{" +
                "id='" + id + '\'' +
                ", createTime=" + createTime +
                ", status='" + status + '\'' +
                ", linkSku='" + linkSku + '\'' +
                ", quantity=" + quantity +
                ", note='" + note + '\'' +
                ", product=" + product +
                '}';
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getLinkSku() {
        return linkSku;
    }

    public void setLinkSku(String linkSku) {
        this.linkSku = linkSku;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

}
