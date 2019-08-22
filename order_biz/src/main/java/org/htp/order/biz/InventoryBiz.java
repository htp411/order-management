package org.htp.order.biz;

import org.htp.order.dto.IdDto;
import org.htp.order.entity.Inventory;

import java.util.List;


public interface InventoryBiz {
    List<Inventory> getAll();
    List<Inventory> getBySku(String sku);
    Inventory getInventory(String linkSku);
    void create(Inventory inventory);

    void update(Inventory inventory);

    void batchDelete(List<IdDto> skus);

    int inventoryWarning();
}
