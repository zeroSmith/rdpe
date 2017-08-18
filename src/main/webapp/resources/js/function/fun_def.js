var uploader;
var isDestoryOnce = false;// 判断是否销毁过一次
var isHasUploaded = false;// 文件是否已经上传成功
$(document).ready(
		function() {
			$("#function-panel").find(".panel-body").niceScroll({
				cursorcolor : "#ccc",
				horizrailenabled : false
			});
			$("#function-panel").find(".icon-tip").bind({// 绑定提示信息
				/*mouseenter : function(e) {
					// Hover event handler
					this.index = layer.tips("在函数节点右键任意添加函数", this, {
						tips : [ 2, '#f8e3d1' ],
						time : 3000
					});
				},*/
				click : function(e) {
					var nodes = resource.treeObj.getSelectedNodes();// 获取 zTree
																	// 当前被选中的节点数据集合,返回值(Array(JSON))
					if (nodes.length > 0) {
						resource.treeObj.cancelSelectedNode(nodes[0]);// 取消当前第一个被选中节点的选中状态
					}
					$(".bootstrapMenu").hide();
					$("#blankContextMenu").css("left", e.clientX);
					$("#blankContextMenu").css("top", e.clientY);
					$("#blankContextMenu").show();
					return false;
				}
			});
			// 绑定右键事件
			$("#function-panel").find(".panel-body").bind({
				contextmenu : function(e) {
					var nodes = resource.treeObj.getSelectedNodes();// 获取 zTree
																	// 当前被选中的节点数据集合,返回值(Array(JSON))
					if (nodes.length > 0) {
						resource.treeObj.cancelSelectedNode(nodes[0]);// 取消当前第一个被选中节点的选中状态
					}
					$(".bootstrapMenu").hide();
					$("#blankContextMenu").css("left", e.clientX);
					$("#blankContextMenu").css("top", e.clientY);
					$("#blankContextMenu").show();
					return false;
				}
			});
			// 取消菜单事件
			$("body").bind({
				click : function(e) {
					$(".bootstrapMenu").hide();
				}
			});
			// 添加文件夹事件
			$(".addFolder").bind({
				click : function() {
					var funTypeId = "0", parentId = "ROOT";
					var formObj = $("#addFolderForm");
					form.clear(formObj);
					form.cleanValidator(formObj);
					var nodes = resource.treeObj.getSelectedNodes();// 获取 zTree
																	// 当前被选中的节点数据集合,返回值(Array(JSON))
					if (nodes.length > 0) {
						var node = nodes[0];
						formObj.find('input[name="parentId"]').val(node.id);
						formObj.find('input[name="path"]').val(node.path);
					} else {
						formObj.find('input[name="parentId"]').val(parentId);
					}
					formObj.find('input[name="funTypeId"]').val(funTypeId);
					layer.open({
						type : 1,
						title : '<i class="iconfont">&#xe641;</i>&nbsp;新增文件夹',
						area : [ '330px', '220px' ],
						content : $("#addFolder"),
						btn : [ '确定', '取消' ],
						btn1 : function(index, layero) {// 确定按钮回调
							// 处理解析&时不好用的问题
							var newData = form.serializeJson(formObj);
							if (form.isValidator(formObj)) {
								$.ajax({
									"url" : webpath + "/funDef/add",
									"type" : "POST",
									dataType : "json",
									data : newData,
									success : function(data) {
										if (data) {
											layer.msg('添加成功！', {
												time : 1000,
												icon : 1
											});
										} else {
											layer.msg('添加失败！', {
												time : 1000,
												icon : 2
											});
										}
										layer.close(index);
										resource.initTree();// 初始化zTree树
									},
									error : function(error) {
										layer.open({
											title : '<i class="iconfont">&#xe649;</i>&nbsp;提示',
											content : "出错了！！:" + error
										});
									}
								});
							}
						},
						btn2 : function(index, layero) {// 取消按钮回调
							layer.close(index);
						},
						cancel : function(index) {
							return true;
						}
					});
				}
			});

			// 修改文件夹事件
			$(".editFolder").bind({
				click : function() {
					var formObj = $("#updateFolderForm");
					form.clear(formObj);
					form.cleanValidator(formObj);
					var nodes = resource.treeObj.getSelectedNodes();// 获取 zTree
																	// 当前被选中的节点数据集合,返回值(Array(JSON))
					if (nodes.length == 0)
						return;
					var node = nodes[0];
					form.load(formObj, node);
					if (node.funTypeId == "0") {
					}
					if (node.parentId == null) {
						formObj.find('input[name="parentId"]').val('ROOT');
					} else {
						formObj.find('input[name="parentId"]').val(node.parentId);
					}
					layer.open({
						type : 1,
						title : '<i class="iconfont">&#xe631;</i>&nbsp;修改文件夹',
						area : [ '330px', '220px' ],
						content : $("#updateFolder"),
						btn : [ '确定', '取消' ],
						btn1 : function(index, layero) {// 确定按钮回调
							// 处理解析&时不好用的问题
							var newData = form.serializeJson(formObj);
							if (form.isValidator(formObj)) {
								$.ajax({
									"url" : webpath + "/funDef/edit",
									"type" : "POST",
									dataType : "json",
									data : newData,
									success : function(data) {
										if (data) {
											layer.msg('修改成功！', {
												time : 3000,
												icon : 1
											});
										} else {
											layer.msg('修改失败！', {
												time : 3000,
												icon : 2
											});
										}
										layer.close(index);
										resource.initTree();
									},
									error : function(error) {
										layer.open({
											title : '<i class="iconfont">&#xe649;</i>&nbsp;提示',
											content : "出错了！！:" + error
										});
									}

								});
							}
						},
						btn2 : function(index, layero) {// 取消按钮回调
							layer.close(index);
						}
					});
				}
			});

			// 删除事件--文件夹、方法
			$(".removeFolder,.removeClass,.removeMethod").bind({
				click : function() {
					var nodes = resource.treeObj.getSelectedNodes();// 获取 zTree
																	// 当前被选中的节点数据集合,返回值(Array(JSON))
					if (nodes.length == 0)
						return;
					var node = nodes[0];
					layer.confirm('删除该文件？（删除后不可恢复）', {
						icon : 3,
						btn : [ '是', '否' ]
					// 按钮
					}, function(index, layero) {
						$.ajax({
							"url" : webpath + "/funDef/remove",
							"type" : "POST",
							dataType : "json",
							data : {
								id : node.id
							},
							success : function(data) {
								if (data=="true") {
									layer.msg('删除成功！', {
										time : 3000,
										icon : 1
									});
								} else if(data == "false") {
									layer.msg('删除失败！', {
										time : 3000,
										icon : 2
									});
								} else{
									layer.msg(data, {
										time : 3000,
										icon : 2
									});
								}
								layer.close(index);
								resource.initTree();// 初始化zTree树
							},
							error : function(error) {
								layer.open({
									title : '<i class="iconfont">&#xe649;</i>&nbsp;提示',
									content : "出错了！！:" + error
								});
							}
						});
					});
				}
			});

			// 删除事件--类
			$(".removeClass").bind({
				click : function() {
					var nodes = resource.treeObj.getSelectedNodes();// 获取 zTree
																	// 当前被选中的节点数据集合,返回值(Array(JSON))
					if (nodes.length == 0)
						return;
					var node = nodes[0];
					layer.confirm('删除该文件？（删除后不可恢复）', {
						icon : 3,
						btn : [ '是', '否' ]
					// 按钮
					}, function(index, layero) {
						var hasChildren=false;
						$.ajax({
							"url" : webpath + "/funDef/getChildren",
							"type" : "POST",
							dataType : "json",
							data : {
								id : node.id
							},
	           				 async: false,
	           				 success:function(data){
	           					hasChildren = data;
	           				 },
	           				 error : function(error) {
	           					 layer.open({
	           						 title:'<i class="iconfont">&#xe649;</i>&nbsp;提示',
	           						 content: "出错了！！:" + error
	           					 });
	           				 }
           			 	});
						if(hasChildren){
							layer.confirm('当前类节点下有方法节点，确定删除？（删除后不可恢复）', {
								icon : 3,
								btn : [ '是', '否' ]
							// 按钮
							}, function(index, layero) {
								$.ajax({
									"url" : webpath + "/funDef/remove",
									"type" : "POST",
									dataType : "json",
									data : {
										id : node.id
									},
									success : function(data) {
										if (data=="true") {
											layer.msg('删除成功！', {
												time : 3000,
												icon : 1
											});
										} else if(data == "false") {
											layer.msg('删除失败！', {
												time : 3000,
												icon : 2
											});
										} else{
											layer.msg(data, {
												time : 3000,
												icon : 2
											});
										}
										layer.close(index);
										resource.initTree();// 初始化zTree树
									},
									error : function(error) {
										layer.open({
											title : '<i class="iconfont">&#xe649;</i>&nbsp;提示',
											content : "出错了！！:" + error
										});
									}
								});
							});
						}else{
							$.ajax({
								"url" : webpath + "/funDef/remove",
								"type" : "POST",
								dataType : "json",
								data : {
									id : node.id
								},
								success : function(data) {
									if (data=="true") {
										layer.msg('删除成功！', {
											time : 3000,
											icon : 1
										});
									} else if(data == "false") {
										layer.msg('删除失败！', {
											time : 3000,
											icon : 2
										});
									} else{
										layer.msg(data, {
											time : 3000,
											icon : 2
										});
									}
									layer.close(index);
									resource.initTree();// 初始化zTree树
								},
								error : function(error) {
									layer.open({
										title : '<i class="iconfont">&#xe649;</i>&nbsp;提示',
										content : "出错了！！:" + error
									});
								}
							});
						}
					});
				}
			});
			
			// 添加类的事件
			$(".addClass").bind({
				click : function() {
					var funTypeId = "1", parentId = "ROOT";
					var formObj = $("#addClassForm");
					form.clear(formObj);
					form.cleanValidator(formObj);
					var nodes = resource.treeObj.getSelectedNodes();// 获取 zTree
																	// 当前被选中的节点数据集合,返回值(Array(JSON))
					if (nodes.length > 0) {
						var node = nodes[0];
						formObj.find('input[name="parentId"]').val(node.id);
						formObj.find('input[name="path"]').val(node.path);
					} else {
						formObj.find('input[name="parentId"]').val(parentId);
					}
					formObj.find('input[name="funTypeId"]').val(funTypeId);
					$("#thelist").empty();
					var isHasUploaded = false;
					if ((uploader !== undefined) && !isDestoryOnce) {
						uploader.destroy();
						isDestoryOnce = true;
					}
					if ((uploader === undefined) || isDestoryOnce) {
						isDestoryOnce = false;
						$("#addClass").find("#isExistFileNo").show();
						$("#addClass").find("#isExistFileYes").hide();
						uploader = initUploader("Add");
					}
					$("#addClass").find("#fileDown").unbind("click").click(function() {
						var storePath = $("#filePathAdd").val();
						window.location.href = webpath + '/file/download?filePathEncode=' + storePath.replace(/\+/g, '%2B');
					});
					$("#addClass").find("#fileDelete").unbind("click").click(function() {
						layer.confirm('确认删除该源文件？', {
							icon : 3,
							btn : [ '是', '否' ]
						}, function(index, layero) {
							$.ajax({
								"url" : webpath + "/funDef/deleteFile",
								"type" : "POST",
								dataType : "json",
								data : {
									"filePath" : $("#filePathAdd").val()
								},
								success : function(data) {
									if (data) {
										layer.msg('文件删除成功！', {
											time : 1000,
											icon : 1
										});
									} else {
										layer.msg('文件删除失败！', {
											time : 1000,
											icon : 2
										});
									}
									layer.close(index);
									$("#addClass").find("input[name='classPath']").val("")
									if ((uploader !== undefined) && !isDestoryOnce) {
										uploader.destroy();
										isDestoryOnce = true;
									}
									if ((uploader === undefined) || isDestoryOnce) {
										isDestoryOnce = false;
										$("#addClass").find("#isExistFileNo").show();
										$("#addClass").find("#isExistFileYes").hide();
										uploader = initUploader("Add");
									}
									isHasUploaded = false;
								},
								error : function(error) {
									layer.open({
										title : '<i class="iconfont">&#xe649;</i>&nbsp;提示',
										content : "出错了！！:" + error
									});
								}
							});
						});
					});
					$("#ctlBtn").on('click', function() {
						if ($("#thelist").text().length > 0) {
							var fileName = $("#thelist").text().split(".");
							var funName = formObj.find("[name='funName']").val();// 输入的类名
							var dataType = formObj.find("[name='dataType']").val();// 选择的处理数据类型
							if (isValidFile(fileName[0].trim(), funName)) {
								// if(isValidFile(fileName[1].trim(),codeType)){
								uploader.upload();
								isHasUploaded = true;
								// }else{
								// layer.msg('要求文件后缀与编码类型一致', {time: 2000,
								// icon:6});
								// }
							} else {
								layer.msg('要求文件名与类名一致', {
									time : 2000,
									icon : 5
								});
							}
						} else {
							layer.msg('请选择文件', {
								time : 2000,
								icon : 5
							});
						}
					});
					layer.open({
						type : 1,
						title : '<i class="iconfont">&#xe641;</i>&nbsp;新增类',
						area : [ '450px', '410px' ],
						content : $("#addClass"),
						btn : [ '确定', '取消' ],
						btn1 : function(index, layero) {// 确定按钮回调
							// 处理解析&时不好用的问题
							var newData = form.serializeJson(formObj);
							if (form.isValidator(formObj)) {
								$.ajax({
									"url" : webpath + "/funDef/add",
									"type" : "POST",
									dataType : "json",
									data : newData,
									success : function(data) {
										if (data) {
											layer.msg('添加成功！', {
												time : 1000,
												icon : 1
											});
										} else {
											layer.msg('添加失败！', {
												time : 1000,
												icon : 2
											});
										}
										layer.close(index);
										resource.initTree();// 初始化zTree树
									},
									error : function(error) {
										layer.open({
											title : '<i class="iconfont">&#xe649;</i>&nbsp;提示',
											content : "出错了！！:" + error
										});
									}
								});
							}
						},
						btn2 : function(index, layero) {// 取消按钮回调
							layer.close(index);
							if (isHasUploaded) {// 说明已经上传了文件，但没有添加数据，需要将文件删除
								$.ajax({
									url : webpath + '/funDef/deleteFile',
									type : 'POST',
									data : {
										filePath : $("#filePathAdd").val()
									},
									success : function(data) {
									},
									error : function(error) {
										layer.open({
											title : '<i class="iconfont">&#xe649;</i>&nbsp;提示',
											content : "出错了！！:" + error
										});
									}
								})
							}
						},
						end : function() {// 关闭回调函数，无论确定、取消、叉都执行
						},
						success : function() {
						}
					});
				}
			});

			// 修改类的事件
			$(".editClass").bind({
				click : function() {
					var formObj = $("#editClassForm");
					form.clear(formObj);
					form.cleanValidator(formObj);
					var nodes = resource.treeObj.getSelectedNodes();// 获取 zTree
																	// 当前被选中的节点数据集合,返回值(Array(JSON))
					if (nodes.length == 0)
						return;
					var node = nodes[0];
					form.load(formObj, node);
					if (node.funTypeId == "0") {
					}
					if (node.parentId == null) {
						formObj.find('input[name="parentId"]').val('ROOT');
					} else {
						formObj.find('input[name="parentId"]').val(node.parentId);
					}
					$('#thelistUpdate').empty();
					var isHasUploaded = false;
					var jarPath = formObj.find("#filePathUpdate").val();
					if (jarPath.length > 0) {// 说明有上传的文件
						$.ajax({
							url : webpath + "/file/decodeJarPath",
							type : "POST",
							data : {
								"jarPath" : jarPath
							},
							dataType : "json",
							async : false,
							success : function(data) {
								$("#editClass").find("input[name='classPath']").val(data);
							},
							error : function(error) {
								layer.open({
									title : '<i class="iconfont">&#xe649;</i>&nbsp;提示',
									content : "出错了！！:" + error
								});
							}
						});
						formObj.find("#isExistFileNoUpdate").hide();
						formObj.find("#isExistFileYesUpdate").show();
						formObj.find("#fileDownUpdate").unbind("click").click(function() {
							window.location.href = webpath + '/file/download?filePathEncode=' + jarPath.replace(/\+/g, '%2B');
						});
						formObj.find("#fileDeleteUpdate").unbind("click").click(function() {
							layer.confirm('确认删除该源文件？', {
								icon : 3,
								btn : [ '是', '否' ]
							// 按钮
							}, function(index, layero) {
								$.ajax({
									"url" : webpath + "/funDef/deleteFile",
									"type" : "POST",
									dataType : "json",
									data : {
										"filePath" : jarPath
									},
									success : function(data) {
										if (data) {
											layer.msg('文件删除成功！', {
												time : 1000,
												icon : 1
											});
										} else {
											layer.msg('文件删除失败！', {
												time : 1000,
												icon : 2
											});
										}
										layer.close(index);
										formObj.find("input[name='classPath']").val("");
										formObj.find("#filePathUpdate").val("");
										node.storePath = "";
										$.ajax({// 文件删除更新数据库
											"url" : webpath + "/funDef/edit",
											"type" : "POST",
											dataType : "json",
											data : form.serializeJson(formObj),
											success : function(data) {
												if (data) {
													layer.msg('修改成功！', {
														time : 1000,
														icon : 1
													});
												} else {
													layer.msg('修改失败！', {
														time : 1000,
														icon : 2
													});
												}
												if ((uploader !== undefined) && !isDestoryOnce) {
													uploader.destroy();
													isDestoryOnce = true;
												}
												if ((uploader === undefined) || isDestoryOnce) {
													isDestoryOnce = false;
													formObj.find("#isExistFileNoUpdate").show();
													formObj.find("#isExistFileYesUpdate").hide();
													uploader = initUploader("Update");
												}
											}
										});
									},
									error : function(error) {
										layer.open({
											title : '<i class="iconfont">&#xe649;</i>&nbsp;提示',
											content : "出错了！！:" + error
										});
									}
								});
							});
						});
					} else {// 没有上传文件
						if ((uploader !== undefined) && !isDestoryOnce) {
							uploader.destroy();
							isDestoryOnce = true;
						}
						if ((uploader === undefined) || isDestoryOnce) {
							isDestoryOnce = false;
							formObj.find("#isExistFileNoUpdate").show();
							formObj.find("#isExistFileYesUpdate").hide();
							uploader = initUploader("Update");
						}
						formObj.find("#fileDownUpdate").unbind("click").click(function() {
							var jarPath = formObj.find("#filePathUpdate").val();
							window.location.href = webpath + '/file/download?filePathEncode=' + jarPath.replace(/\+/g, '%2B');
						});
						formObj.find("#fileDeleteUpdate").unbind("click").click(function() {
							layer.confirm('确认删除该源文件？', {
								icon : 3,
								btn : [ '是', '否' ]
							// 按钮
							}, function(index, layero) {
								$.ajax({
									"url" : webpath + "/funDef/deleteFile",
									"type" : "POST",
									dataType : "json",
									data : {
										"filePath" : $("#filePathUpdate").val()
									},
									success : function(data) {
										if (data) {
											layer.msg('文件删除成功！', {
												time : 1000,
												icon : 1
											});
										} else {
											layer.msg('文件删除失败！', {
												time : 1000,
												icon : 2
											});
										}
										layer.close(index);
										formObj.find("input[name='classPath']").val("");
										formObj.find("#filePathUpdate").val("");
										node.storePath = "";
										$.ajax({// 文件删除更新数据库
											"url" : webpath + "/funDef/edit",
											"type" : "POST",
											dataType : "json",
											data : form.serializeJson(formObj),
											success : function(data) {
												if (data) {
													layer.msg('修改成功！', {
														time : 1000,
														icon : 1
													});
												} else {
													layer.msg('修改失败！', {
														time : 1000,
														icon : 2
													});
												}
												if ((uploader !== undefined) && !isDestoryOnce) {
													uploader.destroy();
													isDestoryOnce = true;
												}
												if ((uploader === undefined) || isDestoryOnce) {
													isDestoryOnce = false;
													formObj.find("#isExistFileNoUpdate").show();
													formObj.find("#isExistFileYesUpdate").hide();
													uploader = initUploader("Update");
												}
											}
										});
									},
									error : function(error) {
										layer.open({
											title : '<i class="iconfont">&#xe649;</i>&nbsp;提示',
											content : "出错了！！:" + error
										});
									}
								});
							});
						});
					}
					$("#ctlBtnUpdate").on('click', function() {
						if ($("#thelistUpdate").text().length > 0) {
							var fileName = $("#thelistUpdate").text().split(".");
							var funName = formObj.find("[name='funName']").val();// 输入的类名
							var dataType = formObj.find("[name='dataType']").val();// 选择的编码类型
							if (isValidFile(fileName[0].trim(), funName)) {
								// if(isValidFile(fileName[1].trim(),dataType)){
								 uploader.upload();
								 isHasUploaded = true;
								// }else{
								// layer.msg('要求文件后缀与编码类型一致', {time: 2000,
								// icon:6});
								// }
							} else {
								layer.msg('要求文件名与类名一致', {
									time : 2000,
									icon : 5
								});
							}
						} else {
							layer.msg('请选择文件', {
								time : 2000,
								icon : 5
							});
						}
					});
					layer.open({
						type : 1,
						title : '<i class="iconfont">&#xe631;</i>&nbsp;修改类',
						area : [ '450px', '410px' ],
						content : $("#editClass"),
						btn : [ '确定', '取消' ],
						btn1 : function(index, layero) {// 确定按钮回调
							// 处理解析&时不好用的问题
							var newData = form.serializeJson(formObj);
							if (form.isValidator(formObj)) {
								$.ajax({
									"url" : webpath + "/funDef/edit",
									"type" : "POST",
									dataType : "json",
									data : newData,
									success : function(data) {
										if (data) {
											layer.msg('修改成功！', {
												time : 1000,
												icon : 1
											});
										} else {
											layer.msg('修改失败！', {
												time : 1000,
												icon : 2
											});
										}
										layer.close(index);
										resource.initTree();
									},
									error : function(error) {
										layer.open({
											title : '<i class="iconfont">&#xe649;</i>&nbsp;提示',
											content : "出错了！！:" + error
										});
									}
								});
							}
						},
						btn2 : function(index, layero) {// 取消按钮回调
							layer.close(index);
							node.storePath = $("#filePathUpdate").val();
							if (isHasUploaded) {// 更新时，如果上传了文件，点击取消按钮也更新数据
								$.ajax({
									"url" : webpath + "/funDef/edit",
									"type" : "POST",
									dataType : "json",
									data : form.serializeJson(formObj),
									success : function(data) {
									},
									error : function(error) {
										layer.open({
											title : '<i class="iconfont">&#xe649;</i>&nbsp;提示',
											content : "出错了！！:" + error
										});
									}
								});
							}
							if ((!formObj.find("input[name='classPath']").val().length > 0)) {// 没有上传的文件
								layer.open({
									title : '<i class="iconfont">&#xe649;</i>&nbsp;提示',
									content : "当前类没有上传源文件"
								});
							}
						},
						end : function() {// 关闭回调函数
						}
					});
					isDestoryOnce = false;
				}
			});

			// 添加方法的事件
			$(".addMethod").bind({
				click : function() {
					var funTypeId = "2", parentId = "ROOT";
					var nodes = resource.treeObj.getSelectedNodes();// 获取 zTree当前被选中的节点数据集合,返回值(Array(JSON))
					var dataType = nodes[0].dataType;
					var formObj;
					if(dataType=="field"){
						formObj = $("#addMethodFormOfField");
						form.clear(formObj);
						formObj.find("#funParam").children().remove();// 新增方法时，首先清空参数配置框
					}else{
						formObj = $("#addMethodForm");
						form.clear(formObj);
					}
					form.cleanValidator(formObj);
					if (nodes.length > 0) {
						var node = nodes[0];
						formObj.find('input[name="parentId"]').val(node.id);
						formObj.find('input[name="path"]').val(node.path);
					} else {
						formObj.find('input[name="parentId"]').val(parentId);
					}
					formObj.find('input[name="funTypeId"]').val(funTypeId);
					if(dataType=="field"){
						layer.open({
							type : 1,
							title : '<i class="iconfont">&#xe641;</i>&nbsp;新增方法',
							area : [ '520px', '470px' ],
							content : $("#addMethodOfField"),
							btn : [ '确定', '取消' ],
							btn1 : function(index, layero) {// 确定按钮回调
								var html = $("#funParam").children().html();
								if (html == null || html.length == 0) {
									layer.open({
										title : '<i class="iconfont">&#xe649;</i>&nbsp;提示',
										content : "方法参数配置不能为空"
									});
									return;
								}
								if (form.isValidator(formObj)) {
									var funParam = formObj.find(".funParamTypeClass");
									funParam.each(function(index, value, array) {
										$(value).attr("name", "params[" + index + "].funParamType");
									});
									var funParamDescribe = formObj.find(".funParamDescribeClass");
									funParamDescribe.each(function(index, value, array) {
										$(value).attr("name", "params[" + index + "].funParamDescribe");
									});
									$.ajax({
										"url" : webpath + "/funDef/add",
										"type" : "POST",
										dataType : "json",
										data : form.serializeJson(formObj),
										success : function(data) {
											if (data) {
												layer.msg('添加成功！', {
													time : 1000,
													icon : 1
												});
											} else {
												layer.msg('添加失败！', {
													time : 1000,
													icon : 2
												});
											}
											layer.close(index);
											resource.initTree();// 初始化zTree树
										},
										error : function(error) {
											layer.open({
												title : '<i class="iconfont">&#xe649;</i>&nbsp;提示',
												content : "出错了！！:" + error
											});
										}
									});
								}
							},
							btn2 : function(index, layero) {// 取消按钮回调
								layer.close(index);
							}
						});
					}else{
						layer.open({
							type : 1,
							title : '<i class="iconfont">&#xe641;</i>&nbsp;新增方法',
							area : [ '520px', '320px' ],
							content : $("#addMethod"),
							btn : [ '确定', '取消' ],
							btn1 : function(index, layero) {// 确定按钮回调
								if (form.isValidator(formObj)) {
									$.ajax({
										"url" : webpath + "/funDef/add",
										"type" : "POST",
										dataType : "json",
										data : form.serializeJson(formObj),
										success : function(data) {
											if (data) {
												layer.msg('添加成功！', {
													time : 1000,
													icon : 1
												});
											} else {
												layer.msg('添加失败！', {
													time : 1000,
													icon : 2
												});
											}
											layer.close(index);
											resource.initTree();// 初始化zTree树
										},
										error : function(error) {
											layer.open({
												title : '<i class="iconfont">&#xe649;</i>&nbsp;提示',
												content : "出错了！！:" + error
											});
										}
									});
								}
							},
							btn2 : function(index, layero) {// 取消按钮回调
								layer.close(index);
							}
						});
					}
				}
			});

			// 修改方法的事件
			$(".editMethod").bind({
						click : function() {
							var nodes = resource.treeObj.getSelectedNodes();// 获取
							// zTree
							// 当前被选中的节点数据集合,返回值(Array(JSON))
							if (nodes.length == 0)
								return;
							var node = nodes[0];
							var dataType = node.dataType;
							var formObj;
							if(dataType == "field"){
								formObj = $("#editMethodFormOfField");
								form.clear(formObj);
								form.cleanValidator(formObj);
//								formObj.find('input[name="inputParam"]').attr("value", node.inputParam);
							}else{
								formObj = $("#editMethodForm");
								form.clear(formObj);
								form.cleanValidator(formObj);
								
							}
							form.load(formObj, node);
							if (node.funTypeId == "0") {
							}
							if (node.parentId == null) {
								formObj.find('input[name="parentId"]').val('ROOT');
							} else {
								formObj.find('input[name="parentId"]').val(node.parentId);
							}
							if(dataType == "field"){
								var str = node.inputParam;
								if (str == "" || str == null) {
									var obj = null;
								} else {
									var obj = eval('(' + str + ')');
								}
								if (obj != null) {
									if (obj.length > 0) {
										formObj.find("#funParamUpdate").children().remove();
										obj.forEach(function(value, index, array) {
											var param = "<div>" + "<input type='text' class='form-control input-sm funParamTypeClass' name='' value='" + value.funParamType
													+ "' readonly style='width:23%;'/>" + "<input type='text' class='form-control input-sm funParamDescribeClass' name='' value = '"
													+ value.funParamDescribe + "' style='width:68%;' placeholder='参数描述'/>&nbsp;&nbsp;"
													+ "<button type='button' class='removeFunParamClass' title = '删除'><i class='iconfont'>&#xe675;</i></button></div>";
											$("#funParamUpdate").append(param);
										});
										$(".removeFunParamClass").on("click", function() {
											$(this).parent().remove();// 删除此项
										});
									}
								}
								layer.open({
									type : 1,
									title : '<i class="iconfont">&#xe631;</i>&nbsp;修改方法',
									area : [ '520px', '470px' ],
									content : $("#editMethodOfField"),
									btn : [ '确定', '取消' ],
									btn1 : function(index, layero) {
										;// 确定按钮回调
										var html = $("#funParamUpdate").children().html();
										if (html == null || html.length == 0) {
											layer.open({
												title : '<i class="iconfont">&#xe649;</i>&nbsp;提示',
												content : "方法参数配置不能为空"
											});
											return;
										}
										if (form.isValidator(formObj)) {
											var funParam = $(".funParamTypeClass");
											funParam.each(function(index, value, array) {
												$(value).attr("name", "params[" + index + "].funParamType");
											});
											var funParamDescribe = $(".funParamDescribeClass");
											funParamDescribe.each(function(index, value, array) {
												$(value).attr("name", "params[" + index + "].funParamDescribe");
											});
											$.ajax({
												"url" : webpath + "/funDef/edit",
												"type" : "POST",
												dataType : "json",
												data : form.serializeJson(formObj),
												success : function(data) {
													if (data) {
														layer.msg('修改成功！', {
															time : 1000,
															icon : 1
														});
													} else {
														layer.msg('修改失败！', {
															time : 1000,
															icon : 2
														});
													}
													layer.close(index);
													resource.initTree();
												},
												error : function(error) {
													layer.open({
														title : '<i class="iconfont">&#xe649;</i>&nbsp;提示',
														content : "出错了！！:" + error
													});
												}
											});
										}
									},
									btn2 : function(index, layero) {// 取消按钮回调
										layer.close(index);
									}
								});
							}else{
								layer.open({
									type : 1,
									title : '<i class="iconfont">&#xe631;</i>&nbsp;修改方法',
									area : [ '520px', '320px' ],
									content : $("#editMethod"),
									btn : [ '确定', '取消' ],
									btn1 : function(index, layero) {// 确定按钮回调
										if (form.isValidator(formObj)) {
											$.ajax({
												"url" : webpath + "/funDef/edit",
												"type" : "POST",
												dataType : "json",
												data : form.serializeJson(formObj),
												success : function(data) {
													if (data) {
														layer.msg('修改成功！', {
															time : 1000,
															icon : 1
														});
													} else {
														layer.msg('修改失败！', {
															time : 1000,
															icon : 2
														});
													}
													layer.close(index);
													resource.initTree();
												},
												error : function(error) {
													layer.open({
														title : '<i class="iconfont">&#xe649;</i>&nbsp;提示',
														content : "出错了！！:" + error
													});
												}
											});
										}
									},
									btn2 : function(index, layero) {// 取消按钮回调
										layer.close(index);
									}
								});
							}
							
						}
					});

			resource.initTree();// 初始化zTree树

			// 添加时，添加参数，绑定点击事件
			$("#addFunParamAdd").on("click", function() {
				var funType = $("#funParamTypeAdd :selected").val();
				$("#funParam").append(addParams(funType));
				$(".removeFunParamClass").on("click", function() {
					$(this).parent().remove();// 删除此项
				});
			});
			// 更新时，添加参数，绑定点击事件
			$("#addFunParamUpdate").on("click", function() {
				var funType = $("#funParamTypeUpdate :selected").val();
				$("#funParamUpdate").append(addParams(funType));
				$(".removeFunParamClass").on("click", function() {
					$(this).parent().remove();// 删除此项
				});
			});

		});

function addParams(funType) {
	var param;
	if (funType === undefined) {
		layer.open({
			title : '<i class="iconfont">&#xe649;</i>&nbsp;提示',
			content : "请先选择方法参数类型"
		});
	} else {
		param = "<div><input type='text' class='form-control input-sm funParamTypeClass' name='' value='" + funType + "' readonly style='width:23%;'/>"
				+ "<input type='text' class='form-control input-sm funParamDescribeClass' name='' style='width:68%;' placeholder='参数描述'/>&nbsp;&nbsp;"
				+ "<button type='button' class='removeFunParamClass' title = '删除'><i class='iconfont'>&#xe675;</i></button></div>";
	}
	return param;
}

// 初始化文件上传功能
var initUploader = function(operateType) {
	// 初始化webuploader组件，设置上传等事件监听
	var $list;
	var thumbnailWidth = 100; // 缩略图高度和宽度 （单位是像素），当宽高度是0~1的时候，是按照百分比计算
	var thumbnailHeight = 100;
	uploader = WebUploader.create({
		// swf文件路径
		swf : webpath + '/resources/plugin/webuploader-0.1.5/Uploader.swf',
		// 文件接收服务端。
		server : webpath + '/funDef/upload',
		// 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
		resize : false,
		method : 'POST',
		// 可重复上传
		duplicate : true,
		formData : {},
		accept : {
			title : 'content',
			extensions : 'scala,java' // 可选择的文件类型
		}
	});

	// 上传事件对象
	var uploaderObj = {
		'beforeFileQueued' : function(file) {
			uploader.reset();// 文件添加之前重置队列，只上传一个文件
		},
		'fileQueued' : function(file) {
			$list.empty();
			$list.append('<div id="' + file.id + '" class="item" style="font-size:13px;"> ' + file.name + '</div>');
		},
		'uploadProgress' : function(file, percentage) {
			var $li = $('#' + file.id), $percent = $li.find('.progress .progress-bar');
//			$percent = $('.progress .progress-bar');
			// 避免重复创建
//			if (!$percent.length) {
//				$percent = $('<div class="progress progress-striped active" style="width: 100%;">' + '<div class="progress-bar" role="progressbar" >' + '</div>' + '</div>').appendTo($li).find(
//						'.progress-bar');
//			}
			if (!$percent.length) {
				layer.open({
					title : '<i class="iconfont">&#xe649;</i>&nbsp;提示',
					content : '<div class="progress progress-striped active" style="height: 10px;margin-bottom: 2px;">' + '<div class="progress-bar" role="progressbar" >'
							+ '</div></div> <span id="percentage"></span>',
					closeBtn : 0,
					btn : []
				});
			}
			$("#percentage").text(percentage * 100 + '%');
			$percent.css('width', percentage * 100 + '%');
		},
		'uploadSucc' : function(file, result) {// 后台返回的是一个List
			layer.open({
				title : '<i class="iconfont">&#xe649;</i>&nbsp;提示',
				content : "上传成功"
			});
			var filePath = result[0].path;
			if (operateType == "Add") {
				$("#filePathAdd").val(filePath);
				$.ajax({
					url : webpath + "/file/decodeJarPath",
					type : "POST",
					data : {
						"jarPath" : filePath
					},
					dataType : "json",
					async : false,
					success : function(data) {
						$("#addClass").find("input[name='classPath']").val(data);
					},
					error : function(error) {
						layer.open({
							title : '<i class="iconfont">&#xe649;</i>&nbsp;提示',
							content : "出错了！！:" + error
						});
					}
				});
				$("#addClass").find("#isExistFileNo").hide();
				$("#addClass").find("#isExistFileYes").show();
			}
			if (operateType == "Update") {
				$("#filePathUpdate").val(filePath);
				$.ajax({
					url : webpath + "/file/decodeJarPath",
					type : "POST",
					data : {
						"jarPath" : filePath
					},
					dataType : "json",
					async : false,
					success : function(data) {
						$("#editClass").find("input[name='classPath']").val(data);
					},
					error : function(error) {
						layer.open({
							title : '<i class="iconfont">&#xe649;</i>&nbsp;提示',
							content : "出错了！！:" + error
						});
					}
				});
				$("#editClass").find("#isExistFileNoUpdate").hide();
				$("#editClass").find("#isExistFileYesUpdate").show();
			}
			$list.empty();
		},
		'uploadErr' : function(file) {
			$('#' + file.id).find('p.state').text('上传出错');
		},
		'uploadComp' : function(file) {
			$('#' + file.id).find('.progress').fadeOut();
		},
		'error' : function(type) {
			if (type == "Q_TYPE_DENIED") {
				$list.empty();
				layer.msg('请选择.java或者.scala文件', {
					time : 2000,
					icon : 5
				});
			}
		},
		'uploadAccept' : function(file, response) {
			if (response.code == 1) {
				// 通过return false来告诉组件，此文件上传有错。
				return false;
			}
		}

	};
	uploader.on('error', uploaderObj.error);
	// 当有文件被添加进队列前
	uploader.on('beforeFileQueued', uploaderObj.beforeFileQueued);
	// 当有文件被添加进队列的时候
	uploader.on('fileQueued', uploaderObj.fileQueued);
	// 文件上传过程中创建进度条实时显示。
	uploader.on('uploadProgress', uploaderObj.uploadProgress);
	// 文件上传成功
	uploader.on('uploadSuccess', uploaderObj.uploadSucc);
	// 文件上传失败，显示上传出错。
	uploader.on('uploadError', uploaderObj.uploadErr);
	// 完成上传完了，成功或者失败，先删除进度条。
	uploader.on('uploadComplete', uploaderObj.uploadComp);

	if (operateType == "Add") {
		uploader.addButton({
			id : '#pickerUpload'
		});
		$list = $('#thelist');
	}

	if (operateType == "Update") {
		uploader.addButton({
			id : '#pickerUploadUpdate'
		});
		$list = $('#thelistUpdate');
	}

	return uploader;
}

// 校验上传的文件是否是合法的
function isValidFile(fileName, funName) {
	if (funName == fileName) {
		return true;
	} else {
		return false;
	}
}

var resource = {
	treeObj : null,
	setting : {
		data : {
			simpleData : {
				/**
				 * 确定 zTree 初始化时的节点数据、异步加载时的节点数据、或 addNodes 方法中输入的 newNodes
				 * 数据是否采用简单数据模式 (Array) 不需要用户再把数据库中取出的 List 强行转换为复杂的 JSON 嵌套格式
				 * true / false 分别表示 使用 / 不使用 简单数据模式 默认值：false 如果设置为 true，请务必设置
				 * setting.data.simpleData 内的其他参数: idKey / pIdKey /
				 * rootPId，并且让数据满足父子关系
				 */
				enable : true,
				/**
				 * 节点数据中保存唯一标识的属性名称 默认值："id"
				 */
				idKey : 'id',
				/**
				 * 节点数据中保存其父节点唯一标识的属性名称 默认值："pId"
				 */
				pIdKey : 'parentId'
			},
			key : {
				/**
				 * zTree 节点数据保存节点名称的属性名称 默认值："name"
				 */
				name : 'funName',
				/**
				 * zTree 节点数据保存节点链接的目标 URL 的属性名称 特殊用途：当后台数据只能生成 url
				 * 属性，又不想实现点击节点跳转的功能时，可以直接修改此属性为其他不存在的属性名称 默认值："url"
				 * 
				 * 设置 zTree 显示节点时，将 treeNode 的 xurl 属性当做节点链接的目标 URL
				 */
				url : 'xurl'
			}
		},
		callback : {
			onRightClick : function(e, treeId, treeNode) {// 用于捕获 zTree
															// 上鼠标右键点击之后的事件回调函数
				/**
				 * 参数说明： e--js event 对象：标准的 js event 对象 treeId--String：对应 zTree
				 * 的 treeId，便于用户操控 treeNode--JSON：鼠标右键点击时所在节点的 JSON 数据对象
				 */
				if (!treeNode)
					return;
				resource.treeObj.selectNode(treeNode);// 选中指定节点,treeNode(JSON)--需要被选中的节点数据
				$(".bootstrapMenu").hide();
				if (treeNode.funTypeId == "0") {
					$("#folderContextMenu").css("left", e.clientX);
					$("#folderContextMenu").css("top", e.clientY);
					$("#folderContextMenu").show();
				} else if (treeNode.funTypeId == "1") {
					$("#linkContextMenu").css("left", e.clientX);
					$("#linkContextMenu").css("top", e.clientY);
					$("#linkContextMenu").show();
				} else if (treeNode.funTypeId == "2") {
					$("#link1ContextMenu").css("left", e.clientX);
					$("#link1ContextMenu").css("top", e.clientY);
					$("#link1ContextMenu").show();
				}
			},
			onClick : function(e, treeId, treeNode) {// 用于捕获节点被点击的事件回调函数
				if (!treeNode)
					return;
				resource.treeObj.selectNode(treeNode);// 选中指定节点,treeNode(JSON)--需要被选中的节点数据
				if (treeNode.funTypeId == "2") {
					$("#tableHeading").show();
					$("#inputParamTable").show();
					if(treeNode.dataType=="field"){
						var str = treeNode.inputParam;
						if (str == "" || str == null) {
							var obj = null;
						} else {
							var obj = eval('(' + str + ')');
						}
						var param = " ( ";
						var desc = "";
						if (obj != null && obj.length > 0) {
							obj.forEach(function(value, index, array) {
								param += value.funParamType + ", ";
								desc += "参数" + index + " : " + value.funParamDescribe + " </br>";
							});
							param = param.substr(0, param.length - 2);
						}
						param += " )";
						
						var dataSet = [ [ treeNode.methodDescription, treeNode.outputParam + " " + treeNode.funName + param, desc ] ];
					}else{
						var dataSet = [ [ treeNode.methodDescription, treeNode.dataType + " " + treeNode.funName + " ( " + treeNode.dataType + " ) " , "" ] ];
					}
					$("#methodName").html("").append(treeNode.funName);

					$("#inputParamTable").find("tbody").html('');
					$("#inputParamTable").dataTable({
						"destroy" : true,
						"processing" : true,
						"bServerSide" : false,// 不使用服务器端处理
						"bPaginate" : false,// 不开启分页功能
						"data" : dataSet,
						columnDefs : [ {
							"targets" : 0,// 操作目标列
							"width" : "30%",
						} ]
					});
				} else {
					$("#tableHeading").hide();
					$("#inputParamTable").hide();
				}
			}

		}
	},
	initTree : function() {
		if (resource.treeObj != null) {
			resource.treeObj.destroy();// 销毁 zTreeObj 代表的 zTree
		}
		$.ajax({// 初始化组织机构树
			"url" : webpath + "/funDef/list",
			"type" : "POST",
			dataType : "json",
			success : function(data) {
				if (data != null && data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						data[i].icon = webpath + funTypeIcon[data[i].funTypeId];
					}
					/**
					 * 参数说明： 第一个参数jQuery Object：用于展现 zTree 的 DOM 容器
					 * 第二个参数JSON：zTree 的配置数据 第三个参数Array(JSON) / JSON：zTree 的节点数据
					 * 返回值JSON：zTree 对象，提供操作 zTree 的各种方法，对于通过 js 操作 zTree
					 * 来说必须通过此对象
					 */
					resource.treeObj = $.fn.zTree.init($("#function-tree"), resource.setting, data);// zTree初始化方法
					resource.treeObj.expandAll(true);// 展开所有节点
				} else {
					layer.msg('暂无数据', {
						time : 1000,
						icon : 5
					});
				}
			},
			error : function(error) {
				layer.open({
					title : '<i class="iconfont">&#xe649;</i>&nbsp;提示',
					content : "出错了！！:" + error
				});
			}
		});
	}
};

var funTypeIcon = {
	"0" : "/resources/img/icon/16x16/floder1-org.png",
	"1" : "/resources/img/icon/16x16/resorce.png",
	"2" : "/resources/img/icon/16x16/fun-black.png",
};