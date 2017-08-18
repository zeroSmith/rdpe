/**
 * 框架页面的js
 */
//左侧菜单的初始化data对象，用于测试
var leftNavArr = userMenuTree;

/*配置生成左侧菜单配置对象*/
/**
* onClick的函数会返回三个参数title,url,id
*/
var barsObj = {
    "data": leftNavArr,
    "onClick": function(title,url,id){
    	addNewTab(title,url,id,true);
    	$.ajax({
			"url":webpath+"/platform/doResourceLog",
			"data":{
				resourcesId:id
			},
			"type":"POST",
			beforeSend:function(a,b){
				return null;
			},
			complete:function(a,b){
				return null;
			},
			success:function(data){
				//console.log(data);
			}/*,
			error:function(){
				 console.log("记录日志失败！");
			}*/
		});
    },
    "BeforeExpandFun": LBarBeforeExpandFun,
    "AfterExpandFun": LBarAfterExpandFun,
    "BeforeCollapseFun":LBarBeforeCollapseFun,
    "AfterCollapseFun":LBarAfterCollapseFun,
    "barsWidth":{
      "minWidth":"42",
      "ExpandWidth1":"185",
      "ExpandWidth2":"12%",
      "mediaWidth":"1400",
    }
}

//关于计算dom中某些div高度的js
var calcHeight = function() {
    var headH = Math.ceil($('.frame-head').height());
    var WH = document.body.clientHeight;
    var b = browser();
    if ("IE" === b) {
        WH = $(window).height() - 1;
    }
    var leftBarH = WH - headH;
    $('.l-content-wrapper,.r-content-wrapper').height(leftBarH);
};

//计算leftBar右侧div宽度的js
var calcWidth = function(){
    var ww = $(window).width();
    if(ww < 900){
    	ww = 900;
    }
    var lw = $('#leftBar').parent().width();
    $('#leftBar').parent().siblings().width(ww - lw - 1);
};

//计算宽度和高度并初始化美化滚动条的事件
var setWH = function() {
    $(window).resize(function() {
        calcHeight();
        calcWidth();
        $(".l-content-wrapper").getNiceScroll().resize();
    }).resize();
    $('.l-content-wrapper').niceScroll({ cursorcolor: "#ccc", horizrailenabled: false });
}

//初始化第一个不可关闭的frame
var initTabs = function(){
	if(frameStyle == "tab"){
		$("#tabs").tabs({
	    	fit:true,
	    	border:false,
	    	heigt:'34px',
	    	tabHeight:'34px'
	    });
	}
    if(userMenuTree.length==0){
    	layer.msg('授权资源为空，请联系管理员解决问题！', {icon: 1});
    }else{
    	var m = userMenuTree[0];
    	if(m.children.length==0){
    		addNewTab(m.text, m.url, m.id ,false);
    	}else{
    		addNewTab(m.children[0].text, m.children[0].url, m.children[0].id ,false);
    	}
    }
    //addNewTab('我的工作台', '/workbench/index', '001' ,false);
    //窗口resize的时候调用easyui的tabs插件的自适应函数
    $(window).resize(function(){
    	if(frameStyle == "tab"){
    		$("#tabs").tabs("resize");
    	}
    });
}


//绑定密码强弱校验
function bindPasswordCheck(){
	$('#newPassword').keyup(function () { 
		var strongRegex = new RegExp("^(?=.{8,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*$", "g"); 
		var mediumRegex = new RegExp("^(?=.{7,})(((?=.*[A-Z])(?=.*[a-z]))|((?=.*[A-Z])(?=.*[0-9]))|((?=.*[a-z])(?=.*[0-9]))).*$", "g"); 
		var enoughRegex = new RegExp("(?=.{4,}).*", "g"); 
	
		if (false == enoughRegex.test($(this).val())) { 
			$('#level').removeClass('pw-weak'); 
			$('#level').removeClass('pw-medium'); 
			$('#level').removeClass('pw-strong'); 
			$('#level').addClass('pw-defule'); 
			 //密码小于六位的时候，密码强度图片都为灰色 
		} 
		else if (strongRegex.test($(this).val())) { 
			$('#level').removeClass('pw-weak'); 
			$('#level').removeClass('pw-medium'); 
			$('#level').removeClass('pw-strong'); 
			$('#level').addClass('pw-strong'); 
			 //密码为八位及以上并且字母数字特殊字符三项都包括,强度最强 
		} 
		else if (mediumRegex.test($(this).val())) { 
			$('#level').removeClass('pw-weak'); 
			$('#level').removeClass('pw-medium'); 
			$('#level').removeClass('pw-strong'); 
			$('#level').addClass('pw-medium'); 
			 //密码为七位及以上并且字母、数字、特殊字符三项中有两项，强度是中等 
		} 
		else { 
			$('#level').removeClass('pw-weak'); 
			$('#level').removeClass('pw-medium'); 
			$('#level').removeClass('pw-strong'); 
			$('#level').addClass('pw-weak'); 
			 //如果密码为6为及以下，就算字母、数字、特殊字符三项都包括，强度也是弱的 
		} 
		return true; 
	}); 
}

// layer弹出层--内容区为iframe页面或html页面均可
/**
 * type可传入的值有：0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）。
 * content可传入的值与type对应：
 * 			type=1, content可传入 1）任意的文本或html；2）$('#id')；3）str
 * 			type=2, content可传入url地址
 * 			type=4, content可传['内容', '#id'] ，数组第二项即吸附元素选择器或者DOM
 * areaArr定义弹框大小，传入数组形式，如['100px','100px']
 */ 
var openByContent = function(type, content, areaArr){
	layer.open({
		type: type,
		title: false,
		closeBtn: false,
		area: areaArr,
		content: content,
		btn: ['关闭'],
		btn1: function(index, layero){
			layer.close(index);
			noticeTimer();
		}
	})
}


//var openByContent = function(noticeId){
//	window.open(webpath+'/specnotice/noticeDetail?noticeId='+noticeId);
//}

var noticeTimer = function(){
	$.ajax({
		"url":webpath+"/specnotice/selectUnreadNotice",
		"type":"POST",
		dataType:"json",
		success:function(data){
			if(data.total == 0){
				$('.external font').html('你有0条未读公告');
				$('.tipsScrollDiv > ul').html('<li><a><span class="details"><span class="label label-sm label-icon"> </span><font>暂无未读公告</font></span></a></li>');
				$('#notice').html('<i class="iconfont">&#xe66e;</i><span class="label label-danger">'+data.total+'</span>');
			}else{
				$('#notice').html('<i class="iconfont">&#xe66e;</i><span class="label label-danger">'+data.total+'</span>');
				var noticeList = data.data;
				$('.external font').html('你有'+data.total+'条未读公告');
				var noticeHtml='';
				for(var i = 0 ;i<noticeList.length;i++){
					if(noticeList[i].noticeType == '1'){
						noticeHtml += '<li><a href="javascript:openByContent(2, \''+webpath+'/specnotice/noticeDetail?noticeId='+noticeList[i].noticeId+'\', [\'900px\',\'600px\']);"><span class="time">'+noticeList[i].pubTime+'</span><span class="details"><span class="label label-sm label-icon label-success"> </span><font>'+noticeList[i].noticeTitle+'</font></span></a></li>';
					}else if(noticeList[i].noticeType == '2'){
						noticeHtml += '<li><a href="javascript:openByContent(2, \''+webpath+'/specnotice/noticeDetail?noticeId='+noticeList[i].noticeId+'\', [\'900px\',\'600px\']);"><span class="time">'+noticeList[i].pubTime+'</span><span class="details"><span class="label label-sm label-icon label-danger"> </span><font>'+noticeList[i].noticeTitle+'</font></span></a></li>';
					}else if(noticeList[i].noticeType == '3'){
						noticeHtml += '<li><a href="javascript:openByContent(2, \''+webpath+'/specnotice/noticeDetail?noticeId='+noticeList[i].noticeId+'\', [\'900px\',\'600px\']);"><span class="time">'+noticeList[i].pubTime+'</span><span class="details"><span class="label label-sm label-icon label-warning"> </span><font>'+noticeList[i].noticeTitle+'</font></span></a></li>';
					}else if(noticeList[i].noticeType == '4'){
						noticeHtml += '<li><a href="javascript:openByContent(2, \''+webpath+'/specnotice/noticeDetail?noticeId='+noticeList[i].noticeId+'\', [\'900px\',\'600px\']);"><span class="time">'+noticeList[i].pubTime+'</span><span class="details"><span class="label label-sm label-icon label-info"> </span><font>'+noticeList[i].noticeTitle+'</font></span></a></li>';
					}else{
						noticeHtml += '<li><a href="javascript:openByContent(2, \''+webpath+'/specnotice/noticeDetail?noticeId='+noticeList[i].noticeId+'\', [\'900px\',\'600px\']);"><span class="time">'+noticeList[i].pubTime+'</span><span class="details"><font>'+noticeList[i].noticeTitle+'</font></span></a></li>';
					}
				}
				$('.tipsScrollDiv > ul').html(noticeHtml);
			}
		},
		error:function(){
			clearTimeout(timer);
		}
	});
	$.ajax({
		"url":webpath+"/specnotice/selectOnlineUser",
		"type":"POST",
		dataType:"json",
		success:function(data){
			if(data == 0){
				$("#onlineUserCount").text(0);
			}else{
				$("#onlineUserCount").text(data);
			}
		},
		error:function(){
			clearTimeout(timer);
		}
	});
}
var timer;
$(function() {
    setWH();
    bindPasswordCheck();
    if(syncDataTime!=-1){//不刷新
    	 timer = setInterval(noticeTimer,syncDataTime);//设置刷新时长
    }
    $('#lBarWrap').boncLeftBar(barsObj);
    initTabs();
    $('body').niceScroll({cursorcolor:"#ccc"});
    //绑定用户信息按钮事件
    $("#userInfoBtn").bind("click",function(){
    	layer.open({
    		type: 1,
            title:'<i class="iconfont">&#xe600;</i>&nbsp;我的信息',
            area: ['300px', '480px'],
            content: $("#userInfoDialog"),
            //btnAlign:'c',
            btn: ['确定'],
            btn1: function(index, layero){//确定按钮回调
            	layer.close(index);
    	    }
        });
    	//我的信息弹出框加滚动条
    	userInfoDialogScroll = $("#userInfoDialog").parent().niceScroll({ cursorcolor: "#ccc", horizrailenabled: false});
    });
    $("#logoutBtn").bind("click",function(){
    	layer.confirm('是否退出系统？', {
          icon: 3,
          btn: ['是','否'] //按钮
    	  }, function(){
    		  window.location.href=webpath+"/login/logout";
    	  }, function(){
    		  return;
    	  });
    });
    //修改密码绑定事件
    $("#updatePasswdBtn").bind("click",function(){
    	//初始化密码初始化强度。
    	$('#level').removeClass('pw-weak'); 
		$('#level').removeClass('pw-medium'); 
		$('#level').removeClass('pw-strong'); 
		$('#level').addClass('pw-defule');
		//清空所有input框
		$("#updatePasswd").find("input").val("");
		//清空校验信息
		$("#errorInfo").html("");
    	layer.open({
    		type: 1,
            title:'<i class="iconfont">&#xe637;</i>&nbsp;修改密码',
            area: ['300px', '330px'],
            content: $("#updatePasswdDialog"),
            btn: ['确定', '取消'],
            btn1: function(index, layero){//确定按钮回调
            	var oldPasswd= $("#updatePasswd").find("input[name='oldPassword']").val()
            	   ,newPasswd= $("#updatePasswd").find("input[name='newPassword']").val()
            	   ,reNewPasswd= $("#updatePasswd").find("input[name='reNewPassword']").val();
    	        if(oldPasswd==""||oldPasswd==null){
    	        	$("#errorInfo").html("旧密码不能为空！");
    	        	return;
    	        }
    	        if(newPasswd==""||newPasswd==null){
    	        	$("#errorInfo").html("新密码不能为空！");
    	        	return;
    	        }
    	        if(newPasswd.length>32 || newPasswd.length<4){
    	        	$("#errorInfo").html("新密码长度需大于4小于32！");
    	        	return;
    	        }
    	        if(newPasswd!=reNewPasswd){
    	        	$("#errorInfo").html("两次密码输入不一致！");
    	        	return;
    	        }
    	        
    	        $.ajax({//请求修改密码
    				"url":webpath+"/login/editPwd",
    				"data":{
    					oldPasswd:oldPasswd,
    					newPasswd:newPasswd
    				},
    				dataType: "json", 
    				"type":"POST",
    				success:function(data){
    					if(data.code == successCode){
    						layer.msg(data.message, {time: 2000, icon:1});
    						layer.close(index);
    					}else{
    						$("#errorInfo").html(data.message);
    					}
    				}
    			});
    	    },
    	    btn2: function(index, layero){//取消按钮回调
    	    	layer.close(index);
    	    }
        });
    });
    //查看更多公告
    $("#loadMoreNotice").bind("click",function(){
    	addNewTab('我的公告','/cusnotice/index','noticeTbl',true);
    });
});
