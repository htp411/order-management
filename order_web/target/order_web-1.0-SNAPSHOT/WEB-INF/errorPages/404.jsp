<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
    <title>404ERROR</title>
    <link rel="stylesheet" href="${pageContext.request.getContextPath()}/resources/css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <div class="row" style="width: 45%;margin: 80px auto;">
        <div class="panel panel-danger">
            <div class="panel-heading"><h4>404错误</h4></div>
            <p></p>
            <p></p>
            <div class="panel-body"><b>错误信息：</b>404无法找到指定页面</div>
            <p></p>
            <p></p>
            <div class="panel-footer">
                <div class="row">
                    <div class="pull-right">
                        <a href="${pageContext.request.getContextPath()}/book/list.do?isIndex=true">
                            <button type="button" class="btn btn-primary">
                                返回首页
                            </button>
                        </a>
                        <a href="${pageContext.request.getContextPath()}/category/list.do" style="margin:0 30px 30px;">
                            <button type="button" class="btn btn-danger">
                                分类管理
                            </button>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.getContextPath()}/resources/js/jquery-3.3.1.min.js"></script>
<script src="${pageContext.request.getContextPath()}/resources/js/bootstrap.min.js"></script>
</body>
</html>
