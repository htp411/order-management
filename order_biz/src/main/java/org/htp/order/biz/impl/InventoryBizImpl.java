package org.htp.order.biz.impl;

import org.htp.order.biz.InventoryBiz;
import org.htp.order.dao.InventoryDao;
import org.htp.order.dto.IdDto;
import org.htp.order.entity.Inventory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
@Service("inventoryBiz")
public class InventoryBizImpl implements InventoryBiz {
    private final InventoryDao inventoryDao;

    public InventoryBizImpl(@Qualifier("inventoryDao") InventoryDao inventoryDao) {
        this.inventoryDao = inventoryDao;
    }

    public List<Inventory> getAll() {
        return inventoryDao.selectAll();
    }

    public List<Inventory> getBySku(String sku) {
        return inventoryDao.selectBySku(sku);
    }

    public Inventory getInventory(String linkSku) {
        return inventoryDao.selectInventory(linkSku);
    }

    public void create(Inventory inventory) {
        inventory.setUpdateTime(new Date());
        inventoryDao.insert(inventory);
    }

    public void update(Inventory inventory) {
        inventory.setUpdateTime(new Date());
        inventoryDao.update(inventory);
    }

    public void batchDelete(List<IdDto> skus) {
        inventoryDao.batchDelete(skus);
    }

    public int inventoryWarning() {
        return inventoryDao.inventoryWarning();
    }
}
