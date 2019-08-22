package org.htp.order.biz.impl;

import org.htp.order.biz.PurchaseBiz;
import org.htp.order.dao.InventoryDao;
import org.htp.order.dao.PurchaseDao;
import org.htp.order.entity.Inventory;
import org.htp.order.entity.Purchase;
import org.htp.order.global.Constant;
import org.htp.order.utils.Utils;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import static org.htp.order.global.Constant.PURCHASE_STATUS_CREATED;

@Service("purchaseBiz")
public class PurchaseBizImpl implements PurchaseBiz {
    private final PurchaseDao purchaseDao;
    private final InventoryDao inventoryDao;


    public PurchaseBizImpl(@Qualifier("purchaseDao") PurchaseDao purchaseDao, @Qualifier("inventoryDao") InventoryDao inventoryDao) {
        this.purchaseDao = purchaseDao;
        this.inventoryDao = inventoryDao;
    }

    public List<Purchase> getAll() {
        return purchaseDao.selectAll();
    }

    public List<Purchase> getBySku(String sku) {
        return purchaseDao.selectBySku(sku);
    }

    public void create(Purchase purchase) {
        purchase.setId("PO"+Utils.parseDate(new Date(),"yyyyMMddHHmm"));
        purchase.setCreateTime(new Date());
        purchase.setStatus(PURCHASE_STATUS_CREATED);
        purchaseDao.insert(purchase);
    }

    public void update(Purchase purchase) {
        purchaseDao.update(purchase);
    }

    public void updateStatus(String id, String status) {
        purchaseDao.updateStatus(id,status);
    }

    public void storage(String id) {
        purchaseDao.updateStatus(id, Constant.PURCHASE_STATUS_WAREHOUSING);
        Purchase purchase = purchaseDao.selectById(id);
        List<Inventory> inventoryList = inventoryDao.selectAll();
        for(Inventory item:inventoryList){
            //采购商品在库存表中有记录，采购到货后，库存数等于当前库存加上采购库存
            if(purchase.getLinkSku().equals(item.getLinkSku())){
                int stock = item.getStock()+purchase.getQuantity();
                item.setStock(stock);
                inventoryDao.updateStock(item);
            }
        }
    }

    public int getTotal() {
        return purchaseDao.getTotal();
    }
}
