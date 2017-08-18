<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.bonc.rdpe.util.SystemPropertiesUtils" language="java"%>
<%
	String webpath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<title>自定义函数</title>
<%@ include file="../common-head.jsp"%>
<%@ include file="../common-layer-ext.jsp"%>
<%@ include file="../common-body-css.jsp"%>
<link rel="stylesheet" href="<%=webpath%>/resources/plugin/webuploader-0.1.5/webuploader.css">
<style type="text/css">
body {
	overflow: hidden;
}

.panel-heading>i.iconfont:first-child {
	font-size: 20px;
	margin-right: 4px;
}

.common-part .icon-tip {
	float: right;
	margin-top: 2px;
}

.panel-heading>span {
	top: -2px;
	position: relative;
}

.ztree {
	width: 50%;
}

.bootstrapMenu {
	z-index: 10000;
	position: absolute;
	display: none;
	height: 23px;
	width: 158px;
}

.dropdown-menu {
	position: static;
	display: block;
	font-size: 0.9em;
}

.help-block {
	display: block;
	float: right;
	color: #e15b52;
}

.upFile {
	margin-right: 10px;
}

#methodDescOfField, #methodDescUpdateOfField {
	width: 398px;
	height: 48px;
	border: 1px solid #ccc;
	margin: 7px auto 7px auto;
}
#methodDesc, #methodDescUpdate {
	width: 422px;
	height: 48px;
	border: 1px solid #ccc;
	margin: 7px auto 7px auto;
}
</style>
</head>
<body>
	<div class="row">
		<div class="col-lg-4 col-md-4 row-tab">
			<div id="function-panel" class="panel panel-default common-wrapper">
				<div class="panel-heading common-part">
					<i class="iconfont">&#xe6db;</i> <span>函数列表</span>
					<!-- <i class="iconfont icon-tip">&#xe6a8;</i> -->
					<i class="iconfont icon-tip">&#xe641;</i>
				</div>
				<div class="panel-body common-content">
					<ul id="function-tree" class="ztree"></ul>
				</div>
			</div>
		</div>
		<div class="col-lg-8 col-md-8 row-tab panel-r">
			<div id="con-panel" class="panel panel-default common-wrapper">
				<div class="panel-heading common-part" style="display: none;" id="tableHeading">
					<span style="font-weight: bold;">方法名称：</span> <span id="methodName"></span>
				</div>
				<div class="panel-body common-content">
					<table id="inputParamTable" class="display" cellspacing="0" width="100%" style="display: none;">
						<thead>
							<tr>
								<th>方法描述</th>
								<th>语法</th>
								<th>参数描述</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>

	</div>
	<!-- 在空白处右键单击弹出的菜单 -->
	<div id="blankContextMenu" class="dropdown bootstrapMenu">
		<ul class="dropdown-menu">
			<li><a href="javascript:void(0);" class="addFolder"> <i class="fa fa-fw fa-lg glyphicon glyphicon-folder-open"></i> <span>添加文件夹</span>
			</a></li>
		</ul>
	</div>
	<!-- 文件夹的菜单 -->
	<div id="folderContextMenu" class="dropdown bootstrapMenu">
		<ul class="dropdown-menu">
			<li><a href="javascript:void(0);" class="addFolder"> <i class="fa fa-fw fa-lg glyphicon glyphicon-folder-open"></i> <span>添加文件夹</span>
			</a></li>
			<li><a href="javascript:void(0);" class="addClass"> <i class="fa fa-fw fa-lg glyphicon glyphicon-link"></i> <span>添加类</span>
			</a></li>
			<li><a href="javascript:void(0);" class="editFolder"> <i class="fa fa-fw fa-lg glyphicon glyphicon-edit"></i> <span>修改文件夹</span>
			</a></li>
			<li><a href="javascript:void(0);" class="removeFolder"> <i class="fa fa-fw fa-lg glyphicon glyphicon-trash"></i> <span>删除文件夹</span>
			</a></li>
		</ul>
	</div>
	<!-- 类的菜单 -->
	<div id="linkContextMenu" class="dropdown bootstrapMenu">
		<ul class="dropdown-menu">
			<li><a href="javascript:void(0);" class="addMethod"> <i class="fa fa-fw fa-lg glyphicon glyphicon-th-large"></i> <span>添加方法</span>
			</a></li>
			<li><a href="javascript:void(0);" class="editClass"> <i class="fa fa-fw fa-lg glyphicon glyphicon-edit"></i> <span>修改类</span>
			</a></li>
			<li><a href="javascript:void(0);" class="removeClass"> <i class="fa fa-fw fa-lg glyphicon glyphicon-trash"></i> <span>删除类</span>
			</a></li>
		</ul>
	</div>
	<!-- 外连接的菜单 -->
	<div id="link1ContextMenu" class="dropdown bootstrapMenu">
		<ul class="dropdown-menu">
			<li><a href="javascript:void(0);" class="editMethod"> <i class="fa fa-fw fa-lg glyphicon glyphicon-edit"></i> <span>修改方法</span>
			</a></li>
			<li><a href="javascript:void(0);" class="removeMethod"> <i class="fa fa-fw fa-lg glyphicon glyphicon-trash"></i> <span>删除方法</span>
			</a></li>
		</ul>
	</div>

	<div id="addFolder" class="dialog-wrap">
		<form id="addFolderForm" data-validator-option="{timely:2, theme:'yellow_right'}">
			<input type="hidden" name="parentId" /> <input type="hidden" name="path" /> <input type="hidden" name="funTypeId" />
			<table class="form-table">
				<tr>
					<div class="form-group">
						<td><label for="funName">文件夹名称</label></td>
						<td><input type="text" class="form-control input-sm" name="funName" placeholder="请输入文件夹名称" data-rule="文件夹名称:required;" /></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="ord">排序</label></td>
						<td><input type="text" class="form-control input-sm" name="ord" placeholder="请输入排序，排序为纯数字" data-rule="排序:required;integer;range(0~9999)" /></td>
					</div>
				</tr>
			</table>
		</form>
	</div>

	<div id="addClass" class="dialog-wrap">
		<form id="addClassForm" data-validator-option="{timely:2, theme:'yellow_right'}">
			<input type="hidden" name="parentId" /> <input type="hidden" name="path" /> <input type="hidden" name="funTypeId" /> <input type="hidden" id="filePathAdd" name="storePath" />
			<table class="form-table">
				<tr>
					<div class="form-group">
						<td style="width: 80px;"><label for="packageName">包名</label></td>
						<td><input type="text" class="form-control input-sm" name="packageName" placeholder="请输入包名" data-rule="包名:required;length(2~32);filter;" /></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="funName">类名</label></td>
						<td><input type="text" class="form-control input-sm" name="funName" placeholder="请输入类名" data-rule="类名:required;length(2~32);filter;" /></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="dataType">处理数据类型</label></td>
						<td><select name="dataType" class="form-control input-select" style="width: 100%;" data-rule="处理数据类型:required;">
								<option value=""></option>
								<option value="stream">stream</option>
								<option value="field">field</option>
								<option value="tuple">tuple</option>
						</select></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="ord">排序</label></td>
						<td><input type="text" class="form-control input-sm" name="ord" placeholder="请输入排序，排序为纯数字" data-rule="排序:required;integer;range(0~9999)" /></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="classPath">文件存放路径</label></td>
						<td><input type="text" class="form-control input-sm" name="classPath" placeholder="文件存放路径" style="width: 100%;" readonly data-rule="required;" /></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="funFile">类源文件</label></td>
						<td>
							<div id="isExistFileNo">
								<div class="btns clearfix" style="margin-top: 10px; margin-bottom: 10px;">
									<div id="pickerUpload" class="fl picker upFile">
										<i class="iconfont">&#xe696;</i>选择文件
									</div>

									<div>
										<button id="ctlBtn" type="button" class="b-redBtn btn-i fl">开始上传</button>
									</div>
								</div>
								<div id="thelist" class="uploader-list" style="margin-left: 10px;"></div>
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
	</div>

	<div id="addMethod" class="dialog-wrap">
		<form id="addMethodForm" data-validator-option="{timely:2, theme:'yellow_right'}">
			<input type="hidden" name="parentId" /> 
			<input type="hidden" name="path" /> <input type="hidden" name="funTypeId" />
			<table class="form-table">
				<tr>
					<div class="form-group">
						<td><label for="funName">方法名</label></td>
						<td style="padding-left: 10px;"><input type="text" class="form-control input-sm" name="funName" placeholder="请输入方法名" data-rule="方法名:required;" /></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="parseFormat">解析格式</label></td>
						<td style="padding-left: 10px;"><select name="parseFormat" class="form-control input-select" style="width: 100%;" data-rule="解析格式:required;">
								<option value="" disabled></option>
								<option value="separator">分隔符</option>
								<option value="json">json</option>
								<option value="xml">xml</option>
						</select></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="ord">排序</label></td>
						<td style="padding-left: 10px;"><input type="text" class="form-control input-sm" name="ord" placeholder="请输入排序，排序为纯数字" data-rule="排序:required;integer;range(0~9999)" /></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="methodDescription">方法描述</label></td>
						<td style="padding-left: 10px;"><textarea type="text" class="form-control input-sm" name="methodDescription" id="methodDesc" placeholder="请输入方法描述" data-rule="方法描述:required;length[0~500]"></textarea></td>
					</div>
				</tr>
			</table>
		</form>
	</div>
	
	<div id="addMethodOfField" class="dialog-wrap">
		<form id="addMethodFormOfField" data-validator-option="{timely:2, theme:'yellow_right'}">
			<input type="hidden" name="parentId" /> <input type="hidden" name="path" /> <input type="hidden" name="funTypeId" />
			<table class="form-table">
				<tr>
					<div class="form-group">
						<td><label for="funName">方法名</label></td>
						<td style="padding-left: 10px;"><input type="text" class="form-control input-sm" name="funName" placeholder="请输入方法名" data-rule="方法名:required;" /></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="funParamType">方法参数类型</label></td>
						<td style="padding-left: 10px;"><select id="funParamTypeAdd" name="funParamType" class="form-control input-select" style="width: 85%;">
								<option value=""></option>
								<option value="int">整型</option>
								<option value="long">长整型</option>
								<option value="float">单精度浮点型</option>
								<option value="double">双精度浮点型</option>
								<option value="string">字符串</option>
								<option value="date">日期</option>
						</select>
							<button id="addFunParamAdd" type="button" class="b-redBtn btn-i">
								<i class="iconfont">&#xe696;</i>添加
							</button></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="funParam">方法参数配置</label></td>
						<td style="padding-left: 10px;">
							<div id="funParam" style="border: 1px solid #cbcbcb; width: 100%; height: 100px; overflow: auto; margin: 7px auto 7px auto;"></div>
						</td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="outputParam">方法返回类型</label></td>
						<td style="padding-left: 10px;"><select name="outputParam" class="form-control input-select" style="width: 100%;" data-rule="方法返回类型:required;">
								<option value=""></option>
								<option value="int">整型</option>
								<option value="long">长整型</option>
								<option value="char">字符型</option>
								<option value="float">单精度浮点型</option>
								<option value="double">双精度浮点型</option>
								<option value="string">字符串</option>
								<option value="date">日期</option>
								<option value="boolean">布尔</option>
								<option value="object">对象</option>
								<option value="void">空值</option>
						</select></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="ord">排序</label></td>
						<td style="padding-left: 10px;"><input type="text" class="form-control input-sm" name="ord" placeholder="请输入排序，排序为纯数字" data-rule="排序:required;integer;range(0~9999)" /></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="methodDescription">方法描述</label></td>
						<td style="padding-left: 10px;"><textarea type="text" class="form-control input-sm" name="methodDescription" id="methodDescOfField" placeholder="请输入方法描述" data-rule="方法描述:required;length[0~500]"></textarea></td>
					</div>
				</tr>
			</table>
		</form>
	</div>

	<div id="updateFolder" class="dialog-wrap">
		<form id="updateFolderForm" data-validator-option="{timely:2, theme:'yellow_right'}">
			<input type="hidden" name="id" /> <input type="hidden" name="parentId" /> <input type="hidden" name="path" /> <input type="hidden" name="funTypeId" />
			<table class="form-table">
				<tr>
					<div class="form-group">
						<td><label for="funName">文件夹名称</label></td>
						<td><input type="text" class="form-control input-sm" name="funName" placeholder="请输入文件夹名称" data-rule="文件夹名称:required;" /></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="ord">排序</label></td>
						<td><input type="text" class="form-control input-sm" name="ord" placeholder="请输入排序，排序为纯数字" data-rule="排序:required;integer;range(0~9999)" /></td>
					</div>
				</tr>
			</table>
		</form>
	</div>

	<div id="editClass" class="dialog-wrap">
		<form id="editClassForm" data-validator-option="{timely:2, theme:'yellow_right'}">
			<input type="hidden" name="id" /> <input type="hidden" name="parentId" /> <input type="hidden" name="path" /> <input type="hidden" name="funTypeId" /> <input type="hidden" id="filePathUpdate"
				name="storePath" />
			<table class="form-table">
				<tr>
					<div class="form-group">
						<td style="width: 80px;"><label for="packageName">包名</label></td>
						<td><input type="text" class="form-control input-sm" name="packageName" placeholder="请输入包名" data-rule="包名:required;length(2~32);filter;" /></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="funName">类名</label></td>
						<td><input type="text" class="form-control input-sm" name="funName" placeholder="请输入类名" data-rule="类名:required;length(2~32);filter;" /></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="dataType">处理数据类型</label></td>
						<td><select name="dataType" class="form-control input-select" style="width: 100%;" data-rule="处理数据类型:required;" disabled="disabled">
								<option value=""></option>
								<option value="stream">stream</option>
								<option value="field">field</option>
								<option value="tuple">tuple</option>
						</select></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="ord">排序</label>
						<td><input type="text" class="form-control input-sm" name="ord" placeholder="请输入排序，排序为纯数字" data-rule="排序:required;integer;range(0~9999)" /></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="classPath">文件存放路径</label></td>
						<td><input type="text" class="form-control input-sm" name="classPath" placeholder="文件存放路径" style="width: 100%;" readonly data-rule="required;" /></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="funFile">类源文件</label></td>
						<td>
							<div id="isExistFileNoUpdate">
								<div class="btns clearfix" style="margin-top: 10px;"margin-bottom: 10px;>
									<div id="pickerUploadUpdate" class="fl picker upFile">
										<i class="iconfont">&#xe696;</i>选择文件
									</div>

									<div>
										<button id="ctlBtnUpdate" type="button" class="b-redBtn btn-i fl">开始上传</button>
									</div>
								</div>
								<div id="thelistUpdate" class="uploader-list" style="margin-left: 10px;"></div>
							</div>
							<div id="isExistFileYesUpdate">
								<button id="fileDownUpdate" type="button" class="b-redBtn btn-i fl">下载</button>

								<button id="fileDeleteUpdate" type="button" class="b-redBtn btn-i fl" style="margin-left: 10px;">删除</button>
							</div>
						</td>
					</div>
				</tr>
			</table>
		</form>
	</div>

	<div id="editMethod" class="dialog-wrap">
		<form id="editMethodForm" data-validator-option="{timely:2, theme:'yellow_right'}">
			<input type="hidden" name="id" /> 
			<input type="hidden" name="parentId" /> 
			<input type="hidden" name="path" /> 
			<input type="hidden" name="funTypeId" />
			<table class="form-table">
				<tr>
					<div class="form-group">
						<td><label for="funName">方法名</label></td>
						<td style="padding-left: 10px;"><input type="text" class="form-control input-sm" name="funName" placeholder="请输入方法名" data-rule="方法名:required;" /></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="parseFormat">解析格式</label></td>
						<td style="padding-left: 10px;"><select name="parseFormat" class="form-control input-select" style="width: 100%;" data-rule="解析格式:required;">
								<option value="" disabled></option>
								<option value="separator">分隔符</option>
								<option value="json">json</option>
								<option value="xml">xml</option>
						</select></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="ord">排序</label></td>
						<td style="padding-left: 10px;"><input type="text" class="form-control input-sm" name="ord" placeholder="请输入排序，排序为纯数字" data-rule="排序:required;integer;range(0~9999)" /></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="methodDescription">方法描述</label></td>
						<td style="padding-left: 10px;"><textarea type="text" class="form-control input-sm" name="methodDescription" id="methodDescUpdate" placeholder="请输入方法描述"
								data-rule="方法描述:required;length[0~500]"></textarea></td>
					</div>
				</tr>
			</table>
		</form>
	</div>
	
	<div id="editMethodOfField" class="dialog-wrap">
		<form id="editMethodFormOfField" data-validator-option="{timely:2, theme:'yellow_right'}">
			<input type="hidden" name="id" /> 
			<input type="hidden" name="parentId" /> <input type="hidden" name="path" /> <input type="hidden" name="funTypeId" />
			<table class="form-table">
				<tr>
					<div class="form-group">
						<td><label for="funName">方法名</label></td>
						<td style="padding-left: 10px;"><input type="text" class="form-control input-sm" name="funName" placeholder="请输入方法名" data-rule="方法名:required;" /></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="funParamType">方法参数类型</label></td>
						<td style="padding-left: 10px;"><select id="funParamTypeUpdate" name="funParamType" class="form-control input-select" style="width: 85%;">
								<option value=""></option>
								<option value="int">整型</option>
								<option value="long">长整型</option>
								<option value="float">单精度浮点型</option>
								<option value="double">双精度浮点型</option>
								<option value="string">字符串</option>
								<option value="date">日期</option>
						</select>
							<button id="addFunParamUpdate" type="button" class="b-redBtn btn-i">
								<i class="iconfont">&#xe696;</i>添加
							</button></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="funParam">方法参数配置</label></td>
						<td style="padding-left: 10px;">
							<div id="funParamUpdate" style="border: 1px solid #cbcbcb; width: 100%; height: 100px; overflow: auto; margin: 7px auto 7px auto;"></div>
						</td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="outputParam">方法返回类型</label></td>
						<td style="padding-left: 10px;"><select name="outputParam" class="form-control input-select" style="width: 100%;" data-rule="方法返回类型:required;">
								<option value=""></option>
								<option value="int">整型</option>
								<option value="long">长整型</option>
								<option value="char">字符型</option>
								<option value="float">单精度浮点型</option>
								<option value="double">双精度浮点型</option>
								<option value="string">字符串</option>
								<option value="date">日期</option>
								<option value="boolean">布尔</option>
								<option value="object">对象</option>
								<option value="void">空值</option>
						</select></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="ord">排序</label></td>
						<td style="padding-left: 10px;"><input type="text" class="form-control input-sm" name="ord" placeholder="请输入排序，排序为纯数字" data-rule="排序:required;integer;range(0~9999)" /></td>
					</div>
				</tr>
				<tr>
					<div class="form-group">
						<td><label for="methodDescription">方法描述</label></td>
						<td style="padding-left: 10px;"><textarea type="text" class="form-control input-sm" name="methodDescription" id="methodDescUpdateOfField" placeholder="请输入方法描述"
								data-rule="方法描述:required;length[0~500]"></textarea></td>
					</div>
				</tr>
			</table>
		</form>
	</div>

	<%@ include file="../common-js.jsp"%>
	<script src="<%=webpath%>/resources/js/function/fun_def.js"></script>
	<script src="<%=webpath%>/resources/plugin/webuploader-0.1.5/webuploader.min.js"></script>
</body>
</html>