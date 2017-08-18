$(document).ready(function(){
	initRedisTable();
	$("#searchBtn").bind("click",reloadTableData);
	$("#resetBtn").bind("click",resetForm);
	$("#addRedisBtn").bind("click",addRedis);
	// 为datatable外的父级设置高度
	$('#redisTable_wrapper').css('height', $('.panel-body').height()-60);
	// 加载日历框
	// 动态为表格添加父级
	$('#redisTable').wrap('<div class="tab-wrapper"></div>');
	$('.tab-wrapper').css('height', $('#redisTable_wrapper').height()-63);
	$('.tab-wrapper').niceScroll({ cursorcolor: "#ccc", horizrailenabled: false});
});



//初始化用户列表表格
function initRedisTable(){
	$("#redisTable").width("100%").dataTable({
		"pageLength" : 7,
		"bAutoWidth": false,
		"columns" : [ {"data" : null,"targets":0 },{
			"data" : "dsName"
		}, {
			"data" : "resultsetType"
		}, {
			"data" : "pk"
		}, {
			"data" : "createTime"
		}],
		 ajax: {
		     url:webpath+'/dsredis/list',
		     "type": 'POST',
		     "data": function (d) {//查询参数
		           return $.extend( {}, d, {
		              "jsonStr": form.serializeStr($("#SearchForm"))
		           });
		     },
		     "dataSrc": function (json) {
		           json.iTotalRecords = json.total;
		           json.iTotalDisplayRecords = json.total;
		           return json.data;
		     }
		},
		columnDefs:[{
			  "targets" : 5,//操作按钮目标列
			  "data" : null,
			  "render" : function(data, type,row) {
				  var id = row.id;
				  var html =  '<a href="javascript:void(0);" onclick="updateRedis(\''+id+'\')" class="icon-wrap" title="编辑"><i class="iconfont i-btn">&#xe66f;</i></a>';
			      html += '&nbsp;&nbsp;';
			      html +=  '<a href="javascript:void(0);" onclick="deleteRedis(\''+id+'\')" class="icon-wrap" title="删除"><i class="iconfont i-btn">&#xe614;</i></a>';
			      html += '&nbsp;&nbsp;';
                  return html;
			   }
		}],
		"fnDrawCallback":function(){
            var api =this.api();
            var startIndex= api.context[0]._iDisplayStart;        //获取到本页开始的条数 　
             api.column(0).nodes().each(function(cell, i) {
                    cell.innerHTML = startIndex + i + 1;
                    }); 
		}
	});
}


//刷新数据  true  整个刷新      false 保留当前页刷新
function reloadTableData(isCurrentPage){
	$("#redisTable").dataTable().fnDraw(isCurrentPage==null?true:isCurrentPage);
}

//新增
function addRedis(){
	var formObj = $("#addRedisForm");
	form.clear(formObj);
	form.cleanValidator(formObj);
	layer.open({
		type: 1,
        title:'<i class="iconfont">&#xe641;</i>&nbsp;新增redis数据源',
        area: ['500px', '370px'],
        content: $("#addRedis"),//弹出框div
        btn: ['确定','取消'],
        btn1: function(index, layero){//确定按钮回调
        	if(form.isValidator(formObj)){
        		$.ajax({
    				"url":webpath+"/dsredis/add",
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
function updateRedis(dsRedisId){
	$.ajax({
		"url":webpath+"/dsredis/load",
		"type":"POST",
		dataType:"json",
		data:{
			dsRedisId:dsRedisId
		},
		success:function(data){
			var formObj = $("#updateRedisForm");
			console.log(data);
			form.clear(formObj);
			form.cleanValidator(formObj);
			form.load(formObj,data);
			layer.open({
				type: 1,
		        title:'<i class="iconfont">&#xe633;</i>&nbsp;修改redis数据源',
		        area: ['500px', '360px'],
		        content: $("#updateRedis"),
		        btn: ['确定','取消'],
		        btn1: function(index, layero){//确定按钮回调
		        	if(form.isValidator(formObj)){
		        		$.ajax({
		    				"url":webpath+"/dsredis/edit",
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
function deleteRedis(dsRedisId){
	layer.confirm('删除该数据源？（删除后不可恢复）', {
        icon: 3,
        btn: ['是','否'] //按钮
  	  }, function(index, layero){
  		  $.ajax({//初始化组织机构树
  				"url":webpath+"/dsredis/remove",
  				"type":"POST",
  				dataType:"json",
  				data:{
  					dsRedisId:dsRedisId
  				},
  				success:function(data){
  					layer.close(index);
					reloadTableData(true);
  				}
  		   });
  	  });
}
//重置查询条件
function resetForm(){
	form.clear($("#SearchForm"));
}

