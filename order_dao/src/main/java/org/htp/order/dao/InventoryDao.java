package org.htp.order.dao;

import org.htp.order.dto.IdDto;
import org.htp.order.entity.Inventory;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository("inventoryDao")
public interface InventoryDao {
    List<Inventory> selectAll();
    List<Inventory> selectBySku(String sku);
    Inventory selectInventory(String linkSku);
    void insert(Inventory inventory);

    void update(Inventory inventory);
    void updateStock(Inventory inventory);
    void batchDelete(List<IdDto> skus);


    int inventoryWarning();
}
