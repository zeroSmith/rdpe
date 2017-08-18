<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.bonc.rdpe.util.SystemPropertiesUtils"
	language="java"%>
<%@ page import="com.bonc.rdpe.entity.EventOpt" %>
<%
	String webpath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<%@ include file="../common-head.jsp"%>
	<%@ include file="../common-layer-ext.jsp"%>
	<%@ include file="../common-body-css.jsp"%>
	<title>数据源配置</title>
    <link rel="stylesheet" type="text/css" href="<%=webpath %>/resources/plugin/flow/css//Font-Awesome-master/css/font-awesome.css">
	<link rel="stylesheet" type="text/css" href="<%=webpath %>/resources/plugin/flow/css/flow.css">
    <link rel="stylesheet" type="text/css" href="<%=webpath %>/resources/plugin/flow/css/event_opt.css">
	
    <script type="text/javascript" src="<%=webpath %>/resources/plugin/jquery/jquery-1.9.1.js"></script>
	<script type="text/javascript" src="<%=webpath %>/resources/plugin/layer/layer.js"></script>

	<!--如果要使用下拉框要引用easyloader js-->
    <script type="text/javascript" src="<%=webpath %>/resources/plugin/flow/js/easyui/easyloader.js"></script>

    <script type="text/javascript" src="<%=webpath %>/resources/plugin/flow/js/flow/raphael-min.js"></script>
    <script type="text/javascript" src="<%=webpath %>/resources/plugin/jquery-ui-1.12.1/jquery-ui.js"></script>
    <script type="text/javascript" src="<%=webpath %>/resources/plugin/flow/js/flow/myflow.source.js"></script>
	<script type="text/javascript" src="<%=webpath %>/resources/plugin/flow/js/flow/myflow.editors.js"></script>
    <script type="text/javascript" src="<%=webpath %>/resources/plugin/flow/js/flow/myflow.jpdl3.js"></script>
    
    <title>field</title>
</head>

<body class="container-fluid">
	<form id="dsOptForm">
	    <div class="containerInfo">
	        <div>
	            <table class="table table-fixedLength form-table" id="dsOptTable">
		            <tr>
						<td>
							<div class="form-group">
								<label for="astype" style="">处理方式:</label> 
								<select class="form-control input-sm" name="astype" id="astype" style="width: 70%;float: right;" data-rule="required;">
									<option value="">请选择处理方式</option>
									<option value="stream">实时流</option>
									<option value="rule">规则库</option>
								</select>
							</div>
						</td>
					</tr>
                    <tr>
                    	<td>
							<div class="form-group">
								<label for="dstype">数据源类型:</label> 
								<select class="form-control input-sm" name="dstype" id="dstype" style="width: 70%;float: right;" data-rule="required;">
								</select>
							</div>
						</td>
                    </tr>
                     <tr>
                     	<td>
							<div class="form-group">
								<label for="dsname">数据源名称:</label> 
								<select class="form-control input-sm" name="dsname" id="dsname" style="width: 70%;float: right;" data-rule="required;">
								</select>
							</div>
						</td>
                    </tr>
                    <tr>
                     	<td>
							<div class="form-group">
								<label for="dsformat">数据源格式:</label> 
								<select class="form-control input-sm" name="dsformat" id="dsformat" style="width: 70%;float: right;" data-rule="required;">
								</select>
							</div>
						</td>
                    </tr>
	            </table>
	        </div>
	    </div>
    </form>
    
    <script type="text/javascript">
    	$(function() {
    		$("#dsOptTable").find("select[name='astype']").unbind("change").change(function(obj){
    			if($(this).val() == 'stream'){
    				$("select[name='dstype']").empty();
    				$("select[name='dsname']").empty();
    				$("select[name='dstype']").append("<option value=''></option><option value='kafka'>kafka</option><option value='hdfs'>hdfs</option>");
    			}else if($(this).val() == 'rule'){
    				$("select[name='dstype']").empty();
    				$("select[name='dsname']").empty();
    				$("select[name='dstype']").append("<option value=''></option><option value='hdfs'>hdfs</option><option value='redis'>redis</option>");
    			}else{
    				$("select[name='dstype']").empty();
    				$("select[name='dsname']").empty();
    			}
    		});
    		
    		$("#dsOptTable").find("select[name='dstype']").unbind("change").change(function(obj){
    			var webpath = "<%=webpath %>";
    			$.ajax({// 根据选择的数据源类型查询数据库
	    				"url" : "<%=webpath %>" + "/event/opt/ds/get",
	    				"type" : "POST",
	    				dataType : "json",
	    				data : {
	    					dstype : $(this).val()
	    				},
	    				success : function(data) {
	    					if(data.length>0){
	    						$("select[name='dsname']").empty();
	    						$("select[name='dsname']").append("<option value=''></option>");
	    						data.forEach(function(value,index,array){
	    							$("select[name='dsname']").append("<option value ='"+value.id+"'>"+value.dsName+"</option>");
	    						});
	    					}else{
	    						$("select[name='dsname']").empty();
	    						$("select[name='dsformat']").empty();
	    						layer.open({
	           						 title:'<i class="iconfont">&#xe649;</i>&nbsp;提示',
	           						 content: "当前数据源为空，请先进行数据源配置！！"
	           					 });
	    					}
	    				}
             	});
    		});
    		
    		$("#dsOptTable").find("select[name='dsname']").unbind("change").change(function(obj){
    			if($(this).val().length>0){
	    			$("select[name='dsformat']").empty();
					$("select[name='dsformat']").append("<option value=''></option><option value='separator'>分隔符</option><option value='json'>json</option><option value='xml'>xml</option>");
    			}else{
    				$("select[name='dsformat']").empty();
    			}
    		});
    		
    		var optDef = '${eventOpt.optDef }';
    		if(optDef!=null && optDef!=''){
    			optDef = eval('(' + optDef + ')');
    			$("select[name='astype']").val(optDef.asType);
    			if(optDef.asType == 'stream'){
    				$("select[name='dstype']").empty();
    				$("select[name='dsname']").empty();
    				$("select[name='dstype']").append("<option value=''></option><option value='kafka'>kafka</option><option value='hdfs'>hdfs</option>");
    				$("select[name='dstype']").val(optDef.dsType);
    			}else if(optDef.asType == 'rule'){
    				$("select[name='dstype']").empty();
    				$("select[name='dsname']").empty();
    				$("select[name='dstype']").append("<option value=''></option><option value='hdfs'>hdfs</option><option value='redis'>redis</option>");
	    			$("select[name='dstype']").val(optDef.dsType);
    			}
    			$.ajax({// 根据选择的数据源类型查询数据库
    				"url" : "<%=webpath %>" + "/event/opt/ds/get",
    				"type" : "POST",
    				dataType : "json",
    				data : {
    					dstype : optDef.dsType
    				},
    				success : function(data) {
    					if(data.length>0){
    						$("select[name='dsname']").empty();
    						$("select[name='dsname']").append("<option value=''></option>");
    						data.forEach(function(value,index,array){
    							$("select[name='dsname']").append("<option value ='"+value.id+"'>"+value.dsName+"</option>");
    						});
    						$("select[name='dsname']").val(optDef.dsName);
    						$("select[name='dsformat']").empty();
    						$("select[name='dsformat']").append("<option value=''></option><option value='separator'>分隔符</option><option value='json'>json</option><option value='xml'>xml</option>");
    						$("select[name='dsformat']").val(optDef.dsFormat);
    					}else{
    						$("select[name='dsname']").empty();
    						$("select[name='dsformat']").empty();
    					}
    				}
         		});
    		}
    	})
    	
    </script>
</body>

</html>
