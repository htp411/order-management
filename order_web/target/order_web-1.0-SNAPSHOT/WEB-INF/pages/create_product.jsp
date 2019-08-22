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
        <form class="form" rol="form" method="post" enctype="multipart/form-data" action="create_product">
            <div class="product-info">
                <div class="product">
                    <div class="panel">
                        <div class="panel-heading">
                            <span>商品信息</span>
                        </div>
                        <div class="panel-body">
                            <label class="form-inline">
                                <span>商品名称：</span>
                                <input type="text" class="form-control" name="name" required="ture">&nbsp;&nbsp;<c>*</c>
                            </label>
                            <label class="form-inline">
                                <span>商品SKU：</span>
                                <input type="text" class="form-control" name="sku" required="ture">&nbsp;&nbsp;<c>*</c>
                            </label>
                            <label class="form-inline">
                                <span>商品简称：</span>
                                <input type="text" class="form-control" name="nickname" value="">
                            </label>
                            <label class="form-inline">
                                <span>商品价格：</span>
                                <input type="number" class="form-control" name="price" required="ture">&nbsp;&nbsp;<c>*</c>
                            </label>
                            <label class="form-inline">
                                <span>商品图片：</span>
                                <input type="file" class="form-control long-input" name="imageUrl" required="ture">&nbsp;&nbsp;<c>*</c>
                            </label>
                            <label class="form-inline">
                                <span>商品备注：</span>
                                <input type="textarea" class="form-control long-input" name="note" value="">
                            </label>
                        </div>
                    </div>
                </div>
                <div class="add-product">
                    <button id="add-product" type="button" class="btn btn-success">继续添加商品</button>
                </div>
                <div class="submit-bar">
                    <button type="submit" class="btn btn-primary">新建商品</button>
                    <button type="reset" class="btn btn-danger">重置</button>
                </div>
            </div>
        </form>
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
        $('#goto_href').attr('href', 'search_orders_by_page?option=${searchInfo.option}&option_detail=${searchInfo.option_detail}&country=${searchInfo.country}&start=${searchInfo.start}&end=${searchInfo.end}&order_status=${searchInfo.order_status}&pageSize=${pageHelper.pageSize}&pageNum=' + $('#goto').val());
        console.log($('#goto_href').attr('href'));
    });
    $('.table-header').on('click', '#select-all', function () {
        $('.product-checkbox input[name="product-items"]').each(function () {
            this.checked = $('#select-all').get(0).checked;
            $(this).attr("checked", $('#select-all').prop("checked"));
        });
    });
    $('.info-checkbox').on('click', 'input', function () {
        var isCheacked = $(this).prop("checked");
        console.log(isCheacked);
        if (isCheacked) {
            $(this).attr("checked", "true");
        } else {
            $(this).removeAttr("checked");
        }
    });
    $('#add-product').on('click',function(){
        let html = '<div class="product">\n'+
            '<div class="panel">\n'+
            '<div class="panel-heading">\n'+
            '<span>商品信息</span>'+
            '</div>\n'+
            '<div class="panel-body">\n'+
            '<label class="form-inline">\n'+
            '<span>商品名称：</span>\n'+
            '<input type="text" class="form-control" name="name" required="ture">&nbsp;&nbsp;<c>*</c>\n'+
            '</label>\n'+
            '<label class="form-inline">\n'+
            '<span>商品SKU：</span>\n'+
            '<input type="text" class="form-control" name="sku" required="ture">&nbsp;&nbsp;<c>*</c>\n'+
            '</label>\n'+
            '<label class="form-inline">\n'+
            '<span>商品简称：</span>\n'+
            '<input type="text" class="form-control" name="nickname" value="">\n'+
            '</label>\n'+
            '<label class="form-inline">\n'+
            '<span>商品价格：</span>\n'+
            '<input type="number" class="form-control" name="price" required="ture">&nbsp;&nbsp;<c>*</c>\n'+
            '</label>\n'+
            '<label class="form-inline">\n'+
            '<span>商品图片：</span>\n'+
            '<input type="file" class="form-control long-input" name="imageUrl" required="ture">&nbsp;&nbsp;<c>*</c>\n'+
            '</label>\n'+
            '<label class="form-inline">\n'+
            '<span>商品备注：</span>\n'+
            '<input type="textarea" class="form-control long-input" name="note" value="">\n'+
            '</label>\n'+
            '</div>\n'+
            '</div>\n'+
            '</div>\n';
        $('.submit-bar').before(html);
    });
</script>
<%@include file="footer.jsp" %>
