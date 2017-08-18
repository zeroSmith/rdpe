<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
   String webpath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="../common-head.jsp"></jsp:include>
	<title>公告编辑</title>
	<%@ include file="../common-layer-ext.jsp"%>
	<style>
		.panel-edit {
			padding: 10px;
		}
		.notice-tab {
		    width: 100%;
		    border-collapse: separate;
		    border-spacing: 10px;
		}
		.notice-tab tbody th {
		    width: 60px;
		    text-align: right;
		}
		.notice-txt {
		    width: 100%;
		    padding: 7px;
		    border: 1px solid #d2d2d2;
		}
		.notice-tab tbody th.area-tit {
		    vertical-align: top;
		    line-height: 40px;
		}
		.radio .type-img {
			top: 2px;
			width: 20px;
		    height: 13px;
		    background: url(<%=webpath %>/resources/img/commonSprites.png);
		}
		.radio .type-common {
			background-position: -4px -78px;
		}
		.radio .type-warn {
			background-position: -37px -78px;
		}
		.radio .type-tips {
			background-position: -69px -78px;
		}
	</style>
</head>
<body>
	<div class="panel-border panel-edit">
   		<div class="content-wrapper common-wrapper">
	        <h2 class="notice-tit common-part">
	            <i></i>公告编辑
	        </h2>
            <div class="notice-content common-content">
            	<table class="notice-tab">
                	<tbody>
                           <tr>
                               <th>收件人：</th>
                               <td>
                                   <input type="text" class="notice-txt" id="sendToUser" value='${recOrgId  }' onfocus="showAddrTree(this);">
                                   <input type="hidden" class="form-control input-sm" name="addrIds" />
                                   <input type="hidden" id="noticeId" value="${noticeId  }" />
                               </td>
                           </tr>
                           <tr>
                               <th>主题：</th>
                               <td>
                                   <input type="text" class="notice-txt" id="title" value="${noticeTitle }">
                               </td>
                           </tr>
                           <tr>
                               <th>公告类型：</th>
                               <td>
                               	<c:if test="${noticeType == null}">
                                   <a href="javascript:;" class="radio radio-l active" onclick="changeSingleBoxBg(this);">
										<i id="radioYes" class="radio-img"></i>
										<label for="radioYes">普通型</label>
										<i class="type-img type-common"></i>
									</a>
									<a href="javascript:;" class="radio radio-l" onclick="changeSingleBoxBg(this);">
										<i id="radioNo" class="radio-img"></i>
										<label for="radioNo">警告型</label>
										<i class="type-img type-warn"></i>
									</a>
									<a href="javascript:;" class="radio" onclick="changeSingleBoxBg(this);">
										<i id="radioNo" class="radio-img"></i>
										<label for="radioNo">提示型</label>
										<i class="type-img type-tips"></i>
									</a>
								</c:if>
								<c:if test="${noticeType != '' }">
								    <c:if test="${noticeType == '1' }">
                                    <a href="javascript:;" class="radio radio-l active" onclick="changeSingleBoxBg(this);">
										<i id="radioYes" class="radio-img"></i>
										<label for="radioYes">普通型</label>
										<i class="type-img type-common"></i>
									</a>
									<a href="javascript:;" class="radio radio-l" onclick="changeSingleBoxBg(this);">
										<i id="radioNo" class="radio-img"></i>
										<label for="radioNo">警告型</label>
										<i class="type-img type-warn"></i>
									</a>
									<a href="javascript:;" class="radio" onclick="changeSingleBoxBg(this);">
										<i id="radioNo" class="radio-img"></i>
										<label for="radioNo">提示型</label>
										<i class="type-img type-tips"></i>
									</a>
									</c:if>
									<c:if test="${noticeType == '2' }">
                                    <a href="javascript:;" class="radio radio-l" onclick="changeSingleBoxBg(this);">
										<i id="radioYes" class="radio-img"></i>
										<label for="radioYes">普通型</label>
										<i class="type-img type-common"></i>
									</a>
									<a href="javascript:;" class="radio radio-l active" onclick="changeSingleBoxBg(this);">
										<i id="radioNo" class="radio-img"></i>
										<label for="radioNo">警告型</label>
										<i class="type-img type-warn"></i>
									</a>
									<a href="javascript:;" class="radio" onclick="changeSingleBoxBg(this);">
										<i id="radioNo" class="radio-img"></i>
										<label for="radioNo">提示型</label>
										<i class="type-img type-tips"></i>
									</a>
									</c:if>
									<c:if test="${noticeType == '3' }">
                                    <a href="javascript:;" class="radio radio-l" onclick="changeSingleBoxBg(this);">
										<i id="radioYes" class="radio-img"></i>
										<label for="radioYes">普通型</label>
										<i class="type-img type-common"></i>
									</a>
									<a href="javascript:;" class="radio radio-l" onclick="changeSingleBoxBg(this);">
										<i id="radioNo" class="radio-img"></i>
										<label for="radioNo">警告型</label>
										<i class="type-img type-warn"></i>
									</a>
									<a href="javascript:;" class="radio active" onclick="changeSingleBoxBg(this);">
										<i id="radioNo" class="radio-img"></i>
										<label for="radioNo">提示型</label>
										<i class="type-img type-tips"></i>
									</a>
									</c:if>
								</c:if>
                               </td>
                           </tr>
                           <tr>
                               <th class="area-tit">内容：</th>
                               <td>
                                   <!-- <textarea name="" id="textArea" class="text-area"></textarea> -->
                                   <div class="editor-wrapper">
                                       <script id="editor" type="text/plain" style="width:100%;"></script>
                                   </div>
                                   <div class="edit-btn">
                                       <button id="publish" class="btn btn-red btn-md" onclick="buttonPublish()">发布</button>
                                       <button class="btn btn-red btn-md" onclick="saveDraft()">保存为草稿</button>
                                       <button class="btn btn-gray btn-md" onclick="canclePublish()">取消</button>
                                   </div>
                               </td>
                           </tr>
                       </tbody>
                </table>
            </div>               
        </div>
        <div id="addrDiv" class="dialog-wrap">
	     <ul id="addrTree" class="ztree"></ul>
   		</div>
   	</div>
    
<script>
	var webpath = '<%=webpath%>';
	var noticeContent = '${noticeContent}';
	var orgIds = '${recOrgId }'.split(",");
</script>
<jsp:include page="../common-js.jsp"></jsp:include>
<script src="<%=webpath %>/resources/plugin/utf8-jsp/ueditor.config.js"></script>
<script src="<%=webpath %>/resources/plugin/utf8-jsp/ueditor.all.min.js"></script>
<script src="<%=webpath %>/resources/plugin/utf8-jsp/lang/zh-cn/zh-cn.js"></script>
<script src="<%=webpath %>/resources/js/notice/noticeEdit.js"></script>

</body>
</html>