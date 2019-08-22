package org.htp.order.biz;

import org.htp.order.dto.DeliveryDto;
import org.htp.order.dto.IdDto;
import org.htp.order.entity.Orders;
import org.htp.order.entity.SearchOrders;

import java.util.Date;
import java.util.List;

public interface OrdersBiz {
    void batchInsert(List<Orders> ordersList);
    void addOrder(Orders order);
    void updateOrder(Orders order);
    Orders getOrderById(String id);
    List<Orders> getAll();
    List<Orders> search(SearchOrders searchOrders);
    List<Orders> getOrdersByIds(List<IdDto> idList);

    List<Orders> getByStatus(String orderStatus);

    void deliveryOrder(DeliveryDto orderInfo);

    List<Orders> searchByOrderStatus(SearchOrders searchOrders);

    List<Orders> getOrdersByTime(Date time);

    int getTotal();

    int getPending();
}
