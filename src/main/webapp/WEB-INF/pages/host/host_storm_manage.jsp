<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String webpath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>主机管理</title>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<%@ include file="../common-head.jsp"%>
<%@ include file="../common-layer-ext.jsp"%>
<%@ include file="../common-body-css.jsp"%>
<style type="text/css">
body {
	overflow: hidden;
}
.textArea {
	resize: none;
}
</style>
</head>
<body style="overflow: hidden;">
	<div class="row">
		<div class="col-lg-12 col-md-12 row-tab">
			<div id="org-panel" class="panel panel-default common-wrapper">
				<div class="panel-heading common-part">
					<i class="iconfont">&#xe6ca;</i><span>storm主机列表</span>
				</div>
				<div class="panel-body common-content">
					<div class="searchWrap">
						<form class="form-inline" id="searchForm">
							<div class="form-group">
								<label for="hostIp">主机IP:</label> <input type="text"
									class="form-control input-sm" name="hostIp" />
							</div>
							<div class="form-group">
								<label for="hostName">主机名称:</label> <input type="text"
									class="form-control input-sm" name="hostName" />
							</div>
							<button type="button" class="b-redBtn btn-i" id="searchBtn">
								<i class="iconfont">&#xe67a;</i>查询
							</button>
							<button type="button" class="b-redBtn btn-i" id="resetBtn">
								<i class="iconfont">&#xe647;</i>重置
							</button>
							<button type="button" class="b-redBtn btn-i" id="addBtn">
								<i class="iconfont">&#xe635;</i>新建storm主机
							</button>
						</form>
					</div>

					<table id="hostTable">
						<thead>
							<tr>
								<th style="width: 6%;">序号</th>
								<th>主机ip</th>
								<th>主机名称</th>
								<th>storm版本</th>
								<th>操作</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
	</div>
	
	
	
<div id="addStormHost" class="dialog-wrap">
	<form id="addStormHostForm" class="form-inline" data-validator-option="{timely:2, theme:'yellow_right'}">
		<table class="form-table" border="0">
			<tr>
				<div class="form-group">
					<td><label for="hostIp">主机ip:</label></td>
					<td><input type="text" class="form-control input-sm" name="hostIp" placeholder="请输入主机ip地址" data-rule="required;"/></td>
					<td><label for="hostName">主机名:</label></td>
					<td><input type="text" class="form-control input-sm" name="hostName" placeholder="请输入主机名" data-rule="required;"/></td>
				</div>
			</tr>
			<tr>
				<div class="form-group">
					<td><label for="hostUsername">ssh用户名:</label></td>
					<td><input type="text" class="form-control input-sm" name="hostUsername" placeholder="请输入ssh用户名" data-rule="required;"/></td>
					<td><label for="hostPassword">ssh密码:</label></td>
					<td><input type="password" class="form-control input-sm" name="hostPassword" placeholder="请输入ssh密码" data-rule="required;"/></td>
				</div>
			</tr>
			<tr>
				<div class="form-group">
					<td><label for="sshPort">ssh端口号:</label></td>
					<td>
						<input type="text" class="form-control input-sm" name="sshPort" placeholder="ssh端口号" data-rule="required;"/>
					</td>
					<td>
						<label for="stormVersion">storm版本:</label>
					</td>
					<td>
						<select class="form-control input-sm" name="stormVersion" id="stormVersion" data-rule="required;" style="width: 85%;">
							<option value =""></option>
							<option value ="apache1.3.1">storm-1.0.0</option>
						</select>
					</td>
				</div>
			</tr>
			<tr>
				<div class="form-group">
					<td><label for="installPath">STORM_HOME:</label></td>
					<td colspan="3">
						<input type="text" class="form-control input-sm" style="width: 95%;" name="installPath" placeholder="请输入storm安装路径" data-rule="required;"/>
					</td>
				</div>
			</tr>
		</table>
	</form>
</div>


<div id="editStormHost" class="dialog-wrap">
	<form id="editStormHostForm" class="form-inline" data-validator-option="{timely:2, theme:'yellow_right'}">
		<input type="hidden" name="id" />
		<input type="hidden" name="createrId" />
		<table class="form-table">
			<tr>
				<div class="form-group">
					<td><label for="hostIp">主机ip:</label></td>
					<td><input type="text" class="form-control input-sm" name="hostIp" placeholder="请输入主机ip" data-rule="required;"/></td>
					<td><label for="hostName">主机名:</label></td>
					<td><input type="text" class="form-control input-sm" name="hostName" placeholder="请输入主机名" data-rule="required;"/></td>
				</div>
			</tr>
			<tr>
				<div class="form-group">
					<td><label for="hostUsername">ssh用户名:</label></td>
					<td><input type="text" class="form-control input-sm" name="hostUsername" placeholder="请输入主机用户名" data-rule="required;"/></td>
					<td><label for="hostPassword">ssh密码:</label></td>
					<td><input type="password" class="form-control input-sm" name="hostPassword" placeholder="请输入主机密码" data-rule="required;"/></td>
				</div>
			</tr>
			<tr>
				<div class="form-group">
					<td><label for="sshPort">ssh端口号:</label></td>
					<td>
						<input type="text" class="form-control input-sm" name="sshPort" placeholder="请输入ssh端口号" data-rule="required;"/>
					</td>
					<td>
						<label for="stormVersion">storm版本:</label>
					</td>
					<td>
						<select class="form-control input-sm" name="stormVersion" id="stormVersion" data-rule="required;" style="width: 85%;">
							<option value =""></option>
							<option value ="apache1.3.1">storm-1.0.0</option>
						</select>
					</td>
				</div>
			</tr>
			<tr>
				<div class="form-group">
					<td><label for="installPath">STORM_HOME:</label></td>
					<td colspan="3">
						<input type="text" class="form-control input-sm" style="width: 95%;" name="installPath" placeholder="请输入storm安装路径" data-rule="required;"/>
					</td>
				</div>
			</tr>
		</table>
	</form>
</div>
<%@ include file="../common-js.jsp"%>
<script src="<%=webpath%>/resources/js/host/host_storm_manage.js"></script>
</body>
</html>