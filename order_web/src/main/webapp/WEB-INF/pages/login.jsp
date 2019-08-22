<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>用户登陆</title>
    <meta charset="utf-8">
    <meta name="viewport" charset="width=device-width,initial-scale=1,maximum-scale=1,minimum-scale=1,user-scalable=no">
    <link rel="shortcut icon" type="image/x-icon" href="<c:url value='/resources/images/icon.png'/>" />
    <link rel="stylesheet" href="<c:url value='/resources/bootstrap/bootstrap.css'/>">
    <link rel="stylesheet" href="<c:url value='/resources/fonts/iconfont.css'/>">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/login.css'/>">
</head>
<style type="text/css">
    @media screen and (min-width: 1920px){
        body,#header,#footer{
            width: 1920px;
            margin: 0 auto;
        }
        #footer{
            position: relative;
        }
    }
</style>

<body>
<header id="header" class="header">
    <div class="logo">
		<span>
			<i class="iconfont icon-dingdanguanli" style="font-size:35px"></i>
		</span>
        <span class="separate title" style="font-size: 24px">外贸公司订单管理系统</span>
    </div>
    <div class="login">
		<span>
			<a href="to_login">
				<button type="button" class="btn self-btn">登陆</button>
			</a>
		</span>
        <span style="padding-left: 10px">
			<a class="register">
				<button type="button" class="btn self-btn">注册</button>
			</a>
		</span>
    </div>
</header><!-- /header -->
<div class="container">
    <div class="row">
        <div class="panel row-fixed">
            <div class="panel-heading">
                <h4>用户登陆</h4>
                <hr>
            </div>
            <div class="panel-body">
                <div class="info">
                    <form role="form" class="form" action="login" method="post">
                        <div class="input">
							<span>
								<input type="text" class="form-control" name="username" placeholder="用户名" autocomplete="off" value="htp411">
								<i class="iconfont icon-denglu"></i>
							</span>
                        </div>
                        <div class="input">
							<span>
								<input type="password" class="form-control" name="password" placeholder="登陆密码" autocomplete="off" value="root@htp411">
								<i class="iconfont icon-mima"></i>
							</span>
                        </div>
                        <div class="form-button">
                            <label>
                                <input type="checkbox" checked>记住密码
                            </label>
                            <button type="submit" class="btn btn-primary">登陆</button>
                        </div>
                    </form>
                </div>
            </div>
            <div class="panel-footer">
                <span><a class="forget-password">忘记密码</a></span>
                <span><a class="register">用户注册</a></span>
            </div>
        </div>
    </div>
</div>
<div class="footer" id="footer">
    <span>订单管理系统</span>
</div>
<!--忘记密码弹窗提示-->
<div class="modal" id="themodal-forget-password" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                忘记密码
            </div>
            <div class="modal-body">
                <ul>
                    <li>默认用户刷新页面直接登录</li>
                    <li>注册用户忘记密码请联系管理员</li>
                </ul>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">确认</button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">取消</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!--用户注册弹窗-->
<div class="modal" id="themodal-register" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                用户注册
            </div>
            <div class="modal-body">
                <form role="form" method="post" action="register">
                    <label class="form-inline">
                        <span>用户名：</span>
                        <input type="text" class="form-control" required="required" name="username" id="username" autocomplete="off">
                    </label>
                    <label class="form-inline">
                        <span>密&nbsp;&nbsp;&nbsp;码：</span>
                        <input type="text" class="form-control" required="required" name="password" id="password" autocomplete="off">
                    </label>
                    <label class="form-inline">
                        <span>密&nbsp;&nbsp;&nbsp;码：</span>
                        <input type="text" class="form-control" required="required" name="confirm-password" id="confirm-password" autocomplete="off">
                    </label>
                    <button style="display: none;" type="submit" class="to-register"></button>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="register">注册</button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">取消</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
    <div id="error-text" class="alert alert-danger" style="display: none;">
        <button type="button" class="close">
            &times;
        </button>
        <p id="error-msg">出错了！</p>
    </div>
</div><!-- /.modal -->
<!--注册弹窗提示-->
<script src="<c:url value='/resources/js/jquery-3.3.1.js'/>"></script>
<script src="<c:url value='/resources/bootstrap/bootstrap.js'/>"></script>
<script>
    $('.forget-password').on('click',function(){
        $('#themodal-forget-password').modal('toggle');
    });
    $('.register').on('click',function(){
        $('#themodal-register').modal('toggle');
    });
    $('#register').on('click',function(){
        let password = $('#password').val().toString();
        let confirm_password = $('#confirm-password').val().toString();
        let username = $('#username').val().toString();
        //$('#error-text').hide();
        if(password == null || password == '' || username == null || username == ''){
            $('#error-msg').text("请如入完整的注册信息！");
            $('#error-text').toggle();
        }
        else if(password === confirm_password){
            $('.to-register').click();
        }else{
            $('#error-msg').text("密码输入不一致，请检查！");
            $('#error-text').toggle();
        }
    });
    $('#error-text').on('click','.close',function () {
        $('#error-text').toggle();
    })
</script>
</body>
</html>
