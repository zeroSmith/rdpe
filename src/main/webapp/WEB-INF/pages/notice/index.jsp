<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String webpath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="../common-head.jsp"></jsp:include>
	<title>已接收公告</title>
	<link rel="stylesheet" href="<%=webpath %>/resources/css/notice/index.css" />
	<%@ include file="../common-layer-ext.jsp"%>
</head>
<body>
	<div class="content">
        <div class="l-content-wrapper">
            <div class="title noticeLogo">
                <p>公告管理</p>
            </div>
            <div class="partTab">
                <a href="#" class="sendedLink"><i class="iconfont partIcon sended">&#xe666;</i><span>已发送</span></a>
                <a href="#" class="active receiveLink"><i class="iconfont partIcon received">&#xe683;</i><span>已接收</span></a>
                <a href="#" class="draftLink"><i class="iconfont partIcon draft">&#xe669;</i><span>草稿箱</span></a>
            </div>
        </div>
        <div id="org-panel" class="panel panel-default r-content-wrapper">
            <div class="panel-heading"><i class="noticeOrg"></i><span>公告</span></div>
            <div class="panel-body panel-content">
                <div class="tblOperation receiveBtns" style="display:block">
                    <input type="checkbox" class="checkAll" />
                    <button type="button" class="markReaded b-redBtn">全部标记为已读</button>
                    <button type="button" class="multiDel b-redBtn">删除</button>
                </div>
                <div class="tblOperation sendedBtns">
                    <input type="checkbox" class="checkAll" />
                    <button type="button" class="newNotice b-redBtn">新增公告</button>
                	<button type="button" class="multiDel b-redBtn">删除</button>
                </div>
                <div class="tblOperation draftBtns">
                    <input type="checkbox" class="checkAll" />
                    <button type="button" class="multiDel b-redBtn">删除</button>
                </div>
                <table id="noticeList">
                </table>
            </div>
        </div>
    </div>
    
	<script>
		var webpath = '<%=webpath%>';
	</script>
	<jsp:include page="../common-js.jsp"></jsp:include>
	<script src="<%=webpath %>/resources/js/notice/index.js"></script>
</body>
</html>