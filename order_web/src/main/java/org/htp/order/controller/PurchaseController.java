package org.htp.order.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.htp.order.biz.ProductBiz;
import org.htp.order.biz.PurchaseBiz;
import org.htp.order.entity.Product;
import org.htp.order.entity.Purchase;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

@Controller("purchaseController")
@RequestMapping("/purchase/")
public class PurchaseController {
    @Autowired
    private PurchaseBiz purchaseBiz;
    @Autowired
    private ProductBiz productBiz;
    @RequestMapping("purchase_list")
    public String purchaseList(Map<String,Object> map){
        Page page = PageHelper.startPage(1,30);
        List<Purchase> purchaseList = purchaseBiz.getAll();
        PageInfo<?> pageHelper = page.toPageInfo();
        map.put("pageHelper",pageHelper);
        map.put("purchaseList",purchaseList);
        return "purchase_list";
    }

    @RequestMapping("search_purchase")
    public String searchPurchase(Map<String,Object> map,@RequestParam("sku") String sku,PageInfo pageHelper){
        System.out.println(sku);
        Page page = PageHelper.startPage(pageHelper.getPageNum(),30);
        List<Purchase> purchaseList = purchaseBiz.getBySku(sku);
        System.out.println(purchaseList.get(0).getProduct().toString());
        pageHelper = page.toPageInfo();
        map.put("pageHelper",pageHelper);
        map.put("purchaseList",purchaseList);
        map.put("sku",sku);
        return "purchase_list";
    }

    @RequestMapping("create_purchase")
    public String createPurchase(Purchase purchase){
        purchaseBiz.create(purchase);
        return "redirect:purchase_list";
    }

    @RequestMapping("update_purchase")
    public String updatePurchase(Purchase purchase){
        purchaseBiz.update(purchase);
        return "redirect:purchase_list";
    }

    @RequestMapping("to_create_purchase")
    public String toCreatePurchase(Map<String,Object> map,PageInfo pageHelper){
        List<Product> products = productBiz.getAll();
        Page page = PageHelper.startPage(pageHelper.getPageNum(),30);
        pageHelper = page.toPageInfo();
        map.put("pageHelper",pageHelper);
        map.put("products",products);
        return "select_product";
    }
    @RequestMapping("update_purchase_status")
    public String updatePurchaseStatus(@RequestParam("id") String id,@RequestParam("status") String status){
        purchaseBiz.updateStatus(id,status);
        return "redirect:purchase_list";
    }

    @RequestMapping("storage")
    public String storage(@RequestParam("id") String id){
        purchaseBiz.storage(id);
        return "redirect:purchase_list";
    }
}
