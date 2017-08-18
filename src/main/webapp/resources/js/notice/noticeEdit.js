$(function() {    
    // 公告编辑的textarea编辑框高度
	$('#editor').css('height', $('.notice-content').height()-285);
	// 公告详情的textarea编辑框高度
	var areaMaxH = $('.notice-content').height()-60;
	$('#areaDetail').css({'max-height':areaMaxH});
	// 编辑框内容超出父级时出现滚动条	
	$("#areaDetail").niceScroll({ cursorcolor: "#ccc", horizrailenabled: false});
	// 初始化编辑器
	initEditor();
	
	// 加载收件人树
	initAddrTree();
});

// 选择收件人
function showAddrTree(obj){
	getNodesById();
	layer.open({
		type: 1,
        title:'<i class="iconfont">&#xe65c;</i>&nbsp;选择收件人',
        area: ['300px', '340px'],
        content: $("#addrDiv"),
        btn: ['确定','取消'],
        btn1: function(index, layero){//确定按钮回调
        	onCheck();
        	layer.close(index);
	    },
	    btn2: function(index, layero){//确定按钮回调
        	layer.close(index);
	    }
    });
	$("#addrDiv").parent().niceScroll({ cursorcolor: "#ccc", horizrailenabled: false});
}
function initAddrTree(){
	//组织人员树
	var setting = {
			data: {
				simpleData: {
					enable:true, 
					idKey:'orgId',
					pIdKey:'parentId'
				},
				key:{
					name:'orgName'
				}
			},
			check: {
				enable: true,
				chkboxType: {"Y":"s", "N":"s"}
			},
			callback: {
				beforeClick: function(treeId, treeNode){
					var zTree = $.fn.zTree.getZTreeObj("addrTree");
					zTree.checkNode(treeNode, !treeNode.checked, null, true);
					return false;
				}
			}
	};
	$.ajax({//初始化组织人员树
		"url":webpath+"/user/org",
		"type":"POST",
		dataType:"json",
		success:function(data){			
			var treeObj = $.fn.zTree.init($("#addrTree"), setting, data);
			treeObj.expandAll(true);
		}
	});
}
function onCheck(e, treeId, treeNode){
	var zTree = $.fn.zTree.getZTreeObj("addrTree"),
	nodes = zTree.getCheckedNodes(true),
	v = "";
	for (var i=0, l=nodes.length; i<l; i++) {
		v += '"'+nodes[i].orgName+'"'+ '<' + nodes[i].orgId + '>' +',';
	}
	if (v.length > 0 ) v = v.substring(0, v.length-1);
	var cityObj = $("#sendToUser");
	cityObj.attr("value", v);
}
// 通过id查找相应的树节点
function getNodesById(){	
	var zTree = $.fn.zTree.getZTreeObj("addrTree");
	var userArr = [];
	for(var i = 0; i < orgIds.length; i++){
		userArr.push(orgIds[i].substring(orgIds[i].indexOf('<')+1, orgIds[i].lastIndexOf('>')));
	}
	for(var i = 0; i < userArr.length; i++){
		var nodes = zTree.getNodesByParam("orgId", userArr[i], null);
		if(nodes.length>0){
			zTree.checkNode(nodes[0], true, false);
		}
	}
	
}

//发布公告
var buttonPublish = function(){	
	var typeIdx = $('.notice-tab .radio.active').index()+1;
	var userIds = $('#sendToUser').val().split(",");
	var userArr = [];
	if($('#sendToUser').val() === ''){
		layer.msg('收件人不能为空！', {icon:1});
	}else if($('#title').val() === ''){
		layer.msg('主题不能为空！', {icon:1});
	}else {	
		for(var i = 0; i < userIds.length; i++){
			userArr.push(userIds[i].substring(userIds[i].indexOf('<')+1, userIds[i].lastIndexOf('>')));
		}
		$.ajax({
			"url":webpath+"/notice/pubNotice",
			"type":"POST",
			dataType:"json",
			data:{
				noticeId:$('#noticeId').val(),
				noticeTitle : $('#title').val(),
				noticeContent : UE.getEditor('editor').getContent(),
				fromSign : "2",
				state : "-1",
				noticeType: typeIdx,
				orgIdList:window.JSON.stringify(userArr),
				recOrgId:$('#sendToUser').val()
			},
			success:function(data){
				layer.msg('发布成功！', {time: 1000, icon:1});
				window.close();
			}
	   });
	}
	
};

//保存草稿
var saveDraft = function(){
	var typeIdx = $('.notice-tab .radio.active').index()+1;
	var userIds = $('#sendToUser').val().split(",");
	var userArr = [];
	for(var i = 0; i < userIds.length; i++){
		userArr.push(userIds[i].substring(userIds[i].indexOf('<')+1, userIds[i].lastIndexOf('>')));
	}
	$.ajax({
		"url":webpath+"/notice/saveDraft",
		"type":"POST",
		dataType:"json",
		data:{
			noticeId:$('#noticeId').val(),
			noticeTitle : $('#title').val(),
			recOrgId : $('#sendToUser').val(),
			noticeContent : UE.getEditor('editor').getContent(),
			fromSign : "2",
			state : "-2",
			noticeType: typeIdx,
		},
		success:function(data){
			layer.msg('保存草稿 成功！', {time: 1000, icon:1});
			window.close();
		}
   });
};

//取消发布
var canclePublish = function(){
	window.close();
}

//初始化编辑器
var initEditor = function(){
	var ue = UE.getEditor('editor', {
		toolbars: [[
            'fullscreen', 'undo', 'redo', '|',
            'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',
            'rowspacingtop', 'rowspacingbottom', 'lineheight', '|',
            'customstyle', 'paragraph', 'fontfamily', 'fontsize', '|',
            'directionalityltr', 'directionalityrtl', 'indent', '|',
            'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'touppercase', 'tolowercase', '|',
            'link', 'unlink', 'anchor', '|', 'imagenone', 'imageleft', 'imageright', 'imagecenter', '|',
            'simpleupload', 'insertimage', 'attachment', 'insertframe', 'pagebreak', 'template', 'background', '|',
            'horizontal', 'date', 'time', 'spechars', 'snapscreen', 'wordimage', '|',
            'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols', 'charts', '|',
            'print', 'preview', 'searchreplace', 'drafts', 'help'
		]]
	});
	ue.ready(function() {
	    //设置编辑器的内容
	    ue.setContent(noticeContent);
	});

    function isFocus(e){
        alert(UE.getEditor('editor').isFocus());
        UE.dom.domUtils.preventDefault(e)
    }
    function setblur(e){
        UE.getEditor('editor').blur();
        UE.dom.domUtils.preventDefault(e)
    }
    function insertHtml() {
        var value = prompt('插入html代码', '');
        UE.getEditor('editor').execCommand('insertHtml', value)
    }
    function createEditor() {
        enableBtn();
        UE.getEditor('editor');
    }
    function getAllHtml() {
        alert(UE.getEditor('editor').getAllHtml())
    }
    function getContent() {
        var arr = [];
        arr.push("使用editor.getContent()方法可以获得编辑器的内容");
        arr.push("内容为：");
        arr.push(UE.getEditor('editor').getContent());
        alert(arr.join("\n"));
    }
    function getPlainTxt() {
        var arr = [];
        arr.push("使用editor.getPlainTxt()方法可以获得编辑器的带格式的纯文本内容");
        arr.push("内容为：");
        arr.push(UE.getEditor('editor').getPlainTxt());
        alert(arr.join('\n'))
    }
//    function setContent(isAppendTo) {
//        var arr = [];
//        arr.push("使用editor.setContent('欢迎使用ueditor')方法可以设置编辑器的内容");
//        UE.getEditor('editor').setContent('欢迎使用ueditor', isAppendTo);
//        alert(arr.join("\n"));
//    }
//    function setDisabled() {
//        UE.getEditor('editor').setDisabled('fullscreen');
//        disableBtn("enable");
//    }
//
//    function setEnabled() {
//        UE.getEditor('editor').setEnabled();
//        enableBtn();
//    }
//
//    function getText() {
//        //当你点击按钮时编辑区域已经失去了焦点，如果直接用getText将不会得到内容，所以要在选回来，然后取得内容
//        var range = UE.getEditor('editor').selection.getRange();
//        range.select();
//        var txt = UE.getEditor('editor').selection.getText();
//        alert(txt)
//    }
//
    function getContentTxt() {
        var arr = [];
        arr.push("使用editor.getContentTxt()方法可以获得编辑器的纯文本内容");
        arr.push("编辑器的纯文本内容为：");
        arr.push(UE.getEditor('editor').getContentTxt());
        alert(arr.join("\n"));
    }
//    function hasContent() {
//        var arr = [];
//        arr.push("使用editor.hasContents()方法判断编辑器里是否有内容");
//        arr.push("判断结果为：");
//        arr.push(UE.getEditor('editor').hasContents());
//        alert(arr.join("\n"));
//    }
//    function setFocus() {
//        UE.getEditor('editor').focus();
//    }
//    function deleteEditor() {
//        disableBtn();
//        UE.getEditor('editor').destroy();
//    }
//    function disableBtn(str) {
//        var div = document.getElementById('btns');
//        var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
//        for (var i = 0, btn; btn = btns[i++];) {
//            if (btn.id == str) {
//                UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
//            } else {
//                btn.setAttribute("disabled", "true");
//            }
//        }
//    }
//    function enableBtn() {
//        var div = document.getElementById('btns');
//        var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
//        for (var i = 0, btn; btn = btns[i++];) {
//            UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
//        }
//    }
//
//    function getLocalData () {
//        alert(UE.getEditor('editor').execCommand( "getlocaldata" ));
//    }
//
//    function clearLocalData () {
//        UE.getEditor('editor').execCommand( "clearlocaldata" );
//        alert("已清空草稿箱")
//    }
}