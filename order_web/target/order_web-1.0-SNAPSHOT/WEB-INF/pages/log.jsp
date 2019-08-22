<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@include file="header.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="order-container">
    <div class="top-tips">
        <h4 class="">日志<span>/</span>查看日志</h4>
    </div>
    <div class="search-bar">
        <form class="form" rol="form" method="post" action="search_log">
            <label class="form-inline">
                <span class="form-control">选择模块</span>
                <select class="form-control" name="module">
                    <option value="订单管理">订单管理</option>
                    <option value="商品管理">商品管理</option>
                    <option value="采购管理">采购管理</option>
                    <option value="库存管理">库存管理</option>
                    <option value="登陆系统">用户登录</option>
                </select>
            </label>
            <label class="form-inline">
                <span class="form-control">操作时间</span>
                <input type="date" name="start" class="form-control" >
                <input type="date" name="end"   class="form-control" >
            </label>
            <label class="form-inline">
                <button type="submit" class="btn btn-primary">搜索</button>
            </label>
        </form>
    </div>
    <div class="container-item">
        <table class="table table-striped table-hover table-bordered table-condensed" style="width:95%;margin: 20px auto;margin-bottom: 70px">
            <thead>
            <tr>
                <th>时间</th>
                <th>操作类型</th>
                <th>操作模块</th>
                <th>操作内容</th>
                <th>操作结果</th>
                <th>操作人</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${logs}" var="log">
                <tr>
                    <td><spring:eval expression="log.operatingTime"/></td>
                    <td>${log.type}</td>
                    <td>${log.module}</td>
                    <td>${log.operating}</td>
                    <td>${log.result}</td>
                    <td>${log.operator}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<div class="page-bar">
    <ul class="pagination">
        <li>
            <a href="search_log?module=${module}&start=${start}&end=${end}&pageSize=${pageHelper.pageSize}&pageNum=1">
                首页
            </a>
        </li>
        <c:if test="${pageHelper.pages>=5}">
            <c:set var="pageIndex" value="5"/>
        </c:if>
        <c:if test="${pageHelper.pages<5}">
            <c:set var="pageIndex" value="${pageHelper.pages}"/>
        </c:if>
        <c:forEach begin="1" end="${pageIndex}" var="i">
            <li <c:if test="${pageHelper.pageNum==i}">class="active" </c:if>>
                <a href="search_log?module=${module}&start=${start}&end=${end}&pageSize=${pageHelper.pageSize}&pageNum=${i}">
                        ${i}
                </a>
            </li>
        </c:forEach>
        <li>
            <a href="search_log?module=${module}&start=${start}&end=${end}&pageSize=${pageHelper.pageSize}&pageNum=${pageHelper.pages}">
                尾页
            </a>
        </li>
        <li class="disabled"><a style="color:#909090">${pageHelper.pageNum}/${pageHelper.pages}</a></li>
        <li class="disabled"><a style="color:#909090">共${pageHelper.total}条</a></li>
    </ul>
    <div class="input-group">
        <input type="number" class="form-control" id="goto">
        <span class="input-group-addon"><a id="goto_href">跳转</a></span>
    </div>
</div>
<script src="<c:url value='/resources/js/jquery-3.3.1.js'/>"></script>
<script>
    //跳页
    $('#goto').on('change',function () {
        $('#goto_href').attr('href','search_log?module=${module}&start=${start}&end=${end}&pageSize=${pageHelper.pageSize}&pageNum='+$('#goto').val());
    });
</script>
<%@include file="footer.jsp" %>
