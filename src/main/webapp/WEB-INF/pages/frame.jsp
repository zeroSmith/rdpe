<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.bonc.rdpe.util.SystemPropertiesUtils" language="java"%>
<%@ page import="com.bonc.rdpe.util.UserUtil" language="java"%>
<%@ page import="java.util.List" language="java"%>
<%@ page import="com.bonc.rdpe.entity.user.User" language="java"%>
<%@ page import="com.bonc.rdpe.entity.orgnization.Orgnization" language="java"%>
<%@ page import="com.bonc.rdpe.security.util.Constant" language="java"%>
<%@ page import="com.bonc.rdpe.util.DateUtil" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
   String webpath = request.getContextPath();
   User user = UserUtil.getUserResource(request);
   List<Orgnization> orgs = user.getOrgnization();
   StringBuffer sb = new StringBuffer();
   for(Orgnization org : orgs){
	   sb.append(org.getOrgName()).append(",");
   }
   if(orgs!=null&&orgs.size()>0){
	   sb.deleteCharAt(sb.length()-1);
   }
   String frameStyle = SystemPropertiesUtils.getFrameStyle().trim();
   String syncDataTime = SystemPropertiesUtils.getSyncDataTime();
%>
<html>
<head>
	<jsp:include page="common-head.jsp"></jsp:include>
	<title><%=SystemPropertiesUtils.getSystemTitle() %></title>
	<meta name="description" content="BONC基础框架 2017版" />
	<link rel="stylesheet" href="<%=webpath %>/resources/plugin/jquery-easyui-1.5.1/themes/default/easyui.css">
	<link rel="stylesheet" href="<%=webpath %>/resources/plugin/jquery-easyui-1.5.1/themes/icon.css">
	<link rel="stylesheet" href="<%=webpath %>/resources/plugin/jquery-check-password/check-pass.css" />
	<link rel="stylesheet" href="<%=webpath %>/resources/css/frame/leftSideBar.css">
	<link rel="stylesheet" href="<%=webpath %>/resources/css/frame/frame.css">
	<jsp:include page="common-layer-ext.jsp"></jsp:include>
</head>
<body class="no-skin">
	<div class="frame-container">
		<!-- frame页面头部开始 -->
		<div class="frame-head clearfix">
			<h1>
				<a href="javascript:;"> 
					<img src="<%=webpath %>/resources/img/frame/logo.png"
					title="<%=SystemPropertiesUtils.getSystemTitle() %>" alt="<%=SystemPropertiesUtils.getSystemTitle() %>" class="logo-img">
					<span class="logo-title"><%=SystemPropertiesUtils.getSystemTitle() %></span>
				</a>
			</h1>
			<!-- header 右侧菜单 -->
			<div class="navbar-custom-menu">
			    <ul class="nav navbar-nav">
			        <li>
			             <a href="javascript:void(0);" title="公告" id="notice" class="dropdown-a">
			           		<i class="iconfont">&#xe66e;</i>
		           			<c:if test="${unreadNoticeCount>0}">
		           				<span class="label label-danger">
		           					${unreadNoticeCount }
		           				</span>
							</c:if>
							<c:if test="${unreadNoticeCount == 0}">
		           				<span class="label label-danger">
		           					0
		           				</span>
							</c:if>
			         	 </a>
			         	 <div class="dropdownTips beforeArrow downInfo" id="tabscon1">
			         	 	 <div class="external"><font>你有${unreadNoticeCount }条<a href="javascript:;">未读公告</a> </font><a href="javascript:;" id="loadMoreNotice" class="more-notice">查看更多</a></div>
							 <div class="tipsScrollDiv">
								<ul class="dropdownTips-list">
									<li>
										<c:if test="${unreadNoticeCount==0}">
										<a>
											<span class="details">
												<span class="label label-sm label-icon"></span>
												<font>暂无未读公告</font>
											</span>
										</a>
										</c:if>
									</li>
									<c:if test="${unreadNoticeCount>0}">
									<c:forEach items="${unreadNoticeList }" var="notice">
									<li>
									<a href="javascript:openByContent(2, '<%=webpath %>/specnotice/noticeDetail?noticeId=${notice.noticeId }', ['900px','600px']);">
				                        <span class="time">${notice.pubTime }</span>
				                        <span class="details">
										<c:if test="${notice.noticeType=='1' }">
											<span class="label label-sm label-icon label-success">
											</span>
										</c:if>
										<c:if test="${notice.noticeType=='2' }">
											<span class="label label-sm label-icon label-danger">
											</span>
										</c:if>
										<c:if test="${notice.noticeType=='3' }">
											<span class="label label-sm label-icon label-warning">
											</span>
										</c:if>
										<c:if test="${notice.noticeType=='4' }">
											<span class="label label-sm label-icon label-info">
											</span>
										</c:if>
										<font>${notice.noticeTitle }</font>
				                        </span>
				                    </a>
				                    </li>
									</c:forEach>
									</c:if>
								</ul>
							</div>
						</div>
			        </li>
			        <li>
			             <a href="javascript:void(0);" title="在线人数" class="onlineCount">
              				<i class="iconfont">&#xe629;</i>
              				<span class="label label-success" id="onlineUserCount"><%=request.getAttribute("onlineUserCount")%></span>
            			 </a>
			        </li>
			        <li>
			             <a href="javascript:void(0);" class="dropdown-a userInfo" title="登录用户">
              				<img src="<%=webpath %>/resources/img/frame/user-160X60.png" class="user-image" alt="User Image">
                            <span class="hidden-xs"><%=user.getUserName() %></span>
                            <i class="iconfont">&#xe68d;</i>
            			 </a>
            			 <div class="dropdownTips user-drow downInfo">
							<ul class="dropdownTips-list">
								<li><a href="javascript:void(0);" id="userInfoBtn"><i class="info iconfont">&#xe600;</i>&nbsp;<span>我的信息</span></a></li>
								<li><a href="javascript:void(0);" id="updatePasswdBtn"><i class="info iconfont">&#xe637;</i>&nbsp;<span>修改密码</span></a></li>
								<li><a href="javascript:void(0);" id="logoutBtn"><i class="logout iconfont">&#xe636;</i>&nbsp;<span>退出系统</span></a></li>
							</ul>
						</div>
			        </li>
			    </ul>
			</div>
			
		</div>
		<!-- frame页面头部结束 -->
		<div class="frame-content">
			<!-- 左侧菜单的包裹层 -->
			<div class="l-content-wrapper" id="lBarWrap">
			</div>
			<!-- 右侧frame的包裹层 -->
			<div class="r-content-wrapper">
				<%if(frameStyle.equals("tab")){%>
				    <div id="tabs">
				    </div>
				<%} else if(frameStyle.equals("page")){%>
					<iframe id="childPage" src="/frame/workbench/index" allowtransparency="true" width="100%" height="100%" frameborder="0" scrolling="auto"></iframe>
				<%}%>
			</div>
		</div>
	</div>
	
	
<!-- 修改密碼dialog -->
	<div id="updatePasswdDialog" class="dialog-wrap">
	   <form id="updatePasswd">
	      	<div class="form-group">
    			<label for="oldPassword">旧密码</label>
    			<input type="password" class="form-control input-sm" id="oldPassword" name="oldPassword" placeholder="请输入旧密码">
  		  	</div>
  		  	<div class="form-group">
    			<label for="newPassword">新密码</label>
    			<input type="password" class="form-control input-sm" id="newPassword" name="newPassword" placeholder="请输入新密码">
    			<div id="level" class="pw-strength"><div class="pw-bar"></div><div class="pw-bar-on"></div></div>
  		  	</div>
  		  	<div class="form-group">
    			<label for="reNewPassword">再次输入</label>
    			<input type="password" class="form-control input-sm" id="reNewPassword" name="reNewPassword" placeholder="请与新密码保持一致">
  		  	    <p class="help-block" id="errorInfo">两次密码输入不一致.</p>
  		  	</div>
	   </form>
	</div>
	
	<!-- 我的信息dialog -->
	<div id="userInfoDialog" class="dialog-wrap">
	     <img class="profile-user-img img-responsive img-circle" src="<%=webpath %>/resources/img/frame/user-160X60.png" alt="我的信息">
	     <h3 class="profile-username text-center"><%=user.getUserName() %></h3>
	     <strong><i class="iconfont">&#xe646;</i>&nbsp;登录账号</strong>
	     <p class="text-muted">
                <%=user.getLoginId() %>
         </p>
	     <hr>
	     <strong><i class="iconfont">&#xe62f;</i>&nbsp;电子邮箱</strong>
	     <p class="text-muted">
                <%=user.getEmall()==null?"暂无信息":user.getEmall() %>
         </p>
	     <hr>
	     <strong><i class="iconfont">&#xe60c;</i>&nbsp;手机号码</strong>
	     <p class="text-muted">
                <%=user.getTelephone()==null?"暂无信息":user.getTelephone() %>
         </p>
	     <hr>
	     <strong><i class="iconfont">&#xe644;</i>&nbsp;所属组织</strong>
	     <p class="text-muted">
                <%=sb.length()==0?"暂无组织":sb.toString()%>
         </p>
	     <hr>
	     <strong><i class="iconfont">&#xe624;</i>&nbsp;注册时间</strong>
	     <p class="text-muted">
                <%=user.getRegDate()==null?"暂无信息":DateUtil.DateToString(user.getRegDate(),DateUtil.DateStyle.YYYY_MM_DD_HH_MM_CN)%>
         </p>
	     <hr>
	     <strong><i class="iconfont">&#xe61d;</i>&nbsp;上次修改密码时间</strong>
	     <p class="text-muted">
                <%=user.getPwdUpdateDate()==null?"暂无信息":DateUtil.DateToString(user.getPwdUpdateDate(),DateUtil.DateStyle.YYYY_MM_DD_HH_MM_CN) %>
         </p>
	     <hr>
	     <strong><i class="iconfont">&#xe620;</i>&nbsp;上次登录时间</strong>
	     <p class="text-muted">
                <%=user.getLastLoginDate()==null?"暂无信息":DateUtil.DateToString(user.getLastLoginDate(),DateUtil.DateStyle.YYYY_MM_DD_HH_MM_CN) %>
         </p>
	</div>
<script>
	var webpath = '<%=webpath%>';
	var userMenuTree = ${userMenuTree};
	var frameStyle = '<%=frameStyle%>';
	var syncDataTime = <%=syncDataTime%>;
</script>
<script src="<%=request.getContextPath() %>/resources/plugin/forIE/browser-fix.js"></script>
<script src="<%=request.getContextPath() %>/resources/plugin/jquery/jquery-1.10.2.js"></script>
<script src="<%=request.getContextPath() %>/resources/plugin/bootstrap-menu/BootstrapMenu.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/plugin/layer/layer.js"></script>
<script type="text/javascript">
	//定义全局使用的layer样式
	layer.config({
	 	 skin: 'layui-layer-ext'
	});
</script>
<!--[if lte IE 9]>
<script src="<%=request.getContextPath() %>/resources/plugin/forIE/html5shiv.js"></script>
<script src="<%=request.getContextPath() %>/resources/plugin/forIE/respond.js"></script>
<![endif]-->
<script src="<%=request.getContextPath() %>/resources/plugin/ztree/js/jquery.ztree.all.js"></script>
<script src="<%=request.getContextPath() %>/resources/plugin/nicescroll/jquery.nicescroll.min.js"></script>
<script src="<%=webpath %>/resources/plugin/jquery-easyui-1.5.1/jquery.easyui.min.js"></script>
<script src="<%=webpath %>/resources/plugin/jquery-easyui-1.5.1/jquery.easyui.ext.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/common.js"></script>
<script src="<%=webpath %>/resources/js/frame/frameBarControlFun.js"></script>
<script src="<%=webpath %>/resources/js/frame/leftSidebar.js"></script>
<script src="<%=webpath %>/resources/js/frame/frame.js"></script>
<script src="<%=webpath %>/resources/js/frame/frameHeader.js"></script>
</body>
</html>