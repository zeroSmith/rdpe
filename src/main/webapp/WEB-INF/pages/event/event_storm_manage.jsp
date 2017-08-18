<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String webpath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>storm事件管理</title>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<%@ include file="../common-head.jsp"%>
<%@ include file="../common-layer-ext.jsp"%>
<%@ include file="../common-body-css.jsp"%>
<link rel="stylesheet"
	href="<%=webpath%>/resources/plugin/webuploader-0.1.5/webuploader.css">
<style type="text/css">
body {
	overflow: hidden;
}

.upFile {
	margin-right: 10px;
}
.textArea {
	resize: none;
	width: 96%;
}
</style>
</head>
<body style="overflow: hidden;">
	<div class="row">
		<div class="col-lg-12 col-md-12 row-tab">
			<div id="org-panel" class="panel panel-default common-wrapper">
				<div class="panel-heading common-part">
					<i class="iconfont">&#xe6ca;</i><span>storm事件列表</span>
				</div>
				<div class="panel-body common-content">
					<div class="searchWrap">
						<form class="form-inline" id="searchForm">
							<div class="form-group">
								<label for="eventName">事件名称:</label> <input type="text"
									class="form-control input-sm" name="eventName" />
							</div>
							<div class="form-group">
								<label for="eventType">事件类型:</label> <select
									class="form-control input-sm" name="eventType" id="eventType">
									<option value=""></option>
									<option value="trident">trident事件</option>
									<option value="external">外部事件</option>
								</select>
							</div>
							<button type="button" class="b-redBtn btn-i" id="searchBtn">
								<i class="iconfont">&#xe67a;</i>查询
							</button>
							<button type="button" class="b-redBtn btn-i" id="resetBtn">
								<i class="iconfont">&#xe647;</i>重置
							</button>
							<button type="button" class="b-redBtn btn-i" id="addBtn">
								<i class="iconfont">&#xe635;</i>新建storm事件
							</button>
						</form>
					</div>

					<table id="eventTable">
						<thead>
							<tr>
								<th style="width: 6%;">序号</th>
								<th>事件名称</th>
								<th>事件类型</th>
								<th>运行主机IP</th>
								<th>创建时间</th>
								<th>操作</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
	</div>



	<div id="add" class="dialog-wrap">
		<form id="addForm" class="form-inline"
			data-validator-option="{timely:2, theme:'yellow_right'}">
			<input type="hidden" id="filePathAdd" name="uploadJarPath"/>
			<table class="form-table">
				<tr>
					<div class="form-group">
						<td style="width:15%;"><label for="eventType">事件类型:</label></td>
						<td style="width:35%"><label title="trident"><input
								type="radio" value="trident" name="eventType"
								data-rule="checked(1)">自定义事件</label> <label title="external"><input
								type="radio" value="external" name="eventType"
								data-rule="checked(1)">外部事件</label></td>
						<td style="width:15%"><label for="eventEnName">事件英文名称:</label></td>
						<td style="width:35%"><input type="text" class="form-control input-sm"
							name="eventEnName" placeholder="请输入事件英文名称" style="width: 90%;"  data-rule="required;"/></td>
					</div>
				</tr>
				
				<tr>
					<div class="form-group">
						<td style="width:15%"><label for="eventCnName">事件中文名称:</label></td>
						<td style="width:35%"><input type="text" class="form-control input-sm"
							name="eventCnName" placeholder="请输入事件中文名称" style="width: 90%;"  data-rule="required;"/></td>
						<td style="width:15%"><label for="submitHostId">运行主机:</label></td>
						<td style="width:35%"><select class="form-control input-sm" name="submitHostId"
							id="submitHostId" style="width: 90%;"  data-rule="required;">
								<option value=""></option>
						</select></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td style="width:15%"><label for="publishJar">文件保存路径:</label></td>
						<td colspan="3" style="width:85%">
							<input type="text" class="form-control input-sm" name="publishJar" placeholder="文件保存路径" style="width: 96%;" readonly="readonly"  data-rule="required;"/>
						</td>
					</div>
				</tr>
				<tr class="externalFileClassAdd">
					<div class="form-group">
						<td></td>
						<td colspan="3">
							<div id="isExistFileNo">
								<div class="btns clearfix" style="margin-top: 10px;margin-bottom: 10px;">
									<div id="pickerUpload" class="fl picker upFile">
										<i class="iconfont">&#xe696;</i>选择文件
									</div>
	
									<div>
										<button id="ctlBtn" type="button" class="b-redBtn btn-i fl">开始上传</button>
									</div>
									<span id="thelist" class="uploader-list" style="margin-left: 10px;"></span>
								</div>
							</div>
							<div id="isExistFileYes">
								<button id="fileDown" type="button" class="b-redBtn btn-i fl">下载</button>
								
								<button id="fileDelete" type="button" class="b-redBtn btn-i fl" style="margin-left: 10px;">删除</button>
							</div>
						</td>
					</div>
				</tr>
			</table>
		</form>
		<table class="form-table">
			<tr>
				<div class="form-group">
					<td style="width: 15%;">
						<label for="executeDef">运行参数:</label>
					</td>
					<td >
						<textarea type="text" rows="12" class="form-control input-sm textArea" name="executeDef" placeholder="请输入运行参数,多个参数用空格分开" data-rule="required;"></textarea>
					</td>
				</div>
			</tr>
		</table>
	</div>


	<div id="edit" class="dialog-wrap">
		<form id="editForm" class="form-inline"
			data-validator-option="{timely:2, theme:'yellow_right'}">
			<input type="hidden" name="id" />
			<input type="hidden" id="filePathUpdate" name="uploadJarPath"/>
			<table class="form-table">
				<tr>
					<div class="form-group">
						<td style="width:15%;"><label for="eventType">事件类型:</label></td>
						<td style="width:35%"><label title="trident"><input
								type="radio" value="trident" name="eventType"
								data-rule="checked(1)" disabled>自定义事件</label> <label title="external"><input
								type="radio" value="external" name="eventType"
								data-rule="checked(1)" disabled>外部事件</label></td>
						<td style="width:15%"><label for="eventEnName">事件英文名称:</label></td>
						<td style="width:35%"><input type="text" class="form-control input-sm"
							name="eventEnName" placeholder="请输入事件英文名称" style="width: 90%;"  data-rule="required;"/></td>
					</div>
				</tr>
				
				<tr>
					<div class="form-group">
						<td style="width:15%"><label for="eventCnName">事件中文名称:</label></td>
						<td style="width:35%"><input type="text" class="form-control input-sm"
							name="eventCnName" placeholder="请输入事件中文名称" style="width: 90%;"  data-rule="required;"/></td>
						<td style="width:15%"><label for="submitHostId">运行主机:</label></td>
						<td style="width:35%"><select class="form-control input-sm" name="submitHostId"
							id="submitHostId" style="width: 90%;"  data-rule="required;" disabled="disabled">
								<option value=""></option>
						</select></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td style="width:15%"><label for="publishJar">文件保存路径:</label></td>
						<td colspan="3" style="width:85%">
							<input type="text" class="form-control input-sm" name="publishJar" placeholder="文件保存路径" style="width: 96%;" readonly="readonly"  data-rule="required;"/>
						</td>
					</div>
				</tr>
				<tr class="externalFileClassUpdate">
					<div class="form-group">
						<td></td>
						<td colspan="3">
							<div id="isExistFileNo">
								<div class="btns clearfix" style="margin-top: 10px;margin-bottom: 10px;">
									<div id="pickerUploadUpdate" class="fl picker upFile">
										<i class="iconfont">&#xe696;</i>选择文件
									</div>
	
									<div>
										<button id="ctlBtnUpdate" type="button" class="b-redBtn btn-i fl">开始上传</button>
									</div>
									<span id="thelistUpdate" class="uploader-list" style="margin-left: 10px;"></span>
								</div>
							</div>
							<div id="isExistFileYes">
								<button id="fileDown" type="button" class="b-redBtn btn-i fl">下载</button>
								
								<button id="fileDelete" type="button" class="b-redBtn btn-i fl" style="margin-left: 10px;">删除</button>
							</div>
						</td>
					</div>
				</tr>
			</table>
		</form>
		<table class="form-table">
			<tr>
				<div class="form-group">
					<td style="width: 15%;">
						<label for="executeDef">运行参数:</label>
					</td>
					<td >
						<textarea type="text" rows="12" class="form-control input-sm textArea" name="executeDef" placeholder="请输入运行参数,多个参数用空格分开" data-rule="required;"></textarea>
					</td>
				</div>
			</tr>
		</table>
	</div>
	<%@ include file="../common-js.jsp"%>
	<script src="<%=webpath%>/resources/js/event/event_storm_manage.js"></script>
	<script src="<%=webpath%>/resources/js/event/uploadJar.js"></script>
	<script src="<%=webpath%>/resources/plugin/webuploader-0.1.5/webuploader.min.js"></script>
</body>
</html>