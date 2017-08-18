<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String webpath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<link rel="stylesheet" href="<%=webpath%>/resources/css/workbench/index.css" />
<link rel="stylesheet" href="<%=webpath%>/resources/plugin/layui/css/layui.css" media="all">
<script type="text/javascript" src="<%=webpath%>/resources/plugin/layui/layui.js"></script>
<script type="text/javascript" src="<%=webpath%>/resources/plugin/jquery/jquery-1.9.1.js"></script>
<%@ include file="../common-head.jsp"%>
<%@ include file="../common-layer-ext.jsp"%>
<%@ include file="../common-body-css.jsp"%>
<style type="text/css">
body {
	overflow: hidden;
}

.hovertable {
	width: 98%;
	margin-left: 8px;
	font-family: verdana, arial, sans-serif;
	font-size: 11px;
	color: #333333;
	border-collapse: collapse;
	font-family: verdana, arial, sans-serif;
}

.hovertable tr th {
	font-size: 13px;
	border-width: 1px;
	background-color: Write;
	padding: 8px;
	border-style: solid;
	border-color: #ddd;
	font-weight: bold;
	border-left-width: 0px;
	border-right: 0px;
	border-top: 0px;
	background: #ffffff;
}

.hovertable .trClass {
	background-color: #ffffff;
}

.hovertable .trClass:nth-child(even) {
	background: #ffffff;
}

.hovertable .trClass:nth-child(odd) {
	background: #f9f9f9;
}

.hovertable .tdClass {
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #ddd;
	border-left-width: 0px;
	border-right: 0px;
}

.hovertable .thClass.titleTh {
	font-size: 17px;
	background-color: #d5d5d5;
}

.sparkClusterPage {
	position: absolute;
	top: 90%;
	right: 3%;
}
.applicationTable td{
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #ddd;
	border-left-width: 0px;
}
</style>
</head>
<body>

	<div class="row">
		<div class="col-lg-12 col-md-12 row-tab">
			<div id="org-panel" class="panel panel-default common-wrapper">
				<div class="panel-heading common-part">
					<i class="iconfont">&#xe6ca;</i><span>基于YARN的Spark事件监控界面</span>
				</div>
				<div class="panel-body common-content">
					<div class="searchWrap">
						<form class="form-inline" id="searchForm">
							<div class="form-group">
								<label for="eventName">事件ID:</label> <input type="text"
									class="form-control input-sm" name="eventName" />
							</div>
							<button type="button" class="b-redBtn btn-i" id="searchBtn">
								<i class="iconfont">&#xe67a;</i>查询
							</button>
							<button type="button" class="b-redBtn btn-i" id="resetBtn">
								<i class="iconfont">&#xe647;</i>重置
							</button>
						</form>
					</div>
				
				
				
					<table class="hovertable" id="sparkInfoTable">
						<thead>
							<tr>
								<th class="thClass">YARN ID</th>
								<th class="thClass">事件名称</th>
								<th class="thClass">开始时间</th>
								<th class="thClass">结束时间</th>
								<th class="thClass">状态</th>
								<th class="thClass">最终状态</th>
								<th class="thClass">操作</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
					<div id="sparkClusterPage" align="right" class="sparkClusterPage"></div>
					
					<div id="applicationInfo" class="dialog-wrap">
						<form id="addForm" class="form-inline" data-validator-option="{timely:2, theme:'yellow_right'}">
							<table class="form-table applicationTable">
							</table>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../common-js.jsp"%>
	<script type="text/javascript" src="<%=webpath%>/resources/js/workbench/index.js"></script>
</body>
</html>