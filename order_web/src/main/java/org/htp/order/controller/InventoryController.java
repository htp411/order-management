package org.htp.order.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.htp.order.biz.InventoryBiz;
import org.htp.order.biz.OrdersBiz;
import org.htp.order.biz.ProductBiz;
import org.htp.order.dto.IdDto;
import org.htp.order.entity.Inventory;
import org.htp.order.entity.Orders;
import org.htp.order.entity.Product;
import org.htp.order.utils.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.rmi.CORBA.Util;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller("inventoryController")
@RequestMapping("/inventory/")
public class InventoryController {
    private final InventoryBiz inventoryBiz;
    private final ProductBiz productBiz;
    private final OrdersBiz ordersBiz;

    public InventoryController(InventoryBiz inventoryBiz, ProductBiz productBiz, OrdersBiz ordersBiz) {
        this.inventoryBiz = inventoryBiz;
        this.productBiz = productBiz;
        this.ordersBiz = ordersBiz;
    }

    @RequestMapping("inventory_list")
    public String inventoryList(Map<String,Object> map){
        Page page = PageHelper.startPage(1,30);
        List<Inventory> inventoryList = inventoryBiz.getAll();
        List<Orders> sevenDaysOrders = ordersBiz.getOrdersByTime(Utils.sevenDaysAgo());
        List<Orders> monthlyOrders = ordersBiz.getOrdersByTime(Utils.aMonthAgo());
        inventoryList = Utils.calculateSales(inventoryList,sevenDaysOrders,monthlyOrders);
        PageInfo<?> pageHelper = page.toPageInfo();
        map.put("pageHelper",pageHelper);
        map.put("inventoryList",inventoryList);
        return "inventory_list";
    }

    @RequestMapping("search_inventory")
    public String searchInventory(Map<String,Object> map, @RequestParam("sku") String sku,PageInfo pageHelper){
        Page page = PageHelper.startPage(pageHelper.getPageNum(),30);
        List<Inventory> inventoryList = inventoryBiz.getBySku(sku);
        List<Orders> sevenDaysOrders = ordersBiz.getOrdersByTime(Utils.sevenDaysAgo());
        List<Orders> monthlyOrders = ordersBiz.getOrdersByTime(Utils.aMonthAgo());
        inventoryList = Utils.calculateSales(inventoryList,sevenDaysOrders,monthlyOrders);
        pageHelper = page.toPageInfo();
        map.put("pageHelper",pageHelper);
        map.put("sku",sku);
        map.put("inventoryList",inventoryList);
        return "inventory_list";
    }
    @RequestMapping("to_create_inventory")
    public String toCreateInventory(Map<String,Object> map){
        List<Product> productList = productBiz.getAll();
        List<Inventory> inInventoryList = inventoryBiz.getAll();
        productList = Utils.removeProductInInventory(productList,inInventoryList);
        map.put("productList",productList);
        return "select_inventory_product";
    }
    @RequestMapping("create_inventory")
    public String createInventory(Inventory inventory){
        inventoryBiz.create(inventory);
        return "redirect:inventory_list";
    }

    @RequestMapping("update_inventory")
    public String updateInventory(Inventory inventory){
        inventoryBiz.update(inventory);
        return "redirect:inventory_list";
    }

    @RequestMapping("batch_delete_inventory")
    @ResponseBody
    public String batchDeleteInventory(@RequestBody String skuList){
        List<IdDto> skus = Utils.jsonArrayToIdList(skuList);
        inventoryBiz.batchDelete(skus);
        return "redirect:inventory_list";
    }
}
