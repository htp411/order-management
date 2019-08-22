package org.htp.order.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.htp.order.biz.ProductBiz;
import org.htp.order.dto.IdDto;
import org.htp.order.entity.Product;
import org.htp.order.utils.FileUtils;
import org.htp.order.utils.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller("productController")
@RequestMapping("/product/")
public class ProductController {
    @Autowired
    private ProductBiz productBiz;

    @RequestMapping("product_list")
    public String productList(Map<String,Object> map){
        Page page = PageHelper.startPage(1,30);
        List<Product> productList =productBiz.getAll();
        PageInfo<?> pageHelper = page.toPageInfo();
        map.put("pageHelper",pageHelper);
        map.put("productList",productList);
        return "product_list";
    }
    @RequestMapping("search_product")
    public String searchProduct(Map<String,Object> map,@RequestParam("search_option") String search_option){
        Page page = PageHelper.startPage(1,30);
        List<Product> productList =productBiz.gatBySearchOption(search_option);
        PageInfo<?> pageHelper = page.toPageInfo();
        map.put("pageHelper",pageHelper);
        map.put("productList",productList);
        return "product_list";
    }
    @RequestMapping("search_product_by_page")
    public String searchProductByPage(Map<String,Object> map,String search_option,PageInfo pageHelper){
        Page page = PageHelper.startPage(pageHelper.getPageNum(),30);
        List<Product> productList =productBiz.gatBySearchOption(search_option);
        pageHelper = page.toPageInfo();
        map.put("pageHelper",pageHelper);
        map.put("productList",productList);
        map.put("defaultSearch",false);
        map.put("search_option",search_option);
        return "product_list";
    }
    @RequestMapping("to_create_product")
    public String toCreateProduct(){
        return "create_product";
    }

    @RequestMapping("create_product")
    public String createProduct(HttpServletRequest request){
        List<Product> products = FileUtils.getProducts(request);
        productBiz.createProduct(products);
        return "redirect:product_list";
    }
    @RequestMapping("to_product_update")
    public String toProductUpdate(String sku,Map<String,Object> map){
        Product product = productBiz.getBySku(sku);
        map.put("product",product);
        return "update_product";
    }
    @RequestMapping("update_product")
    public String updateProduct(HttpServletRequest request,@RequestParam("id") Integer id){
        List<Product> products = FileUtils.getProducts(request);
        Product product = products.get(0);
        product.setId(id);
        System.out.println(product.toString());
        productBiz.update(product);
        return "redirect:product_list";
    }
    @RequestMapping("delete_product")
    public String deleteProduct(String sku){
        productBiz.remove(sku);
        return "redirect:product_list";
    }
    @RequestMapping("batch_delete_product")
    @ResponseBody
    public String batchDeleteProduct(@RequestBody String skuList){
        List<IdDto> skus  = Utils.jsonArrayToIdList(skuList);
        productBiz.batchDelete(skus);
        return "redirect:product_list";
    }
}
