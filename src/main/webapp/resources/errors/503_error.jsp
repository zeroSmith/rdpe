<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String webpath = request.getContextPath();
%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1" />

<link href="<%=webpath%>/resources/css/errors/gxj_error.css" type="text/css" rel="stylesheet">
<title>503_error</title>
</head>

<body>
	<!-- 503 error -->
	<div class="gxj_503Block">
		<h2>访问受限</h2>
		<p>对不起，您没有权限访问，请联系管理员！</p>
	</div>
	<!-- // 503 error -->
</body>

</html>
