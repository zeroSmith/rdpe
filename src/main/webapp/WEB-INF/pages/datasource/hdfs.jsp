<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String webpath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../common-head.jsp"%>
<title>Hdfs数据源</title>
<%@ include file="../common-layer-ext.jsp"%>
<%@ include file="../common-body-css.jsp"%>
<%@ include file="../common-js.jsp"%>
<style type="text/css">
body {
	overflow: hidden;
}
</style>
</head>
<body>
	<div class="row">
		<div class="col-lg-12 col-md-12 row-tab">
			<div id="role-panel" class="panel panel-default common-wrapper">
				<div class="panel-heading common-part">
					<i class="iconfont">&#xe6ca;</i><span>Hdfs数据源列表</span>
				</div>
				<div class="panel-body common-content common-wrap">
					<div class="searchWrap common-part">
						<form class="form-inline" id="hdfsSearchForm">
							<div class="form-group">
								<label for="dsName">数据名称:</label> <input type="text"
									class="form-control input-sm" name="dsName" />
							</div>
							<button type="button" class="b-redBtn btn-i" id="searchBtn">
								<i class="iconfont">&#xe67a;</i>查询
							</button>
							<button type="button" class="b-redBtn  btn-i" id="resetBtn">
								<i class="iconfont">&#xe647;</i>重置
							</button>
							<button type="button" class="b-redBtn  btn-i" id="addHdfsBtn">
								<i class="iconfont">&#xe635;</i>新建hdfs数据源
							</button>
						</form>
					</div>

					<table id="hdfsTable">
						<thead>
							<tr>
								<th>序号</th>
								<th>数据源名称</th>
								<th>创建时间</th>
								<th>操作</th>
							</tr>
						</thead>
					</table>

				</div>
			</div>
		</div>
	</div>

	<!-- 新增spark主机 -->
	<div id="addHdfs" class="dialog-wrap">
		<form id="addHdfsForm"
			data-validator-option="{timely:2, theme:'yellow_right'}">
			<table class="form-table">
				<tr>
					<div class="form-group">
						<td><label for="dsName">数据源名称:</label></td>
						<td><input type="text" class="form-control input-sm"
							name="dsName" placeholder="请输入数据源名称"
							data-rule="required;length(0~32);filter;" /></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="path">存放路径:</label></td>
						<td>
					<input type="text" class="form-control input-sm" name="path"
							id="path" placeholder="hdfs://ip:prot/path"
							data-rule="required;filter;" />
					</td>
					</div>
				</tr>
			</table>
		</form>
	</div>

	<!-- 修改hdfs数据源 -->
	<div id="updateHdfs" class="dialog-wrap">
		<form id="updateHdfsForm"
			data-validator-option="{timely:2, theme:'yellow_right'}">
			<input type="hidden" name="id" />
			<table class="form-table">
				<tr>
					<div class="form-group">
						<td><label for="dsName">数据源名称:</label></td>
						<td><input type="text" class="form-control input-sm"
							name="dsName" placeholder="请输入数据源名称"
							data-rule="required;length(0~32);filter;" /></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="path">存放路径:</label></td>
						<td>
					<input type="text" class="form-control input-sm" name="path"
							id="path" placeholder="hdfs://ip:prot/path"
							data-rule="required;filter;" />
					</td>
					</div>
				</tr>
			</table>
		</form>
	</div>


	<%@ include file="../common-js.jsp"%>
	<script src="<%=webpath%>/resources/js/datasource/hdfs_manage.js"></script>
</body>
</html>