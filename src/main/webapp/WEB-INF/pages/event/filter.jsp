<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String webpath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="stylesheet" type="text/css"
	href="<%=webpath%>/resources/plugin/flow/css/Font-Awesome-master/css/font-awesome.css">
<link rel="stylesheet" type="text/css"
	href="<%=webpath%>/resources/plugin/ztree/css/zTreeStyle/zTreeStyle.css">
<link rel="stylesheet" type="text/css"
	href="<%=webpath%>/resources/plugin/flow/css/filter.css">

<script type="text/javascript"
	src="<%=webpath%>/resources/plugin/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript"
	src="<%=webpath%>/resources/plugin/layer/layer.js"></script>
<script type="text/javascript"
	src="<%=webpath%>/resources/plugin/ztree/js/jquery.ztree.all.js"></script>
<script type="text/javascript"
	src="<%=webpath%>/resources/plugin/nicescroll/jquery.nicescroll.js"></script>
<title>filter</title>
</head>

<body class="container-fluid">
	<div class="treeInfo">
		<div class="flowTreeInfo left">
			<ul id="filterTree" class="ztree"></ul>
		</div>
		<div class="zTreeFilterContent left">
			<div class="conTitle">过滤规则配置</div>
			<div>
		
			<textarea name="" class="filterKeyCon" id="filterKeyCon"></textarea>
			<input type="hidden" name="id" id="data" value=${optField}/>
				<div class="operatorCon">
					<div class="conditonCon">
						<input type="button" class="add" value="&&" /> <input
							type="button" class="or" value="||" /> <input type="button"
							class="more" value="&gt;" /> <input type="button" class="less"
							value="&lt;" /> <input type="button" class="bigEqual" value="==" />
						<input type="button" class="notEqual" value="!=" /> <input
							type="button" class="lessOrE" value="<=" /> <input type="button"
							class="moreOrE" value=">=" />
					</div>
					<div class="">
						<button type="button" class="clearBtn">清空</button>
					</div>
				</div>
			</div>

			<div class="condition">
				<div class="conditionList">
					<p class="conditionTit">方法列表</p>
					<div id="conditionListTree" class="ztree"></div>
				</div>
				<div class="conditionDescribe">
					<p class="conditionTit">详情</p>
					<div>
						<p class="discribe">名称：</p>
						<p id="funName"></p>
					</div>
					<div>
						<p class="discribe">语法：</p>
						<p id="funGrammar"></p>
					</div>
					<div>
						<p class="discribe">参数：</p>
						<p id="paramDesc"></p>
					</div>
					<div>
						<p class="discribe">描述：</p>
						<p id="funDescribe"></p>
					</div>
				</div>
				<div class="conditionPara">
					<p id="conditionTit">
						参数列表<i class="fa fa-plus paraPlus" title="添加自定义参数"></i>
					</p>
					<ul>

					</ul>
				</div>
				<div class="conditionBtn">
					<button type="button" class="addFilterBtn">添加</button>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
    $(document).ready(function(){
    	var filterSetting = {
	    	callback: {
	            beforeDrag: flowTreeFun.varsTreeBeforeDrag,
	            onDrop: flowTreeFun.onDropParame,
	            onDragMove: flowTreeFun.dragMove
	        },
	        edit: {
	            enable: true,
				showRemoveBtn: false,
				showRenameBtn: false,
	            drag: {
	                isCopy: true,
	                isMove: false,
	                prev: false,
	                next: false,
	                inner: false
	            }
	        },
	        view: {
	            selectedMulti: false
	        },
	        data:{
	        	simpleData: {
					enable:true,
					idKey:'fieldId'
				},
	        	key:{
	        		name : 'enNameAndCnName'
	        	}
	        }
    	};
    	
    	 var flowzNodesIn = [{
    		enNameAndCnName:"输入字段", 
   	    	open:true, 
   	    	isParent:true,
   	    	children:${optField }
   	    }]; 
    	 $("#filterKeyCon").val(${rule});
        filterzTreeObj = $.fn.zTree.init($("#filterTree"), filterSetting, flowzNodesIn);
        resource.initTree();
    });
$(function() {
	//清空各输入框
    $(".clearBtn").click(function(){
    	$(".filterKeyCon").val("");
    });
    //选中参数列表项  显示移除按钮
    $(document).on("click",".conditionPara li",function(){
        $(this).addClass('active').siblings().removeClass('active');
        if ($(".conditionBtn > .delete").length == 0) {
            var btnHtml = "<button class='delete'>移除</button>";
            $(".conditionBtn").append(btnHtml);
        }
        fanOperateRemove();
    });
    //操作字符按钮, 点击后添加到textarea中
    $(".conditonCon > input").click(function(e) {
        var valTxt = $(e.target).val();
        insertAtCursor(document.getElementById('filterKeyCon'),valTxt);
    });
    //添加自定义参数按钮
    $(".paraPlus").click(function(){
    	var idx = 'param' + funTreeFun.curPrmCnt;
    	var definedParaHtml = '<li id="'+idx+'"><input type="text" value="" placeholder="字段名称" class="definedParaCon addtxt"><input type="text" value="" placeholder="数据类型" class="definedParaCon addtype"></li>';
    	$(".conditionPara ul").append(definedParaHtml);
    	funTreeFun.curPrmCnt++;
    });
    //添加函数表达式按钮
    $(".addFilterBtn").click(function() {
        //判断拖拽的参数类型是否与函数类型符合
        var fuNode = funTreeFun.node;
        var lis = $(".conditionPara > ul > li");
        var i = 0;
        var isLegal = true;
        if(fuNode == null){
            //没有选择函数，弹窗提醒
             layer.alert('请选择函数再拖拽参数到函数中！', {
                skin: 'layui-layer-lan',
                closeBtn: 0,
             });
             isLegal = false;
        }else{
        	if(fuNode.funTypeId=="2"){
	    		var str = fuNode.inputParam;
	    		if(str=="" || str == null){
					var obj = null;
				}else{
					var fNodeParams = eval('(' + str + ')');
				}
	    	}/* 
            var fNodeParams = fuNode.params == undefined? 0:fuNode.params; */
            if(fNodeParams == 0 && lis.length > 0){
                layer.alert('此函数的参数个数为零,请清空参数！', {
                    skin: 'layui-layer-lan',
                    closeBtn: 0,
                 });
                isLegal = false;
            }else if(fNodeParams != 0){
                if(lis.length > fNodeParams.length){
                    layer.alert('函数参数多了，若需删除参数请点击该参数并删除！', {
                        skin: 'layui-layer-lan',
                        closeBtn: 0,
                     });
                    isLegal = false;
                }else if(lis.length < fNodeParams.length){
                    layer.alert('函数参数不足，需添加参数！', {
                        skin: 'layui-layer-lan',
                        closeBtn: 0,
                     });
                    isLegal = false;
                }else{
                	
                    var idxNotEql = '';
                    for(i = 0; i < lis.length; i++){
                        if($(lis[i]).data("node") == null){
                        	var addtype = $(lis[i]).find(".addtype").val();
                        	if(addtype != fNodeParams[i].funParamType){
                        		idxNotEql += parseInt(i + 1) + ', ';
                        	} 
                        }else{
                        	var dataLi = $(lis[i]).data("node").type;
                        	if(fNodeParams[i].funParamType != dataLi){
                                idxNotEql += parseInt(i + 1) + ', ';
                            }
                        }
                    }
                    idxNotEql = idxNotEql.substring(0,idxNotEql.length-2);
                    if(idxNotEql != ''){
                        layer.alert('第'+idxNotEql+'个变量的类型和函数目标参数不符合！', {
                            skin: 'layui-layer-lan',
                            closeBtn: 0,
                        });
                        isLegal = false;
                    }
                }
            }
        }

        if(isLegal){
            var newTxt = fuNode.funName +'(';
            for(i = 0; i < lis.length; i++){
            	var isDataNode = $(lis[i]).data("node");
            	if(isDataNode == null){
            		newTxt += '[' + $(lis[i]).find(".addtxt").val() + ']' + ',';
            	}else{
            		newTxt += '[' + isDataNode.enName + ']' + ',';
            	}
                
            }
            newTxt = newTxt.substring(0,newTxt.length-1);
            newTxt += ')';
            insertAtCursor(document.getElementById('filterKeyCon'),newTxt)
        }
    });
}); /*function*/  

	var flowTreeFun = {
	//变量树的拖拽开始时触发函数
    dragMove: function(e, treeId, treeNodes) {
        //if (!$(".cfgCore").is(":visible")) return;
        //当鼠标拖拽的位置在目标元素上时该元素加蓝色外发光
        var targetCls = ["filterKeyCon", "conditionPara"];
        var cls = $(e.target).attr("class");

        for (i = 0; i < targetCls.length; i++) {
            var parentCls = $(e.target).parents("." + targetCls[i]);
            if (cls != undefined && cls.indexOf(targetCls[i]) >= 0 && parentCls.length == 0) {
                flowTreeFun.removeActive();
                $(e.target).addClass('moveActive');
            } else if (parentCls.length > 0) {
                flowTreeFun.removeActive();
                $(".conditionPara").addClass('moveActive');
            }
        }
    },
    //拖拽变量树的子节点后松开时触发函数
    onDropParame: function(e, treeId, treeNodes, targetNode, moveType) {
    
        var mX = 0,
            mY = 0,
            i, j, pos, domType, valTxt0 = "[" + treeNodes[0].enName + "]",
            node = treeNodes[0],
            valTxts = "";
        var dictId = node.dictId;
        var e = e || window.event;
        var targetCls = $(e.target).attr("class");
        //var iptHtml = '<input id="result" class="result" type="text"/>';

        //判断添加到哪个元素上
        //if (targetCls != undefined && targetCls.indexOf("flowKeyCon") >= 0) {
            //textarea
            //$(".flowKeyCon").val(valTxt0);
        //} 
        if (targetCls != undefined && targetCls.indexOf("filterKeyCon") >= 0) {
            //textarea
            valTxtadd = $(".filterKeyCon").val()+valTxt0;
            $(".filterKeyCon").val(valTxtadd);

            //更新右侧部分的html
            if (dictId != undefined) {
                //取含有可选字典的值
                for (i = 0; i < dictList.length; i++) {
                    if (dictId == dictList[i].dictId) {
                        varsTreeFun.dictValues = dictList[i].dictValues;
                    }
                }
                if (varsTreeFun.dictValues != null) {
                    var radioSelectHtml = '<input id="result" class="easyui-combotree result"/>';
                    $(".resultWrap").html(radioSelectHtml);
                    ruleCfg.fuUpdateDictSelect();
                }
            }
        } else if (targetCls != undefined && targetCls.indexOf("conditionPara") >= 0 || $(e.target).parents(".conditionPara").length > 0) {
        	
            //辅助函数的参数列表div中
            var type = node.type == undefined ? '' : node.type;
            var paramTp = '';
            if(type != ''){
                paramTp = '<span class="type">'+type+'</span>';
            }
            var idx = 'param' + funTreeFun.curPrmCnt;
            var tempHtml = '<li id="'+idx+'"><span class="pName">' + valTxt0 +'</span>'+ paramTp + '</li>';
            $(".conditionPara > ul").append(tempHtml);
            $("#" + idx).data("node",node);
            //ruleCfg.bindFunPrmLiClick();
            funTreeFun.curPrmCnt++;
        }

        //变激活状态为平常状态
        flowTreeFun.removeActive();
    },
    //设置是父节点的节点不可拖拽, 初始化目标元素的坐标信息
    varsTreeBeforeDrag: function(treeId, treeNode) {
        if (treeNode[0].isParent == true) {
            return false;
        } else {
            return true;
        }
    },
    removeActive: function() {
        $('.filterKeyCon').removeClass('moveActive');
        $('.conditionPara').removeClass('moveActive');
    },
};

var funTreeFun = {
    //当前选中的函数节点
    node:null,
    curPrmCnt: 1,
    //更新描述部分的页面内容
    generateHtml: function(){
        var i = 0, params = funTreeFun.node.params == undefined ? 0: funTreeFun.node.params;
        var grammar = funTreeFun.node.funCode + '(';

        for(i = 0; i < params.length; i++){
            grammar += params[i];

            if((i + 1) != params.length){
                //多个参数中间逗号分开
                grammar += ',';
            }
        }
        grammar += ')';

        var parameter = "";
        var parameters = funTreeFun.node.parameter == undefined ? 0: funTreeFun.node.parameter;
        for(var j = 0; j < parameters.length; j++){
            parameter += parameters[j];

            if((j + 1) != parameters.length){
                //多个参数中间逗号分开
                parameter += '<br>';
            }
        }

        $(".funName").text(funTreeFun.node.enName);
        $(".funGrammar").text(grammar);
        $(".paramDesc").html(parameter);
        $(".funDescribe").text(funTreeFun.node.describe);

    },
    conditionListFunClick: function(e, treeId, treeNode) {
        if(treeNode.isParent) return;
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

//给删除参数按钮绑定事件
function fanOperateRemove() {
    $(".conditionBtn > .delete").click(function() {
        var atvDom = $(".conditionPara li.active");
        $(".conditionPara li.active").remove();
        $(this).remove();
        funTreeFun.curPrmCnt = 0;
    });
}
//清空配置部分的文本和内容
function clearCoreTxt() {
    $(".assistCfgVar").val("");
    $("#operator").combobox({
        onLoadSuccess: function() {
            $("#operator").combobox('setValue', operators[0].val);
        }
    });
    $(".resultWrap").html('<input id="result" type="text"  class="result" />');
    $(".core > textarea").val('');
    $(".funParamList > ul > li, .fanOperate .delete").remove();
}
//给textArea的鼠标处添加值
function insertAtCursor(field, value) {
    //IE support
    if (document.selection) {
        field.focus();
        sel = document.selection.createRange();
        sel.text = value;
        sel.select();
    }
    //MOZILLA/NETSCAPE support 
    else if (field.selectionStart || field.selectionStart == '0') {
        var startPos = field.selectionStart;
        var endPos = field.selectionEnd;
        // save scrollTop before insert www.keleyi.com
        var restoreTop = field.scrollTop;
        field.value = field.value.substring(0, startPos) + value + field.value.substring(endPos, field.value.length);
        if (restoreTop > 0) {
            field.scrollTop = restoreTop;
        }
        field.focus();
        field.selectionStart = startPos + value.length;
        field.selectionEnd = startPos + value.length;
    } else {
        field.value += value;
        field.focus();
    }
 }
var resource = {
		treeObj:null,
		setting : {
			data:{
				simpleData: {
					/**
					 * 确定 zTree 初始化时的节点数据、异步加载时的节点数据、或 addNodes 方法中输入的 newNodes 数据是否采用简单数据模式 (Array)
					 * 不需要用户再把数据库中取出的 List 强行转换为复杂的 JSON 嵌套格式
					 * true / false 分别表示 使用 / 不使用 简单数据模式
					 * 默认值：false
					 * 如果设置为 true，请务必设置 setting.data.simpleData 内的其他参数: idKey / pIdKey / rootPId，并且让数据满足父子关系 
					 */
					enable:true, 
					/**
					 * 节点数据中保存唯一标识的属性名称
					 * 默认值："id"
					 */
					idKey:'id',
					/**
					 * 节点数据中保存其父节点唯一标识的属性名称
					 * 默认值："pId"
					 */
					pIdKey:'parentId'
				},
				key:{
					/**
					 * zTree 节点数据保存节点名称的属性名称
					 * 默认值："name"
					 */
					name:'funName',
					/**
					 * zTree 节点数据保存节点链接的目标 URL 的属性名称
					 * 特殊用途：当后台数据只能生成 url 属性，又不想实现点击节点跳转的功能时，可以直接修改此属性为其他不存在的属性名称
					 * 默认值："url"
					 * 
					 * 设置 zTree 显示节点时，将 treeNode 的 xurl 属性当做节点链接的目标 URL
					 */
					url:'xurl'
				}
			},
			callback:{
				  onClick: function(e,treeId,treeNode){//用于捕获节点被点击的事件回调函数
					  debugger;
				    	if(!treeNode) return;
				    	resource.treeObj.selectNode(treeNode);//选中指定节点,treeNode(JSON)--需要被选中的节点数据
				    	if(treeNode.funTypeId=="2"){
				    		var str = treeNode.inputParam;
				    		if(str=="" || str == null){
	    						var obj = null;
	    					}else{
	    						var obj = eval('(' + str + ')');
	    					}
				    		var param = " ( ";
				    		var desc = "";
				    		if(obj!=null && obj.length > 0){
				    			obj.forEach(function(value, index, array) {
				    				param += value.funParamType+",";
				    				desc += "参数"+index+" : "+value.funParamDescribe+" </br>";
				    			});
				    			param = param.substr(0,param.length-1);
				    		}
				    		param += " )";
				    		$("#funName").html('').html(treeNode.funName);
				    		$("#funGrammar").html('').html(treeNode.funName);
				    		$("#paramDesc").html('').html(param);
				    		$("#funDescribe").html('').html(desc);
				    	}
				    	 if(treeNode.isParent) return;
					        funTreeFun.node = treeNode;
					        funTreeFun.generateHtml();
					        $(".conditionPara > ul").html('');
				    }
			}
	    },
		initTree:function(){
			if(resource.treeObj!=null){
				resource.treeObj.destroy();//销毁 zTreeObj 代表的 zTree
			}
			$.ajax({//初始化组织机构树
				"url":"<%=webpath%>/funDef/getFieldFun",
					"type" : "POST",
					dataType : "json",
					success : function(data) {
						if (data != null && data.length > 0) {
							/**
							 * 参数说明：
							 * 第一个参数jQuery Object：用于展现 zTree 的 DOM 容器
							 * 第二个参数JSON：zTree 的配置数据
							 * 第三个参数Array(JSON) / JSON：zTree 的节点数据
							 * 返回值JSON：zTree 对象，提供操作 zTree 的各种方法，对于通过 js 操作 zTree 来说必须通过此对象
							 */
							resource.treeObj = $.fn.zTree.init(
									$("#conditionListTree"), resource.setting,
									data);//zTree初始化方法
							/* resource.treeObj.expandAll(true);//展开所有节点 */
						} else {
							layer.msg('暂无函数数据', {
								time : 2000,
								icon : 5
							});
						}
					}
				});
			}
		};
	</script>
	<%-- 
	<script type="text/javascript" src="<%=webpath %>/resources/js/event/filter.js"></script> --%>
</body>
</html>