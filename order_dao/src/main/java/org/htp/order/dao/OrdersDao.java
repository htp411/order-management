package org.htp.order.dao;

import org.apache.ibatis.annotations.Param;
import org.htp.order.dto.IdDto;
import org.htp.order.entity.Orders;
import org.htp.order.entity.SearchOrders;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Repository("orderDao")
public interface OrdersDao {
    void batchInsert(List<Orders> ordersList);
    void insert(Orders order);
    void update(Orders order);
    void deliveryOrder(Orders order);
    Orders selectById(String id);
    List<Orders> selectAll();
    List<Orders> search(SearchOrders searchOrders);
    List<Orders> selectByIds(List<IdDto> idList);
    List<Orders> selectByStatus(String orderStatus);
    List<Orders> selectByStatus1(SearchOrders searchOrders);

    List<Orders> selectByTime(@Param("time") Date time);

    int getTotal();

    int getPending();
}
