$(document).ready(function() {
	initsystemDictTable();
	$("#addSystemDictBtn").bind("click", addSystemDict);
	$("#searchBtn").bind("click", reloadTableData);
	$("#resetBtn").bind("click", resetForm);

	// 为datatable外的父级设置高度
	$('#systemDictTable_wrapper').css('height', $('.panel-body').height() - 60);

	// 动态为表格添加父级
	$('#systemDictTable').wrap('<div class="tab-wrapper"></div>');
	$('.tab-wrapper').css('height', $('#systemDictTable_wrapper').height() - 63);
	$('.tab-wrapper').niceScroll({
		cursorcolor : "#ccc",
		horizrailenabled : false
	});
});

function initsystemDictTable() {
	$("#systemDictTable").dataTable({
		"bAutoWidth": false,
		"columns" : [  
		               { "data":null,"targets":0 }, 
		               { "data": "propName" },
			           { "data": "propValue" },
			           { "data": "memo" }
		 ],
		ajax : {
			url : webpath + '/systemDict/list',
			"type" : 'POST',
			"data" : function(d) {// 查询参数
				return $.extend({}, d, {
					"jsonStr" : form.serializeStr($("#systemDictSearchForm"))
				});
			},
			"dataSrc" : function(json) {
				json.iTotalRecords = json.total;
				json.iTotalDisplayRecords = json.total;
				return json.data;
			}
		},
		columnDefs : [ {
			"targets" : 4,// 操作按钮目标列
			"data" : null,
			"render" : function(data, type, row) {
				var propName = row.propName;
				var html = '<a href="javascript:void(0);" onclick="modifySystemDict(\'' + propName + '\')" class="icon-wrap" title="编辑"><i class="iconfont i-btn">&#xe66f;</i></a>';
				html += '&nbsp;&nbsp;';
				html += '<a href="javascript:void(0);" onclick="deleteSystemDict(\'' + propName + '\')" class="icon-wrap" title="删除"><i class="iconfont i-btn">&#xe614;</i></a>';
				return html;
			}
		} ],
		"fnDrawCallback":function(){
            var api =this.api();
            var startIndex= api.context[0]._iDisplayStart;        //获取到本页开始的条数 　
             api.column(0).nodes().each(function(cell, i) {
                    cell.innerHTML = startIndex + i + 1;
                    }); 
         }
	});
}

// 刷新数据 true 整个刷新 false 保留当前页刷新
function reloadTableData(isCurrentPage) {
	$("#systemDictTable").dataTable().fnDraw(isCurrentPage == null ? true : isCurrentPage);
}

function addSystemDict() {
	var formObj = $("#addSystemDictForm");
	form.clear(formObj);
	form.cleanValidator(formObj);
	layer.open({
		type : 1,
		title : '<i class="iconfont">&#xe641;</i>&nbsp;新增系统参数',
		area : [ '350px', '300px' ],
		content : $("#addSystemDict"),
		btn : [ '确定', '取消' ],
		btn1 : function(index, layero) {// 确定按钮回调
			if (form.isValidator(formObj)) {
				var propName = $("#addSystemDictForm").find("[name='propName']").val();
				
				$.ajax({
					"url" : webpath + "/systemDict/selectAll",
					"type" : "POST",
					dataType : "json",
					data : form.serializeJson(formObj),
					success : function(data) {
						var flag = false;
						data.forEach(function(value,index,array){
							if(propName == value.propName){
								flag = true;
							}
						});
						if(flag){
							layer.msg("参数："+propName+"   已经存在",{icon:6})
						}else{
							$.ajax({
								"url" : webpath + "/systemDict/add",
								"type" : "POST",
								dataType : "json",
								data : form.serializeJson(formObj),
								success : function(data) {
									layer.close(index);
									reloadTableData(true);
								}
							});
						}
					}
				});
			}
		},
		btn2 : function(index, layero) {// 取消按钮回调
			layer.close(index);
		}
	});
}

function modifySystemDict(propName) {
	$.ajax({
		"url" : webpath + "/systemDict/getSystemDictByPropName",
		"type" : "POST",
		dataType : "json",
		data : {
			propName : propName
		},
		success : function(data) {
			var formObj = $("#updateSystemDictForm");
			form.clear(formObj);
			form.cleanValidator(formObj);
			form.load(formObj, data);
			layer.open({
				type : 1,
				title : '<i class="iconfont">&#xe633;</i>&nbsp;修改系统参数',
				area : [ '350px', '300px' ],
				content : $("#updateSystemDict"),
				btn : [ '确定', '取消' ],
				btn1 : function(index, layero) {// 确定按钮回调
					if (form.isValidator(formObj)) {
						$.ajax({
							"url" : webpath + "/systemDict/edit",
							"type" : "POST",
							dataType : "json",
							data : form.serializeJson(formObj),
							success : function(data) {
								layer.close(index);
								reloadTableData(true);
							}
						});
					}
				},
				btn2 : function(index, layero) {// 确定按钮回调
					layer.close(index);
				}
			});
		}
	});
}

function deleteSystemDict(propName) {

	layer.confirm('删除该数据源？（删除后不可恢复）', {
		icon : 3,
		btn : [ '是', '否' ]
	// 按钮
	}, function(index, layero) {
		$.ajax({
			"url" : webpath + "/systemDict/remove",
			"type" : "POST",
			dataType : "json",
			data : {
				propName : propName
			},
			success : function(data) {
				layer.close(index);
				reloadTableData(true);
			}
		});
	});
}

// 重置查询条件
function resetForm() {
	form.clear($("#systemDictSearchForm"));
}
