var uploader;
var isDestoryOnce = false;// 判断是否销毁过一次
var isHasUploaded = false;// 文件是否已经上传成功
$(document).ready(function() {
	initeventTable();
	$("#searchBtn").bind("click", reloadTableData);
	$("#resetBtn").bind("click", resetForm);
	$("#addBtn").bind("click", addEvent);

	// 为datatable外的父级设置高度
	$('#eventTable_wrapper').css('height', $('.panel-body').height() - 60);

	// 动态为表格添加父级
	$('#eventTable').wrap('<div class="tab-wrapper"></div>');
	$('.tab-wrapper').css('height', $('#eventTable_wrapper').height() - 63);
	$('.tab-wrapper').niceScroll({
		cursorcolor : "#ccc",
		horizrailenabled : false
	});
});

//
function initeventTable() {
	$("#eventTable").width("100%").dataTable({
		"bAutoWidth" : false,
		"columns" : [ {
			"data" : null,
			"targets" : 0
		}, {
			"data" : "eventCnName"
		}, {
			"data" : "eventType"
		}, {
			"data" : "hostIp"
		}, {
			"data" : "createTime"
		} ],
		ajax : {
			url : webpath + '/event/storm/list',
			"type" : 'POST',
			"data" : function(d) {// 查询参数
				return $.extend({}, d, {
					"jsonStr" : form.serializeStr($("#searchForm"))
				});
			},
			"dataSrc" : function(json) {
				json.iTotalRecords = json.total;
				json.iTotalDisplayRecords = json.total;
				return json.data;
			}
		},
		columnDefs : [ {
			"targets" : 1,// 操作按钮目标列
			"data" : null,
			"render" : function(data, type, row) {
				var id = row.id;
				var eventType = row.eventType;
				if (eventType == "external") {
					return html = data;
				} else {
					return html = '<a href="javascript:void(0);" onclick="processEvent(\'' + id + '\')"><i class="iconfont i-btn"></i>' + data + '</a>';
				}
			}
		}, {
			"targets" : 2,// 操作按钮目标列
			"data" : null,
			"render" : function(data, type, row) {
				var html = '';
				if (data == "external") {
					html += '<span>外部事件</span>';
				} else if (data == "trident") {
					html += '<span>trident事件</span>';
				}
				return html;
			}
		}, {
			"targets" : 5,// 操作按钮目标列
			"data" : null,
			"render" : function(data, type, row) {
				var id = row.id;
				var html = '<a href="javascript:void(0);" onclick="gencode(\'' + id + '\')" class="icon-wrap" title="生成代码"><i class="iconfont i-btn">&#xe7a1;</i></a>';
				html += '&nbsp;&nbsp;';
				html += '<a href="javascript:void(0);" onclick="publish(\'' + id + '\')" class="icon-wrap" title="发布"><i class="iconfont i-btn">&#xe679;</i></a>';
				html += '&nbsp;&nbsp;';
				html += '<a href="javascript:void(0);" onclick="run(\'' + id + '\')" class="icon-wrap" title="运行"><i class="iconfont i-btn">&#xe607;</i></a>';
				html += '&nbsp;&nbsp;';
				html += '<a href="javascript:void(0);" onclick="edit(\'' + id + '\')" class="icon-wrap" title="编辑"><i class="iconfont i-btn">&#xe66f;</i></a>';
				html += '&nbsp;&nbsp;';
				html += '<a href="javascript:void(0);" onclick="remove(\'' + id + '\')" class="icon-wrap" title="删除"><i class="iconfont i-btn">&#xe614;</i></a>';
				return html;
			}
		} ],
		"fnDrawCallback" : function() {
			var api = this.api();
			var startIndex = api.context[0]._iDisplayStart; // 获取到本页开始的条数
			api.column(0).nodes().each(function(cell, i) {
				cell.innerHTML = startIndex + i + 1;
			});
		}
	});
}

// 刷新数据 true 整个刷新 false 保留当前页刷新
function reloadTableData(isCurrentPage) {
	$("#eventTable").dataTable().fnDraw(isCurrentPage == null ? true : isCurrentPage);
}

function addEvent() {
	$('#thelist').empty();
	$('#thelistUpdate').empty();
	$("#add").find("textarea[name='executeDef']").val("");
	isHasUploaded = false;
	var formObj = $("#addForm");
	form.clear(formObj);
	form.cleanValidator(formObj);
	$("#add").find("input[name='publishJar']").parent().parent().hide();
	$("#add").find("input[name='publishJar']").attr("disabled", true);
	$(".externalFileClassAdd").hide();
	// 获得master主机
	$.ajax({
		url : webpath + "/hostStorm/getNimbus",
		type : "POST",
		dataType : "json",
		success : function(data) {
			$("select[name='submitHostId']").empty();
			var html = "";
			$("select[name='submitHostId']").append(html);
			data.forEach(function(value, index, array) {
				$("select[name='submitHostId']").append("<option value ='" + value.id + "'>" + value.hostIp + "</option>");
			});
		}
	});
	$("#add").find("input[name='eventType']").unbind("click").click(function(obj) {
		if ($(this).val() == 'external') {
			if ((uploader !== undefined) && !isDestoryOnce) {
				uploader.destroy();
				isDestoryOnce = true;
			}

			if ((uploader === undefined) || isDestoryOnce) {
				isDestoryOnce = false;
				$("#add").find("input[name='publishJar']").parent().parent().show();
				$("#add").find("input[name='publishJar']").attr("disabled", false);
				$("#add").find("input[name='publishJar']").val("");
				$(".externalFileClassAdd").show();
				$("#add").find("#isExistFileNo").show();
				$("#add").find("#isExistFileYes").hide();
				uploader = initUploader("Add");
			}
			$("#add").find("#fileDown").unbind("click").click(function() {
				var jarPath = $("#filePathAdd").val();
				window.location.href = webpath + '/file/download?filePathEncode=' + jarPath.replace(/\+/g, '%2B');
			});
			$("#add").find("#fileDelete").unbind("click").click(function() {
				layer.confirm('确认删除该事件jar包？', {
					icon : 3,
					btn : [ '是', '否' ]
				}, function(index, layero) {
					var jarPath = $("#filePathAdd").val();
					$.ajax({
						"url" : webpath + "/file/delete",
						"type" : "POST",
						dataType : "json",
						data : {
							filePath : $("#filePathAdd").val()
						},
						success : function(data) {
							layer.close(index);
							$("#add").find("input[name='publishJar']").val("");
							if ((uploader !== undefined) && !isDestoryOnce) {
								uploader.destroy();
								isDestoryOnce = true;
							}
							if ((uploader === undefined) || isDestoryOnce) {
								isDestoryOnce = false;
								$("#add").find("#isExistFileNo").show();
								$("#add").find("#isExistFileYes").hide();
								uploader = initUploader("Add");
							}
							isHasUploaded = false;
						}
					});
				});

			});
		} else {
			$(".externalFileClassAdd").hide();
			$("#add").find("input[name='publishJar']").parent().parent().hide();
			$("#add").find("input[name='publishJar']").attr("disabled", true);
		}
	});
	$("#ctlBtn").on('click', function() {
		if ($("#thelist").text().length > 0) {
			uploader.upload();
		} else {
			layer.msg('请选择文件', {
				time : 2000,
				icon : 6
			});
		}
	});
	layer.open({
		type : 1,
		title : '<i class="iconfont">&#xe641;</i>&nbsp;新建事件',
		area : [ '800px', '550px' ],
		closeBtn : 0,// 不显示关闭
		content : $("#add"),
		btn : [ '确定', '取消' ],
		btn1 : function(index, layero) {// 确定按钮回调
			if ($("#add").find("input[name='eventType']:checked").val() != 'external') {
				// 不是外部事件，jarPath与publishJarPath置空
				$("#filePathAdd").val("");
			}

			if (form.isValidator(formObj)) {
				$.ajax({
					url : webpath + "/event/storm/add",
					type : "POST",
					dataType : "json",
					data : {
						eventStormJson : form.serializeStr(formObj),
						executeDef : $("#add").find("textarea[name='executeDef']").val()
					},
					success : function(data) {
						if (data == true) {
							layer.close(index);
							reloadTableData(true);
						} else {
							layer.msg('添加失败', {
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
			if (isHasUploaded) {// 说明已经上传了文件，但没有添加数据，需要将文件删除
				$.ajax({
					url : webpath + '/file/delete',
					type : 'POST',
					data : {
						filePath : $("#filePathAdd").val()
					},
					success : function(data) {
					}
				});
			}
		},
		end : function() {// 关闭回调函数，无论确定、取消、叉都执行
		},
		success : function() {
		}
	});
}
// 修改数据
function edit(id) {
	$('#thelist').empty();
	$('#thelistUpdate').empty();
	if ($("#edit").find("textarea[name='executeDef']").val().length > 0) {
		$("#edit").find("textarea[name='executeDef']").val("");
	}
	isHasUploaded = false;
	$.ajax({
		"url" : webpath + "/event/storm/load",
		"type" : "POST",
		dataType : "json",
		data : {
			id : id,
		},
		success : function(data) {
			var formObj = $("#editForm");
			form.clear(formObj);
			form.cleanValidator(formObj);
			// 获得master主机,先获取再加载数据
			$.ajax({
				url : webpath + "/hostStorm/getNimbus",
				type : "POST",
				dataType : "json",
				async : false,
				success : function(data) {
					$("select[name='submitHostId']").empty();
					var html = "";
					$("select[name='submitHostId']").append(html);
					data.forEach(function(value, index, array) {
						$("select[name='submitHostId']").append("<option value ='" + value.id + "'>" + value.hostIp + "</option>");
					});
				}
			});

			$("#edit").find("input[name='publishJar']").parent().parent().hide();
			$("#edit").find("input[name='publishJar']").attr("disabled", true);
			$(".externalFileClassUpdate").hide();

			form.load(formObj, data);
			// 加载运行参数
			if (data.executeDef != null) {
				$("#edit").find("textarea[name='executeDef']").val(data.executeDef);
			}

			if ($("#edit").find("input[name='eventType']:checked").val() == 'external') {
				$("#edit").find("input[name='publishJar']").parent().parent().show();
				$("#edit").find("input[name='publishJar']").attr("disabled", false);
				$(".externalFileClassUpdate").show();
				var jarPath = $("#filePathUpdate").val();
				if (jarPath.length > 0) {// 说明有上传的文件
					isHasUploaded = true;
					$.ajax({
						url : webpath + "/file/decodeJarPath",
						type : "POST",
						data : {
							"jarPath" : jarPath
						},
						dataType : "json",
						async : false,
						success : function(data) {
							$("#isExistFileYes").find("span").remove();
							$("#edit").find("input[name='publishJar']").val(data);
						}
					});
					$("#edit").find("#isExistFileNo").hide();
					$("#edit").find("#isExistFileYes").show();
					// 从tomcat所在的服务器上下载文件
					$("#edit").find("#fileDown").unbind("click").click(function() {
						var $jarPath = $("#filePathUpdate").val();
						window.location.href = webpath + '/file/download?filePathEncode=' + $jarPath.replace(/\+/g, '%2B');
					});
					$("#edit").find("#fileDelete").unbind("click").click(function() {
						layer.confirm('确认删除该事件jar包？', {
							icon : 3,
							btn : [ '是', '否' ]
						// 按钮
						}, function(index, layero) {
							$.ajax({
								"url" : webpath + "/file/delete",
								"type" : "POST",
								dataType : "json",
								data : {
									filePath : $("#filePathUpdate").val()
								},
								success : function(data) {
									layer.close(index);
									$("#edit").find("input[name='publishJar']").val("")
									$("#filePathUpdate").val("");
									$.ajax({// 文件删除更新数据库
										"url" : webpath + "/event/storm/editPath",
										"type" : "POST",
										dataType : "json",
										data : {
											id : id,
											uploadJarPath : ''
										},
										success : function(data) {
											if ((uploader !== undefined) && !isDestoryOnce) {
												uploader.destroy();
												isDestoryOnce = true;
											}
											if ((uploader === undefined) || isDestoryOnce) {
												isDestoryOnce = false;
												$("#edit").find("#isExistFileNo").show();
												$("#edit").find("#isExistFileYes").hide();
												uploader = initUploader("Update");
											}
											isHasUploaded = false;
										}
									});
								}
							});
						});
					});
				} else {
					if ((uploader !== undefined) && !isDestoryOnce) {
						uploader.destroy();
						isDestoryOnce = true;
					}
					if ((uploader === undefined) || isDestoryOnce) {
						isDestoryOnce = false;
						$("#edit").find("#isExistFileNo").show();
						$("#edit").find("#isExistFileYes").hide();
						uploader = initUploader("Update");
					}
				}

			} else {
				$("input[name='publishJar']").parent().parent().hide();
				$("input[name='publishJar']").attr("disabled", true);
				$(".externalFileClassUpdate").hide();
			}
			$("#ctlBtnUpdate").on('click', function() {
				if ($("#thelistUpdate").text().length > 0) {
					uploader.upload();
				} else {
					layer.msg('请选择文件', {
						time : 2000,
						icon : 6
					});
				}
			});
			layer.open({
				type : 1,
				title : '<i class="iconfont">&#xe633;</i>&nbsp;修改事件信息',
				area : [ '800px', '520px' ],
				closeBtn : 0,// 不显示关闭
				content : $("#edit"),
				btn : [ '确定', '取消' ],
				btn1 : function(index, layero) {// 确定按钮回调
					if (form.isValidator(formObj)) {
						if ((!$("#edit").find("input[name='publishJar']").val().length > 0) && ($("#edit").find("input[name='eventType']:checked").val() == 'external')) {// 没有上传的文件
							layer.open({
								title : '<i class="iconfont">&#xe649;</i>&nbsp;提示',
								content : "当前事件没有jar包"
							});
						}
						// 都会更新数据库
						$.ajax({
							"url" : webpath + "/event/storm/edit",
							"type" : "POST",
							dataType : "json",
							data : {
								eventStormJson : form.serializeStr(formObj),
								executeDef : $("#edit").find("textarea[name='executeDef']").val()
							},
							success : function(data) {
								if (data) {
									layer.close(index);
									reloadTableData(true);
									layer.msg('操作成功', {
										time : 3000,
										icon : 1
									});
								} else {
									layer.msg('操作失败', {
										time : 3000,
										icon : 2
									});
								}
							}
						});
					}
				},
				btn2 : function(index, layero) {// 确定按钮回调
					if ((!$("#edit").find("input[name='publishJar']").val().length > 0) && ($("#edit").find("input[name='eventType']:checked").val() == 'external')) {// 没有上传的文件
						layer.open({
							title : '<i class="iconfont">&#xe649;</i>&nbsp;提示',
							content : "当前事件没有jar包"
						});
					}
					layer.close(index);
				}
			});
		}
	});
	isDestoryOnce = false;
}

// 删除数据
function remove(id) {
	layer.confirm('确认删除该事件？', {
		icon : 3,
		btn : [ '是', '否' ]
	// 按钮
	}, function(index, layero) {
		$.ajax({// 初始化组织机构树
			"url" : webpath + "/event/storm/remove",
			"type" : "POST",
			dataType : "json",
			data : {
				id : id
			},
			success : function(data) {
				if (data) {
					reloadTableData(true);
					layer.msg("操作成功", {
						time : 3000,
						icon : 1
					});
				} else {
					layer.msg("操作失败", {
						time : 3000,
						icon : 2
					});
				}
			}
		});
	});
}
// 生成代码
function gencode(id) {
	$.ajax({
		"url" : webpath + "/event/storm/load",
		"type" : "POST",
		dataType : "json",
		data : {
			id : id
		},
		success : function(data) {
			if (data.eventType == "external") {
				layer.msg('外部事件不需要生成代码', {
					time : 3000,
					icon : 6
				});
			} else {
				if (data.hasGeneratorCode == '00') {
					layer.confirm('是否重新生成代码？', {
						icon : 3,
						btn : [ '是', '否' ]
					}, function(index, layero) {
						code(id);
					});
				} else {
					code(id);
				}
			}
		}
	})
}

// 调用生成代码方法
function code(id) {
	$.ajax({
		"url" : webpath + "/event/storm/gencode",
		"type" : "POST",
		dataType : "json",
		data : {
			id : id
		},
		success : function(ret) {
			if (ret.successful) {
				layer.msg(ret.msg, {
					time : 3000,
					icon : 1
				});
			} else {
				layer.msg(ret.msg, {
					time : 3000,
					icon : 2
				});
			}
		}
	});
}

// 运行
function run(id) {
	$.ajax({
		"url" : webpath + "/event/storm/load",
		"type" : "POST",
		dataType : "json",
		data : {
			id : id
		},
		success : function(data) {
			$.ajax({
				"url" : webpath + "/event/storm/run",
				"type" : "POST",
				dataType : "json",
				data : {
					id : id
				},
				success : function(ret) {
					if (ret.successful) {
						layer.msg(ret.msg, {
							time : 3000,
							icon : 1
						});
					} else {
						layer.msg(ret.msg, {
							time : 3000,
							icon : 2
						});
					}
				}
			});
			// }
		}
	});
}

// 发布
function publish(id) {
	// 自定义事件及外部事件都需要发布
	$.ajax({
		"url" : webpath + "/event/storm/publish",
		"type" : "POST",
		dataType : "json",
		data : {
			id : id
		},
		success : function(data) {
			if (data) {
				layer.msg('操作成功', {
					time : 3000,
					icon : 1
				});
			} else {
				layer.msg('操作失败', {
					time : 3000,
					icon : 2
				});
			}
		}
	});
}

// 点击事件名称，跳转到事件处理界面
function processEvent(id) {
	window.location.href = webpath + "/event/storm/process?id=" + id;
}

// 重置查询条件
function resetForm() {
	form.clear($("#searchForm"));
}
