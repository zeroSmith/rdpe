<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
   String webpath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="stylesheet" type="text/css" href="<%=webpath %>/resources/plugin/flow/css/Font-Awesome-master/css/font-awesome.css">
<link rel="stylesheet" type="text/css" href="<%=webpath %>/resources/plugin/ztree/css/zTreeStyle/zTreeStyle.css">
<link rel="stylesheet" type="text/css" href="<%=webpath %>/resources/plugin/flow/css/trans.css">

<script type="text/javascript" src="<%=webpath %>/resources/plugin/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="<%=webpath %>/resources/plugin/layer/layer.js"></script>
<script type="text/javascript" src="<%=webpath %>/resources/plugin/ztree/js/jquery.ztree.all.js"></script>
<script type="text/javascript" src="<%=webpath %>/resources/plugin/nicescroll/jquery.nicescroll.js"></script>
<script type="text/javascript" src="<%=webpath %>/resources/js/event/UUID.js"></script>
<script type="text/javascript" src="<%=webpath %>/resources/js/event/functionList.js"></script>
<title>fundef</title>
</head>

<body class="container-fluid">
	<div class="treeInfo">
		<div class="flowTreeInfo left">
			<ul id="funDefTree" class="ztree"></ul>
		</div>
	</div>


	<script>
	//当前事件
	var eventOpt = ${eventOpt };
	var resource = {
			treeObj:null,
			setting : {
				data:{
					simpleData: {
						enable:true, 
						idKey:'id',
						pIdKey:'parentId'
					},
					key:{
						name:'funName',
						url:'xurl'
					}
				},
				check: {
					enable: true,
					chkboxType: {"Y":"p", "N":"p"}
				},
				callback:{
					  onClick: function(e,treeId,treeNode){
					    },
					  beforeCheck: function(treeId,treeNode){
						  	var nodes = resource.treeObj.getCheckedNodes(true);
					    	$.each(nodes, function(index, value, array) {
					    		//取消已经选择的
					    		resource.treeObj.checkNode(value, false, true);
					    	});
					    	return true;
					  }
				}
		    },
			initTree:function(){
				if(resource.treeObj!=null){
					resource.treeObj.destroy();//销毁 zTreeObj 代表的 zTree
				}
				$.ajax({//初始化组织机构树
					"url":"<%=webpath%>/funDef/get",
						"type" : "POST",
						dataType : "json",
						async: false,//设为同步
						success : function(data) {
							if (data != null && data.length > 0) {
								for(var i=0;i<data.length;i++){
									data[i].icon=<%=webpath%>/+resourceTypeIcon[data[i].funTypeId];
								}
								resource.treeObj = $.fn.zTree.init($("#funDefTree"), resource.setting,data);
								resource.treeObj.expandAll(false);
							} else {
								layer.msg('暂无函数数据', {
									time : 2000,
									icon : 5
								});
							}
						}
					});
				}
			};
	
	var resourceTypeIcon = {
			"0":"/resources/img/icon/16x16/floder1-black.png",
			"1":"/resources/img/icon/16x16/link1-black.png",
			"2":"/resources/img/icon/16x16/fun-black.png"
	};
	$(document).ready(function(){
		resource.initTree();
		var _optDef = eventOpt.optDef;
		if(_optDef.length > 0){
			var _optDef_JSON = JSON.parse(_optDef);
			var _hasFun = resource.treeObj.getNodeByParam("id",_optDef_JSON.id,null);
			if(_hasFun != null){
				resource.treeObj.checkNode(_hasFun, true, true)
				resource.treeObj.expandNode(_hasFun.getParentNode(), true, true, true)
			}
		}
		
	});
	
	</script>
</body>

</html>
