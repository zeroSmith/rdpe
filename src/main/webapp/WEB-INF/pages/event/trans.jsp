<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String webpath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<link rel="stylesheet" type="text/css" href="<%=webpath %>/resources/plugin/flow/css/Font-Awesome-master/css/font-awesome.css">
    <link rel="stylesheet" type="text/css" href="<%=webpath %>/resources/plugin/ztree/css/zTreeStyle/zTreeStyle.css">
	<link rel="stylesheet" type="text/css" href="<%=webpath %>/resources/plugin/flow/css/trans.css">
	
    <script type="text/javascript" src="<%=webpath %>/resources/plugin/jquery/jquery-1.9.1.js"></script>
	<script type="text/javascript" src="<%=webpath %>/resources/plugin/layer/layer.js"></script>
	<script type="text/javascript" src="<%=webpath %>/resources/plugin/ztree/js/jquery.ztree.all.js"></script>
	<script type="text/javascript" src="<%=webpath %>/resources/plugin/nicescroll/jquery.nicescroll.js"></script>
	<script type="text/javascript" src="<%=webpath %>/resources/js/event/UUID.js"></script>	
	<script type="text/javascript" src="<%=webpath %>/resources/js/event/functionList.js"></script>	
    <title>transition</title>
</head>

<body class="container-fluid">
	<div class="treeInfo">
		<div class="flowTreeInfo left">
			<ul id="flowTree" class="ztree"></ul>
		</div>
		<div class="zTreeContent left">
		   	<div class="conTitle">转换规则配置</div>
		   	<div>
		   		<textarea name="" class="transKeyCon" id="transKeyCon" readonly="readonly"></textarea>
				<div class="operatorCon">
                    <div class="operCondition">
                    	<div><span>字段中文名:</span><input type="text" value="" id="chineseName"></div>
                    	<div><span>字段英文名:</span><input type="text" value="" id="englishName"></div><br>
                    	<div><span>字段类型:&nbsp;</span>
                    		<select name="" id="newNodeType">
                    			<option value=""></option>
                    			<option value="char">char</option>
                    			<option value="int">int</option>
                    			<option value="long">long</option>
                    			<option value="float">float</option>
                    			<option value="double">double</option>
                    			<option value="string">string</option>
                    			<option value="date">date</option>
                    		</select>
                    	</div>
                    	<div><span>字段长度:&nbsp;&nbsp;&nbsp;</span>
                    		<input type="text" value="" id="newNodeLength">
                    	</div>
                    </div>               
                    <div class="">
				   		<button type="button" class="sureBtn">确定</button>
				   		<button type="button" class="clearBtn">清空</button>
				   	</div>
                </div>
		   	</div>
		   	<jsp:include page="functionList.jsp"></jsp:include>
		</div>
		<div class="ruleTreeInfo left">
			<ul id="ruleTree" class="ztree"><span class="addBeforeTree">输出字段</span></ul>
		</div>
	</div>
	
	<script>
		//输入字段树
		var flowzTreeObj;
		//输出字段树
		var rulezTreeObj;
		//方法树
		var conditionListTree;
		//存放输出字段
		var outString = new Array(); 
		//整个转换规则定义
		var transOpt = new Array(); 
		//所有的输入字段
		var allInputField = new Array();
		//每次输入的字段
		var inputField = {};
		//旧的转换规则
		var oldRuleExp = "";
		//转换规则
		var ruleExp = "";
		//当前事件
		var eventOpt = ${eventOpt };
		//用于统计输出节点的英文名是否重复
		var newNodeNameArray = new Array();
		//输出字段树
		var flowzNodesOut = [{
			enNameAndCnName:"输出字段", 
			open:true, 
			isParent:true,
			children:outString
		}
	    ];
		
		var flowOutSetting = {
		    	callback: {
		    		 onClick : function(e,treeId,treeNode){
		    			 var _outputIndex = -1;
		    			 transOpt.forEach(function(value,index,arr){
		    				 if(value.outPutFieldDef.fieldId == treeNode.fieldId){
		    					 $("#transKeyCon").val(value.ruleExp);
		    					 oldRuleExp = value.ruleExp;
		    					 _outputIndex = index;
		    				 }
		    			 });
		    			$("#newNodeType").val(treeNode.type);
		 	        	$("#newNodeLength").val(treeNode.len);
		 	        	$("#englishName").val(treeNode.enName);
		 	        	$("#chineseName").val(treeNode.cnName);
		 	        	if(oldRuleExp.length > 0){
		 	        		var ruleExpSplit = oldRuleExp.split("(");
		 	        		var _temp = ruleExpSplit[0].split(".");
		 	        		//函数名
		 	        		var fN = _temp[_temp.length-1];
		 	        		//类名
		 	        		var fClassN = _temp[_temp.length-2];
		 	        		//包名
		 	        		var pN = ruleExpSplit[0].substring(0,ruleExpSplit[0].indexOf("." + fClassN + "." + fN));
		 	        		
		 	        		//得到父节点,可能会有很多
		 	        		var parentNodes = conditionListTree.getNodesByParam("funName",fClassN,null);
		 	        		
		 	        	 	 $.each(parentNodes, function(index, value, array) {
			    				  if((value.packageName) == pN){
				 	        		var nodes = conditionListTree.getNodesByParam("funName",fN,value);
				 	        		conditionListTree.selectNode(nodes[0]);
				 	        		funTreeFun.node = nodes[0];
				 	        		funTreeFun.generateHtml();
			    				  }
			    			 }); 
		 	        	}else{
		 	        		$(".conditionPara > ul").html('');
			 	   			// 所有数据全部置空
			 	   			$(".funName").text("");
			 	   			$(".funGrammar").text("");
			 	   			$(".paramDesc").html("");
			 	   			$(".funDescribe").text("");
			 	   			conditionListTree.cancelSelectedNode(funTreeFun.fuNode);
			 	   			conditionListTree.expandAll(false);
		 	        	}
		 	        	
		 	   			flowzTreeObj.cancelSelectedNode();
		 	        	if(_outputIndex != -1){//用于控制页面初次加载
			 	        	//选中对应的输入字段
				 	   		$.each(transOpt[_outputIndex].inputFieldDef, function(index, value, array) {
				 	   			var _nodes = flowzTreeObj.getNodesByParam("fieldId",value.fieldId,null);
				 	   			//取消所有选中节点
				 	   			flowzTreeObj.selectNode(_nodes[0],true);
				 	   		});
		 	        	}
		 	        	
		    		 },
		    		 onRemove: function(e,treeId,treeNode){
		    			 //当前删除节点在outString中的索引
		    			 var indexThis = "";
		    			 //遍历保存输出字段的数组
		    			 $.each(outString, function(index, value, array) {
		    				  if((value.fieldId) == (treeNode.fieldId)){
		    					  indexThis = index;
		    				 }
		    			 });
		    			 
		    			 //无论当前字段的数据是否为空，都重置为空
			    		 $("#newNodeType").val("");
			 	         $("#newNodeLength").val("");
			 	         $("#englishName").val("");
			 	         $("#chineseName").val("");
			 	         $("#transKeyCon").val("");
		    			 //从数组中删除当前索引,outString的个数与transOpt的个数一致，newNodeNameArray，用于名称不能重名
		    			 newNodeNameArray.splice(indexThis,1);
		    			 outString.splice(indexThis,1);
		    			 transOpt.splice(indexThis,1);
		    			 //重新加载树
		    			 rulezTreeObj = $.fn.zTree.init($("#ruleTree"), flowOutSetting, flowzNodesOut);
		    		 }
		        },
		        edit: {
		            enable: true,
					showRemoveBtn: showRemoveBtn,
					removeTitle: "删除此输出字段",
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
		function showRemoveBtn(treeId,treeNode){
			return !treeNode.isParent;
		}
		
		$(function() {
			//清空各输入框
		    $(".clearBtn").click(function(){
		    	$(".transKeyCon").val("");
		    	allInputField = [];
		    	$("#newNodeType").val("");
	        	$("#newNodeLength").val("");
	        	$("#englishName").val("");
	        	$("#chineseName").val("");
		    	$(".conditionPara > ul").empty();
		    })
	        
	        //确定输出字段
	        $(".sureBtn").click(function(){
	        	var newNodeType = $("#newNodeType").val();
	        	var newNodeLength = $("#newNodeLength").val();
	        	var englishName = $("#englishName").val();
	        	var chineseName = $("#chineseName").val();
	        	if(chineseName == ""){
	        		layer.tips('不能为空', '#chineseName', {
					  tips: [1, '#78BA32'] 
					});
					return;
	        	}
	        	if(englishName == ""){
	        		layer.tips('不能为空', '#englishName', {
					  tips: [1, '#78BA32'] 
					});
					return;
	        	}
	        	if(newNodeType == ""){
	        		layer.tips('不能为空', '#newNodeType', {
					  tips: [1, '#78BA32'] 
					});
					return;
	        	}
	        	if(newNodeLength == ""){
	        		layer.tips('不能为空', '#newNodeLength', {
					  tips: [1, '#78BA32'] 
					});
					return;
	        	}
	        	
	        	//验证是否是数字
	        	var reg = new RegExp("^[0-9]*[1-9][0-9]*$"); 
	        	if(!reg.test(newNodeLength)){
	        		layer.tips('只能是非0正整数', '#newNodeLength', {
					  tips: [1, '#78BA32'] 
					});
					return;
	        	}
	        	
	        	//新的输出字段
	        	var newNode = {
	        			fieldId : UUID.prototype.createUUID (),
        				enName : englishName,
        				cnName : chineseName,
        				type : newNodeType,
        				len : newNodeLength,
        				index : newNodeNameArray.length + 1,
        				enNameAndCnName : englishName+"["+chineseName+"]"
        		};
	        	
	        	//是否已经有当前加入的输出字段
	        	var isHasOutputField = false;
	        	var isHasOutputFieldIndex = "";
	        	if(newNodeNameArray.length > 0){
		        	for(var i=0; i<newNodeNameArray.length; i++){
	        			if(englishName == newNodeNameArray[i]){
	        				isHasOutputField = true;
	        				isHasOutputFieldIndex = i;
	        			}
	        		}
	        	}
	        	if(!isHasOutputField){//没有
	        		newNodeNameArray.push(englishName);
				    outString.push(newNode);
				    rulezTreeObj = $.fn.zTree.init($("#ruleTree"), flowOutSetting, flowzNodesOut);
				  	//当前字段整个转换规则
		        	var transOptDef = {
		        			inputFieldDef : allInputField,
		        			outPutFieldDef : newNode,
		        			ruleExp : ruleExp
		        	};
		        	
		        	transOpt.push(transOptDef);
		        	allInputField = [];
		        	$(".transKeyCon").val("");//清空规则配置
		        	//清空参数列表
		        	$(".conditionPara > ul").empty();
		        	//确定完成，数据进行清空
		        	var newNodeType = $("#newNodeType").val("");
		        	var newNodeLength = $("#newNodeLength").val("");
		        	var englishName = $("#englishName").val("");
		        	var chineseName = $("#chineseName").val("");
	        	}else {
	        		layer.confirm('输出字段英文名称已经存在，需要覆盖吗？', {
						icon : 3,
						btn : [ '是', '否' ]
					}, function(index, layero) {
						newNodeNameArray.splice(isHasOutputFieldIndex,1,englishName);
		    			outString.splice(isHasOutputFieldIndex,1,newNode);
		    			rulezTreeObj = $.fn.zTree.init($("#ruleTree"), flowOutSetting, flowzNodesOut);
		    			
		    			var oldTransOpt = transOpt[isHasOutputFieldIndex];
		    			//当前字段整个新的转换规则
		    			var newTransOptDef = {};
		    			if(ruleExp != oldRuleExp){//转换规则发生了改变
			    			//当前字段整个新的转换规则,只修改了输出字段的属性
				        	newTransOptDef = {
				        			inputFieldDef : allInputField,
				        			outPutFieldDef : newNode,
				        			ruleExp : ruleExp
				        	};
		    			}else{
		    				newTransOptDef = {
				        			inputFieldDef : oldTransOpt.inputFieldDef,
				        			outPutFieldDef : newNode,
				        			ruleExp : ruleExp
				        	};
		    			}
		    			
		    			transOpt.splice(isHasOutputFieldIndex,1,newTransOptDef);
		    			layer.close(index);
					});
	        	}
	        });
		});/*function*/
		

		
	    var flowTreeFun = {
	    	//变量树的拖拽开始时触发函数
		    dragMove: function(e, treeId, treeNodes) {
		        //当鼠标拖拽的位置在目标元素上时该元素加蓝色外发光
		        var targetCls = ["transKeyCon", "conditionPara"];
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
		            valTxts = "";
		        var node = treeNodes[0];
		        var dictId = node.dictId;
		        var e = e || window.event;
		        var targetCls = $(e.target).attr("class");
		        
		        inputField = {
		        			fieldId : node.fieldId,//生成32位的UUID
			        		enName : node.enName,
		       				cnName : node.cnName,
		       				type : node.type,
		       				len : node.len,
		       				index : node.index,
		       				enNameAndCnName : node.enName+"["+node.cnName+"]"
				        };
		        //已经有过规则配置，该数组就清空
		        if($(".transKeyCon").val().length > 0){
		       		 allInputField = [];
		        }
		        
		     	 //判断添加到哪个元素上
		        if (targetCls != undefined && targetCls.indexOf("transKeyCon") >= 0) {
					// 所有数据全部置空
					$(".funName").text("");
					$(".funGrammar").text("");
					$(".paramDesc").html("");
					$(".funDescribe").text("");
					conditionListTree.cancelSelectedNode(funTreeFun.node);
					conditionListTree.expandAll(false);
		        	
		        	allInputField = [];
		        	//清空参数列表
		        	$(".conditionPara > ul").empty();
		            //textarea
		            $(".transKeyCon").val(valTxt0);
		            //如果是节点直接拖到textarea中，转换规则为空。
		            ruleExp = "";
		           	// 每次拖拽则回显数据
		            $("#newNodeType").val(node.type);
	 	        	$("#newNodeLength").val(node.len);
	 	        	$("#englishName").val(node.enName);
	 	        	$("#chineseName").val(node.cnName);
		            
		            
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
		            //每个判断条件下都放一个，否则，退拽了没放入框中，会出现错误
			        allInputField.push(inputField);
		        } else if (targetCls != undefined && targetCls.indexOf("conditionPara") >= 0 || $(e.target).parents(".conditionPara").length > 0) {
		        	if(funTreeFun.node == null){
		        		layer.alert('请先选择方法', {
                            skin: 'layui-layer-lan',
                            closeBtn: 0,
                         });
		        		return ;
		        	}else{
		        		if(funTreeFun.node.funTypeId != '2'){
		        			layer.alert('请先选择方法', {
	                            skin: 'layui-layer-lan',
	                            closeBtn: 0,
	                         });
			        		return ;
		        		}
		        	}
		        	$(".transKeyCon").val("");
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
		            funTreeFun.curPrmCnt++;
			        allInputField.push(inputField);
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
		        $('.transKeyCon').removeClass('moveActive');
		        $('.conditionPara').removeClass('moveActive');
		    },
	    };
	    
	    // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
	    var flowInSetting = {
	    	callback: {
	            beforeDrag: flowTreeFun.varsTreeBeforeDrag,
	            onDrop: flowTreeFun.onDropParame,
	            onDragMove: flowTreeFun.dragMove,
	            onClick : function(e,treeId,treeNode){
	    		 },
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
	            selectedMulti: true
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
	    
	    // zTree 的数据属性，深入使用请参考 API 文档（zTreeNode 节点数据详解）
	    var flowzNodesIn = [{
	    	enNameAndCnName:"输入字段", 
	    	open:true, 
	    	isParent:true,
	    	children:${optField }
	    }];
	    
	    var conditionListSetting = {
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
				},
		        callback: {
		            onClick: funTreeFun.conditionListFunClick
		        }
	    };
	    
	    $(document).ready(function(){
	   		var outputField = ${eventOpt.optDef };
	    	outputField.forEach(function(value,index,array){
	    		//将已有的转换规则加入数组
	    		transOpt.push(value);
	    		//将已有的输出字段加入数组
	    		outString.push(value.outPutFieldDef);
	    		//将英文名加入数组
	    		newNodeNameArray.push(value.outPutFieldDef.enName);
	    	});
	    	//初始化加载输入字段树
	    	flowzTreeObj = $.fn.zTree.init($("#flowTree"), flowInSetting, flowzNodesIn);
	        var funData = ${funData};
	        //初始化加载方法列表树
	        conditionListTree = $.fn.zTree.init($("#conditionListTree"), conditionListSetting, funData);
	      	//初始化加载输出字段树
	        rulezTreeObj = $.fn.zTree.init($("#ruleTree"), flowOutSetting, flowzNodesOut);
	       
	    });

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
