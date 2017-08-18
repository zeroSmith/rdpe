$(document).ready(function() {
	initHostTable();
	$("#searchBtn").bind("click", reloadTableData);
	$("#resetBtn").bind("click", resetForm);
	$("#addBtn").bind("click", addHost);

	// 为datatable外的父级设置高度
	$('#hostTable_wrapper').css('height', $('.panel-body').height() - 60);

	// 动态为表格添加父级
	$('#hostTable').wrap('<div class="tab-wrapper"></div>');
	$('.tab-wrapper').css('height', $('#hostTable_wrapper').height() - 63);
	$('.tab-wrapper').niceScroll({
		cursorcolor : "#ccc",
		horizrailenabled : false
	});
});

// 初始化storm主机列表表格
function initHostTable() {
	$("#hostTable")
			.width("100%")
			.dataTable(
					{
						"pageLength" : 7,
						"bAutoWidth": false,
						"columns" : [ { "data":null,"targets":0 },
							{"data" : "hostIp"}, 
							{"data" : "hostName"}, 
							{"data" : "sparkVersion"}
						],
						ajax : {
							url : webpath + '/hostSpark/list',
							"type" : 'POST',
							"data" : function(d) {// 查询参数
								return $.extend( {}, d, {
									"jsonStr" : form
											.serializeStr($("#searchForm"))
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
								var html = '<a href="javascript:void(0);" onclick="updateHost(\''
										+ id
										+ '\')" class="icon-wrap" title="编辑"><i class="iconfont i-btn">&#xe66f;</i></a>';
								html += '&nbsp;&nbsp;';
								html += '<a href="javascript:void(0);" onclick="deleteHost(\''
										+ id
										+ '\')" class="icon-wrap" title="删除"><i class="iconfont i-btn">&#xe614;</i></a>';
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
	$("#hostTable").dataTable().fnDraw(
			isCurrentPage == null ? true : isCurrentPage);
}

function addHost() {
	var formObj = $("#addSparkHostForm");
	form.clear(formObj);
	form.cleanValidator(formObj);
	layer.open({
		type : 1,
		title : '<i class="iconfont">&#xe641;</i>&nbsp;新建主机',
		area : [ '550px', '340px' ],
		content : $("#addSparkHost"),
		btn : [ '确定', '取消' ],
		btn1 : function(index, layero) {// 确定按钮回调
			if (form.isValidator(formObj)) {
				$.ajax({
					url : webpath + "/hostSpark/addSpark",
					type : "POST",
					dataType : "json",
					data : form.serializeJson(formObj),
					success : function(data) {
						if(data==true){
							layer.close(index);
							reloadTableData(true);
						}else{
							layer.msg('添加失败', {time: 2000, icon:6});
						}
					}
				});
			}
		},
		btn2 : function(index, layero) {// 确定按钮回调
			layer.close(index);
		},
		end : function() {// 关闭回调函数，无论确定、取消、叉都执行
		}
	});
}

// 修改数据
function updateHost(id) {
	$.ajax({
		"url" : webpath + "/hostSpark/load",
		"type" : "POST",
		dataType : "json",
		data : {
			id : id,
		},
		success : function(data) {
			var formObj = $("#editSparkHostForm");
			form.clear(formObj);
			form.cleanValidator(formObj);
			form.load(formObj, data);
			layer.open({
				type : 1,
				title : '<i class="iconfont">&#xe633;</i>&nbsp;修改主机信息',
				area : [ '550px', '340px' ],
				content : $("#editSparkHost"),
				btn : [ '确定', '取消' ],
				btn1 : function(index, layero) {// 确定按钮回调
					if (form.isValidator(formObj)) {
						$.ajax({
							"url" : webpath + "/hostSpark/editSpark",
							"type" : "POST",
							dataType : "json",
							data : form.serializeJson(formObj),
							success : function(data) {
								if(data==true){
									layer.close(index);
									reloadTableData(true);
								}
								if(data == false){
									layer.msg('删除失败', {time: 2000, icon:6});
								}
								if(data == 'NoAuthority'){
									layer.msg('您没有编辑此主机的权限！', {time: 2000, icon:6});
								}
							}
						});
					}
				},
				btn2 : function(index, layero) {// 确定按钮回调
					layer.close(index);
				},
				end : function() {
				}
			});
		}
	});
}

// 删除数据
function deleteHost(id) {
	layer.confirm('确认删除该主机？', {
		icon : 3,
		btn : [ '是', '否' ]
	// 按钮
	}, function(index, layero) {
		$.ajax({// 初始化组织机构树
			"url" : webpath + "/hostSpark/remove",
			"type" : "POST",
			dataType : "json",
			data : {
				id : id
			},
			success : function(data) {
				if(data==true){
					layer.close(index);
					reloadTableData(true);
				}
				if(data == false){
					layer.msg('删除失败', {time: 2000, icon:6});
				}
				if(data == 'NoAuthority'){
					layer.msg('您没有删除此主机的权限！', {time: 2000, icon:6});
				}
			}
		});
	});
}

// 重置查询条件
function resetForm() {
	form.clear($("#searchForm"));
}