import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.*;
import org.htp.order.dto.IdDto;
import org.htp.order.entity.Inventory;
import org.htp.order.entity.Orders;
import org.htp.order.entity.Product;
import org.htp.order.utils.Utils;
import org.junit.Test;

import java.io.*;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class Exceltest {
    @Test
    public void test() {
        try {
            Workbook workbook = WorkbookFactory.create(new File("C:\\Users\\Administrator.000\\Desktop\\test.xlsx"));
            Sheet sheet = workbook.getSheetAt(0);
            int rowNum = sheet.getLastRowNum();
            for (int i = 1; i <= rowNum; i++) {
                Row row = sheet.getRow(i);
                System.out.println("姓名" + row.getCell(0).getStringCellValue());
                System.out.println("年龄" + (int) row.getCell(1).getNumericCellValue());
            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (InvalidFormatException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void date() throws ParseException {
        String dateString = "2019-04-02 16:16:49";
        String format = "yyyy-MM-dd HH:mm:ss";
        Date date = new SimpleDateFormat(format).parse(dateString);
        System.out.println(date);

        System.out.println("现在转化日期："+new SimpleDateFormat(format).format(date));

        String str = "$88";
        str = str.substring(1);
        System.out.println(str);
    }

    @Test
    public void  jsonTest(){
        String jsonStr = "[{\"id\":\"5a1801931132645731ed9e11\"},{\"id\":\"5a182fc6a2713443dc8d900b\"},{\"id\":\"5a186fca7705654f580d39af\"},{\"id\":\"5a1892e1ba1e096ea04f7522\"},{\"id\":\"5a18e0310ab69906f638fccf\"},{\"id\":\"5a1912fc00c7267c555d0a21\"},{\"id\":\"5a194b9216b6676b5f6e6626\"},{\"id\":\"5a19ff3248450a6d9bacc091\"},{\"id\":\"5a1a07ab3b791a6e3036b6e2\"},{\"id\":\"5a1a4b2c280c636f8a68e1f1\"},{\"id\":\"5a1a5d5717ba466e768e5067\"},{\"id\":\"5a1a857361bf996f7197d62b\"},{\"id\":\"5a1ac42cbb1cac52ff57d80e\"},{\"id\":\"5a1aef091161d4387f557c64\"},{\"id\":\"5a1afd7248450a6dc1acea8d\"},{\"id\":\"5a1b1820eced493bb407241b\"},{\"id\":\"5a1b2bd00b80a66e7af16da2\"},{\"id\":\"5a1b652d86ebbf6e9c75c4a1\"},{\"id\":\"5a1b8cb27214045df5602ed5\"},{\"id\":\"5a1bb8e4c4e7c06ee0b7ff5d\"},{\"id\":\"5a1be6285cea00230857ad30\"},{\"id\":\"5a1c230f30b0197d509a6a25\"},{\"id\":\"5ca1672c3ec4256aed3cd7fb\"},{\"id\":\"5ca1ade4ff5aca266970c745\"},{\"id\":\"5ca1bee862d27563ad89fa90\"},{\"id\":\"5ca21ea11f53041670f01e4d\"},{\"id\":\"5ca23d3c40c918261a6855f8\"},{\"id\":\"5ca2569bd25adc21afd2a703\"},{\"id\":\"5ca27ec03568d1268cea48bf\"},{\"id\":\"5ca2a18e8ecf05656545dbbd\"}]";
        List<IdDto> idList = Utils.jsonArrayToIdList(jsonStr);
        for (IdDto id:idList){
            System.out.println(id.getId());
        }
    }

    @Test
    public void listTest(){
        List<Inventory> inventoryList = new ArrayList<Inventory>();
        List<Product> productList = new ArrayList<Product>();
        Product p = new Product(1,"sku1","耳机","小耳机","http://",new BigDecimal(1.2),"备注",new Date());
        Product p2 = new Product(12,"sku12","耳机","小耳机","http://",new BigDecimal(1.2),"备注",new Date());
        Product p3 = new Product(13,"sku13","耳机","小耳机","http://",new BigDecimal(1.2),"备注",new Date());
        Product p4 = new Product(14,"sku14","耳机","小耳机","http://",new BigDecimal(1.2),"备注",new Date());
        Product p5 = new Product(15,"sku15","耳机","小耳机","http://",new BigDecimal(1.2),"备注",new Date());
        Inventory i = new Inventory("sku1",new Date(),20,20,20,p);
        Inventory i2 = new Inventory("sku121",new Date(),20,20,20,p2);
        Inventory i3 = new Inventory("sku13",new Date(),20,20,20,p3);
        productList.add(p);
        productList.add(p2);
        productList.add(p3);
        productList.add(p4);
        productList.add(p5);
        inventoryList.add(i);
        inventoryList.add(i2);
        inventoryList.add(i3);
        productList = Utils.removeProductInInventory(productList,inventoryList);

        for(Product item1:productList){
            System.out.println(item1.toString());
        }
    }

    @Test
    public void DateTest(){
        Orders o1 = new Orders("001",StringToDate("2019-04-27"),StringToDate("2018-01-01"),"北京E邮宝",
                                    "LL12347575CN","已发货", "产品名称","SKU",
                                    "Link_sku",new BigDecimal(12),1,"URl","name","tel",
                                    "国家","省州","城市","地址","邮编");
        Orders o2 = new Orders("002",StringToDate("2019-04-27"),StringToDate("2018-01-01"),"北京E邮宝",
                                    "LL12347575CN","已发货", "产品名称","SKU",
                                    "Link_sku",new BigDecimal(12),1,"URl","name","tel",
                                    "国家","省州","城市","地址","邮编");
        Orders o3 = new Orders("003",StringToDate("2019-04-27"),StringToDate("2018-01-01"),"北京E邮宝",
                                    "LL12347575CN","已发货", "产品名称","SKU",
                                    "Link_sku",new BigDecimal(12),1,"URl","name","tel",
                                    "国家","省州","城市","地址","邮编");
        Orders o4 = new Orders("003",StringToDate("2019-04-27"),StringToDate("2018-01-01"),"北京E邮宝",
                                    "LL12347575CN","已发货", "产品名称","SKU",
                                    "Link_sku",new BigDecimal(12),1,"URl","name","tel",
                                    "国家","省州","城市","地址","邮编");
        Orders o5 = new Orders("003",StringToDate("2019-04-27"),StringToDate("2018-01-01"),"北京E邮宝",
                                    "LL12347575CN","已发货", "产品名称","SKU",
                                    "Link_sku",new BigDecimal(12),1,"URl","name","tel",
                                    "国家","省州","城市","地址","邮编");
        Orders o6 = new Orders("003",StringToDate("2019-04-01"),StringToDate("2018-01-01"),"北京E邮宝",
                                    "LL12347575CN","已发货", "产品名称","SKU",
                                    "Link_sku",new BigDecimal(12),1,"URl","name","tel",
                                    "国家","省州","城市","地址","邮编");
        Orders o7 = new Orders("003",StringToDate("2019-04-01"),StringToDate("2018-01-01"),"北京E邮宝",
                                    "LL12347575CN","已发货", "产品名称","SKU",
                                    "Link_sku",new BigDecimal(12),1,"URl","name","tel",
                                    "国家","省州","城市","地址","邮编");
        List<Orders> ordersList = new ArrayList<Orders>();
        ordersList.add(o1);
        ordersList.add(o2);
        ordersList.add(o3);
        ordersList.add(o4);
        ordersList.add(o5);
        ordersList.add(o6);
        ordersList.add(o7);

        Date date = new Date();
        Calendar today = Calendar.getInstance();
        today.setTime(date);

        today.add(Calendar.DAY_OF_YEAR,-7);
        Date sevenDaysAgo = today.getTime();
        today.add(Calendar.DAY_OF_YEAR,-23);
        Date aMonthAgo = today.getTime();

        System.out.println("今天："+Utils.parseDate(date,"yyyy-MM-dd"));
        System.out.println("7天前："+Utils.parseDate(Utils.sevenDaysAgo(),"yyyy-MM-dd"));
        System.out.println("30天前："+Utils.parseDate(aMonthAgo,"yyyy-MM-dd"));

    }

    private Date StringToDate(String dateString){

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date date = null;
        try {
            date = format.parse(dateString);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }

}
