$(document).ready(function(){
	initOrgTree();
	initRoleTree();
	initUserTable();
	$("#searchBtn").bind("click",reloadTableData);
	$("#addUserBtn").bind("click",addUser);
	$("#resetBtn").bind("click",resetForm);
	
	// 为datatable外的父级设置高度
	$('#userTable_wrapper').css('height', $('.panel-body').height()-60);
	// 加载日历框
	$('#datepicker').datepicker({changeMonth: true, changeYear: true});
	
	// 动态为表格添加父级
	$('#userTable').wrap('<div class="tab-wrapper"></div>');
	$('.tab-wrapper').css('height', $('#userTable_wrapper').height()-63);
	$('.tab-wrapper').niceScroll({ cursorcolor: "#ccc", horizrailenabled: false});
});



//初始化用户列表表格
function initUserTable(){
	$("#userTable").width("100%").dataTable({
		"columns":[
		            { "data": "userName" },
		            { "data": "loginId" },
		            { "data": "emall" },
		            { "data": "mobile" },
		            { "data": "state" },
		            { "data": "lockLoginTimes" },
		            { "data": "regDate"}
		 ],
		 ajax: {
		     url:webpath+'/user/selectPage',
		     "type": 'POST',
		     "data": function (d) {//查询参数
		           return $.extend( {}, d, {
		              "jsonStr": form.serializeStr($("#userSearchForm"))
		           });
		     },
		     "dataSrc": function (json) {
		           json.iTotalRecords = json.total;
		           json.iTotalDisplayRecords = json.total;
		           return json.data;
		     }
		},
		columnDefs:[{
			"targets" : 4,//操作按钮目标列
			"data" : null,
			"render" : function(data, type,row) {
				  var html = '';
				  if(data=="1"){
					  html += '<span style="color:green;">未锁定</span>';
				  }else{
					  html += '<span style="color:red;">已锁定</span>';
				  }
			      return html;
			   }
		},{
			  "targets" : 7,//操作按钮目标列
			  "data" : null,
			  "render" : function(data, type,row) {
				  var id = row.userId;
				  var html =  '<a href="javascript:void(0);" onclick="updateUser(\''+id+'\')" class="icon-wrap" title="编辑"><i class="iconfont i-btn">&#xe66f;</i></a>';
				      html += '&nbsp;&nbsp;';
				      html +=  '<a href="javascript:void(0);" onclick="deleteUser(\''+id+'\')" class="icon-wrap" title="删除"><i class="iconfont i-btn">&#xe614;</i></a>';
				      html += '&nbsp;&nbsp;';
				      html +=  '<a href="javascript:void(0);" onclick="resetPasswd(\''+id+'\')" class="icon-wrap" title="重置密码"><i class="iconfont i-btn">&#xe637;</i></a>';
				      html += '&nbsp;&nbsp;';
				      html +=  '<a href="javascript:void(0);" onclick="roleAuth(\''+id+'\')" class="icon-wrap" title="角色授权"><i class="iconfont i-btn">&#xe646;</i></a>';
				      return html;
			   }
		}]
	});
}


//刷新数据  true  整个刷新      false 保留当前页刷新
function reloadTableData(isCurrentPage){
	$("#userTable").dataTable().fnDraw(isCurrentPage==null?true:isCurrentPage);
}

//新增用户
function addUser(){
	var formObj = $("#addUserForm");
	form.clear(formObj);
	form.cleanValidator(formObj);
	layer.open({
		type: 1,
        title:'<i class="iconfont">&#xe641;</i>&nbsp;新增用户',
        area: ['500px', '340px'],
        content: $("#addUser"),
        btn: ['确定','取消'],
        btn1: function(index, layero){//确定按钮回调
        	if(form.isValidator(formObj)){
        		$.ajax({
    				"url":webpath+"/user/insert",
    				"type":"POST",
    				dataType:"json",
    				data:form.serializeJson(formObj),
    				success:function(data){
    					layer.close(index);
    					reloadTableData(true);
    				}
    			});
        	}
	    },
	    btn2: function(index, layero){//确定按钮回调
        	layer.close(index);
	    }
    });
}


//修改数据
function updateUser(userId){
	$.ajax({
		"url":webpath+"/user/getUserById",
		"type":"POST",
		dataType:"json",
		data:{
			userId:userId
		},
		success:function(data){
			var formObj = $("#updateUserForm");
			form.clear(formObj);
			form.cleanValidator(formObj);
			form.load(formObj,data);
			var ids='',vals='';
			for(var i=0;i<data.orgnization.length;i++){
				ids += data.orgnization[i].orgId + ',';
				vals+= data.orgnization[i].orgName + ',';
			}
			if(data.orgnization.length>0){
				ids=ids.substring(0,ids.length-1);
            	vals=vals.substring(0,vals.length-1);
			}
			formObj.find('input[name="orgIds"]').val(ids);
			formObj.find('input[name="orgName"]').val(vals);
			layer.open({
				type: 1,
		        title:'<i class="iconfont">&#xe633;</i>&nbsp;修改用户',
		        area: ['500px', '340px'],
		        content: $("#updateUser"),
		        btn: ['确定','取消'],
		        btn1: function(index, layero){//确定按钮回调
		        	if(form.isValidator(formObj)){
		        		$.ajax({
		    				"url":webpath+"/user/update",
		    				"type":"POST",
		    				dataType:"json",
		    				data:form.serializeJson(formObj),
		    				success:function(data){
		    					layer.close(index);
		    					reloadTableData(true);
		    				}
		    			});
		        	}
			    },
			    btn2: function(index, layero){//确定按钮回调
		        	layer.close(index);
			    }
		    });
		}
	});
}

//删除数据
function deleteUser(userId){
	layer.confirm('删除该用户？（删除后不可恢复）', {
        icon: 3,
        btn: ['是','否'] //按钮
  	  }, function(index, layero){
  		  $.ajax({//初始化组织机构树
  				"url":webpath+"/user/delete",
  				"type":"POST",
  				dataType:"json",
  				data:{
  					id:userId
  				},
  				success:function(data){
  					layer.close(index);
					reloadTableData(true);
  				}
  		   });
  	  });
}

//重置密码
function resetPasswd(userId){
	layer.confirm('是否将用户密码重置为“123456”？', {
        icon: 3,
        btn: ['是','否'] //按钮
  	  }, function(index, layero){
  		  $.ajax({//初始化组织机构树
  				"url":webpath+"/user/resetPasswd",
  				"type":"POST",
  				dataType:"json",
  				data:{
  					userId:userId
  				},
  				success:function(data){
  					layer.msg('操作成功！', {time: 1000, icon:1});
  				}
  		   });
  	  });
}


function initOrgTree(){
	//组织结构树
	var setting = {
			data: {
				simpleData: {
					enable:true, 
					idKey:'orgId',
					pIdKey:'parentId'
				},
				key:{
					name:'orgName'
				}
			},
			check: {
				enable: true,
				chkboxType: {"Y":"", "N":""}
			}
	};
	$.ajax({//初始化组织机构树
		"url":webpath+"/user/org",
		"type":"POST",
		dataType:"json",
		success:function(data){
			//console.log(data);
			var treeObj = $.fn.zTree.init($("#orgTree"), setting, data);
			treeObj.expandAll(true);
		}
	});
}


function showOrgTree(obj){
	var treeObj = $.fn.zTree.getZTreeObj("orgTree");
	treeObj.checkAllNodes(false);
	var ds = $(obj).parent().find('input[type="hidden"]').val();
	var arr = ds.split(",");
	for(var n=0;n<arr.length;n++){
		var node = treeObj.getNodesByParam("orgId", arr[n], null);
		if(node.length>0){
			treeObj.checkNode(node[0], true, false);
		}
	}
	layer.open({
		type: 1,
        title:'<i class="iconfont">&#xe65c;</i>&nbsp;选择组织结构',
        area: ['300px', '340px'],
        content: $("#orgDiv"),
        btn: ['确定','取消'],
        btn1: function(index, layero){//确定按钮回调
        	var nodes = treeObj.getCheckedNodes(true);
        	if(!nodes.length){
        		$(obj).val('');
            	$(obj).parent().find('input[type="hidden"]').val('');
            	layer.close(index);
        		layer.close(index);
        		return;	
        	}
        	var vals = '',ids = '';
        	for(var i=0;i<nodes.length;i++){
        		vals += nodes[i].orgName + ',';
        		ids  += nodes[i].orgId + ',';
        	}
        	if(nodes.length=0){
        		vals = '',ids = '';
        	}else{
        		ids=ids.substring(0,ids.length-1);
            	vals=vals.substring(0,vals.length-1);
        	}
        	$(obj).val(vals);
        	$(obj).parent().find('input[type="hidden"]').val(ids);
        	layer.close(index);
	    },
	    btn2: function(index, layero){//确定按钮回调
        	layer.close(index);
	    }
    });
	$("#orgDiv").parent().niceScroll({ cursorcolor: "#ccc", horizrailenabled: false});
}

//重置查询条件
function resetForm(){
	form.clear($("#userSearchForm"));
}




//初始化角色树
function initRoleTree(){
	var setting = {
			data: {
				simpleData: {
					enable:true, 
					idKey:'roleId',
					pIdKey:'parentId'
				},
				key:{
					name:'roleName'
				}
			},
			check: {
				enable: true,
				chkboxType: {"Y":"", "N":""}
			}
	};
	$.ajax({//初始化组织机构树
		"url":webpath+"/user/role",
		"type":"POST",
		dataType:"json",
		success:function(data){
			var treeObj = $.fn.zTree.init($("#roleTree"), setting, data);
			treeObj.expandAll(true);
		}
	});
}

//角色授权
function roleAuth(userId){
	var treeObj = $.fn.zTree.getZTreeObj("roleTree");
	treeObj.checkAllNodes(false);
	$.ajax({
		"url":webpath+"/user/getUserRole",
		"type":"POST",
		data:{
			userId:userId
		},
		dataType:"json",
		success:function(data){
			var treeObj = $.fn.zTree.getZTreeObj("roleTree");
			for(var i=0;i<data.length;i++){
				for(var n=0;n<data.length;n++){
					var node = treeObj.getNodesByParam("roleId", data[n].roleId, null);
					if(node.length>0){
						treeObj.checkNode(node[0], true, false);
					}
				}
			}
			layer.open({
				type: 1,
		        title:'<i class="iconfont">&#xe65b;</i>&nbsp;角色授权',
		        area: ['300px', '340px'],
		        content: $("#roleDiv"),
		        btn: ['确定','取消'],
		        btn1: function(index, layero){//确定按钮回调
		        	var arrs = [],nodes = treeObj.getCheckedNodes(true);
		        	for(var n=0;n<nodes.length;n++){
		        		var obj = new Object();
		        		obj.roleId = nodes[n].roleId;
		        		obj.userId = userId;
		        		arrs.push(obj);
		        	}
		        	$.ajax({
		        		"url":webpath+"/user/userAuth",
		        		"type":"POST",
		        		data:{
		        			userId:userId,
		        			jsonStr:JSON.stringify(arrs)
		        		},
		        		dataType:"json",
		        		success:function(data){
		        			layer.msg('用户授权成功！', {time: 1000, icon:1});
		        			layer.close(index);
		        		}
		        	});
			    },
			    btn2: function(index, layero){//确定按钮回调
		        	layer.close(index);
			    }
			 });
			 $("#roleDiv").parent().niceScroll({ cursorcolor: "#ccc", horizrailenabled: false});
		}
	});
}
