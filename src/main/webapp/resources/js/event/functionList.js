$(function() {
	// 选中参数列表项 显示移除按钮
	$(document).on("click", ".conditionPara li", function() {
		$(this).addClass('active').siblings().removeClass('active');
		if ($(".conditionBtn > .delete").length == 0) {
			var btnHtml = "<button class='delete'>移除</button>";
			$(".conditionBtn").append(btnHtml);
		}
		fanOperateRemove();
	});
	// 添加自定义参数按钮
	$(".paraPlus").click(
			function() {
				if (funTreeFun.node == null) {
					layer.alert('请先选择方法', {
						skin : 'layui-layer-lan',
						closeBtn : 0,
					});
					return;
				} else {
					if (funTreeFun.node.funTypeId != '2') {
						layer.alert('请先选择方法', {
							skin : 'layui-layer-lan',
							closeBtn : 0,
						});
						return;
					}
				}
				var idx = 'param' + funTreeFun.curPrmCnt;
				var definedParaHtml = '<li id="' + idx + '"><input type="text" value="" placeholder="参数值" class="definedParaCon addtxt">' + '<select name="" class="definedParaCon addtype" >'
						+ '<option value=""></option>' + '<option value="char">char</option>' + '<option value="int">int</option>' + '<option value="long">long</option>'
						+ '<option value="float">float</option>' + '<option value="double">double</option>' + '<option value="string">string</option>' + '<option value="date">date</option>'
						+ '</select>';
				$(".conditionPara ul").append(definedParaHtml);
				funTreeFun.curPrmCnt++;
			});

	// 添加函数表达式按钮
	$(".conditionBtn > .addFlowBtn").click(function() {
		// 判断拖拽的参数类型是否与函数类型符合
		var fuNode = funTreeFun.node;
		if (funTreeFun.node == null) {
			layer.alert('请先选择方法', {
				skin : 'layui-layer-lan',
				closeBtn : 0,
			});
			return;
		} else {
			if (funTreeFun.node.funTypeId != '2') {
				layer.alert('请先选择方法', {
					skin : 'layui-layer-lan',
					closeBtn : 0,
				});
				return;
			}
		}
		var fuParentNode = fuNode.getParentNode();
		var lis = $(".conditionPara > ul > li");
		var i = 0;
		var isLegal = true;
		if (fuNode == null) {
			// 没有选择函数，弹窗提醒
			layer.alert('请选择函数再拖拽参数到函数中！', {
				skin : 'layui-layer-lan',
				closeBtn : 0,
			});
			isLegal = false;
		} else {
			var params = fuNode.inputParam == undefined ? 0 : fuNode.inputParam;
			var fNodeParams = JSON.parse(params);
			if (fNodeParams == 0 && lis.length > 0) {
				layer.alert('此函数的参数个数为零,请清空参数！', {
					skin : 'layui-layer-lan',
					closeBtn : 0,
				});
				isLegal = false;
			} else if (fNodeParams != 0) {
				if (lis.length > fNodeParams.length) {
					layer.alert('函数参数多了，若需删除参数请点击该参数并删除！', {
						skin : 'layui-layer-lan',
						closeBtn : 0,
					});
					isLegal = false;
				} else if (lis.length < fNodeParams.length) {
					layer.alert('函数参数不足，需添加参数！', {
						skin : 'layui-layer-lan',
						closeBtn : 0,
					});
					isLegal = false;
				} else {
					var idxNotEql = '';
					for (i = 0; i < lis.length; i++) {
						if ($(lis[i]).data("node") == null) {
							var addtype = $(lis[i]).find(".addtype").val();
							if (addtype != fNodeParams[i].funParamType) {
								idxNotEql += parseInt(i + 1) + ', ';
							}
						} else {
							var dataLi = $(lis[i]).data("node").type;
							if (fNodeParams[i].funParamType != dataLi) {
								idxNotEql += parseInt(i + 1) + ', ';
							}
						}
					}
					idxNotEql = idxNotEql.substring(0, idxNotEql.length - 2);
					if (idxNotEql != '') {
						layer.alert('第' + idxNotEql + '个变量的类型和函数目标参数不符合！', {
							skin : 'layui-layer-lan',
							closeBtn : 0,
						});
						isLegal = false;
					}
				}
			}
		}

		if (isLegal) {
			var newTxt = fuParentNode.packageName + '.' + fuParentNode.funName + '.' + fuNode.funName + '(';
			for (i = 0; i < lis.length; i++) {
				var isDataNode = $(lis[i]).data("node");
				if (isDataNode == null) {
					newTxt += $(lis[i]).find(".addtxt").val() + ',';
				} else {
					newTxt += '[' + isDataNode.enName + '],';
				}

			}
			newTxt = newTxt.substring(0, newTxt.length - 1);
			newTxt += ')';
			$("#transKeyCon").val("");
			insertAtCursor(document.getElementById('transKeyCon'), newTxt)
			ruleExp = $("#transKeyCon").val();
			$(".conditionPara > ul").html('');
			// 所有数据全部置空
			$(".funName").text("");
			$(".funGrammar").text("");
			$(".paramDesc").html("");
			$(".funDescribe").text("");
			conditionListTree.cancelSelectedNode(fuNode);
			conditionListTree.expandAll(false);
		}
	});

});

var funTreeFun = {
	// 当前选中的函数节点
	node : null,
	curPrmCnt : 1,
	// 更新描述部分的页面内容
	generateHtml : function() {
		var i = 0, params = funTreeFun.node.inputParam == undefined ? 0 : funTreeFun.node.inputParam;
		var paramsJSON = JSON.parse(params);
		var parameter = "";
		var grammar = funTreeFun.node.funName + '(';
		paramsJSON.forEach(function(value, index, array) {
			grammar += value.funParamType;
			parameter += ("参数" + (index + 1) + " : ");
			parameter += value.funParamDescribe;
			if (index != (array.length - 1)) {
				// 多个参数中间逗号分开
				grammar += ',';
				parameter += '<br>';
			}

		});
		grammar += ')';
		$(".funName").text(funTreeFun.node.funName);
		$(".funGrammar").text(grammar);
		$(".paramDesc").html(parameter);
		$(".funDescribe").text(funTreeFun.node.methodDescription);

	},
	conditionListFunClick : function(e, treeId, treeNode) {
		funTreeFun.node = treeNode;
		$(".conditionPara > ul").html('');
		if (treeNode.funTypeId != '2') {
			// 所有数据全部置空
			$(".funName").text("");
			$(".funGrammar").text("");
			$(".paramDesc").html("");
			$(".funDescribe").text("");
		} else {
			funTreeFun.generateHtml();
		}

	}
}

// 给删除参数按钮绑定事件
function fanOperateRemove() {
	$(".conditionBtn > .delete").click(function() {
		var atvDom = $(".conditionPara li.active");
		$(".conditionPara li.active").remove();
		$(this).remove();
		// 每移除一个参数则清空数组，重新赋值
		allInputField = [];
		var lis = $(".conditionPara > ul > li");
		lis.each(function(index, value, array) {
			var node = $(value).data("node");
			if (node != null) {
				var inputField = {
					fieldId : node.fieldId,
					enName : node.enName,
					cnName : node.cnName,
					type : node.type,
					len : node.len,
					index : node.index
				};
				allInputField.push(inputField);
			}
		});
		funTreeFun.curPrmCnt = 0;
	});
}