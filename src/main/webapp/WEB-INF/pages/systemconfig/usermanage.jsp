<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String webpath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<%@ include file="../common-head.jsp"%>
	<title>用户管理</title>
	<%@ include file="../common-layer-ext.jsp"%>
	<%@ include file="../common-body-css.jsp"%>
	<style type="text/css">
		body{
		  overflow:hidden;
		}
		#userTable{
		  width:100%;
		}
		#text_area{
		  width: 407px;
		  height: 80px;
		  border: 1px solid #ccc;
		}
	</style>
</head> 
<body>
	<div class="row">
	     <div class="col-lg-12 col-md-12 row-tab">
	         <div id="org-panel" class="panel panel-default common-wrapper">
  					<div class="panel-heading common-part"><i class="iconfont">&#xe6ca;</i><span>用户列表</span></div>
  					<div class="panel-body common-content">
   							<div class="searchWrap">
	                    		<form class="form-inline" id="userSearchForm">
  									<div class="form-group">
    									<label for="loginId">登录账号:</label>
    									<input type="text" class="form-control input-sm" name="loginId" id="loginId" />
  									</div>
  									<div class="form-group">
    									<label for="userName">用户姓名:</label>
    									<input type="text" class="form-control input-sm" name="userName" id="userName"/>
  									</div>
  									<div class="form-group">
    									<label for="orgName">所属组织:</label>
    									<input type="text" class="form-control input-sm" name="orgName" readonly="readonly" onclick="showOrgTree(this);"/>
    									<input type="hidden" class="form-control input-sm" name="orgIds" />
  									</div>
  									<button type="button" class="b-redBtn btn-i" id="searchBtn"><i class="iconfont">&#xe67a;</i>查询</button>
  									<button type="button" class="b-redBtn btn-i" id="resetBtn"><i class="iconfont">&#xe647;</i>重置</button>
  									<button type="button" class="b-redBtn btn-i" id="addUserBtn"><i class="iconfont">&#xe635;</i>新建用户</button>
								</form>
	               			</div>
	               			
	               			<table id="userTable">  
                        		<thead>
            						<tr>
                						<th>用户姓名</th>
                						<th>登录账号</th>
                						<th>电子邮箱</th>
               							<th>手机号码</th>
                						<th>用户状态</th>
                						<th>锁定次数</th>
                						<th>注册时间</th>
                						<th>操作</th>
            						</tr>
        						</thead>
                    		</table>  
  					</div>
			 </div>
	     </div>
	</div>
	
	
	<!-- 新建用户dialog -->
	<div id="addUser" class="dialog-wrap">
	     <form id="addUserForm" class="form-inline" data-validator-option="{timely:2, theme:'yellow_right'}">
	         <table class="form-table">
	            <tr>
	               <td>
	                 <div class="form-group">
					   <label for="loginId">登录账号:</label>
					   <input type="text" class="form-control input-sm" name="loginId" placeholder="请输入用户登录账号" data-rule="required;length(4~32);filter;"/>
		   			 </div>
	               </td>
	               <td>
	                 <div class="form-group">
					   <label for="userName">用户姓名:</label>
					   <input type="text" class="form-control input-sm" name="userName" placeholder="请输入用户姓名" data-rule="required;length(4~32);filter;"/>
		             </div>
	               </td>
	            </tr>
	            <tr>
	               <td>
	                 <div class="form-group">
					    <label for="userName">用户邮箱:</label>
					    <input type="text" class="form-control input-sm" name="emall" placeholder="请输入用户的电子邮箱" data-rule="email"/>
		             </div>
	                </td>
	                <td>
	                  <div class="form-group">
					    <label for="userName">手机号码:</label>
					    <input type="text" class="form-control input-sm" name="mobile" placeholder="请输入11位手机号码" data-rule="mobile"/>
		              </div>
	                </td>
	             </tr>
	             <tr>
	                <td>
	                    <div class="form-group">
						  <label for="userName">用户状态:</label>
					      <label>
						  <input type="radio" value="1" name="state" data-rule="checked(1)">
						    未锁定
						  </label>
						  <label>
						  <input type="radio" value="-1" name="state" data-rule="checked(1)">
						   已锁定
						  </label>
				   		</div>
	                </td>
	                <td>
	                    <div class="form-group">
							<label for="orgName">所属组织:</label>
							<input type="text" class="form-control input-sm" name="orgName" readonly onclick="showOrgTree(this);"/>
							<input type="hidden" class="form-control input-sm" name="orgIds" />
		   				</div>
	                </td>
	             </tr>
	         </table>
		</form>
	</div>
	
	
	<!-- 修改用户信息 -->
	<div id="updateUser" class="dialog-wrap">
	     <form id="updateUserForm" class="form-inline" data-validator-option="{timely:2, theme:'yellow_right'}">
	                <input type="hidden" name="userId"/>
	                <table class="form-table">
	                   <tr>
	                      <td>
	                           <div class="form-group">
    								<label for="loginId">登录账号:</label>
    								<input type="text" class="form-control input-sm" name="loginId" readonly/>
  							   </div>
	                      </td>
	                      <td>
	                           <div class="form-group">
    								<label for="userName">用户姓名:</label>
    								<input type="text" class="form-control input-sm" name="userName" placeholder="请输入用户姓名" data-rule="required;length(2~32);filter;"/>
  							   </div>
	                      </td>
	                   </tr>
	                   <tr><td>
	                           <div class="form-group">
    								<label for="userName">用户邮箱:</label>
    								<input type="text" class="form-control input-sm" name="emall" placeholder="请输入用户的电子邮箱" data-rule="email"/>
  							   </div>
	                       </td>
	                       <td>
	                           <div class="form-group">
    								<label for="userName">手机号码:</label>
    								<input type="text" class="form-control input-sm" name="mobile" placeholder="请输入11位手机号码" data-rule="mobile"/>
  							   </div>
	                       </td>
	                    </tr>
	                    <tr>
	                       <td>
	                           <div class="form-group">
    								<label for="userName">用户状态:</label>
    								<label>
    									<input type="radio" value="1" name="state" data-rule="checked(1)">
    									未锁定
  									</label>
  									<label>
    									<input type="radio" value="-1" name="state" data-rule="checked(1)">
    									已锁定
  									</label>
  							   </div>
	                       </td>
	                       <td>
                                <div class="form-group">
   									<label for="orgName">所属组织:</label>
   									<input type="text" class="form-control input-sm" name="orgName" readonly onclick="showOrgTree(this);"/>
 							        	<input type="hidden" class="form-control input-sm" name="orgIds" />
 							        </div>
	                       </td>
	                    </tr>
	                    <tr>
	                    	<td colspan=2>
	                    		<label for="text_area" class="text-label">备注:</label>
	                    		<textarea name="textArea" id="text_area"></textarea>
	                    	</td>
	                    </tr>
	                </table>
		</form>
	</div>
	
	<!-- 组织机构树div -->
	<div id="orgDiv" class="dialog-wrap">
	     <ul id="orgTree" class="ztree"></ul>
	</div>
	
	<!-- 角色树 -->
	<div id="roleDiv" class="dialog-wrap">
	    <ul id="roleTree" class="ztree"></ul>
	</div>
	<%@ include file="../common-js.jsp"%>
	<script src="<%=webpath %>/resources/js/systemconfig/user_manage.js"></script>
</body>
</html>