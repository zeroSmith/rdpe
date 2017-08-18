<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.bonc.rdpe.util.SystemPropertiesUtils"
	language="java"%>
<%
   String webpath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common-head.jsp"%>
	<title>角色管理</title>
	<%@ include file="../common-layer-ext.jsp"%>
	<%@ include file="../common-body-css.jsp"%>
	<%@ include file="../common-js.jsp"%>
	<style type="text/css">
		body{
		  overflow:hidden;
		}
		#roleTable{
		  width:100%;
		}
	</style>
</head> 
<body>
    <div class="row">
	     <div class="col-lg-12 col-md-12 row-tab">
	         <div id="role-panel" class="panel panel-default common-wrapper">
  					<div class="panel-heading common-part"><i class="iconfont">&#xe6ca;</i><span>角色列表</span></div>
  					<div class="panel-body common-content common-wrap">
   							<div class="searchWrap common-part">
	                    		<form class="form-inline" id="roleSearchForm">
  									<div class="form-group">
    									<label for="userName">角色名称:</label>
    									<input type="text" class="form-control input-sm" name="roleName" />
  									</div>
  									<button type="button" class="b-redBtn btn-i" id="searchBtn"><i class="iconfont">&#xe67a;</i>查询</button>
  									<button type="button" class="b-redBtn  btn-i" id="resetBtn"><i class="iconfont">&#xe647;</i>重置</button>
  									<button type="button" class="b-redBtn  btn-i" id="addRoleBtn"><i class="iconfont">&#xe635;</i>新建角色</button>
								</form>
	               			</div>
	               			
               				<table id="roleTable">  
                        		<thead>
            						<tr>
                						<th>角色名称</th>
                						<th>备注</th>
                						<th>操作</th>
            						</tr>
        						</thead>
                    		</table> 
	               			 
  					</div>
			 </div>
	     </div>
	</div>

    <!-- 新增角色 -->
    <div id="addRole" class="dialog-wrap">
         <form id="addRoleForm" data-validator-option="{timely:2, theme:'yellow_right'}">
	      	<div class="form-group">
    			<label for="roleName">角色名称</label>
    			<input type="text" class="form-control input-sm" name="roleName" placeholder="请输入角色名称" data-rule="required;length(2~32);filter;"/>
  		  	</div>
  		  	<div class="form-group">
    			<label for="memo">备注</label>
    			<input type="text" class="form-control input-sm" name="memo" placeholder="请输入备注" data-rule="length(2~128);filter;"/>
  		  	</div>
	   	</form>
    </div>
    
    <!-- 修改角色 -->
    <div id="updateRole" class="dialog-wrap">
         <form id="updateRoleForm" data-validator-option="{timely:2, theme:'yellow_right'}">
            <input type="hidden" name="roleId"/>
	      	<div class="form-group">
    			<label for="roleName">角色名称</label>
    			<input type="text" class="form-control input-sm" name="roleName" placeholder="请输入角色名称" data-rule="required;length(2~32);filter;"/>
  		  	</div>
  		  	<div class="form-group">
    			<label for="memo">备注</label>
    			<input type="text" class="form-control input-sm" name="memo" placeholder="请输入备注" data-rule="length(2~128);filter;"/>
  		  	</div>
	   	</form>
    </div>
    
    <!-- 资源树 -->
    <!-- 组织机构树div -->
	<div id="resourceDiv" class="dialog-wrap">
	     <ul id="resourceTree" class="ztree"></ul>
	</div>
	<%@ include file="../common-js.jsp"%>
	<script src="<%=webpath %>/resources/js/systemconfig/role_manage.js"></script>
</body>
</html>