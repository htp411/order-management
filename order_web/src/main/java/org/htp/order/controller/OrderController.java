package org.htp.order.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.htp.order.biz.OrdersBiz;
import org.htp.order.dto.DeliveryDto;
import org.htp.order.dto.IdDto;
import org.htp.order.entity.Orders;
import org.htp.order.entity.SearchOrders;
import org.htp.order.global.Constant;
import org.htp.order.utils.FileUtils;
import org.htp.order.utils.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller("orderController")
@RequestMapping("/order/")
public class OrderController {
    @Autowired
    private OrdersBiz ordersBiz;

    @RequestMapping("order_list")
    public String orderList(Map<String,Object> map){
        Page page = PageHelper.startPage(1,30);
        List<Orders> orderList = ordersBiz.getAll();
        PageInfo<?> pageHelper = page.toPageInfo();
        map.put("pageHelper",pageHelper);
        map.put("defaultSearch",true);
        map.put("orders",orderList);
        return "order_list";
    }

    @RequestMapping("search_orders")
    public String searchOrders(Map<String,Object> map, SearchOrders searchOrders){
        Page page = PageHelper.startPage(1,30);
        List<Orders> orderList = ordersBiz.search(searchOrders);
        PageInfo<?> pageHelper = page.toPageInfo();
        map.put("pageHelper",pageHelper);
        map.put("searchInfo",searchOrders);
        map.put("orders",orderList);
        map.put("defaultSearch",false);
        map.put("searchInfoIsEmpty",Utils.searchInfoIsEmpty(searchOrders));
        return "order_list";
    }

    @RequestMapping("order_list_shipped")
    public String orderListShipped(Map<String,Object> map){
        Page page = PageHelper.startPage(1,30);
        SearchOrders searchOrders = new SearchOrders();
        searchOrders.setOrder_status(Constant.ORDER_STATUS_SHIPPED);
        List<Orders> orderList = ordersBiz.searchByOrderStatus(searchOrders);
        PageInfo<?> pageHelper = page.toPageInfo();
        map.put("pageHelper",pageHelper);
        map.put("searchInfo",searchOrders);
        map.put("orders",orderList);
        map.put("searchInfoIsEmpty",Utils.searchInfoIsEmpty(searchOrders));
        map.put("defaultSearch",false);
        map.put("shipped",true);
        return "order_list";
    }

    @RequestMapping("search_orders_by_page")
    public String searchOrdersByPage(Map<String,Object> map,SearchOrders searchOrders,PageInfo pageHelper){
        Page page = PageHelper.startPage(pageHelper.getPageNum(),30);
        List<Orders> orderList = ordersBiz.search(searchOrders);
        pageHelper = page.toPageInfo();
        map.put("pageHelper",pageHelper);
        map.put("searchInfo",searchOrders);
        map.put("orders",orderList);
        map.put("searchInfoIsEmpty",Utils.searchInfoIsEmpty(searchOrders));
        map.put("defaultSearch",false);
        return "order_list";
    }

    @RequestMapping("to_import_order")
    public String toImportOrder(){
        return "import_order";
    }

    @RequestMapping("import_order")
    public String importOrder(Map<String ,Object> map , HttpServletRequest request){
        List<Orders> ordersList = FileUtils.orderImport(request);
        ordersBiz.batchInsert(ordersList);
        map.put("msg","success");
        return "import_order";
    }

    @RequestMapping("to_create_order")
    public String toCreateOrder(Map<String,Object> map/* , @RequestParam("id") String id*/){
        map.put("orders",new Orders());
        return "create_order";
    }

    @RequestMapping("create_order")
    public String createOrder(Orders orders,Map<String,Object> map){
        ordersBiz.addOrder(orders);
        map.put("orders",new Orders());
        map.put("msg","success");
        return "create_order";
    }

    @RequestMapping("to_order_update")
    public String toOrderUpdate(Map<String,Object> map,String id){
        Orders orders = ordersBiz.getOrderById(id);
        map.put("orders",orders);
        return "update_order";
    }

    @RequestMapping("update_order")
    public String updateOrder(Orders orders){
        ordersBiz.updateOrder(orders);
        return "redirect:to_order_update?id="+orders.getId();
    }

    @RequestMapping("export_order")
    @ResponseBody
    public String exportOrder(@RequestBody String jsonArrayIdList,HttpServletRequest request){
        List<IdDto> idList = Utils.jsonArrayToIdList(jsonArrayIdList);
        List<Orders> ordersList = ordersBiz.getOrdersByIds(idList);
        String downloadUrl = FileUtils.exportExcel(request,ordersList);
        System.out.println(downloadUrl);
        return downloadUrl;
    }

    @RequestMapping("order_handle_list")
    public String orderHandleList(Map<String,Object> map){
        Page page = PageHelper.startPage(1,30);
        List<Orders> orderList = ordersBiz.getByStatus(Constant.ORDER_STATUS_WAITING);
        PageInfo<?> pageHelper = page.toPageInfo();
        map.put("pageHelper",pageHelper);
        map.put("statusSearch",true);
        map.put("orders",orderList);
        return "order_list";
    }

    @RequestMapping("delivery_order")
    @ResponseBody
    public String deliveryOrder(@RequestBody String jsonString){
        DeliveryDto orderInfo = Utils.jsonArrayToDeliveryInfo(jsonString).get(0);
        ordersBiz.deliveryOrder(orderInfo);
        return "success";
    }

}
