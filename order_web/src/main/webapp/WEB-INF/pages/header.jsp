<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title>外贸公司订单管理助手</title>
    <meta charset="utf-8">
    <link rel="shortcut icon" type="image/x-icon" href="<c:url value='/resources/images/icon.png'/>" />
    <link rel="stylesheet" href="<c:url value='/resources/bootstrap/bootstrap.css'/>">
    <link rel="stylesheet" href="<c:url value='/resources/css/reset.css'/>">
    <link rel="stylesheet" href="<c:url value='http://at.alicdn.com/t/font_1095554_5j0vj103si6.css'/>">
    <link rel="stylesheet" href="<c:url value='/resources/css/index/index.css'/>">
    <link rel="stylesheet" href="<c:url value='/resources/css/order_list/order_list.css'/>">
    <link rel="stylesheet" href="<c:url value='/resources/css/page-bar/page-bar.css'/>">
    <link rel="stylesheet" href="<c:url value='/resources/css/create_order/create_order.css'/>">
    <link rel="stylesheet" href="<c:url value='/resources/css/prompt_window/prompt_window.css'/> ">
    <link rel="stylesheet" href="<c:url value='/resources/css/product_list/product_list.css'/> ">
    <link rel="stylesheet" href="<c:url value='/resources/css/create_product/create_product.css'/> ">
    <link rel="stylesheet" href="<c:url value='/resources/css/purchase_list/purchase_list.css'/> ">
    <link rel="stylesheet" href="<c:url value='/resources/css/select_product/select_product.css'/> ">
    <link rel="stylesheet" href="<c:url value='/resources/css/inventory_list/inventory_list.css'/> ">
    <link rel="stylesheet" href="<c:url value='/resources/common/header/header.css'/>">
    <link rel="stylesheet" href="<c:url value='/resources/common/hide-details/hide-details.css'/>">
</head>
<style type="text/css">
    @media screen and (max-width: 1200px) {
        html{
            width: 1200px;
        }
        .container > .container-item{
            width: 95%;
        }

    }
</style>
<body>
<header id="header" class="header">
    <div class="logo clearfix">
		<span>
			<i class="iconfont icon-dingdanguanli" style="font-size: 35px"></i>
		</span>
        <span class="separate title" style="transform: translateY(-10px)">外贸公司订单管理系统</span>
    </div>
    <nav class="header-nav">
        <ul class="nav-bar">
            <li class="nav-ul-item"><a class="active" id="index" href="<c:url value='/index'/>">首页</a></li>
            <li class="nav-ul-item">
                <a id="order" href="<c:url value='/order/order_list'/>">订单</a>
                <div class="triangle"></div>
                <div class="hide-details order">
                    <ul class="details-items">
                        <li class="details-item">
                            <label>创建订单</label>
                            <span><a href="<c:url value='/order/to_import_order'/> ">导入订单</a></span>
                            <span><a href="<c:url value='/order/to_create_order'/> ">手工创建</a></span>
                        </li>
                        <li class="details-item">
                            <label>订单处理</label><span><a href="<c:url value='/order/order_handle_list'/>">打包发货</a></span>
                        </li>
                        <li class="details-item">
                            <label>查看订单</label>
                            <span><a href="<c:url value='/order/order_list_shipped'/>">已发订单</a></span>
                            <span><a href="<c:url value='/order/order_list'/>">全部订单</a></span>
                        </li>
                    </ul>
                </div>
            </li>
            <li class="nav-ul-item">
                <a id="product" href="<c:url value='/product/product_list'/>">商品</a>
                <div class="triangle"></div>
                <div class="hide-details order">
                    <ul class="details-items">
                        <li class="details-item">
                            <label>商品列表</label>
                            <span><a href="<c:url value='/product/product_list'/>">查看商品</a></span>
                        </li>
                        <li class="details-item">
                            <label>商品管理</label>
                            <span><a href="<c:url value='/product/to_create_product'/>">创建商品</a></span>
                        </li>
                    </ul>
                </div>
            </li>
            <li class="nav-ul-item">
                <a id="purchase" href="<c:url value='/purchase/purchase_list'/> ">采购</a>
                <div class="triangle"></div>
                <div class="hide-details order">
                    <ul class="details-items">
                        <li class="details-item">
                            <label>采购管理</label>
                            <span>
                                <a href="<c:url value='/purchase/to_create_purchase'/>">新建采购</a>
                            </span>
                        </li>
                        <li class="details-item">
                            <label>采购记录</label>
                            <span>
                                <a href="<c:url value='/purchase/purchase_list'/> ">采购记录</a>
                            </span>
                        </li>
                    </ul>
                </div>
            </li>
            <li class="nav-ul-item">
                <a id="inventory" href="<c:url value='/inventory/inventory_list'/> ">库存</a>
                <div class="triangle"></div>
                <div class="hide-details order">
                    <ul class="details-items">
                        <li class="details-item">
                            <label>库存清单</label>
                            <span>
                                <a href="<c:url value='/inventory/inventory_list'/> ">查看库存</a>
                            </span>
                        </li>
                    </ul>
                </div>
            </li>
            <li class="nav-ul-item">
                <a href="<c:url value='/show_log'/>">数据</a>
                <div class="triangle"></div>
                <div class="hide-details order">
                    <ul class="details-items">
                        <li class="details-item">
                            <label>操作记录</label>
                            <span>
                                <a href="<c:url value='/show_log'/>">操作日志</a>
                            </span>
                        </li>
                    </ul>
                </div>
            </li>
            <li class="nav-ul-item">
                <a href="">帮助</a>
                <div class="triangle"></div>
                <div class="hide-details order">
                    <ul class="details-items">
                        <li class="details-item">
                            <label>用户帮助</label>
                            <span>
                                <a href="">用户帮助</a>
                            </span>
                        </li>
                    </ul>
                </div>
            </li>
        </ul>
    </nav>
    <div class="user">
        <span><i class="iconfont icon-denglu"></i>&nbsp;${user.username}</span>
        <a href="/order/logout">
            <span class="logout">注销</span>
        </a>
    </div>
</header><!-- /header -->
