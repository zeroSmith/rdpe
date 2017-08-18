<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String webpath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../common-head.jsp"%>
<title>Redis数据源</title>
<%@ include file="../common-layer-ext.jsp"%>
<%@ include file="../common-body-css.jsp"%>
<%@ include file="../common-js.jsp"%>
<style type="text/css">
body {
	overflow: hidden;
}

#redisTable {
	width: 100%;
}

#sparkPath {
	width: 375px;
	height: 27px;
	border: 1px solid #ccc;
}
</style>
</head>
<body>
	<div class="row">
		<div class="col-lg-12 col-md-12 row-tab">
			<div id="role-panel" class="panel panel-default common-wrapper">
				<div class="panel-heading common-part">
					<i class="iconfont">&#xe6ca;</i><span>redis数据源列表</span>
				</div>
				<div class="panel-body common-content common-wrap">
					<div class="searchWrap common-part">
						<form class="form-inline" id="SearchForm">
							<div class="form-group">
								<label for="dsName">数据源名称:</label> <input type="text"
									class="form-control input-sm" name="dsName" />
							</div>
							<div class="form-group">
								<label for="hostIp">主机Ip:</label> <input type="text"
									class="form-control input-sm" name="hostIp" id="hostIp" />
							</div>
							<button type="button" class="b-redBtn btn-i" id="searchBtn">
								<i class="iconfont">&#xe67a;</i>查询
							</button>
							<button type="button" class="b-redBtn  btn-i" id="resetBtn">
								<i class="iconfont">&#xe647;</i>重置
							</button>
							<button type="button" class="b-redBtn  btn-i" id="addRedisBtn">
								<i class="iconfont">&#xe635;</i>新建redis数据源
							</button>
						</form>
					</div>

					<table id="redisTable">
						<thead>
							<tr>
								<th>序号</th>
								<th>数据源名称</th>
								<th>数据类型</th>
								<th>key值</th>
								<th>创建时间</th>
								<th>操作</th>
							</tr>
						</thead>
					</table>

				</div>
			</div>
		</div>
	</div>

	<div id="addRedis" class="dialog-wrap">
		<form id="addRedisForm"
			data-validator-option="{timely:2, theme:'yellow_right'}">
			<table class="form-table">
				<tr>
						<div class="form-group">
							<td><label for="dsName">数据源名称:</label> </td>
							<td><input type="text" 	class="form-control input-sm" name="dsName" placeholder="请输入数据源名称" data-rule="required;length(0~32);filter;" /></td>
						</div>
				</tr>
				<tr>
						<div class="form-group">
							<td><label for="hostIp">redis主机ip:</label> </td>
							<td><input type="text" class="form-control input-sm" name="hostIp" 	placeholder="redis主机ip" data-rule="required;length(0~32);filter;" /></td>
						</div>
				</tr>
				<tr>
						<div class="form-group">
							<td><label for="pwd">数据库密码:</label> </td>
							<td><input type="text" class="form-control input-sm" name="pwd" placeholder="数据库密码" /></td>
						</div>
				</tr>
				<tr>
						<div class="form-group">
							<td><label for="hostPort">端口号:</label> </td>
							<td><input type="text" class="form-control input-sm" name="hostPort" id="hostPort" placeholder="端口号" data-rule="required;filter;"></input></td>
						</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="resultsetType">存放数据类型:</label> </td>
						<td><label title="set"><input type="radio" value="set" name=resultsetType data-rule="checked(1)"> set</label> 
						<label title="string"><input type="radio" value="string" name="resultsetType" data-rule="checked(1)">string</label></td>
					</div>
				</tr>
				<tr>
						<div class="form-group">
							<td><label for=pk>key值:</label> </td>
							<td><input class="form-control input-sm" name="pk" id="pk" placeholder="redis数据库中存在的key" /></td>
						</div>
				</tr>
			</table>
		</form>
	</div>

	<div id="updateRedis" class="dialog-wrap">
		<form id="updateRedisForm"
			data-validator-option="{timely:2, theme:'yellow_right'}">
			<input type="hidden" name="id" />
			<table class="form-table">
				<tr>
						<div class="form-group">
							<td><label for="dsName">数据源名称:</label> </td>
							<td><input type="text" 	class="form-control input-sm" name="dsName" placeholder="请输入数据源名称" data-rule="required;length(0~32);filter;" /></td>
						</div>
				</tr>
				<tr>
						<div class="form-group">
							<td><label for="hostIp">redis主机ip:</label> </td>
							<td><input type="text" class="form-control input-sm" name="hostIp" 	placeholder="redis主机ip" data-rule="required;length(0~32);filter;" /></td>
						</div>
				</tr>
				<tr>
						<div class="form-group">
							<td><label for="pwd">数据库密码:</label> </td>
							<td><input type="text" class="form-control input-sm" name="pwd" placeholder="数据库密码" /></td>
						</div>
				</tr>
				<tr>
						<div class="form-group">
							<td><label for="hostPort">端口号:</label> </td>
							<td><input type="text" class="form-control input-sm" name="hostPort" id="hostPort" placeholder="端口号" data-rule="required;filter;"></input></td>
						</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="resultsetType">存放数据类型:</label> </td>
						<td><label title="set"><input type="radio" value="set" name=resultsetType data-rule="checked(1)"> set</label> 
						<label title="string"><input type="radio" value="string" name="resultsetType" data-rule="checked(1)">string</label></td>
					</div>
				</tr>
				<tr>
						<div class="form-group">
							<td><label for=pk>key值:</label> </td>
							<td><input class="form-control input-sm" name="pk" id="pk" placeholder="redis数据库中存在的key" /></td>
						</div>
				</tr>
			</table>
		</form>
	</div>
	<%@ include file="../common-js.jsp"%>
	<script src="<%=webpath%>/resources/js/datasource/redis_manage.js"></script>
</body>
</html>