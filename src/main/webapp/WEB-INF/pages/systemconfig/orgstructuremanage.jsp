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
	<title>组织结构管理</title>
	<%@ include file="../common-layer-ext.jsp"%>
	<%@ include file="../common-body-css.jsp"%>
	<style>
	  body{
	    overflow: hidden;
	  }
	  .common-part .icon-tip{
	    float:right;
	    margin-top:2px;
	  }
	  #org-tree{
	    width:80%;
	  }
	  #orgTreeContextMenu{
	    z-index: 10000;
		position: absolute;
		display: none;
		height: 23px;
		width: 158px;
	  }
	  #orgTreeContextMenu .dropdown-menu{
	    position:static;
	    display:block;
	    font-size:0.9em;
	  }
	</style>
</head>
<body>
    <!-- 布局容器 -->
	<div class="row"><!-- 栅格布局 -->
	     <div class="col-lg-4 col-md-4 row-tab"><!-- 面板 -->
	           <div id="org-panel" class="panel panel-default common-wrapper">
  					<div class="panel-heading common-part">
  						<i class="iconfont">&#xe65c;</i>
  						<span>组织结构管理</span>
  						<i class="iconfont icon-tip">&#xe6a8;</i>
  					</div>
  					<div class="panel-body common-content">
   						<ul id="org-tree" class="ztree"></ul>
  					</div>
			   </div>
	     </div>
	     <div class="col-lg-8 col-md-8 row-tab panel-r">
	     	<div id="con-panel" class="panel panel-default">
	     		<div class="panel-body"></div>
	     	</div>
	     </div>
	</div>

	<!-- 新增组织部门dialog -->
	<div id="addOrg" class="dialog-wrap">
	    <form id="addOrgForm" data-validator-option="{timely:2, theme:'yellow_right'}">
	      	<div class="form-group">
    			<label for="orgName">组织名称</label>
    			<input type="text" class="form-control input-sm" name="orgName" placeholder="请输入组织名称" data-rule="required;length(2~32);filter;"/>
  		  	</div>
  		  	<div class="form-group">
    			<label for="ord">组织排序</label>
    			<input type="text" class="form-control input-sm" name="ord" placeholder="请输入排序，排序为纯数字" data-rule="required;integer;range(0~9999)"/>
    			<div id="level" class="pw-strength"><div class="pw-bar"></div><div class="pw-bar-on"></div></div>
  		  	</div>
  		  	<input type="hidden" name="parentId"/>
  		  	<input type="hidden" name="path"/>
	   	</form>
	</div>

	<!-- 修改部门信息 -->
	<div id="updateOrg" class="dialog-wrap">
	    <form id="updateOrgForm" data-validator-option="{timely:2, theme:'yellow_right'}">
	      	<div class="form-group">
    			<label for="orgName">组织名称</label>
    			<input type="text" class="form-control input-sm" name="orgName" placeholder="请输入组织名称" data-rule="required;length(2~32);filter;"/>
  		  	</div>
  		  	<div class="form-group">
    			<label for="ord">组织排序</label>
    			<input type="text" class="form-control input-sm" name="ord" placeholder="请输入排序，排序为纯数字" data-rule="required;integer;range(0~9999)"/>
    			<div id="level" class="pw-strength"><div class="pw-bar"></div><div class="pw-bar-on"></div></div>
  		  	</div>
  		  	<input type="hidden" name="orgId"/>
  		  	<input type="hidden" name="parentId"/>
  		  	<input type="hidden" name="path"/>
	   	</form>
	</div>

	<!-- 树的菜单 -->
	<div id="orgTreeContextMenu" class="dropdown bootstrapMenu">
	      <ul class="dropdown-menu">
	          <li>
	              <a href="javascript:void(0);" class="addOrgBtn">
	                 <i class="fa fa-fw fa-lg glyphicon glyphicon-plus"></i> 
	                 <span>添加子部门</span>
	              </a>
	          </li>
	          <li>
	              <a href="javascript:void(0);" class="updateOrgBtn">
	                 <i class="fa fa-fw fa-lg glyphicon glyphicon-pencil"></i> 
	                 <span>修改部门</span>
	              </a>
	          </li>
	          <li>
	              <a href="javascript:void(0);" class="delOrgBtn">
	                 <i class="fa fa-fw fa-lg glyphicon glyphicon-trash"></i> 
	                 <span>删除部门</span>
	              </a>
	          </li>
	      </ul>
	</div>

	<%@ include file="../common-js.jsp"%>
	<script src="<%=webpath %>/resources/js/systemconfig/resource_orgstructure.js"></script>
</body>
</html>