//计算宽度高度
var calcFun = function(){
	var ww = $(window).width();
	var wh = $(window).height();
	var contentW = $('.content').width();
	var rDom = $('.r-content-wrapper');
	var lDom = $('.l-content-wrapper');
	rDom.width(contentW - lDom.width() - 11);
	rDom.height(wh - 20);
}
var delFun = function(){
	$('button.multiDel').click(function(){
		if(false){
			//如果没有选中的
			layer.msg('请选中要删除的公告信息！');
		}else{
			layer.confirm('删除选中的公告信息？（删除后不可恢复）', {
			          icon: 3,
			          btn: ['是','否'] //按钮
			    	  }, function(index, layero){
			    		  // $.ajax({
		        	// 			"url":webpath+"/resource/delete",
		        	// 			"type":"POST",
		        	// 			dataType:"json",
		        	// 			data:{
		        	// 				id:node.resourcesId
		        	// 			},
		        	// 			success:function(data){
		        	// 				layer.msg('删除成功！', {time: 1000, icon:1});
		        	// 				layer.close(index);
		        	// 				resource.initTree();
		        	// 			}
		        	// 	   });
			    	  });
		}
		});
}


$(function() {
	delFun();
	//计算大小
    $(window).resize(function(){
        calcFun();
    }).resize();
});