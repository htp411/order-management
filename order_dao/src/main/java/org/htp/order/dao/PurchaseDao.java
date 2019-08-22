package org.htp.order.dao;

import org.apache.ibatis.annotations.Param;
import org.htp.order.entity.Purchase;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("purchaseDao")
public interface PurchaseDao {
    List<Purchase> selectAll();
    List<Purchase> selectBySku(String sku);
    void insert(Purchase purchase);
    void update(Purchase purchase);

    void updateStatus(@Param("id") String id, @Param("status") String status);

    Purchase selectById(String id);

    int getTotal();
}
