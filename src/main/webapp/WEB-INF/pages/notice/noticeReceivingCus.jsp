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
        <div id="org-panel" class="panel panel-default all-content-wrapper">
            <div class="panel-heading"><i class="noticeOrg"></i><span>公告</span></div>
            <div class="panel-content">
                <div class="tblOperation">
                    <input type="checkbox" class="checkAll" />
                    <button type="button" class="markReaded b-redBtn">全部标记为已读</button>
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
<script src="<%=webpath %>/resources/js/notice/noticeReceivingCus.js"></script>

</body>
</html>