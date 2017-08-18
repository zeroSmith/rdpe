//使用.extend重写myflow.editors方法，写所有属性模块中需要调用的编辑input或者select输入
;(function($) {
    var myflow = $.myflow;
    var location = (window.location+'').split('/');  
    var basePath = location[0]+'//'+location[2]+'/'+location[3]; 
//    ${classify}
    var cfgActionLayer;
	//使用.extend重写myflow.editors方法，写所有属性模块中需要调用的编辑input或者select输入
    $.extend(true, myflow.editors, {
        setCfgData: function(obj) {
            //obj中含有data(返回字符串), cgfId(对应的path或者rect的id)
            //设置动作和条件配置子页面会调用这个方法返回配置动作和条件的值

            if (obj.chgIptType == 'action') {
                $("#paction > input").val(obj.data).trigger("change");
            } else if (obj.chgIptType =='pathCdt') {
                $("#ppathCdt > input").val(obj.data).trigger("change");
            }else if(obj.chgIptType =='condition'){
                $("#pcondition > input").val(obj.data).trigger("change");
            }
        },
        bindPickColor: function(obj, r, src) {
            var _src = src,
                _r = r;
            //obj是rect或者path对象，r是画图上下文。
            //选择颜色时候绑定函数
            var showDom = $("#curColor");
            var colorWrap = $("#colorWrap");
            if (obj.type != 'path' && obj.type != 'fork' && obj.type != 'join') {
                //点击开始、结束、动作的时候
                colorWrap.show();
                showDom.removeAttr('style').attr("style", "background-color:" + obj.attr.fill + ";color:" + obj.text.fill);
            } else if (obj.type == 'fork' || obj.type == 'join') {
                colorWrap.hide();
                return;
            } else if (obj.type == 'path') {
                //点击线的时候
                colorWrap.show();
                showDom.removeAttr('style').attr("style", "background-color:" + obj.attr.text.fill);
            }

            $("#colorBoard > table td").unbind();
            $("#colorBoard > table td").click(function() {

                var styleStr = $(this).attr("style");
                var styleArr = styleStr.split(";");
                var bkColor, txtColor, i = 0,
                    tempArr;
                for (i = 0; i < styleArr.length; i++) {
                    if (styleArr[i].indexOf('background-color') >= 0) {
                        tempArr = styleArr[i].split(':');
                        bkColor = $.trim(tempArr[1]);
                    } else if (styleArr[i].indexOf('color') >= 0) {
                        tempArr = styleArr[i].split(':');
                        txtColor = $.trim(tempArr[1]);
                    }
                }

                showDom.removeAttr('style').attr("style", "background-color:" + bkColor + ";color:" + txtColor);

                //改变对象中的颜色
                if (obj.type != 'path' && obj.type != 'fork' && obj.type != 'join') {
                    //点击开始、结束、动作的时候
                    obj.attr.fill = bkColor;
                    obj.text.fill = txtColor;
                    //改变长方形背景和其中文字的颜色
                    $(_r).trigger('colorchange', [bkColor, txtColor, _src]);
                } else if (obj.type == 'path') {
                    //点击线的时候
                    obj.attr.text.fill = bkColor;
                    //改变线上文字的颜色
                    $(_r).trigger('colorchange', ['', bkColor, _src]);
                }
            });
        },
        textEditor: function() {
            //不可编辑的输入框如：分支、开始节点
            var _props, _k, _div, _src, _r;
            this.init = function(O, k, div, src, r) {
                _props = O.props;
                _k = k;
                _div = div;
                _src = src;
                _r = r;

                $('<input  style="width:100%;" readOnly="true"/>').val(_src.text()).change(
                    function() {
                        props[_k].value = $(this).val();
                        $(_r).trigger('textchange', [$(this).val(), _src]);
                    }).appendTo('#' + _div);

                $('#' + _div).data('editor', this);
                //改变颜色函数绑定
                myflow.editors.bindPickColor(O, r, _src);
            };
            this.destroy = function() {
                $('#' + _div + ' input').each(function() {
                    _props[_k].value = $(this).val();
                    $(_r).trigger('textchange', [$(this).val(), _src]);
                });
            };
        },
        inputEditor: function() {
            //使用在属性窗口的第一个输入框，输入框中的值变化可以让图上的文字改变
            var _props, _k, _div, _src, _r;
            this.init = function(O, k, div, src, r) {
                _props = O.props;
                _k = k;
                _div = div;
                _src = src;
                _r = r;
                var pathObjs = myflow.config.restore.paths;

                $('<input id="propTxts" style="width:100%;"/>').change(function() {
                    _props[_k].value = $(this).val();
                    if (_src.getId().indexOf('path') >= 0) {
                        pathObjs[_src.getId()].text.text = $(this).val();
                        pathObjs[_src.getId()].props.text.value = $(this).val();
                    }
                    $(_r).trigger('textchange', [$(this).val(), _src]);
                }).appendTo('#' + _div).bind('keyup', function(event) {
                    if (event.keyCode == "13") {
                        //回车执行更新数据
                        $(this).trigger("change");
                    }
                });

                if (_src.getId().indexOf('path') >= 0) {
                    _props[_k].value = pathObjs[_src.getId()].text.text;
                }
                $("#propTxts").val(_props[_k].value);

                $('#' + _div).data('editor', this);
                //改变颜色函数绑定
                myflow.editors.bindPickColor(O, r, _src);
            }
            this.destroy = function() {
                $('#' + _div + ' input').each(function() {
                    _props[_k].value = $(this).val();
                });
            }
        },
        inputEditorSec: function() {
            //图上的文字不随着输入框中的文字改变，只是多了一个可以编辑的输入框的属性
            var _props, _k, _div, _src, _r;
            this.init = function(O, k, div, src, r) {
                _props = O.props;
                _k = k;
                _div = div;
                _src = src;
                _r = r;
                var pathObjs = myflow.config.restore.paths;

                $('<input id="propTxtsSec" style="width:100%;"/>').change(function() {
                    _props[_k].value = $(this).val();
                }).appendTo('#' + _div).bind('keyup', function(event) {
                    if (event.keyCode == "13") {
                        //回车执行更新数据
                        $(this).trigger("change");
                    }
                });
                $("#propTxtsSec").val(_props[_k].value);

                $('#' + _div).data('editor', this);
            }
            this.destroy = function() {
                $('#' + _div + ' input').each(function() {
                    _props[_k].value = $(this).val();
                });
            }
        },
        inputEditorMore: function(type) {
            //带更多的按钮的输入框，输入框不可编辑
            var _props, _k, _t, _div, _src, _r ,_id;
            this.init = function(O, k, div, src, r) {
                _props = O.props;
                _obj = O,
                _k = k;
                _div = div;
                _src = src;
                _r = r;
                _id = src.getId();//optId
//                _id = O.id;
                var _pathWithCdt = true;
                var states = myflow.config.restore.states;
                var pathObjs = myflow.config.restore.paths;
                var layerTop = $(window).height() / 2 - 516 / 2;
                var _props_ = myflow.config.restore.props;
                
                var paths = myflow.config.restore.paths;
                var topVal = layerTop + 'px';
                var hasPath = false;//是否有连线，默认没有
                for (var k in paths) {
                    if (paths[k].to == _id) {
	                   	 hasPath = true;
	                   	 break;//结束循环
                    }
                }
                
                $('<input class="moreCdt"  readOnly="true"/>').val(_props[_k].value).change(function() {
                    _props[_k].value = $(this).val();
                }).appendTo('#' + _div);

                if (type == "pathCdt") {
                    //判断是从分支节点出来的线
                    var from = pathObjs[_src.getId()].from;

                    for (var rect in states) {
                        if (rect == from && (states[rect].type == 'fork' || states[rect].type == 'forkTxt')) {
                            //线的from端是分支，可以显示配置条件
                            $(".moreCdt").width('128px');
                            _pathWithCdt = true;
                            break;
                        } else {
                            $(".moreCdt").width('100%');
                            _pathWithCdt = false;
                        }
                    }

                }

                if (type == "ds") {
                    //打开配置子页面函数绑定
                    $(".moreCdt").attr("style","margin-right:5px;width:128px");
                    $('<button class="setMove">&hellip;</button>').click(function() {
                    	if(hasPath){
                    		layer.open({
                    			type: 2, 
                    			title: '数据源配置',
                    			area: ['400px', '350px'],
                    			btn: ['保存', '取消'],
                    			yes: function(index, layero){
                    				var body = layer.getChildFrame('body', index);//获取iframe页的DOM元素
                    				var params = {
                    						"asType" : body.find("select[name='astype']").val(),
                    						"dsType" : body.find("select[name='dstype']").val(),
                    						"dsName" : body.find("select[name='dsname']").val(),
                    						"dsFormat" : body.find("select[name='dsformat']").val()
                    				};
                    				$.ajax({
                    					"url":basePath+"/event/opt/ds/add/"+_props_.id+'/'+_id,
                    					"type":"POST",
                    					dataType:"json",
                    					data:JSON.stringify(params),
                    					contentType : "application/json",
                    					success:function(data){
                    						if(data){
                    							layer.msg('操作成功！', {time: 1000, icon:1});
                    						}else{
                    							layer.msg('操作失败！', {time: 1000, icon:2});
                    						}
                    						layer.close(index);
                    					},
                    					error : function(error) {
                    						layer.open({
                    							title:'<i class="iconfont">&#xe649;</i>&nbsp;提示',
                    							content: "出错了！！:" + error
                    						});
                    					}
                    				});
                    			},
                    			maxmin:'true',
                    			content: basePath+'/event/opt/ds/'+_props_.id+'/'+_id
                    		});
                    	}else{
                    		layer.msg('请先连接当前节点!',{
                                offset: topVal,
                                time :1500
                            });
                    	}

                    }).appendTo('#' + _div);
                }
               
                if (type == "parse") {
                    //打开配置子页面函数绑定
                    $(".moreCdt").attr("style","margin-right:5px;width:128px");
                    $('<button class="setMove">...</button>').click(function() {
                    	 if(hasPath){
                    		 var fromRectId;
                    		 for (var k in paths) {
                                 if (paths[k].to == _id) {
                                	 fromRectId = paths[k].from;//获取当前节点的父节点的id
             	                   	 break;//结束循环
                                 }
                             }
                    		 if(states[fromRectId].type == "ds"){//上级节点是提取节点
                    			 var hasParentDs=false;
                    			 var dsFormat;
                    			 $.ajax({
                    				 "url":basePath+"/event/opt/parse/getDs/"+_props_.id+'/'+fromRectId,
                    				 "type":"POST",
                    				 dataType:"json",
                    				 async: false,
                    				 contentType : "application/json",
                    				 success:function(data){
                    					 if(data.info=="correct"){
                    						 hasParentDs=true;
                    						 dsFormat = data.format;
                    					 }
                    				 },
                    				 error : function(error) {
                    					 layer.open({
                    						 title:'<i class="iconfont">&#xe649;</i>&nbsp;提示',
                    						 content: "出错了！！:" + error
                    					 });
                    				 }
                    			 });
                    			 if(hasParentDs){//提取节点的配置字段正确
                    				 if(dsFormat=="separator"){//数据源格式是分隔符
                    					 var index = layer.open({
                    						 type: 2, 
                    						 title: '字段配置',
                    						 area: ['700px', '350px'],
                    						 maxmin:'true',//开启最大化最小化按钮
                    						 content: basePath+'/event/opt/parse/'+_props_.id+'/'+_id,
                    						 btn: ['保存', '取消'],
                    						 yes: function(index, layero){
                    							 var body = layer.getChildFrame('body', index);//获取iframe页的DOM元素
                    							 var fieldIds = new Array();
                    							 var chineseName = new Array();
                    							 var englishName = new Array();
                    							 var fieldType = new Array();
                    							 var fieldLength = new Array();
                    							 var fieldIndex = new Array();
                    							 var isEmpty = false;
                    							 body.find('input[name="fieldId"]').each(function(i) {
                    								 fieldIds[i] = $(this).val();
                    							 });
                    							 body.find('input[name="cnName"]').each(function(i) {
                    								 if($(this).val() === ''){
                    									 isEmpty = true;
                    									 return;
                    								 }
                    								 chineseName[i] = $(this).val();
                    							 });
                    							 body.find('input[name="enName"]').each(function(i) {
                    								 if($(this).val() === ''){
                    									 isEmpty = true;
                    									 return;
                    								 }
                    								 englishName[i] = $(this).val();
                    							 });
                    							 body.find('select[name="type"]').each(function(i) {
                    								 if($(this).val() === ''){
                    									 isEmpty = true;
                    									 return;
                    								 }
                    								 fieldType[i] = $(this).val();
                    							 });
                    							 body.find('input[name="len"]').each(function(i) {
                    								 if($(this).val() === ''){
                    									 isEmpty = true;
                    									 return;
                    								 }
                    								 fieldLength[i] = $(this).val();
                    							 });
                    							 body.find('input[name="index"]').each(function(i) {
                    								 if($(this).val() === ''){
                    									 isEmpty = true;
                    									 return;
                    								 }
                    								 fieldIndex[i] = $(this).val();
                    							 });
                    							 var separator = body.find('input[name="firstseparator"]').val();
                    							 if(separator === ''){//对分隔符进行非空校验
                    								 layer.msg('分隔符不能为空', {time: 1000, icon:5});
                    								 return;
                    							 }
                    							 if(isEmpty){//对表单字段各列进行非空校验
                    								 layer.msg('必填项不能为空', {time: 1000, icon:5});
                    								 return;
                    							 }
                    							 var list = [];//定义一个集合，存放表单中的多行值
                    							 for(var i=0;i<englishName.length;i++){
                    								 var obj = new Object(); 
                    								 obj.fieldId = fieldIds[i];
                    								 obj.cnName = chineseName[i];
                    								 obj.enName = englishName[i];
                    								 obj.type = fieldType[i];
                    								 obj.len = fieldLength[i];
                    								 obj.index = fieldIndex[i];
                    								 list[i]=obj;
                    							 }
                    							 var params = {
                    									 "firstSeparator" : body.find('input[name="firstseparator"]').val(),
                    									 "fieldDef" : list
                    							 };
                    							 $.ajax({
                    								 "url":basePath+"/event/opt/parse/separator/add/"+_props_.id+'/'+_id,
                    								 "type":"POST",
                    								 dataType:"json",
                    								 data:JSON.stringify(params),
                    								 contentType : "application/json",
                    								 success:function(data){
                    									 if(data){
                    										 layer.msg('操作成功！', {time: 1000, icon:1});
                    									 }else{
                    										 layer.msg('操作失败！', {time: 1000, icon:2});
                    									 }
                    									 layer.close(index);
                    								 },
                    								 error : function(error) {
                    									 layer.open({
                    										 title:'<i class="iconfont">&#xe649;</i>&nbsp;提示',
                    										 content: "出错了！！:" + error
                    									 });
                    								 }
                    							 });
                    						 },
                    						 btn2: function(index, layero){
                    							 layer.close(index);
                    						 }
                    					 });
                    					 layer.full(index);
                    					 
                    				 }else if(dsFormat=="json"){//数据源格式是json
                    					 var indexOfJson = layer.open({
                    						 type: 2, 
                    						 title: '字段配置',
                    						 area: ['700px', '350px'],
                    						 maxmin:'true',//开启最大化最小化按钮
                    						 content: basePath+'/event/opt/parse/'+_props_.id+'/'+_id,
                    						 btn: ['保存', '取消'],
                    						 yes: function(index, layero){
                    							 var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method()
                    							 var _propertyArray = iframeWin.propertyArray;
                    							 _propertyArray.splice(0,1);//剔除第一个元素
                    							 var _optdef = {};
                    							 _optdef["jsonProperties"] = _propertyArray;
                    							 $.ajax({
                    								 "url":basePath+"/event/opt/parse/json/add/"+_props_.id+'/'+_id,
                    								 "type":"POST",
                    								 dataType:"json",
                    								 data:{
                    									 optDef:JSON.stringify(_optdef)
                    								 },
                    								 success:function(data){
                    									 if(data){
                    										 layer.msg('操作成功！', {time: 1000, icon:1});
                    									 }else{
                    										 layer.msg('操作失败！', {time: 1000, icon:2});
                    									 }
                    									 layer.close(index);
                    								 },
                    								 error : function(error) {
                    									 layer.open({
                    										 title:'<i class="iconfont">&#xe649;</i>&nbsp;提示',
                    										 content: "出错了！！:" + error
                    									 });
                    								 }
                    							 });
                    						 }
                    					 });
                    					 layer.full(indexOfJson);
                    				 }else if(dsFormat=="xml"){//数据源格式是xml
                    					 
                    				 }
                    			 }else{
                    				 layer.msg('请检查上级提取节点的配置信息!',{
                    					 offset: topVal,
                    					 time :1500
                    				 });
                    			 }
                    		 }else{//上级节点是函数节点
                    			 layer.open({
                					 type: 2, 
                					 title: '字段配置',
                					 area: ['700px', '350px'],
                					 maxmin:'true',//开启最大化最小化按钮
                					 content: basePath+'/event/opt/parse/'+_props_.id+'/'+_id,
                					 btn: ['保存', '取消'],
                					 yes: function(index, layero){
                						 var body = layer.getChildFrame('body', index);//获取iframe页的DOM元素
                						 var fieldIds = new Array();
                						 var chineseName = new Array();
                						 var englishName = new Array();
                						 var fieldType = new Array();
                						 var fieldLength = new Array();
                						 var fieldIndex = new Array();
                						 var isEmpty = false;
                						 body.find('input[name="fieldId"]').each(function(i) {
                							 fieldIds[i] = $(this).val();
                						 });
                						 body.find('input[name="cnName"]').each(function(i) {
                							 if($(this).val() === ''){
                								 isEmpty = true;
                								 return;
                							 }
                							 chineseName[i] = $(this).val();
                						 });
                						 body.find('input[name="enName"]').each(function(i) {
                							 if($(this).val() === ''){
                								 isEmpty = true;
                								 return;
                							 }
                							 englishName[i] = $(this).val();
                						 });
                						 body.find('select[name="type"]').each(function(i) {
                							 if($(this).val() === ''){
                								 isEmpty = true;
                								 return;
                							 }
                							 fieldType[i] = $(this).val();
                						 });
                						 body.find('input[name="len"]').each(function(i) {
                							 if($(this).val() === ''){
                								 isEmpty = true;
                								 return;
                							 }
                							 fieldLength[i] = $(this).val();
                						 });
                						 body.find('input[name="index"]').each(function(i) {
                							 if($(this).val() === ''){
                								 isEmpty = true;
                								 return;
                							 }
                							 fieldIndex[i] = $(this).val();
                						 });
                						 var separator = body.find('input[name="firstseparator"]').val();
                						 if(separator === ''){//对分隔符进行非空校验
                							 layer.msg('分隔符不能为空', {time: 1000, icon:5});
                							 return;
                						 }
                						 if(isEmpty){//对表单字段各列进行非空校验
                							 layer.msg('必填项不能为空', {time: 1000, icon:5});
                							 return;
                						 }
                						 var list = [];//定义一个集合，存放表单中的多行值
                						 for(var i=0;i<englishName.length;i++){
                							 var obj = new Object(); 
                							 obj.fieldId = fieldIds[i];
                							 obj.cnName = chineseName[i];
                							 obj.enName = englishName[i];
                							 obj.type = fieldType[i];
                							 obj.len = fieldLength[i];
                							 obj.index = fieldIndex[i];
                							 list[i]=obj;
                						 }
                						 var params = {
                								 "firstSeparator" : body.find('input[name="firstseparator"]').val(),
                								 "fieldDef" : list
                						 };
                						 $.ajax({
                							 "url":basePath+"/event/opt/parse/add/"+_props_.id+'/'+_id,
                							 "type":"POST",
                							 dataType:"json",
                							 data:JSON.stringify(params),
                							 contentType : "application/json",
                							 success:function(data){
                								 if(data){
                									 layer.msg('操作成功！', {time: 1000, icon:1});
                								 }else{
                									 layer.msg('操作失败！', {time: 1000, icon:2});
                								 }
                								 layer.close(index);
                							 },
                							 error : function(error) {
                								 layer.open({
                									 title:'<i class="iconfont">&#xe649;</i>&nbsp;提示',
                									 content: "出错了！！:" + error
                								 });
                							 }
                						 });
                					 },
                					 btn2: function(index, layero){
                						 layer.close(index);
                					 }
                				 });
                    		 }
                    	 }else{
                    		 layer.msg('请先连接当前节点!',{
                                 offset: topVal,
                                 time :1500
                             });
                    	 }

                    }).appendTo('#' + _div);
                }
				
				if (type == "join") {
                    //打开配置子页面函数绑定
                    $(".moreCdt").attr("style","margin-right:5px;width:128px");
                    $('<button class="setMove">...</button>').click(function() {
                    	var count = 0;
                    	for (var k in paths) {
                            if (paths[k].to == _id) {
        	                   	count=count+1;
                            }
                        }
                    	if(hasPath && count ==2){
                    		layer.open({
                    			type: 2, 
                    			title: '关联配置',
                    			area: ['1000px', '400px'],
                    			btn: ['保存', '取消'],
                    			yes: function(index, layero){
                    				var body = layer.getChildFrame('body', index);//获取iframe页的DOM元素
                    				var iframeWin = window[layero.find('iframe')[0]['name']];
                    				var joinKeyCon = body.find('#joinKeyCon').val();
                    				var isBroadcast = body.find("input[name='isBroadcast']:checked").val();
                    				var list = iframeWin.flowNode;
                    				list = list.concat(iframeWin.ruleNode);
                    				$.each(list, function(index, value, array) {
                    					list[index].index = index;
                    				});
                    				var params = {
                    						"streamFieldDef" : iframeWin.flowNode,
                    						"ruleFieldDef" : iframeWin.ruleNode,
                    						"outPutFieldDef" : list,
                    						"joinRule" : joinKeyCon,
                    						"isBroadcast" : isBroadcast
                    				};
                    				$.ajax({
                    					"url":basePath+"/event/opt/join/add/"+_props_.id+'/'+_id,
                    					"type":"POST",
                    					dataType:"json",
                    					data:JSON.stringify(params),
                    					contentType : "application/json",
                    					success:function(data){
                    						if(data){
                    							layer.msg('操作成功！', {time: 1000, icon:1});
                    						}else{
                    							layer.msg('操作失败！', {time: 1000, icon:2});
                    						}
                    						layer.close(index);
                    					},
                    					error : function(error) {
                    						layer.open({
                    							title:'<i class="iconfont">&#xe649;</i>&nbsp;提示',
                    							content: "出错了！！:" + error
                    						});
                    					}
                    				});
                    			},
                    			maxmin:'true',
                    			content: basePath+'/event/opt/join/'+_props_.id+'/'+_id
                    		});
                    	}else{
                    		 layer.msg('请先连接当前节点，检查父节点个数是否为2',{
                                 offset: topVal,
                                 time :1500
                             });
                    	}

                    }).appendTo('#' + _div);
                }
				
				if (type == "filter") {
                    //打开配置子页面函数绑定
                    $(".moreCdt").attr("style","margin-right:5px;width:128px");
                    $('<button class="setMove">...</button>').click(function() {
                    	if(hasPath){
                    		layer.open({
                    			type: 2, 
                    			title: '过滤配置',
                    			area: ['800px', '500px'],
                    			btn: ['保存', '取消'],
                    			maxmin:'true',
                    			content: basePath+'/event/opt/filter/'+_props_.id+'/'+_id,
                    			btn1: function(index, layero){
                    				var body = layer.getChildFrame('body', index);//获取iframe页的DOM元素      	
                    				var ruleExp = body.find('#filterKeyCon').val();
                    				var fieldDef = body.find('input[id=data]').val();
                    				$.ajax({
                    					"url":basePath+"/event/opt/filter/add/"+_props_.id+'/'+_id,
                    					"type":"POST",
                    					dataType:"json",
                    					data:{
                    						ruleExp:JSON.stringify(ruleExp),
                    						fieldDef:fieldDef
                    					},
                    					success:function(data){
                    						if(data){
                    							layer.msg('操作成功！', {time: 1000, icon:1});
                    						}else{
                    							layer.msg('操作失败！', {time: 1000, icon:2});
                    						}
                    						layer.close(index);
                    					},
                    					error : function(error) {
                    						layer.open({
                    							title:'<i class="iconfont">&#xe649;</i>&nbsp;提示',
                    							content: "出错了！！:" + error
                    						});
                    					}
                    				});
                    			},
                    			btn2: function(index, layero){
                    				layer.close(index);
                    			}
                    		});
                    	}else{
                    		layer.msg('请先连接当前节点!',{
                                offset: topVal,
                                time :1500
                            });
                    	}

                    }).appendTo('#' + _div);
                }
				
				
				if (type == "trans") {
                    //打开配置子页面函数绑定
                    $(".moreCdt").attr("style","margin-right:5px;width:128px");
                    $('<button class="setMove">&hellip;</button>').click(function() {
                    	if(hasPath){
                    		layer.open({
                    			type: 2, 
                    			title: '转换配置',
                    			area: ['1024px', '450px'],
                    			btn: ['保存', '取消'],
                    			yes: function(index, layero){
                    				var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method()
                    				var _transOpt_ = iframeWin.transOpt;
                    				$.each(_transOpt_, function(index, value, array) {
                    					_transOpt_[index].outPutFieldDef.index = index;
                    				});
                    				var _transOpt = JSON.stringify(_transOpt_);
                    				var _eventOpt = JSON.stringify(iframeWin.eventOpt);
                    				$.ajax({
                    					"url":basePath+"/event/opt/trans/add",
                    					"type":"POST",
                    					dataType:"json",
                    					data:{
                    						eventOptStr : _eventOpt,
                    						optDef : _transOpt
                    					},
                    					success:function(data){
                    						if(data){
                    							layer.msg('操作成功！', {time: 1000, icon:1});
                    						}else{
                    							layer.msg('操作失败！', {time: 1000, icon:2});
                    						}
                    						layer.close(index);
                    					},
                    					error : function(error) {
                    						layer.open({
                    							title:'<i class="iconfont">&#xe649;</i>&nbsp;提示',
                    							content: "出错了！！:" + error
                    						});
                    					}
                    				});
                    			},
                    			maxmin:'true',
                    			content: basePath+'/event/opt/trans/'+_props_.id+'/'+_id
                    		});
                    	}else{
                    		layer.msg('请先连接当前节点!',{
                                offset: topVal,
                                time :1500
                            });
                    	}

                    }).appendTo('#' + _div);
                }
				
				if (type == "aggregate") {
                    //打开配置子页面函数绑定
                    $(".moreCdt").attr("style","margin-right:5px;width:128px");
                    $('<button class="setMove">&hellip;</button>').click(function() {
                    	if(hasPath){
                    		layer.open({
                    			type: 2, 
                    			title: '聚合配置',
                    			area: ['1024px', '450px'],
                    			btn: ['保存', '取消'],
                    			yes: function(index, layero){
                    				var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method()
                    				var _aggOpt_ = iframeWin.aggregateOpt;
                    				$.each(_aggOpt_, function(index, value, array) {
                    					_aggOpt_[index].outPutFieldDef.index = index;
                    				});
                    				var _aggOpt = JSON.stringify(_aggOpt_);
                    				var _eventOpt = JSON.stringify(iframeWin.eventOpt);
                    				$.ajax({
                    					"url":basePath+"/event/opt/aggregate/add",
                    					"type":"POST",
                    					dataType:"json",
                    					data:{
                    						eventOptStr : _eventOpt,
                    						optDef : _aggOpt
                    					},
                    					success:function(data){
                    						if(data){
                    							layer.msg('操作成功！', {time: 1000, icon:1});
                    						}else{
                    							layer.msg('操作失败！', {time: 1000, icon:2});
                    						}
                    						layer.close(index);
                    					},
                    					error : function(error) {
                    						layer.open({
                    							title:'<i class="iconfont">&#xe649;</i>&nbsp;提示',
                    							content: "出错了！！:" + error
                    						});
                    					}
                    				});
                    			},
                    			maxmin:'true',
                    			content: basePath+'/event/opt/aggregate/'+_props_.id+'/'+_id
                    		});
                    	}else{
                    		layer.msg('请先连接当前节点!',{
                                offset: topVal,
                                time :1500
                            });
                    	}

                    }).appendTo('#' + _div);
                }
				
				if (type == "store") {
                    //打开配置子页面函数绑定
                    $(".moreCdt").attr("style","margin-right:5px;width:128px");
                    $('<button class="setMove">&hellip;</button>').click(function() {
                    	if(hasPath){
                    		layer.open({
                    			type: 2, 
                    			title: '数据存储配置',
                    			area: ['400px', '320px'],
                    			btn: ['保存', '取消'],
                    			yes: function(index, layero){
                    				var body = layer.getChildFrame('body', index);//获取iframe页的DOM元素
                    				var storeFieldDef=[];
                    				$.ajax({
                    					"url":basePath+"/event/opt/get/"+_props_.id+'/'+_id,
                    					"type":"POST",
                    					dataType:"json",
                    					async: false,
                    					contentType : "application/json",
                    					success:function(data){
                    						if(data.length>0){
                    							storeFieldDef = storeFieldDef.concat(data);
                    						}
                    					},
                    					error : function(error) {
                    						layer.open({
                    							title:'<i class="iconfont">&#xe649;</i>&nbsp;提示',
                    							content: "出错了！！:" + error
                    						});
                    					}
                    				});
                    				var params = {
                    						"storeType" : body.find("select[name='storetype']").val(),
                    						"storeName" : body.find("select[name='storename']").val(),
                    						"storeFormat" : body.find("select[name='storeformat']").val(),
                    						"storeFieldDef" : storeFieldDef
                    				};
                    				$.ajax({
                    					"url":basePath+"/event/opt/store/add/"+_props_.id+'/'+_id,
                    					"type":"POST",
                    					dataType:"json",
                    					data:JSON.stringify(params),
                    					contentType : "application/json",
                    					success:function(data){
                    						if(data){
                    							layer.msg('操作成功！', {time: 1000, icon:1});
                    						}else{
                    							layer.msg('操作失败！', {time: 1000, icon:2});
                    						}
                    						layer.close(index);
                    					},
                    					error : function(error) {
                    						layer.open({
                    							title:'<i class="iconfont">&#xe649;</i>&nbsp;提示',
                    							content: "出错了！！:" + error
                    						});
                    					}
                    				});
                    			},
                    			maxmin:'true',
                    			content: basePath+'/event/opt/store/'+_props_.id+'/'+_id
                    		});
                    	}else{
                    		layer.msg('请先连接当前节点!',{
                                offset: topVal,
                                time :1500
                            });
                    	}

                    }).appendTo('#' + _div);
                }
				
				
				if (type == "fun") {
                    //打开配置子页面函数绑定
                    $(".moreCdt").attr("style","margin-right:5px;width:128px");
                    $('<button class="setMove">&hellip;</button>').click(function() {
                    	if(hasPath){
                    		layer.open({
                    			type: 2, 
                    			title: '函数选择',
                    			area: ['300px', '400px'],
                    			btn: ['保存', '取消'],
                    			yes: function(index, layero){
                    				//当前选择的方法
                    				var funTreeNode;
                    				//当前方法所在的类
                    				var funParentNode;
                    				var iframeWin = window[layero.find('iframe')[0]['name']]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method()
                    				var _resourceTreeObj = iframeWin.resource.treeObj;
                    				var _nodes = _resourceTreeObj.getCheckedNodes(true);
        					    	$.each(_nodes, function(index, value, array) {//判断是否选择了方法
        					    		if(value.funTypeId == "1"){//每一个方法肯定有父类
        					    			funParentNode = value;
        					    		}
        					    		if(value.funTypeId == "2"){
        					    			funTreeNode = value;
        					    		}
        					    	});
        					    	if(!funTreeNode){//即funTreeNode == undefined,,没有选择方法
        					    		layer.msg('请选择方法！', {time: 1000, icon:1});
        					    	}else{
        					    		var _optFunDef = {
	        					    			id: funTreeNode.id,
	        					    			funName: funTreeNode.funName,
	        					    			packageName: funParentNode.packageName,
	        					    			className: funParentNode.funName
        					    			};
        					    		
        					    		var _eventOpt = JSON.stringify(iframeWin.eventOpt);
        					    		console.log(_eventOpt);
                        				$.ajax({
                        					"url":basePath+"/event/opt/trans/add",
                        					"type":"POST",
                        					dataType:"json",
                        					data:{
                        						eventOptStr : _eventOpt,
                        						optDef : JSON.stringify(_optFunDef)
                        					},
                        					success:function(data){
                        						if(data){
                        							layer.msg('操作成功！', {time: 1000, icon:1});
                        						}else{
                        							layer.msg('操作失败！', {time: 1000, icon:2});
                        						}
                        						layer.close(index);
                        					},
                        					error : function(error) {
                        						layer.open({
                        							title:'<i class="iconfont">&#xe649;</i>&nbsp;提示',
                        							content: "出错了！！:" + error
                        						});
                        					}
                        				});
        					    		
        					    	}
                    				
                    			},
                    			maxmin:'true',
                    			content: basePath+'/event/opt/fun/'+_props_.id+'/'+_id
                    		});
                    	}else{
                    		layer.msg('请先连接当前节点!',{
                                offset: topVal,
                                time :1500
                            });
                    	}
                    	
                    	
                    	}).appendTo('#' + _div);
                    }
				
				
                $('#' + _div).data('editor', this);

                //改变颜色函数绑定
                myflow.editors.bindPickColor(O, r, _src);
            }
            this.destroy = function() {
                $('#' + _div + ' input').each(function() {
                    _props[_k].value = $(this).val();
                });
            }
        },
        selectEditor: function(arg) {
            //下拉列表框，如果使用了这个函数需要调用easyui的插件来美化文本框
            //单选 获取值的方法是： $("#sltType").combobox('getValue');
            var _props, _k, _div, _src, _r;
            this.init = function(O, k, div, src, r) {
                _props = O.props;
                _k = k;
                _div = div;
                _src = src;
                _r = r;

                if (typeof arg === 'string') {
                    //传进来一个url用来获取select值
                    //获取的data对象是一个'value','name'值的对象
                    $.ajax({
                        type: "GET",
                        url: arg,
                        success: function(data) {
                            var opts = eval(data);
                            var sle = $('<input  style="width:100%;height:25px;" id="sltType" />').val(_props[_k].value).change(function() {
                                _props[_k].value = $(this).val();
                            }).appendTo('#' + _div);
                            easyloader.load('combobox',function(){
                                // alert('load combobox success!');
                                sle.css("width", sle.parent().width() + "px");
                                sle.combobox({});
                                sle.combobox({
                                    valueField: 'value',
                                    textField: 'name',
                                    editable: false,
                                    data: arg,
                                    panelHeight: 'auto',
                                    onLoadSuccess: function() {
                                        sle.combobox('setValue', _props[_k].value);
                                    },
                                    onSelect: function(record) {
                                        sle.val(record.value);
                                        _props[_k].value = record.value;
                                    }
                                });
                            });
                        }
                    });
                } else {
                    //传进来的arg是一个'value','name'值的对象
                	if(_k == 'funname'){
                		$.ajax({// 根据选择的数据源类型查询数据库
     	    				"url" : basePath + "/funDef/get",
     	    				"type" : "POST",
     	    				dataType : "json",
     	    				async: false,
     	    				success : function(data) {
     	    					if(data!=null){
     	    						for(var i=0;i<data.length;i++){
     	    							var _obj = new Object();
     	    							_obj.name = data[i].funName;
     	    							_obj.value = data[i].id;
     	    							arg[i+1]=_obj;
     	    						}
     	    					}
     	    					
     	    				}
                     	});
                	}
                    var sle = $('<input  style="width:100%;height:25px;" id="sltType" />').val(_props[_k].value).change(function() {
                        _props[_k].value = $(this).val();
                    }).appendTo('#' + _div);
                    easyloader.load('combobox',function(){
                    // alert('load combobox success!');
	                    sle.css("width", sle.parent().width() + "px");
	                    sle.combobox({});
	                    sle.combobox({
	                        valueField: 'value',
	                        textField: 'name',
	                        editable: false,
	                        data: arg,
	                        panelHeight: 'auto',
	                        onLoadSuccess: function() {
	                            if(_props[_k].value != ''){
	                                sle.combobox('setValue', _props[_k].value);
	                            }else{
	                                sle.combobox('setValue', arg[0].value);
	                            }
	                        },
	                        onSelect: function(record) {
	                            sle.val(record.value);
	                            _props[_k].value = record.value;
	                        }
	                    });
	                });
                }
                $('#' + _div).data('editor', this);

            };
            this.destroy = function() {
                $('#' + _div + ' input').each(function() {
                    _props[_k].value = $(this).val();
                });
            };
        },
        selectEditorMulti: function(arg) {
            //下拉列表多选框，如果使用了这个函数需要调用easyui的插件来美化文本框
            //获取值并返回一个逗号分隔的字符串的方法是： $("#sltTypes").combobox('getValues').join('","');
            var _props, _k, _div, _src, _r;
            this.init = function(O, k, div, src, r) {
                _props = O.props;
                _k = k;
                _div = div;
                _src = src;
                _r = r;

                if (typeof arg === 'string') {
                    //传进来一个url用来获取select值
                    //获取的data对象是一个'id','text'值的对象的数组
                    $.ajax({
                        type: "GET",
                        url: arg,
                        success: function(data) {
                            var opts = eval(data);
                            var sle = $('<input  style="width:100%;height:25px;" id="sltTypes" editable="false" class="easyui-combotree" multiple="true"/>').val(_props[_k].value).change(function() {
                                _props[_k].value = $(this).val();
                            }).appendTo('#' + _div);
                            easyloader.load('combotree',function(){
                                // alert('load combotree success!');
                                sle.css("width", sle.parent().width() + "px");
                                sle.combotree({});
                                sle.combotree({
                                    valueField: 'value',
                                    textField: 'name',
                                    editable: false,
                                    data: arg,
                                    panelHeight: 'auto',
                                    onLoadSuccess: function() {
                                        sle.combotree('setValue', _props[_k].value);
                                    },
                                    onSelect: function(record) {
                                        sle.val(record.value);
                                        _props[_k].value = record.value;
                                    }
                                });
                            });
                        }
                    });
                } else {
                    //传进来的arg是一个'id','text'值的对象的数组
                    var sle = $('<input  style="width:100%;height:25px;" id="sltTypes" editable="false" class="easyui-combotree" multiple="true"/>').val(_props[_k].value).change(function() {
                        _props[_k].value = $(this).val();
                    }).appendTo('#' + _div);
                    easyloader.load('combotree',function(){
                        // alert('load combotree success!');
                        sle.css("width", sle.parent().width() + "px");
                        sle.combotree({});
                        sle.combotree('loadData', arg);
                        sle.combotree({
                            onLoadSuccess: function() {
                                if(_props[_k].value != ''){
                                    sle.combotree('setValues', _props[_k].value.split(','));
                                }
                            },
                            onSelect: function(record) {
                                sle.val(record.value);
                                _props[_k].value = record.value;
                            }
                        });
                    });
                }
                $('#' + _div).data('editor', this);

            };
            this.destroy = function() {
                $('#' + _div + ' input').each(function() {
                    _props[_k].value = $(this).val();
                });
            };
        },
    });
	//使用.extend重写myflow.config.tools.save方法，写保存按钮点击时候做的操作。
	$.extend(true, myflow.config.tools.save, {
		onclick: function(data) {
			var classify = $("input[name='classify']").val();
            if(classify=="storm"){
            	var url = basePath + "/event/storm/editFlowDef";
            }else{
            	var url = basePath + "/event/spark/editFlowDef";
            }
			$.ajax({// 更新事件
				"url" : url,
				"type" : "POST",
				dataType : "json",
				data : {
					id : myflow.config.restore.props.id,
					flowDef : data
				},
				success : function(data) {
					layer.msg('保存成功！', {time: 1000, icon:1});
//					window.location.href = basePath+"/event/spark/index";
				}
			});
		}
	});
	
})(jQuery);

//绑定保存按钮显示隐藏的事件
var bindSaveBtn = function() {
    $("#iconCtlSave").click(function() {
        $("#myflow_save").toggle();
    });
}

$(function() {
    bindSaveBtn();
    $("#myflow_tools").show();
    $(".addOneFixedLength").bind({
		 click:function(e){
			 $(".addOneFixedBtn").before(addRow());//点击添加按钮，添加行
		 }
	});
});

function addRow(){
	var options = "<option value=''></option><option value='int'>int</option>" +
		"<option value='long'>long</option><option value='float'>float</option>" +
		"<option value='double'>double</option><option value='string'>string</option>" +
		"<option value='date'>date</option>";
	var addHtml='<tr>'
		+'<input type="hidden" name="fieldId" value="'+uuid()+'" class="form-control idClass">'
        +'<td><input type="text" name="cnName" class="form-control cnNameClass" required lay-verify="required"></td>'
        +'<td><input type="text" name="enName" class="form-control enNameClass" required lay-verify="required"></td>'
        +'<td><select name="type" class="form-control typeClass" required lay-verify="required">' + options + '</select></td>'
        +'<td><input type="text" name="len" class="form-control lenClass" required lay-verify="required" onkeyup=\'if(/\\D/.test(this.value)){layer.msg("只能输入数字", {time: 1000, icon:5});this.value="";}\'></td>'
        +'<td><input type="text" name="index" class="form-control indexClass" required lay-verify="required" onkeyup=\'if(/\\D/.test(this.value)){layer.msg("只能输入数字", {time: 1000, icon:5});this.value="";}\'></td>'
        +'<td><a onclick="delOneFixedLength(this)"><i class="fa fa-trash fa-lg" title="删除该字段"></i></a></td>'
//        +'<td><a onclick="divide(this)"><i class="fa fa-plus fa-lg" title="分割该字段"></i></a></td>'
        +'</tr>';
	return addHtml;
}

function uuid() {
    var s = [];
    var hexDigits = "0123456789abcdef";
    for (var i = 0; i < 36; i++) {
        s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
    }
    s[14] = "4";  // bits 12-15 of the time_hi_and_version field to 0010
    s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1);  // bits 6-7 of the clock_seq_hi_and_reserved to 01
    s[8] = s[13] = s[18] = s[23] = "";
 
    var uuid = s.join("");
    return uuid.replace('-','').toUpperCase();
}

//删除行
function delOneFixedLength(obj){
	if($(obj).parent().parent().next().children().children().attr('class')=="containerInfo"){
		$(obj).parent().parent().next().remove();
	}
    $(obj).parent().parent().remove();
}

function divide(obj){
	 $(obj).parent().parent().after(addTable());
	 $(obj).parent().hide();
}

//添加二级分隔符的表格
function addTable(){
	return '<tr style="border: 1px solid #8a8a8a;"><td colspan="5"><div class="containerInfo">'
	+'<div class="form-group">'
	+'<label for="secondseparator">二级分隔符:</label>&nbsp;<input type="text" class="form-control input-sm" style="width: 20%;" value="" name="secondseparator" id="secondseparator"/>'
	+'</div>'
	+'<div>'
	+'<table class="table table-fixedLength form-table" id="parseOptTable2" style="background-color: #eceff4;">'
	+'<thead><tr><th>字段中文</th><th>字段英文</th><th>字段类型</th><th>长度</th><th>下标位置</th><th>&nbsp;</th><th>&nbsp;</th></tr></thead>'
	+'<tbody>'
	+'<tr class="addOneFixedBtn2">'
	+'<td colspan="7"><a class="addOneFixedLength2" onclick="addTableRow(this)"><i class="fa fa-plus fa-lg"></i>添加</a></td>'
	+'</tr>'
	+'</tbody>'
	+'</table>'
	+'</div>'
	+'</div></td><td colspan="2"><div><a onclick="delDivide(this)" style="margin:15px 0px 0px 0px;"><i class="fa fa-times-circle-o fa-2x"></i></a></div></td></tr>';
}

//删除二级分割符
function delDivide(obj){
	$(obj).parent().parent().parent().prev().children().last().show();
	$(obj).parent().parent().parent().remove();
}


function addTableRow(obj){
	$(".addOneFixedBtn2").before(addRow2());//点击添加按钮，添加行
}

function addRow2(){
	var options = "<option value=''></option><option value='int'>int</option>" +
		"<option value='long'>long</option><option value='float'>float</option>" +
		"<option value='double'>double</option><option value='string'>string</option>" +
		"<option value='date'>date</option>";
	var addHtml='<tr>'
		+'<input type="hidden" name="fieldId" value="'+uuid()+'" class="form-control idClass">'
        +'<td><input type="text" name="cnName" class="form-control cnNameClass" required lay-verify="required"></td>'
        +'<td><input type="text" name="enName" class="form-control enNameClass" required lay-verify="required"></td>'
        +'<td><select name="type" class="form-control typeClass" required lay-verify="required">' + options + '</select></td>'
        +'<td><input type="text" name="len" class="form-control lenClass" required lay-verify="required" onkeyup=\'if(/\\D/.test(this.value)){layer.msg("只能输入数字", {time: 1000, icon:5});this.value="";}\'></td>'
        +'<td><input type="text" name="index" class="form-control indexClass" required lay-verify="required" onkeyup=\'if(/\\D/.test(this.value)){layer.msg("只能输入数字", {time: 1000, icon:5});this.value="";}\'></td>'
        +'<td><a onclick="delOneFixedLength(this)"><i class="fa fa-trash fa-lg" title="删除该字段"></i></a></td>'
        +'<td><a onclick="divide2(this)"><i class="fa fa-plus fa-lg" title="分割该字段"></i></a></td>'
        +'</tr>';
	return addHtml;
}

function divide2(obj){
	 $(obj).parent().parent().after(addTable2());
	 $(obj).parent().hide();
}

//添加三级分隔符表格
function addTable2(){
	return '<tr style="border: 1px solid #2b303b;"><td colspan="5"><div class="containerInfo">'
	+'<div class="form-group">'
	+'<label for="thirdseparator">三级分隔符:</label>&nbsp;<input type="text" class="form-control input-sm" style="width: 20%;" value="" name="thirdseparator" id="thirdseparator"/>'
	+'</div>'
	+'<div>'
	+'<table class="table table-fixedLength form-table" id="parseOptTable3" style="background-color: #eceff4;">'
	+'<thead><tr><th>字段中文</th><th>字段英文</th><th>字段类型</th><th>长度</th><th>下标位置</th><th>&nbsp;</th></tr></thead>'
	+'<tbody>'
	+'<tr class="addOneFixedBtn3">'
	+'<td colspan="7"><a class="addOneFixedLength3" onclick="addTableRow3(this)"><i class="fa fa-plus fa-lg"></i>添加</a></td>'
	+'</tr>'
	+'</tbody>'
	+'</table>'
	+'</div>'
	+'</div></td><td colspan="2"><div><a onclick="delDivide(this)" style="margin:15px 0px 0px 0px;"><i class="fa fa-times-circle-o fa-2x"></i></a></div></td></tr>';
}
function addTableRow3(obj){
	$(".addOneFixedBtn3").before(addRow3());//点击添加按钮，添加行
}
function addRow3(){
	var options = "<option value=''></option><option value='int'>int</option>" +
		"<option value='long'>long</option><option value='float'>float</option>" +
		"<option value='double'>double</option><option value='string'>string</option>" +
		"<option value='date'>date</option>";
	var addHtml='<tr>'
		+'<input type="hidden" name="fieldId" value="'+uuid()+'" class="form-control idClass">'
        +'<td><input type="text" name="cnName" class="form-control cnNameClass" required lay-verify="required"></td>'
        +'<td><input type="text" name="enName" class="form-control enNameClass" required lay-verify="required"></td>'
        +'<td><select name="type" class="form-control typeClass" required lay-verify="required">' + options + '</select></td>'
        +'<td><input type="text" name="len" class="form-control lenClass" required lay-verify="required" onkeyup=\'if(/\\D/.test(this.value)){layer.msg("只能输入数字", {time: 1000, icon:5});this.value="";}\'></td>'
        +'<td><input type="text" name="index" class="form-control indexClass" required lay-verify="required" onkeyup=\'if(/\\D/.test(this.value)){layer.msg("只能输入数字", {time: 1000, icon:5});this.value="";}\'></td>'
        +'<td><a onclick="delOneFixedLength(this)"><i class="fa fa-trash fa-lg" title="删除该字段"></i></a></td>'
        +'</tr>';
	return addHtml;
}