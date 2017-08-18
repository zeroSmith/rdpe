/**
 * 控制iframe的标签和左侧菜单进行交互
 */
//计算跟leftBar父层同级的左侧div的宽度
var calcRightWrapWidth = function() {
    var ww = $(window).width();
    var lw = $('#leftBar').parent().width();
    $('#leftBar').parent().siblings().width(ww - lw - 1);
}

var LBarBeforeExpandFun = function() {
    //console.log("OMG！ LBarBeforeExpandFun has runned~ ");
}
var LBarAfterExpandFun = function() {
    calcRightWrapWidth();
    $("#tabs").tabs("resize");
}
var LBarBeforeCollapseFun = function() {
    //console.log("OMG！ LBarBeforeCollapseFun has runned~ ");
}
var LBarAfterCollapseFun = function() {
    calcRightWrapWidth();
    if(frameStyle == "tab"){
    	$("#tabs").tabs("resize");
    }
}


// add a new tab panel
var addNewTab = function(title, url, id, closable) {
	var nurl = "";
	var tabIdTag = "tab_id_header_";
	if(url=="/"){
		nurl = ""
	}else if(url.startWith("http://")){
		nurl = url;
	}else{
		nurl = webpath + url;
	}
	//添加新的tab或者切换页面
	if(frameStyle == "page"){
		$('#childPage').attr('src', nurl);
	}else if(frameStyle == "tab"){
		var $tab = $('#tabs');
	    if ($tab.tabs('existsById', tabIdTag+id)) {
	        $tab.tabs('selectById', tabIdTag+id);
	    } else {
	        $tab.tabs('add', {
	            id: tabIdTag+id,
	            title: title,
	            content: '<iframe id="' + id + '" src="' + nurl + '" allowTransparency="true" width="100%" height="100%" frameBorder="0" scrolling="auto"></iframe>',
	            closable: closable,
	            tools: [{
	                iconCls: 'icon-refresh',
	                handler: function() {
	                    refreshTab({ tabTitle: title, url: url });
	                }
	            }]
	        });
    	}

    }
}

/**       
 * 刷新tab   
 * @cfg    
 *example: {tabTitle:'tabTitle',url:'refreshUrl'}   
 *如果tabTitle为空，则默认刷新当前选中的tab   
 *如果url为空，则默认以原来的url进行reload   
 */
var refreshTab = function(cfg) {
    var $tab = $('#tabs');
    var refresh_tab = cfg.tabTitle ? $tab.tabs('getTab', cfg.tabTitle) : $tab.tabs('getSelected');
    if (refresh_tab && refresh_tab.find('iframe').length > 0) {
        var _refresh_ifram = refresh_tab.find('iframe')[0];
        var refresh_url = cfg.url ? cfg.url : _refresh_ifram.src;
        _refresh_ifram.contentWindow.location.href = $(_refresh_ifram).prop("src");
    }
}
