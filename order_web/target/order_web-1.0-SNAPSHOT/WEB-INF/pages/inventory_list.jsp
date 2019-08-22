<%@include file="header.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="org.htp.order.global.Constant" %>
<div class="order-container">
    <div class="top-tips">
        <h4 class="">库存<span>/</span>库存清单</h4>
    </div>
</div>
<div class="inventory-container">
    <form class="form clearfix" rol="form" method="post" action="search_inventory">
        <div class="form-inline">
            <input type="text" class="form-control" name="sku" placeholder="支持SKU搜索">
            <button type="submit" class="btn btn-primary">搜索</button>
        </div>
    </form>
    <div class="inventory-list">
        <div class="product_operating">
            <a href="to_create_inventory">
                <button type="button" class="btn btn-success">添加库存商品</button>
            </a>
                <button type="button" id="beach_delete_inventory" class="btn btn-warning">批量删除</button>
        </div>
        <table class="table table-striped table-hover table-bordered">
            <thead class="table-header">
            <tr>
                <th>
                    <input type="checkbox" name="select-all" id="select-all">
                </th>
                <th>商品信息</th>
                <th>7天销量</th>
                <th>30天销量</th>
                <th>剩余库存</th>
                <th>库存更新时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${inventoryList}" var="inventory">
                <tr <c:if test="${inventory.stock <= 0}">class="danger"</c:if>>
                    <td>
                        <div class="info-checkbox">
                            <input type="checkbox" name="inventory-items">
                        </div>
                    </td>
                    <td style="width: 25%">
                        <div class="product-info">
                            <div class="product-image">
                                <img src="${inventory.product.imageUrl}" alt="">
                            </div>
                            <div class="other-info">
                                <span class="span-width" style="color: #428BCA;font-weight: bold">${inventory.product.sku}</span>
                                <span>${inventory.product.name}</span>
                            </div>
                        </div>
                    </td>
                    <td>
                        <div class="">
                            <span>${inventory.weekSale}</span>
                        </div>
                    </td>
                    <td>
                        <div class="">
                            <span>${inventory.monthSale}</span>
                        </div>
                    </td>
                    <td>
                        <div class="stock">
                            <span>${inventory.stock}</span>
                        </div>
                    </td>
                    <td>
                        <div>
                            <span><spring:eval expression="inventory.updateTime"/></span>
                        </div>
                    </td>
                    <td>
                        <div class="operating">
                            <button type="button" class="btn btn-primary">编辑库存</button>
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
            <a href="search_inventory?sku=${sku}&pageSize=${pageHelper.pageSize}&pageNum=1">
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
                <a href="search_inventory?sku=${sku}&pageSize=${pageHelper.pageSize}&pageNum=${i}">
                        ${i}
                </a>
            </li>
        </c:forEach>
        <li>
            <a href="search_inventory?sku=${sku}&pageSize=${pageHelper.pageSize}&pageNum=${pageHelper.pages}">
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
<!--订单导出中提示-->
<div class="modal" id="themodal-loading" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <!-- 			<div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">导出订单</h4>
            </div> -->
            <div class="modal-body">
                <div class="exporting">
                    <img src="<c:url value='/resources/images/loading1.gif'/> ">
                    <span>处理中</span>
                </div>
            </div>
            <!-- 			<div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary">保存</button>
            </div> -->
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!--修改提示-->
<div class="modal fade" id="inventory-details" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">库存信息</h4>
            </div>
            <div class="modal-body">
                <form class="purchase-form" id="purchase-form" method="post" action="/order/inventory/update_inventory">
                    <div class="product-info">
                        <div class="product-image">
                            <img id="product-image" src="">
                        </div>
                        <div class="product-sku">
                            <span id="product-sku"></span>
                            <input type="hidden" name="linkSku" value="">
                        </div>
                    </div>
                    <div class="default-inventory">
                        <label>
                            <span>默认库存:</span>
                            <input type="text" value="0" name="stock" required class="form-control">
                        </label>
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
    //跳页
    $('#goto').on('change',function () {
        $('#goto_href').attr('href','search_inventory?sku=${sku}&pageSize=${pageHelper.pageSize}&pageNum='+$('#goto').val());
    });
</script>
<script>
    $('.inventory-list').on('click','.operating',function(){
        $('#inventory-details').modal('toggle');
        let parent_tr = $(this).parents('tr');
        let product_sku = $(parent_tr[0]).find('span')[0].innerHTML;
        let stock = $($(parent_tr[0]).find('span')[4]).text();
        let image_url = $($(parent_tr[0]).find('img')[0]).attr('src');
        $('#product-image').attr('src',image_url);
        $('#product-sku').text(product_sku);
        $('.product-sku input[name="linkSku"]').attr('value',product_sku);
        $('input[name="stock"]').val(stock);
    });
    $('#confirm-purchase').on('click',function(){
        $('#purchase-form-submit').click();
    });

    //全选删除
    $('.table-header').on('click','#select-all',function(){
        $('.info-checkbox input[name="inventory-items"]').each(function(){
            this.checked = $('#select-all').get(0).checked;
            $(this).attr("checked",$('#select-all').prop("checked"));
        });
    });
    $('.info-checkbox').on('click','input[name="inventory-items"]',function(){
        let isChecked = $(this).prop("checked");
        if(isChecked){
            $(this).attr("checked","true");
        }else{
            $(this).removeAttr("checked");
        }
    });
    $('#beach_delete_inventory').on('click',function(){
       let selectArray = $('.info-checkbox input[checked="checked"]').parents('tr');
       let skuList = [];
       for(let i=0;i<selectArray.length;i++){
           let spans = $(selectArray[i]).find('span');
           if(spans.length>0){
               skuList.push(
                   {
                       id:$(spans[0]).html()
                   }
               )
           }
       }
       if(skuList.length < 1){
           alert("请选择要删除的记录");
       }else{
           $('#themodal-loading').modal("toggle");
           $.ajax({
               url:'batch_delete_inventory',
               method:'post',
               datatype:'json',
               contentType:'application/json',
               data:JSON.stringify(skuList),
               success:function(){
                   window.location.href = "inventory_list";
               },
               error:function(){
                   alert('操作失败！');
               }
           })
       }
    });
</script>
<%@include file="footer.jsp"%>