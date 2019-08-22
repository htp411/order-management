<%@include file="header.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container">
    <div class="container-item">
        <h4>快捷操作</h4>
        <ul class="quick-operating">
            <a href="order/order_list">
                <li class="operating order">
                    <label>
                        <i class="iconfont icon-dingdan"></i>
                        <p>订单</p>
                    </label>
                    <span>
				        <p title="全部订单">${totalOrder}</p>
			        </span>
                </li>
            </a>
            <a href="order/order_handle_list">
                <li class="operating shipping">
                    <label>
                        <i class="iconfont icon-fahuo1"></i>
                        <p>发货</p>
                    </label>
                    <span>
				        <p title="待发货订单">${pendingOrder}</p>
			        </span>
                </li>
            </a>
            <a href="purchase/purchase_list">
                <li class="operating purchase">
                    <label>
                        <i class="iconfont icon-caigouguocheng"></i>
                        <p>采购</p>
                    </label>
                    <span>
				        <p title="采购清单">${totalPurchase}</p>
			        </span>
                </li>
            </a>
            <a href="inventory/inventory_list">
                <li class="operating pre-alert">
                    <label>
                        <i class="iconfont icon-yujing1"></i>
                        <p>预警</p>
                    </label>
                    <span>
				        <p title="库存预警">${inventoryWarning}</p>
			        </span>
                </li>
            </a>
        </ul>
    </div>
    <div class="container-item">
        <h4>最近订单</h4>
        <div class="recent-order">
            <table class="table table-striped table-hover table-bordered">
                <thead>
                <th>
                    <input type="checkbox" name="select-all" id="select-all">
                </th>
                <th>订单ID</th>
                <th>产品</th>
                <th>买家</th>
                <th>时间</th>
                <th>状态</th>
                </thead>
                <tbody>
                <c:forEach items="${orders}" var="order">
                    <tr class="order-info">
                        <td>
                            <div class="info-checkbox">
                                <input type="checkbox" name="order-items">
                            </div>
                        </td>
                        <td>
                            <div class="info-orderId">
                                <span>${order.id}</span>
                            </div>
                        </td>
                        <td>
                            <div class="info-product">
                                <div class="product-image">
                                    <img src="${order.productImageUrl}">
                                </div>
                                <div class="product-details">
                                    <span>$${order.productPrice}*${order.productQuantity}</span>
                                    <span>${order.productOnlineSku}</span>
                                </div>
                            </div>
                        </td>
                        <td>
                            <div class="info-buyer">
                                <div class="buyer">
                                    <span class="buyer-country"><i
                                            class="iconfont icon-guojiapitchon"></i>${order.country}</span>
                                </div>
                                <div class="buyer">
                                    <span><i class="iconfont icon-denglu"></i> ${order.username}</span>
                                </div>
                            </div>
                        </td>
                        <td>
                            <div class="info-time">
                                <span>下单：<spring:eval expression="order.createTime"/></span>
                                <c:if test="${order.deliveryTime != null}">
                                    <span>发货：<spring:eval expression="order.deliveryTime"/></span>
                                </c:if>
                            </div>
                        </td>
                        <td>
                            <div class="info-status">
                                <button type="button" class="waiting
                                        <c:if test="${order.orderStatus.equals('已发货')}">shipped</c:if>
                                        <c:if test="${order.orderStatus.equals('已退款')}">refund</c:if>   ">
                                        ${order.orderStatus}</button>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<div style="background-color:rgba(238,241,246,1);;height: 45px;">

</div>
<script src="<c:url value='/resources/js/jquery-3.3.1.js'/>"></script>
<script src="<c:url value='/resources/bootstrap/bootstrap.js'/>"></script>
<script src="<c:url value='/resources/common/header/header.js'/>"></script>
<script>
    let hide_details = $('.hide-details');
    hide_details.on('mouseover', function () {
        $($($(this).parent()).find('a')[0]).addClass('hover');
    });
    hide_details.on('mouseout', function () {
        $($($(this).parent()).find('a')[0]).removeClass('hover');
    });
</script>
</body>
</html>
