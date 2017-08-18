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
	<title>资源管理</title>
	<%@ include file="../common-layer-ext.jsp"%>
	<%@ include file="../common-body-css.jsp"%>
	<style type="text/css">
		body{
			overflow:hidden;
		}
		.panel-heading > i.iconfont:first-child{
			font-size:20px;
			margin-right:4px;
		}
		.common-part .icon-tip{
		   float:right;
		   margin-top:2px;
		}
		.panel-heading > span{
			top:-2px;
			position:relative;
		}
		.ztree{
			width:50%;
		}
		.bootstrapMenu{
			z-index: 10000;
			position: absolute;
			display: none;
			height: 23px;
			width: 158px;
		}
		.dropdown-menu{
			position:static;
			display:block;
			font-size:0.9em;
		}
		.help-block{
			display:block;
			float:right;
			color:#e15b52;
		}
	</style>
</head> 
<body>
    <div class="row">
	     <div class="col-lg-4 col-md-4 row-tab">
	         <div id="resources-panel" class="panel panel-default common-wrapper">
				<div class="panel-heading common-part">
				  <i class="iconfont">&#xe6db;</i>
				  <span>资源列表</span>
				  <i class="iconfont icon-tip">&#xe6a8;</i>
				</div>
				<div class="panel-body common-content">
					<ul id="resources-tree" class="ztree"></ul>
				</div>
			 </div>
	     </div>
	     <div class="col-lg-8 col-md-8 row-tab panel-r">
	     	<div id="con-panel" class="panel panel-default">
	     		<div class="panel-body"></div>
	     	</div>
	     </div>
	</div>
    <!-- 空白的菜单 -->
	<div id="blankContextMenu" class="dropdown bootstrapMenu">
	      <ul class="dropdown-menu">
	          <li>
	              <a href="javascript:void(0);" class="addFolder">
	                 <i class="fa fa-fw fa-lg glyphicon glyphicon-folder-open"></i> 
	                 <span>添加文件夹</span>
	              </a>
	          </li>
	          <li>
	              <a href="javascript:void(0);" class="addInnerLink">
	                 <i class="fa fa-fw fa-lg glyphicon glyphicon-link"></i> 
	                 <span>添加内链接</span>
	              </a>
	          </li>
	          <li>
	              <a href="javascript:void(0);" class="addOuterLink">
	                 <i class="fa fa-fw fa-lg glyphicon glyphicon-paperclip"></i> 
	                 <span>添加外链接</span>
	              </a>
	          </li>
	      </ul>
	</div>
	<!-- 文件夹的菜单 -->
	<div id="folderContextMenu" class="dropdown bootstrapMenu">
	      <ul class="dropdown-menu">
	          <li>
	              <a href="javascript:void(0);" class="addFolder">
	                 <i class="fa fa-fw fa-lg glyphicon glyphicon-folder-open"></i> 
	                 <span>添加文件夹</span>
	              </a>
	          </li>
	          <li>
	              <a href="javascript:void(0);" class="addInnerLink">
	                 <i class="fa fa-fw fa-lg glyphicon glyphicon-link"></i> 
	                 <span>添加内链接</span>
	              </a>
	          </li>
	          <li>
	              <a href="javascript:void(0);" class="addOuterLink">
	                 <i class="fa fa-fw fa-lg glyphicon glyphicon-paperclip"></i> 
	                 <span>添加外链接</span>
	              </a>
	          </li>
	          <li>
	              <a href="javascript:void(0);" class="updateResource">
	                 <i class="fa fa-fw fa-lg glyphicon glyphicon-edit"></i> 
	                 <span>修改资源</span>
	              </a>
	          </li>
	          <li>
	              <a href="javascript:void(0);" class="deleteResource">
	                 <i class="fa fa-fw fa-lg glyphicon glyphicon-trash"></i> 
	                 <span>删除资源</span>
	              </a>
	          </li>
	      </ul>
	</div>
	<!-- 内连接的菜单 -->
	<div id="linkContextMenu" class="dropdown bootstrapMenu">
	      <ul class="dropdown-menu">
	          <li>
	              <a href="javascript:void(0);" class="addFun">
	                 <i class="fa fa-fw fa-lg glyphicon glyphicon-th-large"></i> 
	                 <span>添加功能</span>
	              </a>
	          </li>
	          <li>
	              <a href="javascript:void(0);" class="updateResource">
	                 <i class="fa fa-fw fa-lg glyphicon glyphicon-edit"></i> 
	                 <span>修改资源</span>
	              </a>
	          </li>
	          <li>
	              <a href="javascript:void(0);" class="deleteResource">
	                 <i class="fa fa-fw fa-lg glyphicon glyphicon-trash"></i> 
	                 <span>删除资源</span>
	              </a>
	          </li>
	      </ul>
	</div>
	<!-- 外连接的菜单 -->
	<div id="link1ContextMenu" class="dropdown bootstrapMenu">
	      <ul class="dropdown-menu">
	          <li>
	              <a href="javascript:void(0);" class="updateResource">
	                 <i class="fa fa-fw fa-lg glyphicon glyphicon-edit"></i> 
	                 <span>修改资源</span>
	              </a>
	          </li>
	          <li>
	              <a href="javascript:void(0);" class="deleteResource">
	                 <i class="fa fa-fw fa-lg glyphicon glyphicon-trash"></i> 
	                 <span>删除资源</span>
	              </a>
	          </li>
	      </ul>
	</div>
	<div id="addResource" class="dialog-wrap">
	     <form id="addResourceForm" data-validator-option="{timely:2, theme:'yellow_right'}">
	        <input type="hidden" name="parentId"/>
	        <input type="hidden" name="path"/>
	        <input type="hidden" name="resourcesTypeId"/>
	      	<div class="form-group">
    			<label for="resourceName">资源名称</label>
    			<input type="text" class="form-control input-sm" name="resourcesName" placeholder="请输入资源名称" data-rule="required;length(2~32);filter;"/>
  		  	</div>
  		  	<div class="form-group">
    			<label for="url">资源地址</label>
    			<input type="text" class="form-control input-sm" name="url" placeholder="请输入资源请求地址"/>
  		  	</div>
  		  	<div class="form-group">
    			<label for="ext2">拦截规则</label>
    			<input type="text" class="form-control input-sm" name="ext2" placeholder="请输入权限拦截规则，不输入则不做权限拦截"/>
  		  	</div>
  		  	<div class="form-group">
    			<label for="ord">资源排序</label>
    			<input type="text" class="form-control input-sm" name="ord" placeholder="请输入排序，排序为纯数字" data-rule="required;integer;range(0~9999)"/>
  		  	</div>
  		  	<div class="form-group">
    			<label for="ext1">资源图标</label>
    			<input type="text" class="form-control input-sm" name="ext1" placeholder="请输入资源图标" data-rule="length(4~8)"/>
  		  	    <a href="<%=webpath %>/resources/plugin/iconFront/demo_unicode.html" target="_blank" class="help-block">图标库</a>
  		  	</div>
	   	</form>
	</div>

	<div id="updateResource" class="dialog-wrap">
	     <form id="updateResourceForm" data-validator-option="{timely:2, theme:'yellow_right'}">
	        <input type="hidden" name="resourcesId"/>
	        <input type="hidden" name="parentId"/>
	        <input type="hidden" name="path"/>
	        <input type="hidden" name="resourcesTypeId"/>
	      	<div class="form-group">
    			<label for="resourceName">资源名称</label>
    			<input type="text" class="form-control input-sm" name="resourcesName" placeholder="请输入资源名称" data-rule="required;length(2~32);filter;"/>
  		  	</div>
  		  	<div class="form-group">
    			<label for="url">资源地址</label>
    			<input type="text" class="form-control input-sm" name="url" placeholder="请输入资源请求地址"/>
  		  	</div>
  		  	<div class="form-group">
    			<label for="ext2">拦截规则</label>
    			<input type="text" class="form-control input-sm" name="ext2" placeholder="请输入权限拦截规则，不输入则不做权限拦截"/>
  		  	</div>
  		  	<div class="form-group">
    			<label for="ord">资源排序</label>
    			<input type="text" class="form-control input-sm" name="ord" placeholder="请输入排序，排序为纯数字" data-rule="required;integer;range(0~9999)"/>
  		  	</div>
  		  	<div class="form-group">
    			<label for="ext1">资源图标</label>
    			<input type="text" class="form-control input-sm" name="ext1" placeholder="请输入资源图标" data-rule="length(4~8)"/>
  		  	    <a href="<%=webpath %>/resources/plugin/iconFront/demo_unicode.html" target="_blank" class="help-block">图标库</a>
  		  	</div>
	   	</form>
	</div>

	<%@ include file="../common-js.jsp"%>
	<script src="<%=webpath %>/resources/js/systemconfig/resource_manage.js"></script>
</body>
</html>