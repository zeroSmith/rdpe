<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String webpath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>系统参数管理</title>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<%@ include file="../common-head.jsp"%>
<%@ include file="../common-layer-ext.jsp"%>
<%@ include file="../common-body-css.jsp"%>
</head>
<body style="overflow: hidden;">
	<div class="row">
		<div class="col-lg-12 col-md-12 row-tab">
			<div id="org-panel" class="panel panel-default common-wrapper">
				<div class="panel-heading common-part">
					<i class="iconfont">&#xe6ca;</i><span>参数配置列表</span>
				</div>
				<div class="panel-body common-content">
					<div class="searchWrap">
						<form class="form-inline" id="systemDictSearchForm">
							<div class="form-group">
								<label for="propName">参数名:</label> <input type="text"
									class="form-control input-sm" name="propName" />
							</div>
							<button type="button" class="b-redBtn btn-i" id="searchBtn">
								<i class="iconfont">&#xe67a;</i>查询
							</button>
							<button type="button" class="b-redBtn btn-i" id="resetBtn">
								<i class="iconfont">&#xe647;</i>重置
							</button>
							<button type="button" class="b-redBtn btn-i"
								id="addSystemDictBtn">
								<i class="iconfont">&#xe635;</i>新增系统参数
							</button>
						</form>
					</div>

					<table id="systemDictTable">
						<thead>
							<tr>
								<th style="width: 5%;">序号</th>
								<th>参数名</th>
								<th>参数值</th>
								<th>参数描述</th>
								<th style="width: 10%;">操作</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
	</div>


	<!-- 新建系统参数 -->
	<div id="addSystemDict" class="dialog-wrap">
		<form id="addSystemDictForm" class="form-inline"
			data-validator-option="{timely:2, theme:'yellow_right'}">
			<table class="form-table">
				<tr>
					<div class="form-group">
						<td>
							<label for="propName">参数名:</label>
						</td>
						<td>
							<input type="text" class="form-control input-sm" name="propName" placeholder="参数名" style="width: 90%;" data-rule="required;"/>
						</td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td>
							<label for="propValue">参数值:</label>
						</td>
						<td>
							<textarea rows="3" cols="35" name="propValue" placeholder="参数值" data-rule="required;">
							</textarea>
						</td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td>
							<label for="memo">备注说明:</label>
						</td>
						<td>
							<textarea rows="3" cols="35" name="memo" placeholder="备注说明">
							</textarea>
						</td>
					</div>
				</tr>
			</table>
		</form>
	</div>


	<!-- 修改系统参数-->
	<div id="updateSystemDict" class="dialog-wrap">
		<form id="updateSystemDictForm" class="form-inline"
			data-validator-option="{timely:2, theme:'yellow_right'}">
			<table class="form-table">
				<tr>
					<div class="form-group">
						<td>
							<label for="propName">参数名:</label>
						</td>
						<td>
							<input type="text" class="form-control input-sm" name="propName" placeholder="参数名" style="width: 90%;" data-rule="required;" readonly="readonly"/>
						</td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td>
							<label for="propValue">参数值:</label>
						</td>
						<td>
							<textarea rows="3" cols="35" name="propValue" placeholder="参数值" data-rule="required;">
							</textarea>
						</td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td>
							<label for="memo">备注说明:</label>
						</td>
						<td>
							<textarea rows="3" cols="35" name="memo" placeholder="备注说明">
							</textarea>
						</td>
					</div>
				</tr>
			</table>
		</form>
	</div>
	<%@ include file="../common-js.jsp"%>
	<script src="<%=webpath%>/resources/js/systemconfig/system_dict.js"></script>
</body>
</html>