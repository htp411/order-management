package org.htp.order.biz;

import org.htp.order.entity.Purchase;

import java.util.List;

public interface PurchaseBiz {
    List<Purchase> getAll();
    List<Purchase> getBySku(String sku);
    void create(Purchase purchase);
    void update(Purchase purchase);

    void updateStatus(String id, String status);

    void storage(String id);

    int getTotal();
}
