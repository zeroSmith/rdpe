//绑定查看公告详情页面或跳到编辑页面
var noticeListTbl;
var bindlookNoticeDetail = function(){
	$('.lookNoticeDetail').unbind().click(function(e){
		preventDefault(e);
		var $this = $(this);
		var id = $this.attr('id');
		var href = webpath + $this.attr('href') + '&noticeId=' + id;
		var $state = $('.readState', $this.parents('tr'));
		if($state.length > 0 && $state.attr('class').indexOf('unRead') >= 0){
			$state.removeClass('unRead').addClass('hasRead').html('&#xe678;');
			$this.removeClass('unReadSubject');
		}
		// 弹出查看详情弹出层
		if($this.attr('href').indexOf('/notice/editNotice') == -1){
			try{
				parent.window.openByContent(2, href, ['900px', '600px']);
			}catch(err){
				layer.open({
					type: 2,
					title: false,
					closeBtn: false,
					area: ['900px', '600px'],
					content: href,
					btn: ['关闭'],
					btn1: function(index, layero){
						layer.close(index);
					}
				})
			}
		}else{
			window.open(href, '_blank');
		}
		
	});
};

/*已接收部分js开始*/

var bindReceiveBtnFun = function(){
	//全部标记为已读
	$('.markReaded').unbind().click(function(){
		$.ajax({
			"url": webpath+'/notice/markRead',
		    "type": 'POST',
			success:function(data){
				if(JSON.parse(data).status == 0){
					//操作成功
					$("#noticeList .readState").removeClass('unRead').addClass('hasRead');
					$("#noticeList .unReadSubject").removeClass('unReadSubject');
					$('.readState').html('&#xe678;');
					layer.msg('标记成功', {time: 1000, icon:1});
				}else{
					layer.msg('操作失败', {time: 1000, icon:2});
				}
			},
			error:function(){
				layer.msg('系统异常，请稍后重试', {time: 1000, icon:2});
			}
		});
		
	});
	
	//删除单条公告
	$('.delOneNotice').unbind().click(function(){
		var $this = $(this);
		var id = $this.attr('data-idx');
		layer.confirm('删除此公告信息？', {
	          icon: 3,
	          btn: ['是','否'] //按钮
	    	  }, function(index, layero){
	    		   $.ajax({
        	 			"url":webpath+"/notice/deleteRecNotice",
        	 			"type":"POST",
        	 			dataType:"json",
        	 			data:{
        	 				noticeId:id
        	 			},
        	 			success:function(data){
        	 				layer.msg('删除成功！', {time: 1000, icon:1});
        	 				layer.close(index);
        	 				$("#noticeList").dataTable().fnDraw(false);
        	 			}
        	 	   });
	    	  });
	});
};

//初始化接收列表datatables表格
var initReceiveList = function(){
	noticeListTbl = $("#noticeList").width('100%').DataTable({
		serverSide: true,
        "autoWidth": false,
		"columns":[{
			"data" : null,
			"render" : function(data, type,row) {
				  var id = row.noticeId;
				  var html = '';
				  html = '<input id="' + id + '" type="checkBox" />';
			      return html;
			   }
		},{
			  "data" : null,
			  "render" : function(data, type,row) {
				  var hasRead = row.isRead;
				  var html = '';
				  if(hasRead == "1"){
					  html += '<i class="iconfont readState hasRead">&#xe678;</i>';
				  }else{
					  html += '<i class="iconfont readState unRead">&#xe67f;</i>';
				  }
			      return html;
			   }
		},{
			"data" : null,
			"render" : function(data, type,row) {
				  var id = row.noticeId;
				  var hasRead = row.isRead;
				  var clsUnread = '';
				  if(hasRead == "-1"){
					  clsUnread = 'unReadSubject';
				  }
				  var html =  '<a id="'+id+'" href="/specnotice/noticeDetail?fromSign=2" class="lookNoticeDetail ' + clsUnread + '">' + row.noticeTitle + '</a>';
				  return html;
			   }
		},{
			"data" : "pubTime"
		},{
			"data" : "pubPerson"
		},{
			  "data" : null,
			  "render" : function(data, type,row) {
				  var id = row.noticeId;
				  var html =  '<i data-idx="' + id + '" class="i-btn iconfont delOneNotice" title="删除">&#xe614;</i>';
				  return html;
			   }
		}],
		 ajax: {
		     url:webpath+'/notice/noticeRec',
		     "type": 'POST',
		     "dataSrc": function ( json ) {
	                json.iTotalRecords = json.total;
					json.iTotalDisplayRecords = json.total;
					return json.data;
	            }
		},
		 fnDrawCallback:function(){
			 //表格话完回调函数
			 calcTableHeight();
			 bindReceiveBtnFun();
			 bindlookNoticeDetail();
		}
	});
};


/*已接收部分js结束*/

/*已发送部分js开始*/

//已发送部分按钮事件
var bindsendedBtnFun = function(){
	//编辑此条已发送信息页面
	$('.editNotice').unbind().click(function(){
		var id = $(this).attr('data-idx');
		window.open(webpath + '/notice/editNotice?fromSign=1&noticeId=' + id, '_blank');
	});
	
	//删除单条公告
	$('.delOneNotice').unbind().click(function(){
		var $this = $(this);
		var id = $this.attr('data-idx');
		layer.confirm('删除此公告信息？', {
	          icon: 3,
	          btn: ['是','否'] //按钮
	    	  }, function(index, layero){
	    		   $.ajax({
        	 			"url":webpath+"/notice/deleteSendNotice",
        	 			"type":"POST",
        	 			dataType:"json",
        	 			data:{
        	 				noticeId:id
        	 			},
        	 			success:function(data){
        	 				layer.msg('删除成功！', {time: 1000, icon:1});
        	 				layer.close(index);
        	 				$("#noticeList").dataTable().fnDraw(false);
        	 			}
        	 	   });
	    	  });
	});
};


//初始化已发送部分表格
var initSendedList = function(){
	noticeListTbl = $("#noticeList").width('100%').dataTable({
		serverSide: true,
        "autoWidth": false,
		"columns":[{
			"data" : null,
			"render" : function(data, type,row) {
				  var id = row.noticeId;
				  var html = '';
				  html = '<input id="' + id + '" type="checkBox" />';
			      return html;
			   }
		},{
			  "data" : null,
			  "render" : function(data, type,row) {
				  var state = row.state;
				  var html = '';
				  if(state == 1){
					  html += '<i class="iconfont sendState hasSend">&#xe67d;</i>';
				  }else{
					  html += '<i class="iconfont sendState unSend">&#xe688;</i>';
				  }
			      return html;
			   }
		},{
			"data" : null,
			"render" : function(data, type,row) {
				  var id = row.noticeId;
				  var html =  '<a id="'+id+'" href="/specnotice/noticeDetail?fromSign=1" class="lookNoticeDetail">' + row.noticeTitle + '</a>';
				  return html;
			   }
		},{
			"data" : "pubTime"
		},{
			  "data" : null,
			  "render" : function(data, type,row) {
				  var id = row.noticeId;
				  var html =  '<i data-idx=' + id + ' class="iconfont editNotice i-btn" title="编辑">&#xe66f;</i><i data-idx=' + id + ' class="iconfont delOneNotice i-btn" title="删除">&#xe614;</i>';
				  return html;
			   }
		}],
		 ajax: {
		     url:webpath+'/notice/noticeSend',
		     "type": 'POST',
		     "dataSrc": function ( json ) {
	                json.iTotalRecords = json.total;
					json.iTotalDisplayRecords = json.total;
					return json.data;
	            }
		},
		 fnDrawCallback:function(){
			 //表格话完回调函数
			 calcTableHeight();
			 bindlookNoticeDetail();
			 bindsendedBtnFun();
		}
	});
};

/*已发送部分js结束*/

/*草稿箱部分js开始*/
var bindDraftBtnFun = function(){	
	//删除单条公告
	$('.delOneNotice').unbind().click(function(){
		var $this = $(this);
		var id = $this.attr('data-idx');
		layer.confirm('删除此公告信息？', {
	          icon: 3,
	          btn: ['是','否'] //按钮
	    	  }, function(index, layero){
	    		   $.ajax({
        	 			"url":webpath+"/notice/deleteSendNotice",
        	 			"type":"POST",
        	 			dataType:"json",
        	 			data:{
        	 				noticeId:id
        	 			},
        	 			success:function(data){
        	 				layer.msg('删除成功！', {time: 1000, icon:1});
        	 				layer.close(index);
        	 				$("#noticeList").dataTable().fnDraw(false);
        	 			}
        	 	   });
	    	  });
	});
};


//初始化草稿表格
var initDraftsList = function(){
	noticeListTbl = $("#noticeList").width('100%').dataTable({
		serverSide: true,
        "autoWidth": false,
		"columns":[{
			"data" : null,
			"render" : function(data, type,row) {
				  var id = row.noticeId;
				  var html = '';
				  html = '<input id="' + id + '" type="checkBox" />';
			      return html;
			   }
		},{
			  "data" : null,
			  "render" : function(data, type,row) {
				  var hasRead = row.isRead;
				  var html = '<i class="iconfont draftState">&#xe67e;</i>';
			      return html;
			   }
		},{
			"data" : null,
			"render" : function(data, type,row) {
				  var id = row.noticeId;
				  var html =  '<a id="'+id+'" href= "/notice/editNotice?fromSign=3" class="lookNoticeDetail">' + row.noticeTitle + '</a>';
				  return html;
			   }
		},{
			"data" : "pubTime"
		},{	  "data" : null,
			  "render" : function(data, type,row) {
				  var id = row.noticeId;
				  var html =  '<i data-idx="' + id +'" class="iconfont delOneNotice i-btn" title="删除">&#xe614;</i>';
				  return html;
			   }
		}],
		 ajax: {
		     url:webpath+'/notice/noticeDraft',
		     "type": 'POST',
		     "dataSrc": function ( json ) {
	                //console.log('data:' + JSON.stringify(json));
	                json.iTotalRecords = json.total;
					json.iTotalDisplayRecords = json.total;
					return json.data;
	            }
		},
		 fnDrawCallback:function(){
			 //表格话完回调函数
			 calcTableHeight();
			 bindlookNoticeDetail();
			 bindDraftBtnFun();
		}
	});
};

/*草稿箱部分js结束*/
var partTabFun = function(){
	$('.partTab > a').click(function(){
		var cls = $(this).attr('class');
		var $this = $(this);
		if(cls.indexOf('active') >=0 ) return;
		$this.siblings().removeClass('active');
		$this.addClass('active');
		//切换btns
		$('.tblOperation').hide();
		var noticeListTbl = $('#noticeList').DataTable();
		noticeListTbl.destroy();
        $('#noticeList').empty();
		if(cls.indexOf('send') >= 0){
			$('.sendedBtns').show();
			initSendedList();
		}else if(cls.indexOf('draft') >= 0){
			$('.draftBtns').show();
			initDraftsList();
		}else if(cls.indexOf('receive') >= 0){
			$('.receiveBtns').show();
			initReceiveList();
		}
	});
};

//计算左模块和右模块的大小
var calcFun = function(){
	var ww = $(window).width();
	var wh = $(window).height();
	var contentW = $('.content').width();
	var rDom = $('.r-content-wrapper');
	var lDom = $('.l-content-wrapper');
	rDom.width(contentW - lDom.width() - 11);
	rDom.height(wh - 20);
}

//计算datatables表格高度
var calcTableHeight = function(){
	var wh = $(window).height();
	var ph1 = $('.panel-heading').css('height').split('px')[0];
	var ph2 = $('.tblOperation:visible').css('height').split('px')[0];
	var tblWrapH = wh - 21 - parseInt(ph1) - parseInt(ph2);
	$('.dataTables_wrapper').height(tblWrapH);
}

var comBtnFun = function(){
	//全部选中按钮事件
	$('input.checkAll').click(function(){
		var state = this.checked;
		var $tblInput = $('table input[type="checkbox"]', $(this).parents('.panel-content'));
		for(var i=0;i<$tblInput.length;i++){
			$tblInput[i].checked = state;
        }
	});
	
	//多选删除按钮事件
	$('button.multiDel').click(function(){
		var $panelContent = $(this).parents('.panel-content');
		var btnsCls = $('.tblOperation:visible').attr('class');
		var $tblCheckInput = $('table input[type="checkbox"]:checked', $panelContent);
		var checkIdArray = new Array();
		for(var i=0;i<$tblCheckInput.length;i++){
			checkIdArray.push($($tblCheckInput[i]).attr('id'));
        }
		if($tblCheckInput.length == 0){
			//如果没有选中的
			layer.msg('请选中要删除的公告信息！', {time: 1000, icon:3});
		}else{
			layer.confirm('删除选中的公告信息？（删除后不可恢复）', {
			          icon: 3,
			          btn: ['是','否'] //按钮
			    	  }, function(index, layero){
			    		  var url = '';
			    		  if(btnsCls.indexOf('sendedBtns') != -1){
			    			  url = '/notice/batchDeleteSendNotice';
			    		  } else if(btnsCls.indexOf('draftBtns') != -1){
			    			  url = '/notice/batchDeleteSendNotice';
			    		  }else if(btnsCls.indexOf('receiveBtns') != -1){
			    			  url = '/notice/batchDeleteRecNotice';
			    		  }
			    		   $.ajax({
		        	 			"url":webpath+url,
		        	 			"type":"POST",
		        	 			dataType:"json",
		        	 			data:{
		        	 				"noticeIds": JSON.stringify(checkIdArray)
		        	 			},
		        	 			success:function(data){
		        	 				layer.msg('删除成功！', {time: 1000, icon:1});
		        	 				layer.close(index);
		        	 				$("#noticeList").dataTable().fnDraw(false);
		        	 				
		        	 			}
		        	 	   });
			    	  });
		}
		});
	
	//初次绑定新建公告按钮事件
	$('button.newNotice').click(function(){
		window.open(webpath + '/notice/editNotice?fromSign=0', '_blank');
	});
};

$(function() {
	comBtnFun();
	partTabFun();
	initReceiveList();
	//计算大小
    $(window).resize(function(){
        calcFun();
    }).resize();
});