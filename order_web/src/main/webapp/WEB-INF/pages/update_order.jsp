<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@include file="header.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="org.htp.order.global.Constant" %>
<div class="order-container">
    <div class="top-tips">
        <h4 class="">订单<span>/</span>修改订单信息</h4>
    </div>
</div>
<style>
    input{
        margin-right: 45px;
    }
</style>
<div class="create_order">
    <form:form class="form" rol="form" method="post" action="update_order"  modelAttribute="orders">
        <div class="panel">
            <div class="panel-heading">
                <h5>订单信息</h5>
            </div>
            <div class="panel-body">
                <label class="form-inline">
                    <span>订单ID:</span>
                    <form:input type="text" path="id" cssClass="form-control" required="ture" readonly="true"/>
                </label>
                <label class="form-inline">
                    <span>线上SKU:</span>
                    <form:input type="text" path="productOnlineSku" cssClass="form-control"  required="ture" readonly="true"/>
                    <span>关联SKU:</span>
                    <form:input type="text" path="productLinkSku" cssClass="form-control"/>
                </label>
                <label class="form-inline">
                    <span>订单金额:</span>
                    <form:input type="text" path="productPrice" cssClass="form-control"  required="ture" readonly="true"/>
                    <span>商品数量:</span>
                    <form:input type="text" path="productQuantity" cssClass="form-control" required="ture" readonly="true"/>
                </label>
            </div>
        </div>
        <div class="panel">
            <div class="panel-heading">
                <h5>物流信息</h5>
            </div>
            <div class="panel-body">
                <label class="form-inline">
                    <span>发货渠道:</span>
                    <form:input type="text" path="channel" cssClass="form-control"/>
                    <span>物流单号:</span>
                    <form:input type="text" path="trackingNumber" cssClass="form-control"/>
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
                </label>
                <label class="form-inline">
                    <span>电话/手机:</span>
                    <form:input type="text" path="tel" cssClass="form-control"  required="ture"/>
                </label>
                <label class="form-inline">
                    <span>国家:</span>
                    <form:input type="text" path="country" cssClass="form-control"  required="ture"/>
                    <span>省/州:</span>
                    <form:input type="text" path="state" cssClass="form-control" required="ture"/>
                </label>
                <label class="form-inline">
                    <span>城市:</span>
                    <form:input type="text" path="city" cssClass="form-control"  required="ture"/>
                    <span>邮编:</span>
                    <form:input type="text" path="zipCode" cssClass="form-control" required="ture"/>
                </label>
                <label class="form-inline">
                    <span>详细地址:</span>
                    <form:input type="text" path="address" cssClass="form-control full-length" required="ture"/>
                </label>
            </div>
        </div>
        <div class="form-footer">
            <button type="submit" class="btn btn-primary">确认修改</button>
            <a href="javascript :;" onClick="javascript :history.back(-1);">
                <button type="reset" id="reset" class="btn btn-danger">返回</button>
            </a>
        </div>
    </form:form>
</div>
<%@ include file="footer.jsp"%>
