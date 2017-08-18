$(document).ready(function() {
	initKafkaTable();
	$("#searchBtn").bind("click", reloadTableData);
	$("#resetBtn").bind("click", resetForm);
	$("#addKafkaBtn").bind("click", addKafka);
	// 为datatable外的父级设置高度
	$('#kafkaTable_wrapper').css('height', $('.panel-body').height() - 60);
	// 动态为表格添加父级
	$('#kafkaTable').wrap('<div class="tab-wrapper"></div>');
	$('.tab-wrapper').css('height', $('#kafkaTable_wrapper').height() - 63);
	$('.tab-wrapper').niceScroll({
		cursorcolor : "#ccc",
		horizrailenabled : false
	});
});

// 初始化用户列表表格
function initKafkaTable() {
	$("#kafkaTable").width("100%").dataTable({
						"pageLength" : 7,
						"bAutoWidth": false,
						"columns" : [ 
						{"data" : null,"targets":0 
						}, {
							"data" : "dsName"
						}, {
							"data" : "topicName"
						}, {
							"data" : "createTime"
						} ],
						ajax : {
							url : webpath + '/dskafka/list',
							"type" : 'POST',
							"data" : function(d) {// 查询参数
								return $.extend({}, d, {
									"jsonStr" : form
											.serializeStr($("#SearchForm"))
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
								var id = row.id;
								var html = '<a href="javascript:void(0);" onclick="updateKafka(\''
										+ id
										+ '\')" class="icon-wrap" title="编辑"><i class="iconfont i-btn">&#xe66f;</i></a>';
								html += '&nbsp;&nbsp;';
								html += '<a href="javascript:void(0);" onclick="deleteKafka(\''
										+ id
										+ '\')" class="icon-wrap" title="删除"><i class="iconfont i-btn">&#xe614;</i></a>';
								html += '&nbsp;&nbsp;';
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
	$("#kafkaTable").dataTable().fnDraw(
			isCurrentPage == null ? true : isCurrentPage);
}

// 新增用户
function addKafka() {
	var formObj = $("#addKafkaForm");
	form.clear(formObj);
	form.cleanValidator(formObj);
	layer.open({
		type : 1,
		title : '<i class="iconfont">&#xe641;</i>&nbsp;新增kakfa数据源',
		area : [ '500px', '340px' ],
		content : $("#addKafka"),// 弹出框div
		btn : [ '确定', '取消' ],
		btn1 : function(index, layero) {// 确定按钮回调
			if (form.isValidator(formObj)) {
				$.ajax({
					"url" : webpath + "/dskafka/add",
					"type" : "POST",
					dataType : "json",
					data : form.serializeJson(formObj),
					success : function(data) {
						if (data == true) {
							layer.close(index);
							reloadTableData(true);
							layer.msg('操作成功', {
								time : 2000,
								icon : 6
							});
						} else {
							layer.msg('操作失败', {
								time : 2000,
								icon : 6
							});
						}

					}
				});
			}
		},
		btn2 : function(index, layero) {// 确定按钮回调
			layer.close(index);
		}
	});
}

// 修改数据
function updateKafka(dsKafkaId) {
	$.ajax({
		"url" : webpath + "/dskafka/load",
		"type" : "POST",
		dataType : "json",
		data : {
			dsKafkaId : dsKafkaId
		},
		success : function(data) {
			var formObj = $("#updateKafkaForm");
			console.log(data);
			form.clear(formObj);
			form.cleanValidator(formObj);
			form.load(formObj, data);
			layer.open({
				type : 1,
				title : '<i class="iconfont">&#xe633;</i>&nbsp;修改Kafka数据源',
				area : [ '500px', '340px' ],
				content : $("#updateKafka"),
				btn : [ '确定', '取消' ],
				btn1 : function(index, layero) {// 确定按钮回调
					if (form.isValidator(formObj)) {
						$.ajax({
							"url" : webpath + "/dskafka/edit",
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

// 删除数据
function deleteKafka(dsKafkaId) {
	layer.confirm('删除该数据源？（删除后不可恢复）', {
		icon : 3,
		btn : [ '是', '否' ]
	// 按钮
	}, function(index, layero) {
		$.ajax({
			"url" : webpath + "/dskafka/remove",
			"type" : "POST",
			dataType : "json",
			data : {
				dsKafkaId : dsKafkaId
			},
			success : function(data) {
				layer.close(index);
				reloadTableData(true);
			}
		})
	});
}
// 重置查询条件
function resetForm() {
	form.clear($("#SearchForm"));
}