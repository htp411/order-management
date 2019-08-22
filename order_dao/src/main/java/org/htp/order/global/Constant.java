package org.htp.order.global;

import java.util.ArrayList;
import java.util.List;

public class Constant {
    //订单状态
    public static final String ORDER_STATUS_WAITING = "待发货";
    public static final String ORDER_STATUS_SHIPPED = "已发货";
    public static final String ORDER_STATUS_REFUND = "已退款";

    //采购单状态
    public static final String PURCHASE_STATUS_CREATED = "已创建";
    public static final String PURCHASE_STATUS_ARRIVED = "已到货";
    public static final String PURCHASE_STATUS_WAREHOUSING = "已入库";

    public static List<String> getExcelHeader(){
        List<String> excelHeader = new ArrayList<String>();
        excelHeader.add("订单ID");
        excelHeader.add("下单时间");
        excelHeader.add("发货时间");
        excelHeader.add("物流渠道");
        excelHeader.add("物流单号");
        excelHeader.add("订单状态");
        excelHeader.add("产品名称");
        excelHeader.add("线上SKU");
        excelHeader.add("关联SKU");
        excelHeader.add("订单金额");
        excelHeader.add("产品数量");
        excelHeader.add("图片链接");
        excelHeader.add("买家名称");
        excelHeader.add("联系方式");
        excelHeader.add("收货国家");
        excelHeader.add("省/州");
        excelHeader.add("城市");
        excelHeader.add("详细地址");
        excelHeader.add("邮编");
        return excelHeader;
    }
}
