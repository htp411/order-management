<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@include file="header.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="order-container">
    <div class="top-tips">
        <h4 class="">订单<span>/</span>手工创建</h4>
    </div>
    <div class="create_order_tip">
        <c:if test="${msg =='success'}">
            <span style="color: #bd2c00">手工创建订单成功</span>
        </c:if>
    </div>
</div>
<div class="create_order">
    <form:form class="form" rol="form" method="post" action="/order/order/create_order"  modelAttribute="orders">
        <div class="panel">
            <div class="panel-heading">
                <h5>订单信息</h5>
            </div>
            <div class="panel-body">
                <label class="form-inline">
                    <span>订单ID:</span>
                    <form:input type="text" path="id" cssClass="form-control" required="ture"/>
                    <div class="input-required"></div>
                </label>
                <label class="form-inline">
                    <span>线上SKU:</span>
                    <form:input type="text" path="productOnlineSku" cssClass="form-control"  required="ture"/>
                    <div class="input-required"></div>
                    <span>关联SKU:</span>
                    <form:input type="text" path="productLinkSku" cssClass="form-control"/>
                </label>
                <label class="form-inline">
                    <span>订单金额:</span>
                    <form:input type="text" path="productPrice" cssClass="form-control"  required="ture"/>
                    <div class="input-required"></div>
                    <span>商品数量:</span>
                    <form:input type="text" path="productQuantity" cssClass="form-control" required="ture"/>
                    <div class="input-required"></div>
                </label>
            </div>
        </div>
        <div class="panel">
            <div class="panel-heading">
                <h5>买家信息</h5>
            </div>
            <div class="panel-body">
                <label class="form-inline">
                    <span>买家姓名:</span>
                    <form:input type="text" path="username" cssClass="form-control" required="ture"/>
                    <div class="input-required"></div>
                </label>
                <label class="form-inline">
                    <span>电话/手机:</span>
                    <form:input type="text" path="tel" cssClass="form-control"  required="ture"/>
                    <div class="input-required"></div>
                </label>
                <label class="form-inline">
                    <span>国家:</span>
                    <form:input type="text" path="country" cssClass="form-control"  required="ture"/>
                    <div class="input-required"></div>
                    <span>省/州:</span>
                    <form:input type="text" path="state" cssClass="form-control" required="ture"/>
                    <div class="input-required"></div>
                </label>
                <label class="form-inline">
                    <span>城市:</span>
                    <form:input type="text" path="city" cssClass="form-control"  required="ture"/>
                    <div class="input-required"></div>
                    <span>邮编:</span>
                    <form:input type="text" path="zipCode" cssClass="form-control" required="ture"/>
                    <div class="input-required"></div>
                </label>
                <label class="form-inline">
                    <span>详细地址:</span>
                    <form:input type="text" path="address" cssClass="form-control full-length" required="ture"/>
                    <div class="input-required"></div>
                </label>
            </div>
        </div>
        <div class="form-footer">
            <button type="submit" class="btn btn-primary">创建订单</button>
            <button type="reset" id="reset" class="btn btn-danger">重置</button>
        </div>
    </form:form>
</div>
<%@ include file="footer.jsp"%>
