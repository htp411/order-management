package org.htp.order.biz.impl;

import org.htp.order.biz.InventoryBiz;
import org.htp.order.biz.OrdersBiz;
import org.htp.order.biz.ProductBiz;
import org.htp.order.dao.OrdersDao;
import org.htp.order.dto.DeliveryDto;
import org.htp.order.dto.IdDto;
import org.htp.order.entity.Inventory;
import org.htp.order.entity.Orders;
import org.htp.order.entity.Product;
import org.htp.order.entity.SearchOrders;
import org.htp.order.global.Constant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
@Service("OrdersBiz")
public class OrdersBizImpl implements OrdersBiz {
    @Autowired
    private OrdersDao ordersDao;
    @Autowired
    private InventoryBiz inventoryBiz;
    @Autowired
    private ProductBiz productBiz;
    public void batchInsert(List<Orders> ordersList) {
        ordersDao.batchInsert(ordersList);
    }

    public void addOrder(Orders order) {
        order.setCreateTime(new Date());
        order.setOrderStatus(Constant.ORDER_STATUS_WAITING);
        String linkSku = order.getProductLinkSku();
        //判断是否有关联商品，存在并匹配的话把关联商品图片作为手工创建订单的图片
        if(linkSku!=null && !"".equals(linkSku)){
            Product product = productBiz.getBySku(linkSku);
            if(product != null){
                if(product.getImageUrl().toLowerCase().contains("http")){
                    order.setProductImageUrl(product.getImageUrl());
                }else{
                    order.setProductImageUrl(product.getImageUrl());
                }
            }else{
                //否则，手工创建订单一律默认图片
                order.setProductImageUrl("/order/resources/productImages/default_image.jpg");
            }
        }else{
            //否则，手工创建订单一律默认图片
            order.setProductImageUrl("/order/resources/productImages/default_image.jpg");
        }
        ordersDao.insert(order);
    }

    public void updateOrder(Orders orderAfter) {
        Orders orderBefore = ordersDao.selectById(orderAfter.getId());
        //修改前后关联SKU不一致，则需要替换商品图片
        if(!orderBefore.getProductLinkSku().equals(orderAfter.getProductLinkSku())){
            Product product = productBiz.getBySku(orderAfter.getProductLinkSku());
            if(product!=null){
                if(product.getImageUrl().toLowerCase().contains("http")){
                    orderAfter.setProductImageUrl(product.getImageUrl());
                }else{
                    orderAfter.setProductImageUrl(product.getImageUrl());
                }
            }
        }
        ordersDao.update(orderAfter);
    }

    public Orders getOrderById(String id) {
        return ordersDao.selectById(id);
    }

    public List<Orders> getAll(){   return ordersDao.selectAll();}

    public List<Orders> search(SearchOrders searchOrders) {
        return ordersDao.search(searchOrders);
    }

    public List<Orders> getOrdersByIds(List<IdDto> idList) {
        return ordersDao.selectByIds(idList);
    }

    public List<Orders> getByStatus(String orderStatus) {
        return ordersDao.selectByStatus(orderStatus);
    }

    public void deliveryOrder(DeliveryDto orderInfo) {
        Orders order = ordersDao.selectById(orderInfo.getId());
        order.setChannel(orderInfo.getChannel());
        order.setTrackingNumber(orderInfo.getTrackingNumber());
        order.setDeliveryTime(new Date());
        order.setOrderStatus(Constant.ORDER_STATUS_SHIPPED);
        ordersDao.deliveryOrder(order);
        System.out.println(order.toString());
        //订单产品有相关联的商品对库存做出修改
        if(order.getProductLinkSku()!=null && !"".equals(order.getProductLinkSku())){
            String linkSku = order.getProductLinkSku();
            Inventory inventory = inventoryBiz.getInventory(linkSku);
            if(inventory!=null){
                int quantity = order.getProductQuantity();
                int stock = inventory.getStock()-quantity;
                //设置更新以后的库存
                inventory.setStock(stock);
                inventoryBiz.update(inventory);
            }
        }

    }
    public List<Orders> searchByOrderStatus(SearchOrders searchOrders) {
        return ordersDao.selectByStatus1(searchOrders);
    }

    public List<Orders> getOrdersByTime(Date time) {
        return ordersDao.selectByTime(time);
    }

    public int getTotal() {
        return ordersDao.getTotal();
    }

    public int getPending() {
        return ordersDao.getPending();
    }
}
