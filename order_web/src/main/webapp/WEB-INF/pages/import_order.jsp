<%@include file="header.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="<c:url value='/resources/css/order_import/order_import.css'/>">
<div class="order-import">
    <div class="top-tips">
        <h4 class="">订单<span>/</span>导入订单</h4>
    </div>
    <form class="form" rol="form" method="POST" enctype="multipart/form-data" action="import_order?name=name">
        <div class="form-group form-inline">
            <input type="file" name="file" class="form-control">
            <a href="/order/resources/exportFiles/订单导入模板.xlsx" style="color: #4cae4c;border-bottom:1px solid #4cae4c;display: inline-block;padding: 4px 12px;margin-left: 20px">没有导入模板？点击下载&nbsp;&gt;&gt;</a>
        </div>
        <div class="form-group">
            <button type="submit" class="btn btn-primary">
                导入
            </button>
        </div>
    </form>
    <div class="import-note">
        <c:if test="${msg != null}">
            <span>导入成功！</span>
        </c:if>
    </div>
</div>
<%@ include file="footer.jsp"%>
