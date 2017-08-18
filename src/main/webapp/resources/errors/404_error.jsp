<%@ page contentType="text/html; charset=UTF-8" isErrorPage="true"%>
<%@ page import="com.bonc.rdpe.util.RequestUtil"%>
<%@ page import="com.bonc.rdpe.util.ResponseMessage"%>
<%
	String webpath = request.getContextPath();
	boolean isAjax = RequestUtil.isAjaxReq(request);
%>

<%
	if (isAjax) {
		response.setContentType("text/html;charset=utf-8");
		ResponseMessage message = new ResponseMessage();
		message.setCode("404");
		message.setMessage("未找到您请求的地址，请检查后再次请求!");
		response.getWriter().write(message.toString());
		response.getWriter().flush();
		response.getWriter().close();
	} else {
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link href="<%=webpath%>/resources/css/errors/gxj_error.css" type="text/css" rel="stylesheet">
<title>404_error</title>
</head>
<body>
	<!-- 404 error -->
	<div class="gxj_404Block">
		<h2>很抱歉，你访问的页面不存在</h2>
		<p>1 请检查您输入的网址是否正确</p>
		<p>2 如果您不能确认您输入的网址是否正确，请重新刷新</p>
		<p>3 网页已丢失，<a href="<%=webpath%>/platform/index">返回到首页</a></p>
	</div>
	<!-- // 404 error -->
</body>

</html>
<%
	}
%>
