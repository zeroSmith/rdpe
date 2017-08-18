<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.bonc.rdpe.entity.EventSpark" %>
<%String webpath = request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
	<link rel="stylesheet" type="text/css" href="<%=webpath %>/resources/plugin/flow/css//Font-Awesome-master/css/font-awesome.css">
	<link rel="stylesheet" type="text/css" href="<%=webpath %>/resources/plugin/flow/css/event_opt.css">
	<link rel="stylesheet" type="text/css" href="<%=webpath %>/resources/plugin/flow/css/flow.css">
	
	<script type="text/javascript" src="<%=webpath %>/resources/plugin/jquery/jquery-1.9.1.js"></script>
	<script type="text/javascript" src="<%=webpath %>/resources/plugin/layer/layer.js"></script>

    <script type="text/javascript" src="<%=webpath %>/resources/plugin/flow/js/easyui/easyloader.js"></script>
    <script type="text/javascript" src="<%=webpath %>/resources/plugin/jquery-ui-1.12.1/jquery-ui.js"></script>
    <script type="text/javascript" src="<%=webpath %>/resources/plugin/flow/js/flow/raphael-min.js"></script>
    <script type="text/javascript" src="<%=webpath %>/resources/plugin/flow/js/flow/myflow.source.js"></script>
	<script type="text/javascript" src="<%=webpath %>/resources/plugin/flow/js/flow/myflow.editors.js"></script>
    <script type="text/javascript" src="<%=webpath %>/resources/plugin/flow/js/flow/myflow.jpdl4.js"></script>
    <style type="text/css">
		.layui-layer-btn a {
			border:1px solid #8a8a8a;
			background-color: #8a8a8a;
		}
		.layui-layer-title {
			height: 34px;
			line-height: 34px;
		}
    </style>
    <title>事件处理</title>
</head>
<body class="container-fluid">
    <div id="content">
		<div id="dtreeTitle">
			<p class="treeName" style="display: inline-block;">${event.eventCnName }</p>
			<input type="hidden" name="eventType" value="${event.eventType }" />
			<input type="hidden" name="eventCnName" value="${event.eventCnName }" />
			<input type="hidden" name="eventEnName" value="${event.eventEnName }" />
			<input type="hidden" name="eventId" value="${event.id }" />
			<input type="hidden" name="classify" value="${classify }" />
			<a style="display: inline-block; float: right; margin-top: 12px; margin-right: 40px; color: #e15b52" id="backOff" title="返回">
				<i class="fa fa-reply"></i>
			</a>
		</div>
		<div id="treeContent">
            <div id="myflow_tools">
                <div id="myflow_tools_handle">工具集</div>
                <div class="node" id="save">
                    <div id="myflow_save"><img src="<%=webpath%>/resources/plugin/flow/images/flow/save.png" /><span>保存</span></div>
                    <div id="iconCtlSave"><img src="<%=webpath%>/resources/plugin/flow/images/flow/close.png"></div>
                </div>
                <div class="node selectable" id="pointer"><img src="<%=webpath%>/resources/plugin/flow/images/flow/choose.png" />选择</div>
                <div class="node selectable" id="path"><img src="<%=webpath%>/resources/plugin/flow/images/flow/line.png" />线</div>
                <div class="node state" id="start" type="start"><img src="<%=webpath%>/resources/plugin/flow/images/flow/start.png"/>开始</div>
                <div class="node state" id="ds"  type="ds"><img src="<%=webpath%>/resources/plugin/flow/images/flow/action.png" />提取</div>
				<div class="node state" id="parse"  type="parse"><img src="<%=webpath%>/resources/plugin/flow/images/flow/action.png" />解析</div>
				<div class="node state" id="filter"  type="filter"><img src="<%=webpath%>/resources/plugin/flow/images/flow/action.png" />过滤</div>
				<div class="node state" id="join"  type="join"><img src="<%=webpath%>/resources/plugin/flow/images/flow/merge.png" />关联</div>
				<div class="node state" id="trans"  type="trans"><img src="<%=webpath%>/resources/plugin/flow/images/flow/action.png" />转换</div>
				<div class="node state" id="aggregate"  type="aggregate"><img src="<%=webpath%>/resources/plugin/flow/images/flow/action.png" />聚合</div>
				<div class="node state" id="fun"  type="fun"><img src="<%=webpath%>/resources/plugin/flow/images/flow/action.png" />函数</div>
				<div class="node state" id="store"  type="store"><img src="<%=webpath%>/resources/plugin/flow/images/flow/action.png" />存储</div>
				<div class="node state" id="end"   type="end"><img src="<%=webpath%>/resources/plugin/flow/images/flow/end.png" />结束</div>
            </div>
            <div id="myflow_props">
                <div id="myflow_props_handle">属性配置</div>
                <table id="props" width="100%" cellpadding="0" cellspacing="0">
                </table>
            </div>
            <div id="myflow"></div>
        </div>
        </div>
    </div>
    
    <script type="text/javascript">
	    /* $("body").css({overflow:"hidden"}); *///禁止窗口滚动条
	    $(function() {
			var flowDef = '${event.flowDef}';	 
			if(flowDef!=null && flowDef!==""){
				$("#myflow").myflow({
					restore: (eval('(' + flowDef + ')'))
				})
			}else{
				$("#myflow").myflow({restore:({
		            states: {},
		            paths: {},
		            props: {
		            	pkgId: $("input[name='eventType']").val(),
		                id: $("input[name='eventId']").val(),
		                props: { text: { value: $("input[name='eventCnName']").val() } }
		            }
		        })});
			}
	   });
	    $("#backOff").click(function() {
	    	layer.confirm('确定返回事件列表页面', {
				icon : 3,
				btn : [ '是', '否' ]
			}, function(index, layero) {
				var webpath = "<%=webpath %>";
				window.location.href = webpath+"/event/storm/index";		
				/* if('${classify}' == 'storm'){
				}else{
			    	window.location.href = webpath+"/event/spark/index";
				} */
			})
	    })
    </script>
</body>

</html>