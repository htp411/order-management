<%@include file="header.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="org.htp.order.global.Constant" %>
<div class="order-container">
    <div class="top-tips">
        <h4 class="">采购<span>/</span>采购记录</h4>
    </div>
</div>
<div class="purchase-container">
    <form class="form" rol="form" method="post" action="search_purchase">
        <div class="form-inline">
            <input type="text" class="form-control" name="sku" placeholder="支持SKU搜索">
            <button type="submit" class="btn btn-primary">搜索</button>
        </div>
    </form>
    <div class="purchase-list">
        <div class="product_operating">
            <a href="to_create_purchase">
                <button type="button" class="btn btn-success">新建采购单</button>
            </a>
        </div>
        <table class="table table-striped table-hover table-bordered">
            <thead>
            <th>采购单号</th>
            <th>商品信息</th>
            <th>采购金额</th>
            <th>创建时间</th>
            <th>采购状态</th>
            <th>采购备注</th>
            <th>操作</th>
            </thead>
            <tbody>
            <c:forEach items="${purchaseList}" var="purchase">
                <tr>
                    <td>
                        <div class="">
                            <span>${purchase.id}</span>
                        </div>
                    </td>
                    <td style="width: 25%">
                        <div class="product-info">
                            <div class="product-image">
                                <img src="${purchase.product.imageUrl}">
                            </div>
                            <div class="product-other">
                                <span class="sku span-width">${purchase.product.sku}</span>
                                <span style="display: none;">${purchase.product.price}</span>
                                <span style="display: none;">${purchase.quantity}</span>
                                <span class="nickname">${purchase.product.name}</span>
                                <span class="quantity">￥&nbsp;${purchase.product.price}*${purchase.quantity}</span>
                            </div>
                        </div>
                    </td>
                    <td>
                        <div class="">
                            <span>￥：${purchase.product.price * purchase.quantity}</span>
                        </div>
                    </td>
                    <td>
                        <div class="">
                            <span><spring:eval expression="purchase.createTime"/></span>
                        </div>
                    </td>
                    <td>
                        <div class="">
                            <span>${purchase.status}</span>
                        </div>
                    </td>
                    <td style="width: 20%">
                        <div class="">
                            <span>${purchase.note}</span>
                        </div>
                    </td>
                    <td>
                        <div class="operating">
                            <c:if test="${purchase.status == Constant.PURCHASE_STATUS_CREATED}">
                                <button type="button" class="btn btn-info confirm-arrive">到货</button>
                            </c:if>
                            <c:if test="${purchase.status == Constant.PURCHASE_STATUS_ARRIVED}">
                                <a href="storage?id=${purchase.id}">
                                    <button type="button" class="btn btn-success storage">入库</button>
                                </a>
                            </c:if>
                            <button type="button" class="btn btn-warning edit">编辑</button>
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
            <a href="search_purchase?sku=${sku}&pageSize=${pageHelper.pageSize}&pageNum=1">
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
                <a href="search_purchase?sku=${sku}&pageSize=${pageHelper.pageSize}&pageNum=${i}">
                        ${i}
                </a>
            </li>
        </c:forEach>
        <li>
            <a href="search_purchase?sku=${sku}&pageSize=${pageHelper.pageSize}&pageNum=${pageHelper.pages}">
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
<!--修改备注提示-->
<div class="modal fade" id="purchase-details" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">编辑采购单</h4>
            </div>
            <div class="modal-body">
                <form class="purchase-form" id="purchase-form" method="post" action="update_purchase">
                    <div class="purchase-info">
                        <label class="form-inline">
                            <span>采购数量：</span>
                            <input type="text" class="form-control" name="quantity" required="required" readonly>
                        </label>
                        <label class="form-inline">
                            <span>采购单价：</span>
                            <input type="text" class="form-control" name="price" required="required" readonly>
                        </label>
                    </div>
                    <div class="product-info">
                        <div class="product-image">
                            <img id="product-image" src="">
                        </div>
                        <div class="product-sku">
                            <span id="product-sku"></span>
                            <input type="hidden" name="linkSku" value="">
                            <input type="hidden" name="id" value="">
                        </div>
                    </div>
                    <div class="purchase-note">
                        <span>采购单备注：</span>
                        <textarea  type="textarea" name="note" class="form-control"></textarea>

                    </div>
                    <button type="submit" style="display: none" id="purchase-form-submit"></button>
                </form>
            </div>
            <div class="modal-footer">
                <button type="submit" id="confirm-update" href="" class="btn btn-primary">提交</button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">取消</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!--确认到货提示-->
<div class="modal fade" id="purchase-arrive" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">确认到货</h4>
            </div>
            <div class="modal-body">
                <p style="text-align: center;margin: 20px auto;">确认采购商品已到货？</p>
            </div>
            <div class="modal-footer">
                <button type="submit" id="confirm-arrive" href="" class="btn btn-primary">确认</button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">取消</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<script src="<c:url value='/resources/js/jquery-3.3.1.js'/>"></script>
<script>
    //跳转
    $('#goto').on('change', function () {
        $('#goto_href').attr('href', 'search_purchase?sku=${sku}&pageSize=${pageHelper.pageSize}&pageNum=' + $('#goto').val());
        console.log($('#goto_href').attr('href'));
    });
    $('.purchase-list').on('click','.edit',function(){
        $('#purchase-details').modal('toggle');
        let parent_tr = $(this).parents('tr');
        let id = $($(parent_tr[0]).find('span')[0]).text();
        let product_sku = $($(parent_tr[0]).find('span')[1]).text();
        let price = $($(parent_tr[0]).find('span')[2]).text();
        let quantity = $($(parent_tr[0]).find('span')[3]).text();
        let note = $($(parent_tr[0]).find('span')[9]).text();
        let image_url = $($(parent_tr[0]).find('img')[0]).attr('src');
        $('.purchase-info input[name="quantity"]').val(quantity);
        $('.purchase-info input[name="price"]').val(price);
        $('#product-sku').text(product_sku);
        $('.product-sku input[name="linkSku"]').attr('value',product_sku);
        $('.product-sku input[name="id"]').attr('value',id);
        $('.purchase-note textarea[name="note"]').val(note);
        $('#product-image').attr('src',image_url);
    });
    $('#confirm-update').on('click',function(){
        $('#purchase-form-submit').click();
    });
    $('.purchase-list').on('click','.confirm-arrive',function(){
        $('#purchase-arrive').modal('toggle');
        let parent_tr = $(this).parents('tr');
        let id = $($(parent_tr[0]).find('span')[0]).text();
        $('#confirm-arrive').attr('href','update_purchase_status?id='+id+'&status=已到货');
    });
    $('#purchase-arrive').on('click','#confirm-arrive',function(){
        window.location.href = $('#confirm-arrive').attr('href');
    });
</script>
<%@include file="footer.jsp"%>