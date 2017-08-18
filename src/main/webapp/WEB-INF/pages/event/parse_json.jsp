<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
   String webpath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="../common-head.jsp"%>
<%@ include file="../common-layer-ext.jsp"%>
<%@ include file="../common-body-css.jsp"%>
<%@ include file="../common-js.jsp"%>
<script type="text/javascript" src="<%=webpath %>/resources/js/event/UUID.js"></script>	
<title>fundef</title>
<style type="text/css">
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
}</style>
</head>

<body class="container-fluid">
	<div class="row">
		<div class="col-lg-4 col-md-4 row-tab">
			<div id="function-panel" class="panel panel-default common-wrapper">
				<div class="panel-body common-content">
					<ul id="propertiesTree" class="ztree"></ul>
				</div>
			</div>
		</div>
		<div class="col-lg-8 col-md-8 row-tab panel-r">
			<div id="con-panel" class="panel panel-default common-wrapper">
				<div class="panel-body common-content addPropertyParamDiv">
					<form id="addPropertyParam" class="form-inline" data-validator-option="{timely:2, theme:'yellow_right'}">
						<table class="form-table">
							<tr>
								<div class="form-group">
									<td style="width:15%"><label for="enName">属性英文名:</label></td>
									<td style="width:85%">
										<input type="text" class="form-control input-sm" name="enName" placeholder="请输入属性英文名"  style="width: 80%;"  data-rule="required;"/>
									</td>
								</div>
							</tr>
							<tr>
								<div class="form-group">
									<td style="width:15%"><label for="cnName">属性中文名:</label></td>
									<td style="width:85%">
										<input type="text" class="form-control input-sm" name="cnName" placeholder="请输入属性中文名" style="width: 80%;"  data-rule="required;"/>
									</td>
								</div>
							</tr>
							<tr>
								<div class="form-group">
									<td style="width:15%"><label for="type">数据类型:</label></td>
									<td style="width:85%">
										<select name="type" class="form-control input-sm typeClass" style="width: 80%;" data-rule="required;">
											<option value="int">int</option>
											<option value="long">long</option>
											<option value="float">float</option>
											<option value="double">double</option>
											<option value="string">string</option>
											<option value="date">date</option>
										</select>
									</td>
								</div>
							</tr>
								<tr>
								<div class="form-group">
									<td style="width:15%"><label for="len">数据长度:</label></td>
									<td style="width:85%">
										<input type="text" class="form-control input-sm" name="len" placeholder="请输入数据长度" style="width: 80%;"  data-rule="required;"/>
									</td>
								</div>
							</tr>
							<tr>
								<div class="form-group">
									<td style="width:15%"></td>
									<td style="width:85%">
										<button id="sureBtn" type="button" class="b-redBtn btn-i fl" style="margin-left: 60%;">确定</button>
										<button id="resetBtn" type="button" class="b-redBtn btn-i fl"  style="margin-left: 20px;">重置</button>
									</td>
								</div>
							</tr>
						</table>
					</form>
				</div>
				
				<div class="panel-body common-content editPropertyParamDiv">
					<form id="editPropertyParam" class="form-inline" data-validator-option="{timely:2, theme:'yellow_right'}">
						<input type="hidden" name="fieldId"/>
						<input type="hidden" name="parentId"/>
						<table class="form-table">
							<tr>
								<div class="form-group">
									<td style="width:15%"><label for="enName">属性英文名:</label></td>
									<td style="width:85%">
										<input type="text" class="form-control input-sm" name="enName" placeholder="请输入属性英文名"  style="width: 80%;"  data-rule="required;"/>
									</td>
								</div>
							</tr>
							<tr>
								<div class="form-group">
									<td style="width:15%"><label for="cnName">属性中文名:</label></td>
									<td style="width:85%">
										<input type="text" class="form-control input-sm" name="cnName" placeholder="请输入属性中文名" style="width: 80%;"  data-rule="required;"/>
									</td>
								</div>
							</tr>
							<tr>
								<div class="form-group">
									<td style="width:15%"><label for="type">数据类型:</label></td>
									<td style="width:85%">
										<select name="type" class="form-control input-sm typeClass" style="width: 80%;" data-rule="required;">
											<option value="int">int</option>
											<option value="long">long</option>
											<option value="float">float</option>
											<option value="double">double</option>
											<option value="string">string</option>
											<option value="date">date</option>
										</select>
									</td>
								</div>
							</tr>
								<tr>
								<div class="form-group">
									<td style="width:15%"><label for="len">数据长度:</label></td>
									<td style="width:85%">
										<input type="text" class="form-control input-sm" name="len" placeholder="请输入数据长度" style="width: 80%;"  data-rule="required;"/>
									</td>
								</div>
							</tr>
							<tr>
								<div class="form-group">
									<td style="width:15%"></td>
									<td style="width:85%">
										<button id="sureBtn" type="button" class="b-redBtn btn-i fl" style="margin-left: 60%;">确定</button>
										<button id="resetBtn" type="button" class="b-redBtn btn-i fl"  style="margin-left: 20px;">重置</button>
									</td>
								</div>
							</tr>
						</table>
					</form>
				</div>
				
				
			</div>
		</div>

	</div>
	<script>
	var propertyArray = new Array();
	var selectNode = "";//被选中的节点
	//当前事件
	var resource = {
			treeObj:null,
			setting : {
				 edit: {
			            enable: true,
						showRemoveBtn: showRemoveBtn,
						showRenameBtn: false,
						removeTitle: "删除字段",
						editNameSelectAll: true,
			            drag: {
			                isCopy: true,
			                isMove: false,
			                prev: false,
			                next: false,
			                inner: false
			            }
			        },
			        view: {
			        	addHoverDom: addHoverDom,
			    		removeHoverDom: removeHoverDom,
						selectedMulti: false,
						showIcon: true
					},
				data:{
					simpleData: {
						enable:true, 
						idKey:'fieldId',
						pIdKey:'parentId'
					},
					key:{
						name:'enName',
						url:'xurl'
					}
				},
				callback:{
					onRemove:function(event, treeId, treeNode){
						var indexThis = "";
						 $.each(propertyArray, function(index, value, array) {
							  if((value.fieldId) == (treeNode.fieldId)){
								  indexThis = index;
							 }
						 });
						 propertyArray.splice(indexThis,1);
						 resource.treeObj = $.fn.zTree.init($("#propertiesTree"), resource.setting,propertyArray);
						 resource.treeObj.expandAll(true);
						 $(".editPropertyParamDiv").hide();
					},
					onClick:function(event, treeId, treeNode){
						$(".addPropertyParamDiv").hide();
						if(treeNode.isParent){
							$(".editPropertyParamDiv").hide();
							return;
						}
						$("#editPropertyParam").find("input[name='enName']").val(treeNode.enName);
						$("#editPropertyParam").find("input[name='cnName']").val(treeNode.cnName);
						$("#editPropertyParam").find("select[name='type']").val(treeNode.type);
						$("#editPropertyParam").find("input[name='len']").val(treeNode.len);
						$("#editPropertyParam").find("input[name='fieldId']").val(treeNode.fieldId);
						$("#editPropertyParam").find("input[name='parentId']").val(treeNode.parentId);
						$(".editPropertyParamDiv").show();
					}
				}
		    },
			initTree:function(){
				if(resource.treeObj!=null){
					resource.treeObj.destroy();//销毁 zTreeObj 代表的 zTree
				}
				resource.treeObj = $.fn.zTree.init($("#propertiesTree"), resource.setting,propertyArray);
				resource.treeObj.expandAll(true);
			}
		};
	function showRemoveBtn(treeId,treeNode){
		return !treeNode.isParent;
	}
	function addHoverDom(treeId, treeNode) {
		if(!treeNode.isParent){
			return;
		}
		var sObj = $("#" + treeNode.tId + "_span"); //获取节点信息  
	    if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;  
	  
	    var addStr = "<span class='button add' id='addBtn_" + treeNode.tId + "' title='添加属性' onfocus='this.blur();'></span>"; //定义添加按钮  
	    sObj.after(addStr); //加载添加按钮  
	    var btn = $("#addBtn_"+treeNode.tId);
		if (btn) btn.bind("click", function(){
			$(".editPropertyParamDiv").hide();
			selectNode = treeNode;
			var formObj = $("#addPropertyParam");
			form.clear(formObj);
			form.cleanValidator(formObj);
			$(".addPropertyParamDiv").show();
			return false;
		});
	};
	function removeHoverDom(treeId, treeNode) {
		$("#addBtn_"+treeNode.tId).unbind().remove();
	};
	
	$(function(){
		// 取消菜单事件
		$("body").bind({
			click : function(e) {
				$(".bootstrapMenu").hide();
			}
		});
		//每次打开需要重置
		propertyArray = [];
		var _root = {
				enName:"解析字段", 
		    	fieldId:'root',
		    	open:true, 
		    	isParent:true,
		}
		propertyArray.push(_root);
		var _optDef = ${eventOpt.optDef };
		var jsonProperties = _optDef.jsonProperties;
		if(!jsonProperties){
			 layer.msg('当前没有解析的字段', {time: 1000, icon:6});
		}else{
			jsonProperties.forEach(function(value,index,array){
				propertyArray.push(value);
			}); 
		}
		resource.initTree();
		$(".addPropertyParamDiv").hide();
		$(".editPropertyParamDiv").hide();
		$(".addProperty").on("click",function(){
			var formObj = $("#addPropertyParam");
			form.clear(formObj);
			form.cleanValidator(formObj);
			$(".addPropertyParamDiv").show();
			$("#propertyContextMenu").hide();
		});
		$("#resetBtn").on("click",function(){
			form.clear($("#addPropertyParam"));
		});
		$("#addPropertyParam").find("#sureBtn").on("click",function(){
			var formObj = $("#addPropertyParam");
			if (form.isValidator(formObj)) {
				var _len = formObj.find("input[name='len']");
				//验证是否是数字
	        	var reg = new RegExp("^[0-9]*[1-9][0-9]*$"); 
	        	if(!reg.test(_len.val())){
	        		layer.tips('只能是非0正整数', _len, {
					  tips: [1, '#78BA32'] 
					});
					return;
	        	}
				var _property = form.serializeJson(formObj);
				_property["fieldId"] = UUID.prototype.createUUID ();//追加属性
				_property["parentId"] = selectNode.fieldId;
				propertyArray.push(_property);
				resource.treeObj = $.fn.zTree.init($("#propertiesTree"), resource.setting,propertyArray);
				resource.treeObj.expandAll(true);
				$(".addPropertyParamDiv").hide();
			}
		});
		$("#editPropertyParam").find("#sureBtn").on("click",function(){
			var formObj = $("#editPropertyParam");
			if (form.isValidator(formObj)) {
				var _property = form.serializeJson(formObj);
				var indexThis = "";
				//遍历保存输出字段的数组
				 $.each(propertyArray, function(index, value, array) {
					  if((value.fieldId) == (_property.fieldId)){
						  indexThis = index;
					 }
				 });
				propertyArray.splice(indexThis,1,_property);
				resource.treeObj = $.fn.zTree.init($("#propertiesTree"), resource.setting,propertyArray);
				resource.treeObj.expandAll(true);
				$(".editPropertyParamDiv").hide();
			}
		});
	});
	</script>
</body>

</html>
