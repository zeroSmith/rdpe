<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String webpath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../common-head.jsp"%>
<title>kafka数据源</title>
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
					<i class="iconfont">&#xe6ca;</i><span>kafka数据源列表</span>
				</div>
				<div class="panel-body common-content common-wrap">
					<div class="searchWrap common-part">
						<form class="form-inline" id="SearchForm">
							<div class="form-group">
								<label for="dsName">数据名称:</label> <input type="text"
									class="form-control input-sm" name="dsName" />
							</div>
							<div class="form-group">
								<label for="topicName">话题名称:</label> <input type="text"
									class="form-control input-sm" name="topicName" id="topicName" />
							</div>
							<button type="button" class="b-redBtn btn-i" id="searchBtn">
								<i class="iconfont">&#xe67a;</i>查询
							</button>
							<button type="button" class="b-redBtn  btn-i" id="resetBtn">
								<i class="iconfont">&#xe647;</i>重置
							</button>
							<button type="button" class="b-redBtn  btn-i" id="addKafkaBtn">
								<i class="iconfont">&#xe635;</i>新建kafka数据源
							</button>
						</form>
					</div>

					<table id="kafkaTable">
						<thead>
							<tr>
								<th>序号</th>
								<th>数据源名称</th>
								<th>话题名称</th>
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
	<div id="addKafka" class="dialog-wrap">
		<form id="addKafkaForm"
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
						<td><label for="topicName">话题名称:</label></td>
						<td><input type="text" class="form-control input-sm"
							name="topicName" placeholder="请输入话题名称"
							data-rule="required;length(0~32);filter;" /></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="groupId">消费者组:</label></td>
						<td><input type="text" class="form-control input-sm"
							name="groupId" id="groupId" placeholder="请输入消费者组"
							data-rule="required;filter;" /></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for=brokerList>kafka集群列表:</label></td>
						<td><input type="text" class="form-control input-sm"
							name="brokerList" id="brokerList"
							placeholder="kafka集群ip:port,ip:port" /></td>
					</div>

				</tr>
				<tr>
					<div class="form-group">
						<td><label for="zkList">zookeeper列表:</label></td>
						<td><input type="text" class="form-control input-sm"
							name="zkList" placeholder="zookeeper集群ip:port,ip:port" /></td>
					</div>
				</tr>
			</table>
		</form>
	</div>

	<!-- 修改spark主机 -->
	<div id="updateKafka" class="dialog-wrap">
		<form id="updateKafkaForm"
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
						<td><label for="topicName">话题名称:</label></td>
						<td><input type="text" class="form-control input-sm"
							name="topicName" placeholder="请输入话题名称"
							data-rule="required;length(0~32);filter;" /></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="groupId">消费者组:</label></td>
						<td><input type="text" class="form-control input-sm"
							name="groupId" id="groupId" placeholder="请输入消费者组"
							data-rule="required;filter;" /></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for=brokerList>kafka集群列表:</label></td>
						<td><input type="text" class="form-control input-sm"
							name="brokerList" id="brokerList"
							placeholder="kafka集群ip:port,ip:port" /></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="zkList">zookeeper列表:</label></td>
						<td><input type="text" class="form-control input-sm"
							name="zkList" placeholder="zookeeper集群ip:port,ip:port" /></td>
					</div>
				</tr>
			</table>
		</form>
	</div>
	<%@ include file="../common-js.jsp"%>
	<script src="<%=webpath%>/resources/js/datasource/kafka_manage.js"></script>
</body>
</html>