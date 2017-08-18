<%@ page contentType="text/html; charset=UTF-8" isErrorPage="true"%>
<%@ page import="java.io.*"%>
<%@ page import="com.bonc.rdpe.util.RequestUtil"%>
<%@ page import="com.bonc.rdpe.util.ResponseMessage"%>
<%@ page import="com.bonc.rdpe.util.SystemPropertiesUtils" language="java"%>
<%
	String webpath = request.getContextPath();
	String errormsg = "";
	if (!Boolean.parseBoolean(SystemPropertiesUtils.isDebug())) {
		String args[] = exception.getMessage().split(":");
		if (args.length > 0) {
			errormsg = args[args.length - 1];
		} else {
			errormsg = "系统繁忙，请稍后再试！";
		}
	} else {
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		exception.printStackTrace(new PrintStream(baos));
		errormsg = baos.toString().replace("\r\n", "</br>");
	}
	boolean isAjax = RequestUtil.isAjaxReq(request);
%>

<%
	if (isAjax) {
		response.setContentType("text/html;charset=utf-8");
		ResponseMessage message = ResponseMessage.createFailMessage(errormsg);
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
<title>500_error</title>
</head>

<body>
	<!-- 500 error -->
	<div class="gxj_500Block gxj_500bg">
		<h2></h2>
		应用程序中的服务器错误
		</h2>
		<p>运行时错误</p>
		<p>异常：<%=errormsg%></p>
	</div>
	<!-- // 500 error -->
</body>

</html>
<%
	}
%>
