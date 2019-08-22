<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:if test="${sessionScope.user != null}">
    <%@ include file="header.jsp"%>
</c:if>
<c:if test="${sessionScope.user == null}">
    <html>
    <head>
        <title>404ERROR</title>
        <link rel="stylesheet" href="<c:url value='/resources/bootstrap/bootstrap.css'/> ">
    </head>
    <body>
</c:if>
<div class="container">
    <div class="row" style="width: 45%;margin: 80px auto;">
        <div class="panel panel-danger">
            <div class="panel-heading"><h4>500错误</h4></div>
            <p></p>
            <p></p>
            <div class="panel-body"><b>错误信息：</b>500服务器内部错误</div>
            <p></p>
            <p></p>
            <div class="panel-footer">
                <div class="row">
                    <div class="pull-right">
                        <a href="/order/index">
                            <button type="button" class="btn btn-primary">
                                返回首页
                            </button>
                        </a>
                        <a href="#" onClick="javascript :history.go(-1);" style="margin:0 30px 30px;">
                            <button type="button" class="btn btn-danger">
                                返回上一页
                            </button>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>
