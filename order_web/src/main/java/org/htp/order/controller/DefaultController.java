package org.htp.order.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import javafx.scene.chart.PieChart;
import org.htp.order.biz.*;
import org.htp.order.entity.Log;
import org.htp.order.entity.Orders;
import org.htp.order.entity.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.*;

@Controller("defaultController")
@RequestMapping("/")
public class DefaultController {
    private final OrdersBiz ordersBiz;
    private final UserBiz userBiz;
    private final LogBiz logBiz;
    private final PurchaseBiz purchaseBiz;
    private final InventoryBiz inventoryBiz;

    public DefaultController(OrdersBiz ordersBiz, UserBiz userBiz, LogBiz logBiz, PurchaseBiz purchaseBiz, InventoryBiz inventoryBiz) {
        this.ordersBiz = ordersBiz;
        this.userBiz = userBiz;
        this.logBiz = logBiz;
        this.purchaseBiz = purchaseBiz;

        this.inventoryBiz = inventoryBiz;
    }

    @RequestMapping("to_login")
    public String toLogin(){
        return "login";
    }
    @RequestMapping("login")
    public String login(User user, HttpSession session){
        if(userBiz.isPassCheck(user)){
            session.setAttribute("user",user);
            return "redirect:index";
        }else{
            return "login";
        }
    }
    @RequestMapping("register")
    public String register(User user,@RequestParam("confirm-password") String confirm_password){
        if(user.getPassword().equals(confirm_password)){
            userBiz.createUser(user);
            return "login";
        }else{
            return "500";
        }

    }
    @RequestMapping("logout")
    public String logout(HttpSession session){
        session.setAttribute("user",null);
        return "redirect:to_login";
    }
    @RequestMapping("index")
    public String index(Map<String,Object> map){
        List<Orders> orderList = ordersBiz.getAll().subList(0,30);
        int totalOrder = ordersBiz.getTotal();
        int pendingOrder = ordersBiz.getPending();
        int totalPurchase = purchaseBiz.getTotal();
        int inventoryWarning = inventoryBiz.inventoryWarning();
        map.put("orders",orderList);
        map.put("totalOrder",totalOrder);
        map.put("pendingOrder",pendingOrder);
        map.put("totalPurchase",totalPurchase);
        map.put("inventoryWarning",inventoryWarning);
        return "index";
    }
    @RequestMapping("show_log")
    public String showLog(Map<String ,Object> map){
        Page page = PageHelper.startPage(1,50);
        List<Log> logs = logBiz.getAll();
        PageInfo<?> pageHelper = page.toPageInfo();
        map.put("pageHelper",pageHelper);
        map.put("logs",logs);
        return "log";
    }
    @RequestMapping("search_log")
    public String searchLog(@RequestParam("module") String module,@RequestParam("start") String start,@RequestParam("end") String end,Map<String,Object>map,PageInfo pageHelper){
        Page page = PageHelper.startPage(pageHelper.getPageNum(),50);
        List<Log> logs = logBiz.searchLog(module,start,end);
        pageHelper = page.toPageInfo();
        map.put("pageHelper",pageHelper);
        map.put("logs",logs);
        map.put("module",module);
        map.put("start",start);
        map.put("end",end);
        return "log";
    }
    @RequestMapping("get_info")
    public List<demo> get_info(){
        List<demo> list = new ArrayList<demo>();
        list.add(new demo("1","name1",(new Date()).toString()));
        list.add(new demo("2","name2",(new Date()).toString()));
        return list;
    }
    class demo{
        String id;
        String name;
        String ctime;
        public demo(String id,String name,String ctime){
            this.id = id;
            this.name = name;
            this.ctime = ctime;
        }

    }

}
