<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
	<title>数据存储配置</title>
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
	<form id="storeOptForm">
	    <div class="containerInfo">
	        <div>
	            <table class="table table-fixedLength form-table" id="storeOptTable">
                    <tr>
                    	<td>
							<div class="form-group">
								<label for="storetype">数据源类型:</label> 
								<select class="form-control input-sm" name="storetype" id="storetype" style="width: 70%;float: right;" data-rule="required;">
									<option value="">请选择数据源类型</option>
									<option value="kafka">kafka</option>
									<option value="hdfs">hdfs</option>
								</select>
							</div>
						</td>
                    </tr>
                     <tr>
                     	<td>
							<div class="form-group">
								<label for="storename">数据源名称:</label> 
								<select class="form-control input-sm" name="storename" id="storename" style="width: 70%;float: right;" data-rule="required;">
								</select>
							</div>
						</td>
                    </tr>
                    <tr>
                     	<td>
							<div class="form-group">
								<label for="storeformat">数据存储格式:</label> 
								<select class="form-control input-sm" name="storeformat" id="storeformat" style="width: 70%;float: right;" data-rule="required;">
								</select>
							</div>
						</td>
                    </tr>
	            </table>
	        </div>
	    </div>
    </form>
    
    <script type="text/javascript">
    	$(document).ready(function (e) {
    		$("select[name='storeformat']").editable(e);
    	});
		$.fn.editable = function(config){  
		    $(this).each(function(i,t){  
		        $(t).change(function(){  
		            var me=$(this);  
		            me.find('.separator').remove();  
		            if("separator" == me.val()){  
		                var ed = $("<input type=\"text\" class=\"form-control input-sm\" title=\"请输入分隔符\" style=\"width: 70%;float: right;\"/>");  
		                me.after(ed).hide();  
		                ed.blur(function(){  
		                    var v=ed.val();  
		                    if(null === v ||  v.length ==0){  
		                        ed.remove();
		                        me.val(null).show();  
		                    }else{  
		                        me.append("<option value=\""+v+"\" class=\"separator\" selected>"+v+"</option>").show();  
		                        ed.remove();  
		                    }  
		                }).focus();  
		            }  
		        })  
		    });  
		}
    	$(function() {
    		$("#storeOptTable").find("select[name='storetype']").unbind("change").change(function(obj){
    			if($(this).val()!=""){
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
		    						$("select[name='storename']").empty();
		    						$("select[name='storename']").append("<option value=''></option>");
		    						data.forEach(function(value,index,array){
		    							$("select[name='storename']").append("<option value ='"+value.id+"'>"+value.dsName+"</option>");
		    						});
		    						/* 
		    						$("select[name='storeformat']").empty();
		    						$("select[name='storeformat']").append("<option value=''></option><option value='separator'>分隔符</option><option value='json'>json</option><option value='xml'>xml</option>");
		    						*/
		    					 }else{
		    						$("select[name='storename']").empty();
		    						$("select[name='storeformat']").empty();
		    						layer.open({
		           						 title:'<i class="iconfont">&#xe649;</i>&nbsp;提示',
		           						 content: "当前数据源为空，请先进行数据源配置！！"
		           					 });
		    					}
		    				}
	             	});
    			}else{
    				$("select[name='storename']").empty();
    				$("select[name='storeformat']").empty();
    			}
    		});
    		
    		$("#storeOptTable").find("select[name='storename']").unbind("change").change(function(obj){
    			if($(this).val().length>0){
	    			$("select[name='storeformat']").empty();
	    			$("select[name='storeformat']").append("<option value=''></option><option value='separator'>分隔符</option><option value='json'>json</option><option value='xml'>xml</option>");
    			}else{
    				$("select[name='storeformat']").empty();
    			}
    		});
    		
    		var optDef = '${eventOpt.optDef }';
    		if(optDef!=null && optDef!=''){
    			optDef = eval('(' + optDef + ')');
    			$("select[name='storetype']").val(optDef.storeType);
    			$.ajax({// 根据选择的数据源类型查询数据库
    				"url" : "<%=webpath %>" + "/event/opt/ds/get",
    				"type" : "POST",
    				dataType : "json",
    				data : {
    					dstype : optDef.storeType
    				},
    				success : function(data) {
    					if(data.length>0){
    						$("select[name='storename']").empty();
    						$("select[name='storename']").append("<option value=''></option>");
    						data.forEach(function(value,index,array){
    							$("select[name='storename']").append("<option value ='"+value.id+"'>"+value.dsName+"</option>");
    						});
    						$("select[name='storename']").val(optDef.storeName);
    					}else{
    						$("select[name='storename']").empty();
    						$("select[name='storeformat']").empty();
    					}
    				}
         		});
    			$("select[name='storeformat']").append("<option value=''></option><option value='separator'>分隔符</option><option value='json'>json</option><option value='xml'>xml</option>");
    			if($("option[value='"+optDef.storeFormat+"']","#storeformat").length == 1){
    				$("select[name='storeformat']").val(optDef.storeFormat);
    			}else{
	    			$("select[name='storeformat']").append("<option value=\""+optDef.storeFormat+"\" class=\"separator\" selected>"+optDef.storeFormat+"</option>");
    			}
    		}
    	})
    	
    </script>
</body>

</html>
