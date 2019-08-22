package org.htp.order.utils;

import com.mysql.cj.xdevapi.JsonArray;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.htp.order.dto.DeliveryDto;
import org.htp.order.dto.IdDto;
import org.htp.order.entity.*;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class Utils {
    public static boolean searchInfoIsEmpty(SearchOrders searchOrders){
        if(searchOrders == null){
            return true;
        }else if((searchOrders.getCountry()==null || "".equals(searchOrders.getCountry()) )
                && (searchOrders.getOption_detail()==null || "".equals(searchOrders.getOption_detail()))
                && (searchOrders.getStart()==null || "".equals(searchOrders.getStart()) )
                && (searchOrders.getEnd()==null || "".equals(searchOrders.getEnd()))
                && (searchOrders.getOrder_status() == null || "".equals(searchOrders.getOrder_status()))
        ){
            return true;
        }
        else{
            return false;
        }

    }
    public static List<IdDto> jsonArrayToIdList(String jsonArrayString){
        List<IdDto> idList = new ArrayList<IdDto>();
        JSONArray jsonArray = JSONArray.fromObject(jsonArrayString);
        for(Object obj:jsonArray){
            JSONObject jsonObject = JSONObject.fromObject(obj);
            IdDto id = (IdDto) JSONObject.toBean(jsonObject,IdDto.class);
            idList.add(id);
        }
        return idList;
    }
    public static List<DeliveryDto> jsonArrayToDeliveryInfo(String jsonArrayString){
        List<DeliveryDto> orderInfo = new ArrayList<DeliveryDto>();
        JSONArray jsonArray = JSONArray.fromObject(jsonArrayString);
        for(Object obj:jsonArray){
            JSONObject jsonObject = JSONObject.fromObject(obj);
            DeliveryDto deliveryDto = (DeliveryDto) JSONObject.toBean(jsonObject,DeliveryDto.class);
            orderInfo.add(deliveryDto);
        }
        return orderInfo;
    }
    public static String parseDate(Date date,String format){
        return (new SimpleDateFormat(format)).format(date);
    }

    public static List<Product> removeProductInInventory(List<Product> productList, List<Inventory> inventoryList){
        Iterator<Product> iterator = productList.iterator();
        while(iterator.hasNext()){
            Product product = iterator.next();
            for(Inventory i:inventoryList){
                if(i.getLinkSku().equals(product.getSku())){
                    iterator.remove();
                    break;
                }
            }
        }
        return productList;
    }

    public static Log createNormalLog(String className, String methodName, String username,Log log,Boolean isException) {
        //设置时间
        log.setOperatingTime(new Date());
        //设置操作人
        log.setOperator(username);
        //设置日志类型
        if(isException){
            log.setType("系统异常");
        }else if(className.toLowerCase().contains("default")){
            log.setType("登陆系统");
        }else{
            log.setType("用户操作");
        }

        if(!isException){
            if(!"username:null".equals(username)){
                log.setResult("成功");
            }else{
                log.setResult("失败");
            }
        }
        //设置操作模块、实际操作
        if(className.toLowerCase().contains("default")){
            log.setModule("登陆系统");
            if(methodName.toLowerCase().contains("login")){
                log.setOperating("用户登陆");
            }else if(methodName.toLowerCase().contains("logout")){
                log.setOperating("注销登陆");
            }else if(methodName.toLowerCase().contains("index")){
                log.setOperating("查看首页");
            }else{
                log.setOperating("登陆系统--其他");
            }
        }else if(className.toLowerCase().contains("inventory")){
            log.setModule("库存管理");
            if(methodName.toLowerCase().contains("list")){
                log.setOperating("查看库存");
            }else if(methodName.toLowerCase().contains("search")){
                log.setOperating("搜索库存");
            }else if(methodName.toLowerCase().contains("create")){
                log.setOperating("新增库存商品");
            }else if(methodName.toLowerCase().contains("update")){
                log.setOperating("更新库存库存");
            }else if(methodName.toLowerCase().contains("delete")){
                log.setOperating("删除库存记录");
            }else{
                log.setOperating("库存管理--其他");
            }
        }else if(className.toLowerCase().contains("order")){
            log.setModule("订单管理");
            if(methodName.toLowerCase().contains("list") && !methodName.contains("handle")){
                log.setOperating("查看订单");
            }else if(methodName.toLowerCase().contains("search")){
                log.setOperating("搜索订单");
            }else if(methodName.toLowerCase().contains("import")){
                log.setOperating("Excel导入订单");
            }else if(methodName.toLowerCase().contains("create")){
                log.setOperating("手工创建订单");
            }else if(methodName.toLowerCase().contains("update")){
                log.setOperating("修改订单信息");
            }else if(methodName.toLowerCase().contains("export")){
                log.setOperating("导出订单");
            }else if(methodName.toLowerCase().contains("handle")){
                log.setOperating("处理订单");
            }else if(methodName.toLowerCase().contains("delivery")){
                log.setOperating("订单发货");
            }else{
                log.setOperating("订单管理--其他");
            }
        }else if(className.toLowerCase().contains("product")){
            log.setModule("商品管理");
            if(methodName.toLowerCase().contains("list")){
                log.setOperating("查看商品");
            }else if(methodName.toLowerCase().contains("search")){
                log.setOperating("搜索商品");
            }else if(methodName.toLowerCase().contains("create")){
                log.setOperating("创建商品");
            }else if(methodName.toLowerCase().contains("update")){
                log.setOperating("修改商品信息");
            }else if(methodName.toLowerCase().contains("delete")){
                log.setOperating("删除商品信息");
            }else{
                log.setOperating("商品管理--其他");
            }
        }else if(className.toLowerCase().contains("purchase")){
            log.setModule("采购管理");
            if(methodName.toLowerCase().contains("list")){
                log.setOperating("查看采购单");
            }else if(methodName.toLowerCase().contains("search")){
                log.setOperating("搜索采购单");
            }else if(methodName.toLowerCase().contains("create")){
                log.setOperating("创建采购单");
            }else if(methodName.toLowerCase().contains("update")){
                log.setOperating("修改采购单");
            }else if(methodName.toLowerCase().contains("storage")){
                log.setOperating("采购单入库");
            }else{
                log.setOperating("采购管理--其他");
            }
        }else{
            log.setModule("其他");
        }
        return log;
    }

    public static Date sevenDaysAgo(){
        Date date = new Date();
        Calendar today = Calendar.getInstance();
        today.setTime(date);
        today.add(Calendar.DAY_OF_YEAR,-7);
        return today.getTime();
    }

    public static Date aMonthAgo(){
        Date date = new Date();
        Calendar today = Calendar.getInstance();
        today.setTime(date);
        today.add(Calendar.DAY_OF_YEAR,-30);
        return today.getTime();
    }

    public static List<Inventory> calculateSales(List<Inventory> inventoryList, List<Orders> sevenDaysOrders, List<Orders> monthlyOrders) {
        for(Inventory item:inventoryList){
            int sevenDaysSales = 0;
            int monthlySales = 0;
            for(Orders s_order:sevenDaysOrders){
                if(s_order.getProductLinkSku().equals(item.getLinkSku())){
                    sevenDaysSales += s_order.getProductQuantity();
                }
            }
            for(Orders m_order:monthlyOrders){
                if(m_order.getProductLinkSku().equals(item.getLinkSku())){
                    monthlySales += m_order.getProductQuantity();
                }
            }
            item.setWeekSale(sevenDaysSales);
            item.setMonthSale(monthlySales);
        }
        return inventoryList;
    }
}
