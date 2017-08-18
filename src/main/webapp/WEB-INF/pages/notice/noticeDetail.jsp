<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String webpath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="../common-head.jsp"></jsp:include>
	<title>公告详情</title>
	<style>
		.notice-subtit p {
		    display: inline-block;
		    margin: 0;
		    margin-right: 37px;
		    height: 45px;
		    line-height: 45px;
		}
		.area-detail {
		    width: 100%;
		    border: none;
		    border-top: 1px dashed #d2d2d2;
		    background: #f5f5f5;
		    padding: 20px;
		    word-wrap:break-word;
		}
		.area-detail p {
			line-height: 28px;
			margin: 0;
		}
	</style>
</head>
<body>
	<div style="display:none;">
		<input type="hidden" id="sourFromSign" value="${fromSign }">
	</div>
	<div class="panel-border">
		<div class="content-wrapper">
			<h2 class="notice-tit">
             <i></i>公告详情
         </h2>
         <div class="notice-content">
             <h3 class="notice-tit">${noticeTitle }</h3>
             <h4 class="notice-subtit">
             	<p>发布时间：<span><fmt:formatDate value="${pubdate }" pattern="yyyy-MM-dd HH:mm:ss"/></span></p>
             	<p>发件人：<span>${pubPerson }</span></p>
             </h4>
             <div name="" id="areaDetail" class="area-detail">
             </div>
         </div>
		</div>			
	</div>

	<jsp:include page="../common-js.jsp"></jsp:include>
	<script src="<%=webpath %>/resources/js/notice/noticeCommon.js"></script>
	<script>
		var webpath = '<%=webpath%>';
		$(function() {
			$("#areaDetail").html('${noticeContent }');
		});
	</script>
</body>
</html>