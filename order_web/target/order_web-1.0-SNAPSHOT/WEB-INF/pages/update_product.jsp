<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@include file="header.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="org.htp.order.global.Constant" %>
<div class="order-container">
    <div class="top-tips">
        <h4 class="">商品<span>/</span>创建商品</h4>
    </div>
</div>
<div class="create-product">
    <div class="product-form">
        <form:form class="form" rol="form" method="post" enctype="multipart/form-data" action="update_product" modelAttribute="product">
            <div class="product-info">
                <div class="product">
                    <div class="panel">
                        <div class="panel-heading">
                            <span>商品信息</span>
                        </div>
                        <div class="panel-body">
                            <label class="form-inline">
                                <span>商品名称：</span>
                                <form:input type="text" cssClass="form-control" path="name" required="ture"/>&nbsp;&nbsp;<c>*</c>
                            </label>
                            <label class="form-inline">
                                <span>商品SKU：</span>
                                <form:input type="text" cssClass="form-control" path="sku" required="ture"/>&nbsp;&nbsp;<c>*</c>
                                <form:input type="text" cssClass="form-control" path="id" required="ture" cssStyle="display: none"/>
                            </label>
                            <label class="form-inline">
                                <span>商品简称：</span>
                                <form:input type="text" cssClass="form-control" path="nickname"/>
                            </label>
                            <label class="form-inline">
                                <span>商品价格：</span>
                                <form:input type="number" cssClass="form-control" path="price" required="ture"/>&nbsp;&nbsp;<c>*</c>
                            </label>
                            <label class="form-inline">
                                <span>商品图片：</span>
                                <form:input type="file" cssClass="form-control long-input" path="imageUrl"/>&nbsp;&nbsp;<c>*</c>
                            </label>
                            <label class="form-inline">
                                <span>商品备注：</span>
                                <form:input type="textarea" cssClass="form-control long-input" path="note" value=""/>
                            </label>
                        </div>
                    </div>
                </div>
                <div class="submit-bar">
                    <button type="submit" class="btn btn-primary">修改</button>
                    <a href="javascript :;" onClick="javascript :history.back(-1);">
                        <button type="reset" class="btn btn-danger">取消</button>
                    </a>
                </div>
            </div>
        </form:form>
    </div>
</div>
<%@include file="footer.jsp" %>
