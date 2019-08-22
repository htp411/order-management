<%@include file="header.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="org.htp.order.global.Constant" %>
<div class="order-container">
    <div class="top-tips">
        <h4 class="">采购<span>/</span>选择商品</h4>
    </div>
</div>
<div class="purchase-container">
    <div class="purchase-list">
        <table class="table table-striped table-hover table-bordered">
            <thead>
            <th>商品图片</th>
            <th>商品名称</th>
            <th>商品sku</th>
            <th>剩余库存</th>
            <th>操作</th>
            </thead>
            <tbody>
            <c:forEach items="${products}" var="product">
                <tr>
                    <td>
                        <div class="product-info">
                            <div class="product-image">
                                <img src="${product.imageUrl}">
                            </div>
                        </div>
                    </td>
                    <td style="width: 26%">
                        <div class="">
                            <span>${product.name}</span>
                        </div>
                    </td>
                    <td style="width: 26%">
                        <div class="">
                            <span>${product.sku}</span>
                        </div>
                    </td>
                    <td>
                        <div class="">
                            <span>50</span>
                        </div>
                    </td>
                    <td style="width: 12%">
                        <div class="operating">
                            <button type="button" class="btn btn-primary">创建采购单</button>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<div class="page-bar">
    <ul class="pagination">
        <li>
            <a href="to_create_purchase?pageSize=${pageHelper.pageSize}&pageNum=1">
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
                <a href="to_create_purchase?pageSize=${pageHelper.pageSize}&pageNum=${i}">
                        ${i}
                </a>
            </li>
        </c:forEach>
        <li>
            <a href="to_create_purchase?pageSize=${pageHelper.pageSize}&pageNum=${pageHelper.pages}">
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
<!--添加采购单提示-->
<div class="modal fade" id="purchase-details" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">采购单信息</h4>
            </div>
            <div class="modal-body">
                <form class="purchase-form edit" id="purchase-form" method="post" action="/order/purchase/create_purchase">
                    <div class="purchase-info">
                        <label class="form-inline">
                            <span>采购数量：</span>
                            <input type="number" class="form-control" name="quantity" required="ture">
                        </label>
                        <label class="form-inline">
                            <span>采购单价：</span>
                            <input type="number" class="form-control" name="price" required="ture">
                        </label>
                    </div>
                    <div class="product-info">
                        <div class="product-image">
                            <img id="product-image" src="">
                        </div>
                        <div class="product-sku">
                            <span id="product-sku"></span>
                            <input type="hidden" name="linkSku" value="">
                        </div>
                    </div>
                    <button type="submit" style="display: none" id="purchase-form-submit"></button>
                </form>
            </div>
            <div class="modal-footer">
                <button type="submit" id="confirm-purchase" href="" class="btn btn-primary">提交</button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">取消</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<script src="<c:url value='/resources/js/jquery-3.3.1.js'/>"></script>
<script>
    //跳转
    $('#goto').on('change', function () {
        $('#goto_href').attr('href', 'search_orders_by_page?option=${searchInfo.option}&option_detail=${searchInfo.option_detail}&country=${searchInfo.country}&start=${searchInfo.start}&end=${searchInfo.end}&order_status=${searchInfo.order_status}&pageSize=${pageHelper.pageSize}&pageNum=' + $('#goto').val());
        console.log($('#goto_href').attr('href'));
    });
    $('.purchase-list').on('click','.operating',function(){
        $('.purchase-info input[type="number"]').val('');
        $('#purchase-details').modal('toggle');
        let parent_tr = $(this).parents('tr');
        let product_sku = $(parent_tr[0]).find('span')[1].innerHTML;
        let image_url = $($(parent_tr[0]).find('img')[0]).attr('src');
        $('#product-image').attr('src',image_url);
        $('#product-sku').text(product_sku);
        $('.product-sku input[name="linkSku"]').attr('value',product_sku);
    });
    $('#confirm-purchase').on('click',function(){
        $('#purchase-form-submit').click();
    });
</script>
<%@include file="footer.jsp"%>