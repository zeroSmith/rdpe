var _tbody = $("#sparkInfoTable").find("tbody");
var sparkClusterInfoList = new Array();
var _sparkClusterInfoList = new Array();
var pageNum = 0; 
$(function(){
	getsparkClusterInfoList();
	//setInterval(getsparkClusterInfoList,20000);
	$("#searchBtn").on("click",function(){
		var _option = $("#searchForm").find("input[name='eventName']").val();
		_sparkClusterInfoList = [];
		//有查询条件
		if(_option.length > 0){
			$.each(sparkClusterInfoList,function(index, value, array) {
				// 根据applicationId进行模糊查找
				if(value.applicationId.indexOf(_option) >= 0){
					_sparkClusterInfoList.push(value)
				}
			});
		}else{
			_sparkClusterInfoList = sparkClusterInfoList;
		}
		pageFunction(_sparkClusterInfoList);
	});
	$("#resetBtn").on("click",function(){
		$("#searchForm").find("input[name='eventName']").val("");
	});
});
var getsparkClusterInfoList = function (){
	$.ajax({
		url : webpath + "/workbench/getSparkClusterInfoList",
		type : "GET",
		dataType : "json",
		success : function(data){
			if(data.length > 0){
				sparkClusterInfoList = data;
				pageFunction(sparkClusterInfoList);
			}else{
				_tbody.empty();
				_tbody.append('<tr class="trClass" align="center"><td class="tdClass" colspan="9">当前没有事件运行</td></tr>');
			}
		}
	});
};

var pageFunction = function(sparkClusterInfoList){
	var _change = false;
	// 使用layui中的分页工具
	 layui.use(['laypage', 'layer'], function(){
		 var laypage = layui.laypage ,layer = layui.layer;
		 var nums = 10; // 每页出现的数据量
		  
		 var render = function(sparkClusterInfoList, curr){
	     var arr = [],thisData = sparkClusterInfoList.concat().splice(curr*nums-nums, nums);
	     var _tr = '';
	     layui.each(thisData, function(index, item){
	    	 	// js传一个对象
		    	 var jsonstr = JSON.stringify(item);
		    	 jsonstr = jsonstr.replace(/"/gm, "'");
		    	 _tr = '<tr class="trClass">'
					+ '<td class="tdClass"> <a href="javascript:;" onclick="_applicationDetailInfo(' + jsonstr + ');">'+item.id+'</a></td>'
					+ '<td class="tdClass">'+item.eventSparkName+'</td>'
					+ '<td class="tdClass">'+item.startedTime+'</td>'
					+ '<td class="tdClass">'+item.finishedTime+'</td>'
					+ '<td class="tdClass">'+item.state+'</td>'
					+ '<td class="tdClass">'+item.finalStatus+'</td>'
					+ '<td class="tdClass"><a href="javascript:void(0);" onclick="stopEvent(\'' + item.id + '\',\'' + item.eventSparkId + '\',\'' + item.state + '\')" class="icon-wrap" title="停止事件"><i class="iconfont i-btn">&#xe675;</i></a></td>'
					+ '</tr>' ;
					arr.push(_tr);
	   	 	});
		    return arr.join('');
		  };
		  var pageIndex = "";
		  if(pageNum > 0){
			  pageIndex = pageNum;
		  }else{
			  pageIndex = 1;
		  }
		  // 调用分页
		  laypage({
		    cont: 'sparkClusterPage' ,
		    pages: Math.ceil(sparkClusterInfoList.length/nums), // 得到总页数
		    groups:2 ,
		    skin:'#ed5b56',
		    first: '首页',
		    last:'末页',
		    curr:pageIndex,
		    prev:'上一页',
		    next:'下一页',
		    jump: function(obj){
		    	 if( !_change && pageNum > 0){
		    		obj.curr = pageNum;
		    	}else{
		    		pageNum = obj.curr;
		    	} 
		    	_change = true;
		    	_tbody.empty();
			    _tbody.append(render(sparkClusterInfoList, obj.curr));
			    $(".trClass").on('mouseover',function(){
					this.style.backgroundColor='#f2f2f2';
				});
			    $(".trClass:even").on('mouseout',function(){
					this.style.backgroundColor='#ffffff';
				});
			    
			    $(".trClass:odd").on('mouseout',function(){
					this.style.backgroundColor='#f9f9f9';
				});
			     
		    }
		  });
	}); 
}

var _applicationDetailInfo = function(obj){
	var _applicationTable = $(".applicationTable");
	_applicationTable.empty();
	for(var name in obj){
		var _tr = '<tr>'
			+ '<div class="form-group">'
			+ '<td style="width:15%"><label>' + name + '</label></td>'
			+ '<td style="width:85%;border-right: 0px;" ><label">' + obj[name] + '</td>'
			+ '</div>'
			+ '</tr>';
		_applicationTable.append(_tr);
	}
	layer.open({
		type : 1,
		title : '<i class="iconfont">&#xe633;</i>&nbsp;详细信息',
		area : [ '900px', '500px' ],
		content : $("#applicationInfo")
	})
}
var stopEvent = function(applicationId,eventId,state){
	if(state == 'KILLED' || state == 'FINISHED' || state == 'FAILED'){
		layer.msg("已经结束", {
			time : 3000,
			icon : 1
		});
		return;
	}else{
		layer.confirm('确认杀死该事件？', {
			icon : 3,
			btn : [ '是', '否' ]
		}, function(index, layero) {
			$.ajax({
				url : webpath + "/event/spark/stop",
				type : "GET",
				dataType : "json",
				data : {
					applicationId : applicationId,
					eventId : eventId
				},
				success : function(ret){
					if (ret.successful) {
						layer.msg(ret.msg, {
							time : 3000,
							icon : 1
						});
						//重载数据
						getsparkClusterInfoList();
					} else {
						layer.msg(ret.msg, {
							time : 3000,
							icon : 2
						});
					}
				}
			});
		});
	}
}