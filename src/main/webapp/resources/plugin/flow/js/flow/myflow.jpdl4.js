;(function($){
var myflow = $.myflow;
var location = (window.location+'').split('/');  
var basePath = location[0]+'//'+location[2]+'/'+location[3]; 
var imgSrc = basePath+"/resources/plugin/flow/images/flow/";

$.extend(true,myflow.config.props.props,{
	"pkgId": "00000",
	"id": "00000",
	"props" : {
		"text" : {"name":"name", "label":"名称:", "value":"新建决策树", "editor":function(){return new myflow.editors.inputEditor();}}
	}
});
$.extend(true,myflow.config.tools.states,{
	"start" : {
		"type" : "start",
		"name" : {"text":"<<start>>"},
		"text" : {"text":"开始", "fill":"#ffffff"},
		"img" : {"src" : imgSrc + "startWhite.png","width" : 18, "height":18},
		"attr": {"fill":"#77bb11", "width":65,"height":26},
		"props": {
			"text": {"name":"text","label": "节点名称:", "value":"开始", "editor": function(){return new myflow.editors.textEditor();}}
		}
	},
	"end" : {"type" : "end",
		"name" : {"text":"<<end>>"},
		"text" : {"text":"结束", "fill":"#ffffff"},
		"img" : {"src" : imgSrc + "endWhite.png","width" : 18, "height":18},
		"attr": {"fill":"#e87340", "width":65,"height":26},
		"props" : {
			"text": {"name":"text","label": "节点名称:", "value":"结束", "editor": function(){return new myflow.editors.textEditor();}}
		}
	},
	"ds" : {"type" : "ds",
		"name" : {"text":"<<ds>>"},
		"text" : {"text":"选择数据源", "fill":"#ffffff"},
		"attr":{"fill":"#4496d1", "width":70, "height":26},
		"img" : {"src" : imgSrc + "actionWhite.png","width":18, "height":18},
		"props" : {
			"text": {"name":"text", "label": "节点名称:", "value":"提取", "editor": function(){return new myflow.editors.inputEditor();}},
			"parallelism": {"name":"parallelism", "label": "并行度:", "value":"", "editor": function(){return new myflow.editors.inputEditor();}},
			"action": {"name":"action", "label": "提取配置:", "value":"", "editor": function(){return new myflow.editors.inputEditorMore("ds");}}
		}
	},
	"parse" : {"type" : "parse",
		"name" : {"text":"<<parse>>"},
		"text" : {"text":"模型解析", "fill":"#ffffff"},
		"attr":{"fill":"#4496d1", "width":70, "height":26},
		"img" : {"src" : imgSrc + "actionWhite.png","width":18, "height":18},
		"props" : {
			"text": {"name":"text", "label": "节点名称:", "value":"模型解析", "editor": function(){return new myflow.editors.inputEditor();}},
			"parallelism": {"name":"parallelism", "label": "并行度:", "value":"", "editor": function(){return new myflow.editors.inputEditor();}},
			"action": {"name":"action", "label": "解析配置:", "value":"", "editor": function(){return new myflow.editors.inputEditorMore("parse");}}
		}
	},
	"join" : {"type" : "join",
		"name" : {"text":"<<join>>"},
		"text" : {"text":"数据关联"},
		"showType": "image",
		"attr":{"width":26, "height":26},
		"img" : {"src" : imgSrc + "merge.png","width":26, "height":26},
		"props" : {
			"text": {"name":"text", "label": "节点名称:", "value":"数据关联", "editor": function(){return new myflow.editors.inputEditor();}},
			"parallelism": {"name":"parallelism", "label": "并行度:", "value":"1", "editor": function(){return new myflow.editors.inputEditor();}},
			"action": {"name":"action", "label": "关联配置:", "value":"", "editor": function(){return new myflow.editors.inputEditorMore("join");}}
		}
	},
	"filter" : {"type" : "filter",
		"name" : {"text":"<<filter>>"},
		"text" : {"text":"数据过滤"},
		"attr":{"fill":"#4496d1", "width":70, "height":26},
		"img" : {"src" : imgSrc + "actionWhite.png","width":18, "height":18},
		"props" : {
			"text": {"name":"text", "label": "节点名称:", "value":"数据过滤", "editor": function(){return new myflow.editors.inputEditor();}},
			"parallelism": {"name":"parallelism", "label": "并行度:", "value":"1", "editor": function(){return new myflow.editors.inputEditor();}},
			"action": {"name":"action", "label": "过滤配置:", "value":"", "editor": function(){return new myflow.editors.inputEditorMore("filter");}}
		}
	},
	"trans" : {"type" : "trans",
		"name" : {"text":"<<trans>>"},
		"text" : {"text":"数据转换"},
		"attr":{"fill":"#4496d1", "width":70, "height":26},
		"img" : {"src" : imgSrc + "actionWhite.png","width":18, "height":18},
		"props" : {
			"text": {"name":"text", "label": "节点名称:", "value":"数据转换", "editor": function(){return new myflow.editors.inputEditor();}},
			"parallelism": {"name":"parallelism", "label": "并行度:", "value":"1", "editor": function(){return new myflow.editors.inputEditor();}},
			"action": {"name":"action", "label": "转换配置:", "value":"", "editor": function(){return new myflow.editors.inputEditorMore("trans");}}
		}
	},
	"aggregate" : {"type" : "aggregate",
		"name" : {"text":"<<aggregate>>"},
		"text" : {"text":"数据聚合"},
		"attr":{"fill":"#4496d1", "width":70, "height":26},
		"img" : {"src" : imgSrc + "actionWhite.png","width":18, "height":18},
		"props" : {
			"text": {"name":"text", "label": "节点名称:", "value":"数据聚合", "editor": function(){return new myflow.editors.inputEditor();}},
			"parallelism": {"name":"parallelism", "label": "并行度:", "value":"1", "editor": function(){return new myflow.editors.inputEditor();}},
			"action": {"name":"action", "label": "聚合配置:", "value":"", "editor": function(){return new myflow.editors.inputEditorMore("aggregate");}}
		}
	},
	"fun" : {"type" : "fun",
		"name" : {"text":"<<fun>>"},
		"text" : {"text":"函数"},
		"attr":{"fill":"#4496d1", "width":70, "height":26},
		"img" : {"src" : imgSrc + "actionWhite.png","width":18, "height":18},
		"props" : {
			"text": {"name":"text", "label": "节点名称:", "value":"函数", "editor": function(){return new myflow.editors.inputEditor();}},
			"parallelism": {"name":"parallelism", "label": "并行度:", "value":"1", "editor": function(){return new myflow.editors.inputEditor();}},
			"funname": {"name":"funname", "label": "函数名称:", "value":"", "editor": function(){return new myflow.editors.inputEditorMore("fun");}}
		}
	},
	"store" : {"type" : "store",
		"name" : {"text":"<<store>>"},
		"text" : {"text":"数据存储"},
		"attr":{"fill":"#4496d1", "width":70, "height":26},
		"img" : {"src" : imgSrc + "actionWhite.png","width":18, "height":18},
		"props" : {
			"text": {"name":"text", "label": "节点名称:", "value":"数据存储", "editor": function(){return new myflow.editors.inputEditor();}},
			"parallelism": {"name":"parallelism", "label": "并行度:", "value":"1", "editor": function(){return new myflow.editors.inputEditor();}},
			"action": {"name":"action", "label": "存储配置:", "value":"", "editor": function(){return new myflow.editors.inputEditorMore("store");}}
		}
	}
});
})(jQuery);