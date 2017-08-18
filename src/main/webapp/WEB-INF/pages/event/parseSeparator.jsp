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
	<title>数据解析配置</title>
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
    <style type="text/css">
    	table.table > tbody > tr > td> select{
    		width: 120px;
    	}
    </style>
</head>

<body class="container-fluid">
	<form id="parseOptForm">
	    <div class="containerInfo">
	        <div class="form-group">
	            <label for="firstseparator">一级分隔符:</label>&nbsp;<input type="text" class="form-control input-sm" style="width: 20%;" value="" name="firstseparator" id="firstseparator"/>
	        </div>
	        <div>
	            <table class="table table-fixedLength form-table" id="parseOptTable">
	                <thead>
	                    <tr>
	                        <th>字段中文</th>
	                        <th>字段英文</th>
	                        <th>字段类型</th>
	                        <th>长度</th>
	                        <th>下标位置</th>
	                        <th>&nbsp;</th>
	                        <!-- <th>&nbsp;</th> -->
	                    </tr>
	                </thead>
	                <tbody>
	                    <tr class="addOneFixedBtn">
	                        <td colspan="7"><a class="addOneFixedLength"><i class="fa fa-plus fa-lg"></i>添加</a></td>
	                    </tr>
	                </tbody>
	            </table>
	        </div>
	    </div>
    </form>
    
    <script type="text/javascript">
	    $(function() {
	    	var optDef = '${eventOpt.optDef }';
	    	if(optDef!=null & optDef!=''){
		    	optDef = eval('(' + optDef + ')');
	   			var separator = optDef.firstSeparator;
	   			$("#firstseparator").val(separator);
	   			var optField = optDef.fieldDef;
	   			var types = new Array("int","long","float","double","string","date");
	   			for(var i=0,length=optField.length;i<optField.length;i++){
	   				var options="<option value=''></option>";
					for(var index in types){
						var option;
						if(optField[i].type == types[index]){
							option="<option selected='selected' value='"+types[index]+"'>"+types[index]+"</option>";
						}else{
							option="<option value='"+types[index]+"'>"+types[index]+"</option>";
						}
						options+=option;
					}
					var param = "<tr>" 
						+'<input type="hidden" name="fieldId" value="'+optField[i].fieldId+'" class="form-control input-sm idClass">'
						+'<td><input type="text" name="cnName" value="'+optField[i].cnName+'" class="form-control input-sm cnNameClass"></td>'
						+'<td><input type="text" name="enName" class="form-control input-sm enNameClass" value="'+optField[i].enName+'" required lay-verify="required"></td>'
				        +'<td><select name="type" class="form-control input-sm typeClass">' + options + '</select></td>'
				        +'<td><input type="text" name="len" value="'+optField[i].len+'" class="form-control input-sm lenClass" onkeyup=\'if(/\\D/.test(this.value)){layer.msg("只能输入数字", {time: 1000, icon:5});this.value="";}\'></td>'
				        +'<td><input type="text" name="index" value="'+optField[i].index+'" class="form-control input-sm indexClass" onkeyup=\'if(/\\D/.test(this.value)){layer.msg("只能输入数字", {time: 1000, icon:5});this.value="";}\'></td>'
				        +'<td><a onclick="delOneFixedLength(this)"><i class="fa fa-trash fa-lg" title="删除该字段"></i></a></td>'
				        /* +'<td><a onclick="divide(this)"><i class="fa fa-plus fa-lg" title="分割该字段"></i></a></td>' */
				        +'</tr>';
					$(".addOneFixedBtn").before(param);
	   			}
		   }
	    });
    </script>
</body>

</html>
