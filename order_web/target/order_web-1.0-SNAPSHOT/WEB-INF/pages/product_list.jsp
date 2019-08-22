<%@include file="header.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="order-container">
    <div class="top-tips">
        <h4 class="">商品<span>/</span>商品列表</h4>
    </div>
</div>
<div class="product-container">
    <form class="form pull-right" id="product-form" rol="form" method="post" action="search_product">
        <div class="form-inline" id="form-inline">
            <input type="text" class="form-control" name="search_option" placeholder="支持SKU/名称/别名搜索">
            <button type="submit" class="btn btn-primary">搜索</button>
        </div>
    </form>
    <div class="product_list">
        <div class="product_oprating">
            <a href="/order/product/to_create_product">
                <button type="button" class="btn btn-success">添加商品</button>
            </a>
            <button type="button" id="beach-delete-product" class="btn btn-warning" style="margin-left: 10px;">批量删除</button>
        </div>
        <table class="table table-striped table-hover table-bordered">
            <thead class="table-header">
            <tr>
                <th>
                    <input type="checkbox" name="select-all" id="select-all">
                </th>
                <th>商品图片</th>
                <th>商品名称</th>
                <th>配货简称</th>
                <th>商品SKU</th>
                <th>创建时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${productList}" var="product">
                <tr>
                    <td>
                        <div class="product-checkbox">
                            <input type="checkbox" name="product-items">
                        </div>
                    </td>
                    <td>
                        <div class="">
                            <img src="${product.imageUrl}">
                        </div>
                    </td>
                    <td>
                        <div class="">
                            <span>${product.name}</span>
                        </div>
                    </td>
                    <td>
                        <div class="">
                            <span>${product.nickname}</span>
                        </div>
                    </td>
                    <td>
                        <div class="">
                            <span>${product.sku}</span>
                        </div>
                    </td>
                    <td>
                        <div class="">
                            <span><spring:eval expression="product.createTime"/></span>
                        </div>
                    </td>
                    <td style="width: 16%">
                        <div class="product-edit">
                            <a href="to_product_update?sku=${product.sku}">
                                <button type="button" class="btn btn-primary">编辑</button>
                            </a>
                            <a href="delete_product?sku=${product.sku}">
                                <button type="button" class="btn btn-danger">删除</button>
                            </a>
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
            <a href="search_product_by_page?search_option=${search_option}&pageSize=${pageHelper.pageSize}&pageNum=1">
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
                <a href="search_product_by_page?search_option=${search_option}&pageSize=${pageHelper.pageSize}&pageNum=${i}">
                        ${i}
                </a>
            </li>
        </c:forEach>
        <li>
            <a href="search_product_by_page?search_option=${search_option}&pageSize=${pageHelper.pageSize}&pageNum=${pageHelper.pages}">
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
</div>
<!-- /.modal -->
<!--提示下载订单-->
<div class="modal" id="themodal-download" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="exporting">
                    <img src="<c:url value='/resources/images/success.png'/>">
                    <span>操作成功！</span>
                </div>
            </div>
            <div class="modal-footer">
                <a href="" id="file-download">
                    <button type="button" class="btn btn-primary">下载</button>
                </a>
                <button type="button" class="btn btn-danger" data-dismiss="modal">取消</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<!--提示申请运单号-->
<div class="modal" id="order-shipping" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title">订单发货</h4>
            </div>
            <div class="modal-body">
                <div class="edit-order-status">
                    <label class="form-inline">
                        <span>选择渠道：</span>
                        <select id="select-channel" class="select-channel form-control">
                            <option value="">选择发货渠道</option>
                            <option value="GZEUB">广州E邮宝</option>
                            <option value="PostNL">PostNL</option>
                            <option value="BJEUB">北京E邮宝</option>
                        </select>
                    </label>
                    <label class="form-inline">
                        <span>物流单号：</span>
                        <input type="text" name="select-tracking-number" id="select-tracking-number"
                               class="select-tracking-number form-control">
                        <button id="apply-tracking-number" type="button" class="btn btn-info">申请单号</button>
                    </label>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id="confirm-shipping" href="" class="btn btn-primary">确认发货</button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">取消</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<script src="<c:url value='/resources/js/jquery-3.3.1.js'/>"></script>
<script>
    //跳转
    $('#goto').on('change', function () {
        $('#goto_href').attr('href', 'search_product_by_page?search_option=${search_option}&pageSize=${pageHelper.pageSize}&pageNum=' + $('#goto').val());
        console.log($('#goto_href').attr('href'));
    });
    $('.table-header').on('click', '#select-all', function () {
        $('.product-checkbox input[name="product-items"]').each(function () {
            this.checked = $('#select-all').get(0).checked;
            $(this).attr("checked", $('#select-all').prop("checked"));
        });
    });
    $('.product-checkbox').on('click', 'input', function () {
        var isCheacked = $(this).prop("checked");
        console.log(isCheacked);
        if (isCheacked) {
            $(this).attr("checked", "true");
        } else {
            $(this).removeAttr("checked");
        }
    });
    $('#beach-delete-product').on('click',function(){
        let selectArray = $('.product-checkbox input[checked="checked"]').parents('tr');
        let skuList = [];
        for(let i=0;i<selectArray.length;i++){
            let spans = $(selectArray[i]).find('span');
            if(spans.length>0){
                skuList.push({
                    id:$(spans[2]).html()
                });
            }
        }
        if(skuList.length < 1){
            alert("请先选中订单");
        }else{
            $('#themodal-loading').modal("toggle");
            $.ajax({
                url:'batch_delete_product',
                method:'post',
                datatype:'jason',
                contentType:'application/json',
                data:JSON.stringify(skuList),
                success:function(){
                    window.location.href = "product_list";
                },
                error:function(){
                    alert("删除失败！");
                }
            });
        }
    });
</script>
<%@include file="footer.jsp" %>