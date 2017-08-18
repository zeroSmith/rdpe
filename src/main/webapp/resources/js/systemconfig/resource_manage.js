$(document).ready(function(){
	$("#resources-panel").find(".panel-body").niceScroll({ cursorcolor: "#ccc", horizrailenabled: false});
	$("#resources-panel").find(".icon-tip").bind({//绑定提示信息
		mouseenter: function(e) {
			// Hover event handler
			this.index = layer.tips("在资源节点右键任意添加资源。", this,{
				 	tips: [2, '#f8e3d1'],
				 	time: 3000
				}
			);
		}
	});
	//绑定右键事件
	$("#resources-panel").find(".panel-body").bind({
		contextmenu: function(e) {
			    var nodes = resource.treeObj.getSelectedNodes();
			    if (nodes.length>0) { 
			    	resource.treeObj.cancelSelectedNode(nodes[0]);
			    }
			    $(".bootstrapMenu").hide();
				$("#blankContextMenu").css("left",e.clientX);
				$("#blankContextMenu").css("top",e.clientY);
				$("#blankContextMenu").show();
				return false;
		}
	});
	//取消菜单事件
	$("body").bind({
		 click:function(e){
			 $(".bootstrapMenu").hide();
		 }
	});
	//添加文件夹事件
	$(".addFolder").bind({
		click:function(){
			var resourcesTypeId ="0",parentId="ROOT";
			var formObj = $("#addResourceForm");
			form.clear(formObj);
			form.cleanValidator(formObj);
			var nodes = resource.treeObj.getSelectedNodes();
			if(nodes.length>0){
				var node = nodes[0];
				formObj.find('input[name="parentId"]').val(node.resourcesId);
				formObj.find('input[name="path"]').val(node.path);
			}else{
				formObj.find('input[name="parentId"]').val(parentId);
			}
			formObj.find('input[name="resourcesTypeId"]').val(resourcesTypeId);
			formObj.find('input[name="url"]').prop("readOnly","readOnly");
			layer.open({
				type: 1,
		        title:'<i class="iconfont">&#xe641;</i>&nbsp;新增文件夹',
		        area: ['340px', '420px'],
		        content: $("#addResource"),
		        btn: ['确定','取消'],
		        btn1: function(index, layero){//确定按钮回调
		        	//处理解析&时不好用的问题
		        	var ext = $('#addResourceForm input[name="ext1"]').val();
		        	var newData = form.serializeJson(formObj);
		        	newData.ext1 = ext;
		        	if(form.isValidator(formObj)){
		        		$.ajax({
		    				"url":webpath+"/resource/insert",
		    				"type":"POST",
		    				dataType:"json",
		    				data:newData,
		    				success:function(data){
		    					layer.close(index);
		    					resource.initTree();
		    					formObj.find('input[name="url"]').prop("readOnly","");
		    				}
		    			});
		        	}
			    },
			    btn2: function(index, layero){//取消按钮回调
		        	layer.close(index);
		        	formObj.find('input[name="url"]').prop("readOnly","");
			    },
			    cancel:function(index){
			    	formObj.find('input[name="url"]').prop("readOnly","");
			    	return true;
			    }
		    });
		}
	});
	//添加内连接事件
	$(".addInnerLink").bind({
		click:function(){
			var resourcesTypeId ="1",parentId="ROOT";
			var formObj = $("#addResourceForm");
			form.clear(formObj);
			form.cleanValidator(formObj);
			var nodes = resource.treeObj.getSelectedNodes();
			if(nodes.length>0){
				var node = nodes[0];
				formObj.find('input[name="parentId"]').val(node.resourcesId);
				formObj.find('input[name="path"]').val(node.path);
			}else{
				formObj.find('input[name="parentId"]').val(parentId);
			}
			formObj.find('input[name="resourcesTypeId"]').val(resourcesTypeId);
			layer.open({
				type: 1,
		        title:'<i class="iconfont">&#xe641;</i>&nbsp;新增内连接',
		        area: ['340px', '420px'],
		        content: $("#addResource"),
		        btn: ['确定','取消'],
		        btn1: function(index, layero){//确定按钮回调
		        	//处理解析&时不好用的问题
		        	var ext = $('#addResourceForm input[name="ext1"]').val();
		        	var newData = form.serializeJson(formObj);
		        	newData.ext1 = ext;
		        	if(form.isValidator(formObj)){
		        		$.ajax({
		    				"url":webpath+"/resource/insert",
		    				"type":"POST",
		    				dataType:"json",
		    				data:newData,
		    				success:function(data){
		    					layer.close(index);
		    					resource.initTree();
		    				}
		    			});
		        	}
			    },
			    btn2: function(index, layero){//取消按钮回调
		        	layer.close(index);
			    }
		    });
		}
	});
	//添加外链接事件
	$(".addOuterLink").bind({
		click:function(){
			var resourcesTypeId ="2",parentId="ROOT";
			var formObj = $("#addResourceForm");
			form.clear(formObj);
			form.cleanValidator(formObj);
			var nodes = resource.treeObj.getSelectedNodes();
			if(nodes.length>0){
				var node = nodes[0];
				formObj.find('input[name="parentId"]').val(node.resourcesId);
				formObj.find('input[name="path"]').val(node.path);
			}else{
				formObj.find('input[name="parentId"]').val(parentId);
			}
			formObj.find('input[name="resourcesTypeId"]').val(resourcesTypeId);
			formObj.find('input[name="url"]').val("http://");
			layer.open({
				type: 1,
		        title:'<i class="iconfont">&#xe641;</i>&nbsp;新增外连接',
		        area: ['340px', '420px'],
		        content: $("#addResource"),
		        btn: ['确定','取消'],
		        btn1: function(index, layero){//确定按钮回调
		        	//处理解析&时不好用的问题
		        	var ext = $('#addResourceForm input[name="ext1"]').val();
		        	var newData = form.serializeJson(formObj);
		        	newData.ext1 = ext;
		        	if(form.isValidator(formObj)){
		        		$.ajax({
		    				"url":webpath+"/resource/insert",
		    				"type":"POST",
		    				dataType:"json",
		    				data:newData,
		    				success:function(data){
		    					layer.close(index);
		    					resource.initTree();
		    				}
		    			});
		        	}
			    },
			    btn2: function(index, layero){//取消按钮回调
		        	layer.close(index);
			    }
		    });
		}
	});
	
	
	//添加功能
	$(".addFun").bind({
		click:function(){
			var resourcesTypeId ="3",parentId="ROOT";
			var formObj = $("#addResourceForm");
			form.clear(formObj);
			form.cleanValidator(formObj);
			var nodes = resource.treeObj.getSelectedNodes();
			if(nodes.length>0){
				var node = nodes[0];
				formObj.find('input[name="parentId"]').val(node.resourcesId);
				formObj.find('input[name="path"]').val(node.path);
				formObj.find('input[name="url"]').val(node.url);
			}else{
				formObj.find('input[name="parentId"]').val(parentId);
			}
			formObj.find('input[name="resourcesTypeId"]').val(resourcesTypeId);
			layer.open({
				type: 1,
		        title:'<i class="iconfont">&#xe641;</i>&nbsp;新增功能',
		        area: ['340px', '420px'],
		        content: $("#addResource"),
		        btn: ['确定','取消'],
		        btn1: function(index, layero){//确定按钮回调
		        	if(form.isValidator(formObj)){
		        		$.ajax({
		    				"url":webpath+"/resource/insert",
		    				"type":"POST",
		    				dataType:"json",
		    				data:form.serializeJson(formObj),
		    				success:function(data){
		    					layer.msg('添加成功！', {time: 1000, icon:1});
		    					layer.close(index);
		    					resource.initTree();
		    				}
		    			});
		        	}
			    },
			    btn2: function(index, layero){//取消按钮回调
		        	layer.close(index);
			    }
		    });
		}
	});
	//删除事件绑定
	$(".deleteResource").bind({
		click:function(){
			var nodes = resource.treeObj.getSelectedNodes();
			if(nodes.length==0)return;
			var node = nodes[0];
			layer.confirm('删除该资源？（删除后不可恢复）', {
		          icon: 3,
		          btn: ['是','否'] //按钮
		    	  }, function(index, layero){
		    		  $.ajax({
	        				"url":webpath+"/resource/delete",
	        				"type":"POST",
	        				dataType:"json",
	        				data:{
	        					id:node.resourcesId
	        				},
	        				success:function(data){
	        					layer.msg('删除成功！', {time: 1000, icon:1});
	        					layer.close(index);
	        					resource.initTree();
	        				}
	        		   });
		    	  });
		}
	});
	//修改资源事件
	$(".updateResource").bind({
		click:function(){
			var formObj = $("#updateResourceForm");
			form.clear(formObj);
			form.cleanValidator(formObj);
			var nodes = resource.treeObj.getSelectedNodes();
			if(nodes.length==0)return;
			var node = nodes[0];
			form.load(formObj,node);
			if(node.resourcesTypeId=="0"){
				formObj.find('input[name="url"]').prop("readOnly","readOnly");
			}
			if(node.parentId == null){				
				formObj.find('input[name="parentId"]').val('ROOT');
			}else{
				formObj.find('input[name="parentId"]').val(node.parentId);
			}
			layer.open({
				type: 1,
		        title:'<i class="iconfont">&#xe631;</i>&nbsp;修改资源',
		        area: ['340px', '420px'],
		        content: $("#updateResource"),
		        btn: ['确定','取消'],
		        btn1: function(index, layero){//确定按钮回调
		        	//处理解析&时不好用的问题
		        	var ext = $('#updateResourceForm input[name="ext1"]').val();
		        	var newData = form.serializeJson(formObj);
		        	newData.ext1 = ext;
		        	if(form.isValidator(formObj)){
		        		$.ajax({
		    				"url":webpath+"/resource/update",
		    				"type":"POST",
		    				dataType:"json",
		    				data:newData,
		    				success:function(data){
		    					layer.msg('修改成功！', {time: 1000, icon:1});
		    					layer.close(index);
		    					resource.initTree();
		    					formObj.find('input[name="url"]').prop("readOnly","");
		    				}
		    			});
		        	}
			    },
			    btn2: function(index, layero){//取消按钮回调
		        	layer.close(index);
		        	formObj.find('input[name="url"]').prop("readOnly","");
			    }
		    });
		}
	});
	
	resource.initTree();//初始化树
});


var resource = {
		treeObj:null,
		setting : {
			data:{
				simpleData: {
					enable:true, 
					idKey:'resourcesId',
					pIdKey:'parentId'
				},
				key:{
					name:'resourcesName',
					url:'xurl'
				}
			},
			callback:{
				onRightClick:function(e,treeId,treeNode){
					if(!treeNode) return;
					resource.treeObj.selectNode(treeNode);
					$(".bootstrapMenu").hide();
					if(treeNode.resourcesTypeId=="0"){
						$("#folderContextMenu").css("left",e.clientX);
						$("#folderContextMenu").css("top",e.clientY);
						$("#folderContextMenu").show();
					}else if(treeNode.resourcesTypeId=="1"){
						$("#linkContextMenu").css("left",e.clientX);
						$("#linkContextMenu").css("top",e.clientY);
						$("#linkContextMenu").show();
					}else if(treeNode.resourcesTypeId=="2"){
						$("#link1ContextMenu").css("left",e.clientX);
						$("#link1ContextMenu").css("top",e.clientY);
						$("#link1ContextMenu").show();
					}else if(treeNode.resourcesTypeId=="3"){
						$("#link1ContextMenu").css("left",e.clientX);
						$("#link1ContextMenu").css("top",e.clientY);
						$("#link1ContextMenu").show();
					}
			    }
			}
	    },
		initTree:function(){
			if(resource.treeObj!=null){
				resource.treeObj.destroy()
			}
			$.ajax({//初始化组织机构树
				"url":webpath+"/resource/selectAll",
				"type":"POST",
				dataType:"json",
				success:function(data){
					if(data!=null&&data.length>0){
						for(var i=0;i<data.length;i++){
							data[i].icon=webpath+resourceTypeIcon[data[i].resourcesTypeId];
						}
						resource.treeObj = $.fn.zTree.init($("#resources-tree"), resource.setting, data);
						resource.treeObj.expandAll(true);
					}else{
						layer.msg('暂无数据', {time: 1000, icon:5});
					}
				}
			});
		}
};


var resourceTypeIcon = {
		"0":"/resources/img/icon/16x16/floder1-org.png",
		"1":"/resources/img/icon/16x16/resorce.png",
		"2":"/resources/img/icon/16x16/resorce.png",
		"3":"/resources/img/icon/16x16/fun-black.png",
};