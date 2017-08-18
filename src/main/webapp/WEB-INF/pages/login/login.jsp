<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.bonc.rdpe.util.SystemPropertiesUtils"
	language="java"%>
<%
	String webpath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<title><%=SystemPropertiesUtils.getSystemTitle()%></title>
<link href="<%=webpath %>/resources/css/login/main.css" rel="stylesheet"
	type="text/css">
</head>
<body onkeydown="keyEnter();">
	<!-- top -->
	<div class="gxj_header">
		<div class="gxj_top">
			<h1>
				<a href="javascript:void(0);" class="login-title" style="display: block; height: 48px;line-height: 48px;"><img src="<%=webpath %>/resources/css/login/images/gxj_logo.png" alt=" " />
				    <span style="font-size: 22px;color:#333;position:relative;top:-10px;font-weight:bold;"><%=SystemPropertiesUtils.getSystemTitle()%></span>
			    </a>
			</h1>
		</div>
	</div>
	<!-- // top -->
	<!-- 左边内容动画 -->
	<div class="gxj_content">
		<div class="gxj_flash00">
			<a href="javascript:void(0)" class="gxj_prevLeft prev"><img
				src="<%=webpath %>/resources/css/login/images/gxj_preLeft.png" alt=" " title=" " /></a>
			<div class="gxj_bd">
				<ul class="gxj_donghua">
					<li class="gxj_bg01"><img src="<%=webpath %>/resources/css/login/images/gxj_Img01.png"
						width="83" height="75" alt=" " class="trans" /></li>
					<li class="gxj_bg02"><img src="<%=webpath %>/resources/css/login/images/gxj_Img02.png"
						width="70" height="72" alt=" " class="trans" /></li>
					<li class="gxj_bg03"><img src="<%=webpath %>/resources/css/login/images/gxj_Img03.png"
						width="73" height="72" alt=" " class="trans" /></li>
				</ul>
				<ul class="gxj_donghua">
					<li class="gxj_bg04"><img src="<%=webpath %>/resources/css/login/images/gxj_Img04.png"
						width="75" height="73" alt=" " class="trans" /></li>
					<li class="gxj_bg05"><img src="<%=webpath %>/resources/css/login/images/gxj_Img05.png"
						width="76" height="73" alt=" " class="trans" /></li>
					<li class="gxj_bg06"><img src="<%=webpath %>/resources/css/login/images/gxj_Img06.png"
						width="75" height="75" alt=" " class="trans" /></li>
				</ul>
			</div>
			<a href="javascript:void(0)" class="gxj_nextRight next"><img src="<%=webpath %>/resources/css/login/images/gxj_nextRight.png" alt="" /></a>
			<div class="gxj_point">
				<ul>
					<li></li>
					<li></li>
				</ul>
			</div>
		</div>
		<div class="gxj_Iblock">
		    <form id="loginForm" method="post"  action="<%=webpath %>/login/actionLogin" >
			<h2>帐号登录</h2>
			<div class="gxj_Iblock1">
				<dl>
					<dt>用户名:</dt>
					<dd>
						<input id="userName" type="text" class="gxj_text00" onfocus="this.value = ''" name="loginId" placeholder="请输入用户名" />
					</dd>
				</dl>
				<dl>
					<dt>密码:</dt>
					<dd>
						<input id="password" type="password" class="gxj_text01"  name="password" placeholder="请输入密码"/>
					</dd>
				</dl>
				<div class="gxj_checked">
					<span class="gxj_fl"><input type="checkbox" class="gxj_Mfl" onclick="chooseCheckbox(this);"/>记住密码</span>
				    <span class="tips" style="color:red;font-size:10px;float:right;" ></span>
				</div>
				<a href="javascript:void(0);" class="gxj_but00" onclick="loginFun();" id="login">登录</a>
			</div>
			</form>
		</div>
	</div>
	<!--//左边内容动画 -->




	<!-- footer -->
	<div class="gxj_footer">版权所有：北京东方国信科技股份有限公司</div>
	<!-- // footer -->
	<script src="<%=request.getContextPath() %>/resources/plugin/jquery/jquery-1.10.2.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/login/jquery.SuperSlide.2.1.js"></script>
	<script src="<%=request.getContextPath()%>/resources/js/login/login.js"></script>
	<script src="<%=webpath %>/resources/plugin/jquery/jquery.cookie.js"></script>  
	<script type="text/javascript">
		    jQuery(".gxj_flash00").slide({mainCell:".gxj_bd",titCell:".gxj_point ul li",autoPlay:true,interTime:1500});
	</script>
	<script>
	
	function divMiddle(){
	   	var bodyHeight = $(window).height(),
	   	headerHeight = $(".gxj_header").height(),
	   	bottomHeight = $(".gxj_footer").height(),
	   	contentHeight = $(".gxj_flash00").height();
	   	var tempHeight = (bodyHeight - headerHeight - contentHeight - 30)/2;
	   	$(".gxj_flash00").css("margin-top",tempHeight);
	   	$(".gxj_Iblock").css("margin-top",tempHeight);
	}

	$(document).ready(function(){
		divMiddle();
		$(window).resize(function() {
	      divMiddle();
	  });
	});
	
	
		var webpath = '<%=webpath%>';
		if(top.location != location){//解决iframe中跳到登陆页面的问题  
			window.parent.location.reload();
		}
		$(function(){
			if('<%=request.getAttribute("message")%>' == 'notExist'){
				$('.tips').html("<font color='#da392e'>用户名不存在</font>");
			}else if('<%=request.getAttribute("message")%>' == 'pwdFalse'){
				$('.tips').html("<font color='#da392e'>密码错误</font>");
			}else if('<%=request.getAttribute("message")%>' == 'isLocked'){
				$('.tips').html("<font color='#da392e'>用户已被锁定</font>");
			}else if('<%=request.getAttribute("message")%>' == 'isEmpty') {
				$('.tips').html("<font color='#da392e'>用户名为空</font>");
			}
		})
	</script>
</body>
</html>