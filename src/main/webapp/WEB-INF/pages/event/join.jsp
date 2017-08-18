<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
   String webpath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<link rel="stylesheet" type="text/css" href="<%=webpath %>/resources/plugin/flow/css/Font-Awesome-master/css/font-awesome.css">
    <link rel="stylesheet" type="text/css" href="<%=webpath %>/resources/plugin/ztree/css/zTreeStyle/zTreeStyle.css">
	<link rel="stylesheet" type="text/css" href="<%=webpath %>/resources/plugin/flow/css/event_opt.css">
	
    <script type="text/javascript" src="<%=webpath %>/resources/plugin/jquery/jquery-1.9.1.js"></script>
	<script type="text/javascript" src="<%=webpath %>/resources/plugin/layer/layer.js"></script>
	<script type="text/javascript" src="<%=webpath %>/resources/plugin/ztree/js/jquery.ztree.all.js"></script>
	<script type="text/javascript" src="<%=webpath %>/resources/plugin/nicescroll/jquery.nicescroll.js"></script>
    
    <title>join</title>
</head>

<body class="container-fluid">
	<div class="treeInfo">
		<div class="flowTreeInfo left">
			<ul id="flowTree" class="ztree"></ul>
		</div>
		<div class="zTreeContent left">
		   	<div class="conTitle">关联配置</div>
		   	<!-- <table class="cfgTable" style="padding: 8px;border:1px solid #ddd">
		   		<tbody>
		   			<tr style="height:30px;font-size: 12px;text-indent: 8px">
		   				<td>实时流字段Key</td>
		   				<td>规则库Key</td>
		   			</tr>
		   			<tr style="height:50px;border-bottom:1px solid #ddd">
		   				<td id="flowKey"><textarea name="" class="keyCon flowKeyCon" id="flowKeyCon"></textarea></td>
		   				<td id="ruleKey"><textarea name="" class="keyCon ruleKeyCon" id="ruleKeyCon"></textarea></td>
		   			</tr>
		   		</tbody>
		   	</table> -->
		   	<textarea name="" class="keyCon joinKeyCon" id="joinKeyCon"></textarea>
		   	<div class="operatorCon">
               <!-- <div class="conditonCon">
					<input type="button" class="and" value="&&" />
                    <input type="button" class="or" value="||" />
                    <input type="button" class="more" value="&gt;" />
                    <input type="button" class="less" value="&lt;" />
                    <input type="button" class="bigEqual" value="==" />
                    <input type="button" class="notEqual" value="!=" />
                    <input type="button" class="lessOrE" value="<=" />
                    <input type="button" class="moreOrE" value=">=" />
                </div>                  
                <div class="">
				   	<button type="button" class="clearBtn">清空</button>
				</div> -->
				<div style="font-size: 12px;line-height: 30px;padding-left: 5px;">
					规则库字段是否为广播变量：
					<label title="是广播变量">
						<input type="radio" value="true" name="isBroadcast">是</label> 
					<label title="非广播变量">
						<input type="radio" value="false" name="isBroadcast">否</label>
				</div>
				<div>
					
				</div>
            </div>
		   	<div class="condition">
		   		<div class="conditionList">
		   			<p class="conditionTit">方法列表</p>
		   			<div id="conditionListTree" class="ztree"></div>
		   		</div>
		   		<div class="conditionDescribe">
		   			<p class="conditionTit">描述</p>
		   			<div>
                        <p class="discribe">名称：</p>
                        <p class="funName"></p>
                    </div>
                    <div>
                        <p class="discribe">语法：</p>
                        <p class="funGrammar"></p>
                    </div>
                    <div>
                        <p class="discribe">参数：</p>
                        <p class="paramDesc"></p>
                    </div>
                    <div>
                        <p class="discribe">描述：</p>
                        <p class="funDescribe"></p>
                    </div>
		   		</div>
		   		<div class="conditionPara">
		   			<p class="conditionTit">参数列表<i class="fa fa-plus paraPlus" title="添加自定义参数"></i></p>
		   			<ul>
		   				
		   			</ul>
		   		</div>
		   		<div class="conditionBtn">
		   			<!-- <button type="button" class="addFlowBtn">添加实时流</button>
		   			<button type="button" class="addRuleBtn" style="margin-top: 4px">添加规则库</button> -->
		   			<button type="button" class="addJoinBtn">添加</button>
		   		</div>
		   	</div>	
		   	<!-- <div class="" style="height:30px;">
		   		<button type="button" class="clearBtn">清空</button>
		   	</div> -->
		</div>
		<div class="ruleTreeInfo left">
			<ul id="ruleTree" class="ztree"></ul>
		</div>
	</div>
	
	<script type="text/javascript">
		$(function() {
			//清空各输入框
		    $(".clearBtn").click(function(){
		    	$(".keyCon").val("");
		    })
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
		        insertAtCursor(document.getElementById('joinKeyCon'),valTxt);
		    });
	        //添加自定义参数按钮
	        $(".paraPlus").click(function(){
	        	var idx = 'param' + funTreeFun.curPrmCnt;
	        	var definedParaHtml = '<li id="'+idx+'"><input type="text" value="" placeholder="字段名称" class="definedParaCon addtxt"><input type="text" value="" placeholder="数据类型" class="definedParaCon addtype"></li>';
	        	$(".conditionPara ul").append(definedParaHtml);
	        	funTreeFun.curPrmCnt++;
	        });
	        //添加函数表达式按钮
	        $(".conditionBtn > .addJoinBtn").click(function() {
	            //判断拖拽的参数类型是否与函数类型符合
	            var fuNode = funTreeFun.node;
	            var fuParentNode = fuNode.getParentNode();
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
	                var params = fuNode.inputParam == undefined? 0:fuNode.inputParam;
	                var fNodeParams = JSON.parse(params);
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
	                var newTxt = fuParentNode.packageName + '.'+fuParentNode.funName+'.'+fuNode.funName +'(';
	                for(i = 0; i < lis.length; i++){
	                	var isDataNode = $(lis[i]).data("node");
	                	if(isDataNode == null){
	                		newTxt +=  '[' +$(lis[i]).find(".addtxt").val() + '],';
	                	}else{
	                		newTxt += '[' + isDataNode.enName + '],';
	                	}
	                    
	                }
	                newTxt = newTxt.substring(0,newTxt.length-1);
	                newTxt += ')';
	                insertAtCursor(document.getElementById('joinKeyCon'),newTxt)
	            }
	        });
		});
	
	    var flowTreeFun = {
	    	//变量树的拖拽开始时触发函数
		    dragMove: function(e, treeId, treeNodes) {
		        //if (!$(".cfgCore").is(":visible")) return;
		        //当鼠标拖拽的位置在目标元素上时该元素加蓝色外发光
		        var targetCls = ["joinKeyCon", "conditionPara"];
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
		            i, j, pos, domType, valTxt0 = '[' + treeNodes[0].enName + ']', 
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
		        if (targetCls != undefined && targetCls.indexOf("joinKeyCon") >= 0) {
		            //textarea
		            valTxtadd = $(".joinKeyCon").val()+valTxt0;
            		$(".joinKeyCon").val(valTxtadd);

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
		                paramTp = '<span style="margin-left:5px;" class="type">'+type+'</span>';
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
		        $('.joinKeyCon').removeClass('moveActive');
		        $('.conditionPara').removeClass('moveActive');
		    },
	    };
	    var ruleTreeFun = {
	    	//变量树的拖拽开始时触发函数
		    dragMove: function(e, treeId, treeNodes) {
		        //当鼠标拖拽的位置在目标元素上时该元素加蓝色外发光
		        var targetCls = ["joinKeyCon", "conditionPara"];
		        var cls = $(e.target).attr("class");

		        for (i = 0; i < targetCls.length; i++) {
		            var parentCls = $(e.target).parents("." + targetCls[i]);
		            if (cls != undefined && cls.indexOf(targetCls[i]) >= 0 && parentCls.length == 0) {
		                ruleTreeFun.removeActive();
		                $(e.target).addClass('moveActive');
		            } else if (parentCls.length > 0) {
		                ruleTreeFun.removeActive();
		                $(".conditionPara").addClass('moveActive');
		            }
		        }
		    },
		    //拖拽变量树的子节点后松开时触发函数
		    onDropParame: function(e, treeId, treeNodes, targetNode, moveType) {
		        var mX = 0,
		            mY = 0,
		            i, j, pos, domType, valTxt0 = '[' + treeNodes[0].enName + ']',
		            node = treeNodes[0],
		            valTxts = "";
		        var dictId = node.dictId;
		        var e = e || window.event;
		        var targetCls = $(e.target).attr("class");
		        var iptHtml = '<input id="result" class="result" type="text"/>';
		        //判断添加到哪个元素上
		        if (targetCls != undefined && targetCls.indexOf("joinKeyCon") >= 0) {
		            //textarea
		            valTxtadd = $(".joinKeyCon").val()+valTxt0;
            		$(".joinKeyCon").val(valTxtadd);

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
		                paramTp = '<span style="margin-left:5px;" class="type">'+type+'</span>';
		            }
		            var idx = 'param' + funTreeFun.curPrmCnt;
		            var tempHtml = '<li id="'+idx+'"><span class="pName">' + valTxt0 +'</span>'+ paramTp + '</li>';
		            $(".conditionPara > ul").append(tempHtml);
		            $("#" + idx).data("node",node);
		            //ruleCfg.bindFunPrmLiClick();
		            funTreeFun.curPrmCnt++;
		        }
		        //变激活状态为平常状态
		        ruleTreeFun.removeActive();
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
		        $('.joinKeyCon').removeClass('moveActive');
		        $('.conditionPara').removeClass('moveActive');
		    },
	    };
	    var funTreeFun = {
		    //当前选中的函数节点
		    node:null,
		    curPrmCnt: 1,
		    //更新描述部分的页面内容
		    generateHtml: function(){
		        var i = 0, params = funTreeFun.node.inputParam == undefined ? 0: funTreeFun.node.inputParam;
		        var paramsJSON = JSON.parse(params);
		        var parameter = "";
		        var grammar = funTreeFun.node.funName + '(';
		        paramsJSON.forEach(function(value,index,array){
		        	grammar += value.funParamType;
		        	parameter += ("参数"+(index+1)+" : ");
		        	parameter += value.funParamDescribe;
		        	 if(index != (array.length-1)){
		        		 //多个参数中间逗号分开
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
			   
	    var flowzTreeObj;
		var rulezTreeObj;
	    // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
	    var flowSetting = {
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
	    var ruleSetting = {
	    	callback: {
	            beforeDrag: ruleTreeFun.varsTreeBeforeDrag,
	            onDrop: ruleTreeFun.onDropParame,
	            onDragMove: ruleTreeFun.dragMove
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
	    var conditionListSetting = {
	        callback: {
	            onClick: funTreeFun.conditionListFunClick
	        },
	        data:{
				simpleData: {
					enable:true, 
					idKey:'id',
					pIdKey:'parentId'
				},
				key:{
					name:'funName',
					url:'xurl'
				}
			}
	    };
	    // zTree 的数据属性，深入使用请参考 API 文档（zTreeNode 节点数据详解）\
	    if( '${fn:length(ztreeMap)}' == '2'){
			var flowNode = ${ztreeMap.left };  	
	    	var ruleNode = ${ztreeMap.right };
	    	var flowzNodes = [{
	    		enNameAndCnName:"实时流字段",
		    	open:true,
		    	isParent:true,
		    	children:${ztreeMap.left }
		    }];
		    var rulezNodes = [{
		    	enNameAndCnName:"规则库字段",
		    	open:true,
		    	isParent:true,
		    	children:${ztreeMap.right }
		    }];
	    }else{
	    	layer.msg('指向关联节点的父节点个数不正确',{time: 1000, icon:5});
	    }
	    var conditionListNodes = ${funDefList };
	    
	    $(document).ready(function(){
	       flowzTreeObj = $.fn.zTree.init($("#flowTree"), flowSetting, flowzNodes);
	       flowzTreeObj.expandAll(true);//展开所有节点
	       rulezTreeObj = $.fn.zTree.init($("#ruleTree"), ruleSetting, rulezNodes);
	       rulezTreeObj.expandAll(true);//展开所有节点
	       conditionListTree = $.fn.zTree.init($("#conditionListTree"), conditionListSetting, conditionListNodes);
	       //$("#conditionList").niceScroll({cursorcolor : "#cccccc"});
	        var eventOpt = '${eventOpt }';
			if(eventOpt != null & eventOpt != ''){
				var optDef = '${eventOpt.optDef}';
				if(optDef!=null & optDef != ''){
					optDef= eval('(' + optDef + ')');
					var joinRule = optDef.joinRule;
					if(joinRule!=null){
						$(".joinKeyCon").val(joinRule);
					}
					var isBroadcast = optDef.isBroadcast;
					if(isBroadcast!=null){
						$("input[name='isBroadcast'][value="+isBroadcast+"]").attr("checked",true);
					}
				}
			}
	    });

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
	</script>
</body>

</html>
