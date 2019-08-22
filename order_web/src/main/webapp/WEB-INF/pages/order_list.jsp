<%@include file="header.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="org.htp.order.global.Constant" %>
<div class="order-container">
    <div class="top-tips">
        <h4 class="">订单<span>/</span>订单管理</h4>
    </div>
    <div class="search-bar">
        <form class="form" rol="form" action="search_orders" method="post">
            <label class="form-inline">
                <select class="form-control" name="option">
                    <option value="id">订单ID</option>
                    <option value="online_sku">线上SKU</option>
                    <option value="tracking_number">跟踪号</option>
                    <option value="username">买家名称</option>
                </select>
                <input type="text" name="option_detail" class="form-control" autocomplete="off">
            </label>
            <label class="form-inline">
                <span class="form-control">国家</span>
                <input type="text" name="country" class="form-control" >
            </label>
            <label class="form-inline">
                <span class="form-control">订单时间</span>
                <input type="date" name="start"  class="form-control">
                <input type="date" name="end"  class="form-control">
            </label>
            <label class="form-inline">
                <span class="form-control">订单状态</span>
                <select class="form-control" name="order_status">
                    <option value="">选择状态</option>
                    <option value="${Constant.ORDER_STATUS_WAITING}">${Constant.ORDER_STATUS_WAITING}</option>
                    <option value="${Constant.ORDER_STATUS_SHIPPED}">${Constant.ORDER_STATUS_SHIPPED}</option>
                    <option value="${Constant.ORDER_STATUS_REFUND}">${Constant.ORDER_STATUS_REFUND}</option>
                </select>
            </label>
            <label class="form-inline">
                <button type="submit" class="btn btn-primary">搜索</button>
            </label>
        </form>
        <div class="search-tip">
            <span>
                当前搜索条件：
            </span>
            <c:if test="${statusSearch == true}">
                <span>待处理订单</span>
            </c:if>
            <c:if test="${statusSearch != true}">
                <c:if test="${defaultSearch == true}">
                    <span>全部订单</span>
                </c:if>
                <c:if test="${defaultSearch == false}">
                    <c:if test="${searchInfoIsEmpty == true}"><span>全部订单</span></c:if>
                    <c:if test="${searchInfoIsEmpty == false}">
                        <c:if test="${searchInfo.option == 'id' and searchInfo.option_detail != '' and searchInfo.option_detail != null }"><span>订单ID：${searchInfo.option_detail}</span></c:if>
                        <c:if test="${searchInfo.option == 'online_sku' and searchInfo.option_detail != '' and searchInfo.option_detail != null }"><span>线上SKU：${searchInfo.option_detail}</span></c:if>
                        <c:if test="${searchInfo.option == 'tracking_number' and searchInfo.option_detail != '' and searchInfo.option_detail != null}"><span>物流单号：${searchInfo.option_detail}</span></c:if>
                        <c:if test="${searchInfo.option == 'username' and searchInfo.option_detail != '' and searchInfo.option_detail != null }"><span>买家名称：${searchInfo.option_detail}</span></c:if>
                        <c:if test="${searchInfo.country != '' and searchInfo.country != null}"><span>国家：${searchInfo.country}</span></c:if>
                        <c:if test="${searchInfo.start != '' and searchInfo.end != '' and searchInfo.start != null and searchInfo.end != null}"><span>订单时间：${searchInfo.start}&nbsp;-&nbsp;${searchInfo.end}</span></c:if>
                        <c:if test="${shipped == true}">
                            <c:if test="${searchInfo.order_status !='' and searchInfo.order_status != null }"><span>订单状态:已发货</span></c:if>
                        </c:if>
                        <c:if test="${shipped != true}">
                            <c:if test="${searchInfo.order_status !='' and searchInfo.order_status != null }"><span>订单状态：${searchInfo.order_status}</span></c:if>
                        </c:if>
                    </c:if>
                </c:if>
            </c:if>
        </div>
    </div>
    <div class="container-item">
        <div class="all-order" id="all-order">
            <div class="out-port">
                    <span>订单操作&nbsp;：</span>
                    <button type="button" id="out-port" class="btn btn-primary pull-right pull-right" >导出</button>
            </div>
            <div class="order-table">
                <table class="table table-striped table-hover table-bordered">
                    <thead class="table-header">
                    <th>
                        <input type="checkbox" name="select-all" id="select-all">
                    </th>
                    <th>订单ID</th>
                    <th>产品</th>
                    <th>买家</th>
                    <th>时间</th>
                    <th>物流</th>
                    <th>状态</th>
                    <th>操作</th>
                    </thead>
                    <tbody>
                    <c:forEach items="${orders}" var="order">
                        <tr class="order-info">
                            <td>
                                <div class="info-checkbox">
                                    <input type="checkbox" name="order-items">
                                </div>
                            </td>
                            <td>
                                <div class="info-orderId">
                                    <span>${order.id}</span>
                                </div>
                            </td>
                            <td>
                                <div class="info-product">
                                    <div class="product-image">
                                        <img src="${order.productImageUrl}">
                                    </div>
                                    <div class="product-details">
                                        <span>$${order.productPrice}*${order.productQuantity}</span>
                                        <span>${order.productOnlineSku}</span>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="info-buyer">
                                    <div class="buyer">
                                        <span class="buyer-country"><i class="iconfont icon-guojiapitchon"></i>${order.country}</span>
                                    </div>
                                    <div class="buyer">
                                        <span><i class="iconfont icon-denglu"></i> ${order.username}</span>
                                    </div>
                                </div>
                            </td>
                            <td style="width: 16%">
                                <div class="info-time">
                                    <span>下单：<spring:eval expression="order.createTime"/></span>
                                    <c:if test="${order.deliveryTime != null}">
                                        <span>发货：<spring:eval expression="order.deliveryTime"/></span>
                                    </c:if>
                                </div>
                            </td>
                            <td>
                                <div class="info-shipping">
                                    <div class="channel <c:if test="${order.channel == null or order.channel == '' }">channel-null</c:if> ">
                                        <span class="buyer-country">
                                            <i class="iconfont icon-daifahuo"></i>
                                            <c:if test="${order.channel != null and order.channel != '' }">${order.channel}</c:if>
                                            <c:if test="${order.channel == null or order.channel == '' }">未选择物流渠道</c:if>
                                        </span>
                                    </div>
                                    <div class="tracking-number <c:if test="${order.trackingNumber == null or order.trackingNumber == '' }">tracking-number-null</c:if>">
                                        <span>
                                            <i class="iconfont icon-tiaoxingma"></i>
                                            <c:if test="${order.trackingNumber != null and order.trackingNumber != '' }">${order.trackingNumber}</c:if>
                                            <c:if test="${order.trackingNumber == null or order.trackingNumber == '' }">未分配物流单号</c:if>
                                        </span>
                                    </div>
                                </div>
                            </td>
                            <td style="width:6%">
                                <div class="info-status">
                                    <button type="button" class="waiting
                                        <c:if test="${order.orderStatus.equals('已发货')}">shipped</c:if>
                                        <c:if test="${order.orderStatus.equals('已退款')}">refund</c:if>  ">
                                            ${order.orderStatus}</button>
                                </div>
                            </td>
                            <td style="width: 8%">
                                <div class="info-edit" style="display:flex;flex-direction: column;align-items: center;justify-content: center;padding:20px 0">
                                    <c:if test="${order.orderStatus == Constant.ORDER_STATUS_WAITING}">
                                        <div class="info-status" style="margin-top: 10px">
                                            <button class="to_delivery btn btn-success" id="${order.id}" type="button">发货</button>
                                        </div>
                                    </c:if>
                                    <a href="to_order_update?id=${order.id}" style="margin-top: 10px">
                                        <button type="button" class="btn btn-default">
                                            <i class="iconfont icon-bianjiedit26"></i>编辑
                                        </button>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="cover_bottom-line">
    </div>
</div>
<div class="page-bar">
    <ul class="pagination">
        <li>
            <a href="search_orders_by_page?option=${searchInfo.option}&option_detail=${searchInfo.option_detail}&country=${searchInfo.country}&start=${searchInfo.start}&end=${searchInfo.end}&order_status=${searchInfo.order_status}&pageSize=${pageHelper.pageSize}&pageNum=1">
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
                <a href="search_orders_by_page?option=${searchInfo.option}&option_detail=${searchInfo.option_detail}&country=${searchInfo.country}&start=${searchInfo.start}&end=${searchInfo.end}&order_status=${searchInfo.order_status}&pageSize=${pageHelper.pageSize}&pageNum=${i}">
                    ${i}
                </a>
            </li>
        </c:forEach>
        <li>
            <a href="search_orders_by_page?option=${searchInfo.option}&option_detail=${searchInfo.option_detail}&country=${searchInfo.country}&start=${searchInfo.start}&end=${searchInfo.end}&order_status=${searchInfo.order_status}&pageSize=${pageHelper.pageSize}&pageNum=${pageHelper.pages}">
                尾页
            </a>
        </li>
        <li class="disabled"><a style="color:#909090">${pageHelper.pageNum}/${pageHelper.pages}</a></li>
        <li class="disabled"><a style="color:#909090">共${pageHelper.total}条</a></li>
    </ul>
    <div class="input-group">
        <input type="number" class="form-control" id="goto" >
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
                    <span>处理中...</span>
                </div>
            </div>
            <!-- 			<div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary">保存</button>
            </div> -->
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
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
</div><!-- /.modal -->
<!--提示申请运单号-->
<div class="modal" id="order-shipping" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">订单发货</h4>
            </div>
            <div class="modal-body">
                <div class="edit-order-status">
                    <label class="form-inline">
                        <span>选择渠道：</span>
                        <select id="select-channel" class="select-channel form-control" >
                            <option value="">选择发货渠道</option>
                            <option value="广州E邮宝">广州E邮宝</option>
                            <option value="深圳E邮宝">深圳E邮宝</option>
                            <option value="北京E邮宝">北京E邮宝</option>
                            <option value="荷兰小包">荷兰小包</option>
                            <option value="土耳其平邮">土耳其平邮</option>
                            <option value="土耳其小包">土耳其小包</option>
                            <option value="中邮平邮">中邮平邮</option>
                        </select>
                    </label>
                    <label class="form-inline">
                        <span>物流单号：</span>
                        <input type="text" name="select-tracking-number" id="select-tracking-number" class="select-tracking-number form-control">
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
</div><!-- /.modal -->
<script src="<c:url value='/resources/js/jquery-3.3.1.js'/>"></script>
<script>
    //跳转
    $('#goto').on('change',function () {
        $('#goto_href').attr('href','search_orders_by_page?option=${searchInfo.option}&option_detail=${searchInfo.option_detail}&country=${searchInfo.country}&start=${searchInfo.start}&end=${searchInfo.end}&order_status=${searchInfo.order_status}&pageSize=${pageHelper.pageSize}&pageNum='+$('#goto').val());
        console.log($('#goto_href').attr('href'));
    });
    //导出选中数据
    $('.table-header').on('click','#select-all',function(){
        $('.info-checkbox input[name="order-items"]').each(function(){
            this.checked = $('#select-all').get(0).checked;
            $(this).attr("checked",$('#select-all').prop("checked"));
        });
    });
    $('.info-checkbox').on('click','input[name="order-items"]',function(){
        let isChecked = $(this).prop("checked");
        if(isChecked){
            $(this).attr("checked","true");
        }else{
            $(this).removeAttr("checked");
        }
    });
    $('#out-port').on('click',function(){
        let selectArr = $('.info-checkbox input[checked="checked"]').parents("tr");
        let IDList = [];
        for(let i=0;i<selectArr.length;i++){
            let spans = $(selectArr[i]).find('span');
            if(spans.length>0){
                IDList.push({
                    id:$(spans[0]).html()
                });
            }
        }
        if(IDList.length < 1){
            alert("请先选中订单");
        }else{
            $('#themodal-loading').modal("toggle");
            $.ajax({
                url:'export_order',
                method :'POST',
                datatype:'json',
                contentType:'application/json',
                data:JSON.stringify(IDList),
                success:function(data){
                    $('#themodal-loading').modal("toggle");
                    $('#themodal-download').modal("toggle");
                    data += '';
                    data = data.slice(data.lastIndexOf('\\')+1,data.length);
                    console.log(data);
                    let url = window.location.href;
                    console.log('url'+url);
                    url = url.slice(0,url.indexOf('/order/')+7);
                    console.log('url'+url);
                    $('#file-download').attr('href',url+data);
                },
                error:function (data) {
                    console.log(IDList);
                    console.log(data.responseText);
                }
            })
        }
    });
    $('.to_delivery').on('click',function(){
        $('#confirm-shipping').attr('href',$(this).attr('id'));
        $('#order-shipping').modal('toggle');

    });
    $('#apply-tracking-number').on('click',function(){
        let tracking_number = '';
        for(let i=0;i<8;i++){
            tracking_number += Math.floor(Math.random()*10);
        }
        if($('#select-channel').val() == '广州E邮宝'){
            tracking_number = 'LX'+tracking_number+'CN';
        }else if($('#select-channel').val() == '北京E邮宝'){
            tracking_number = 'LL'+tracking_number+'CN';
        }else if($('#select-channel').val() == '深圳E邮宝'){
            tracking_number = 'LS'+tracking_number+'CN';
        }else if($('#select-channel').val() == '荷兰小包'){
            tracking_number = 'RU'+tracking_number+'NL';
        }else if($('#select-channel').val() == '土耳其平邮'){
            tracking_number = 'UH'+tracking_number+'TR';
        }else if($('#select-channel').val() == '土耳其小包'){
            tracking_number = 'RG'+tracking_number+'TR';
        }else if($('#select-channel').val() == '中邮平邮'){
            tracking_number = 'US'+tracking_number+'CN';
        }
        $('#select-tracking-number').attr('value',tracking_number);
    });
    $('#confirm-shipping').on('click',function(){
        let channel = $('#select-channel').val();
        let trackingNumber = $('#select-tracking-number').val();
        let id = $('#confirm-shipping').attr('href');
        let jsonArray = [];
        jsonArray.push({id:id,channel:channel,trackingNumber:trackingNumber});
        $('#order-shipping').modal("toggle");
        $('#themodal-loading').modal("toggle");
        $.ajax({
            url:'delivery_order',
            method: 'POST',
            datatype: 'json',
            contentType:'application/json',
            data:JSON.stringify(jsonArray),
            success:function () {
                window.location.href="order_list";
            },
            error:function(){
                alert('出现异常！');
            }
        });
    });
</script>
<%@include file="footer.jsp"%>