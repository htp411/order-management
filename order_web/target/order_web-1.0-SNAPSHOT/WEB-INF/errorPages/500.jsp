<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>505ERROR</title>
    <link rel="stylesheet" href="<c:url value='/resources/bootstrap/bootstrap.css'/> ">
</head>
<body>
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
                        <a href="index">
                            <button type="button" class="btn btn-primary">
                                返回首页
                            </button>
                        </a>
                        <a href="javascript :;" onClick="javascript :history.back(-1);" style="margin:0 30px 30px;">
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
<script src="<c:url value='/resources/js/jquery-3.3.1.js'/> "></script>
<script src="<c:url value='/resources/bootstrap/bootstrap.js'/>"></script>
</body>
</html>
