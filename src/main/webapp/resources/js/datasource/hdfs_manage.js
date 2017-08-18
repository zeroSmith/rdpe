$(document).ready(function(){
	initHdfsTable();
	$("#searchBtn").bind("click",reloadTableData);
	$("#resetBtn").bind("click",resetForm);
	$("#addHdfsBtn").bind("click",addHdfs);
	// 为datatable外的父级设置高度
	$('#hdfsTable_wrapper').css('height', $('.panel-body').height()-60);
	// 加载日历框
	// 动态为表格添加父级
	$('#hdfsTable').wrap('<div class="tab-wrapper"></div>');
	$('.tab-wrapper').css('height', $('#hdfsTable_wrapper').height()-63);
	$('.tab-wrapper').niceScroll({ cursorcolor: "#ccc", horizrailenabled: false});
});
//初始化用户列表表格
function initHdfsTable(){
	$("#hdfsTable").width("100%").dataTable({
		"pageLength" : 7,
		"bAutoWidth": false,
		"columns" : [ 
		{"data" : null,"targets":0 },{
			"data" : "dsName"
		}, {
			"data" : "createTime"
		}],
		 ajax: {
		     url:webpath+'/dshdfs/list',
		     "type": 'POST',
		     "data": function (d) {//查询参数
	           return $.extend( {}, d, {
	              "jsonStr": form.serializeStr($("#hdfsSearchForm"))
	           });
		     },
		     "dataSrc": function (json) {
	           json.iTotalRecords = json.total;
	           json.iTotalDisplayRecords = json.total;
	           return json.data;
		     }
		},
		columnDefs:[{
			  "targets" : 3,//操作按钮目标列
			  "data" : null,
			  "render" : function(data, type,row) {
				  var id = row.id;
				  var html =  '<a href="javascript:void(0);" onclick="updateHdfs(\''+id+'\')" class="icon-wrap" title="编辑"><i class="iconfont i-btn">&#xe66f;</i></a>';
			      html += '&nbsp;&nbsp;';
			      html +=  '<a href="javascript:void(0);" onclick="deleteHdfs(\''+id+'\')" class="icon-wrap" title="删除"><i class="iconfont i-btn">&#xe614;</i></a>';
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
/*,{
	  "targets" : 1,//操作按钮目标列
	  "data" : null,
	  "render" : function(data, type,row) {
		  var html= '<span>HDFS</span>';
	      return html;
	   }
}*/

//刷新数据  true  整个刷新      false 保留当前页刷新
function reloadTableData(isCurrentPage){
	$("#hdfsTable").dataTable().fnDraw(isCurrentPage==null?true:isCurrentPage);
}

//新增
function addHdfs(){
	var formObj = $("#addHdfsForm");
	form.clear(formObj);
	form.cleanValidator(formObj);
	layer.open({
		type: 1,
        title:'<i class="iconfont">&#xe641;</i>&nbsp;新增Hdfs数据源',
        area: ['500px', '340px'],
        content: $("#addHdfs"),//弹出框div
        btn: ['确定','取消'],
        btn1: function(index, layero){//确定按钮回调
        	if(form.isValidator(formObj)){
        		$.ajax({
    				"url":webpath+"/dshdfs/add",
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
function updateHdfs(dsHdfsId){
	$.ajax({
		"url":webpath+"/dshdfs/load",
		"type":"POST",
		dataType:"json",
		data:{
			dsHdfsId:dsHdfsId
		},
		success:function(data){
			var formObj = $("#updateHdfsForm");
			console.log(data);
			form.clear(formObj);
			form.cleanValidator(formObj);
			form.load(formObj,data);
			layer.open({
				type: 1,
		        title:'<i class="iconfont">&#xe633;</i>&nbsp;修改Hdfs数据源',
		        area: ['500px', '340px'],
		        content: $("#updateHdfs"),
		        btn: ['确定','取消'],
		        btn1: function(index, layero){//确定按钮回调
		        	if(form.isValidator(formObj)){
		        		$.ajax({
		    				"url":webpath+"/dshdfs/edit",
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
function deleteHdfs(dsHdfsId){
	layer.confirm('删除该数据源？（删除后不可恢复）', {

        icon: 3,
        btn: ['是','否'] //按钮
  	  }, function(index, layero){
  		  $.ajax({//初始化组织机构树
  				"url":webpath+"/dshdfs/remove",
  				"type":"POST",
  				dataType:"json",
  				data:{
  					dsHdfsId:dsHdfsId
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
	form.clear($("#hdfsSearchForm"));
}

