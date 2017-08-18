var successCode = "1",//成功代码
    failCode = "-1";//请求失败代码

/**
 * 公用js
 */
function changeSingleBoxBg(ele){
	$('.radio').removeClass('active');
	$(ele).addClass('active');
}
function changeCheckBoxBg(ele){
	$(ele).toggleClass('active');
}

//获取浏览器类型
var browser = function() {
    var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
    var isOpera = userAgent.indexOf("Opera") > -1;
    if (isOpera) {
        return "Opera"
    }; //判断是否Opera浏览器
    if (userAgent.indexOf("Firefox") > -1) {
        return "FF";
    } //判断是否Firefox浏览器
    if (userAgent.indexOf("Chrome") > -1) {
        return "Chrome";
    }
    if (userAgent.indexOf("Safari") > -1) {
        return "Safari";
    } //判断是否Safari浏览器
    if (userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera) {
        return "IE";
    }; //判断是否IE浏览器, ie11判断不了，ie10以下可以判断出来
    //如果都没出去返回
    return "Can not judge";
}

/**
阻止向上冒泡
*/
function preventEvent(e) {
    if (e && e.stopPropagation) {
        e.stopPropagation()
    } else {
        window.event.cancelBubble = true
    }
}
/**
阻止默认方法
*/
function preventDefault(e) {
    if (e && e.preventDefault) {
        e.preventDefault();
    } else {
        window.event.returnValue = false;
        return false;
    }
}


/**获得body的高度**/
function getBodyHeight(){
	return $("body").height();
}

/**获得body的宽度*/
function getBodyWidth(){
	return $("body").width();
}


/**
 * 清空表单内容
 * */
var form = {
		clear:function(form){//清空表单内容
			var target = form;
			if(!target){
				return;
			}
			$('input,select,textarea', target).each(function(){
				var t = this.type, tag = this.tagName.toLowerCase();
				if (t == 'text' || t == 'hidden' || t == 'password' || tag == 'textarea'){
					this.value = '';
				} else if (t == 'file'){
					var file = $(this);
					file.after(file.clone().val(''));
					file.remove();
				} else if (t == 'checkbox' || t == 'radio'){
					this.checked = false;
				} else if (tag == 'select'){
					this.selectedIndex = -1;
				}
			});
			
		},
		load:function(form, data){//将json格式的数据根据name加载到form中，只支持普通元素，复杂元素（如下拉树）需要单独写或扩充该方法
			for(var name in data){
				var val = data[name];
				var rr = false;
				var cc = form.find('[switchbuttonName="'+name+'"]');
				if (cc.length){
					cc.switchbutton('uncheck');
					cc.each(function(){
						if (_isChecked($(this).switchbutton('options').value, val)){
							$(this).switchbutton('check');
						}
					});
					rr = true;
				}
				cc = form.find('input[name="'+name+'"][type=radio], input[name="'+name+'"][type=checkbox]');
				if (cc.length){
					cc.prop('checked', false);
					cc.each(function(){
						if (_isChecked($(this).val(), val)){
							$(this).prop('checked', true);
						}
					});
					rr =  true;
					continue;
				}
				if (!rr){
					$('input[name="'+name+'"]', form).val(val);
					$('textarea[name="'+name+'"]', form).val(val);
					$('select[name="'+name+'"]', form).val(val);
				}
			}
		},
		serializeJson:function(form){//将form表单序列化成jsonObject格式
			var str = this.serializeStr(form);
			return JSON.parse(str)
		},
		serializeStr:function(form){//将form表单序列化成jsonStr格式
	    	var formInfo = jQueryExt.serialize(form);
	    	formInfo = decodeURIComponent(formInfo, true);
	    	return jQueryExt.par2Json(formInfo, true);
		},
		isValidator:function(form){//当没有异步验证的时候使用该方法校验表单
			return form.isValid();
		},
		isSynValidator:function(form,callback){//当有异步验证使用该方法进行表单提交
			form.isValid(function(v){
			    if (v) {
			        callback();
			    }
			});
		},
		cleanValidator:function(form){
			form.validator('cleanUp');
		}
}



function _isChecked(v, val){
	if (v == String(val) || $.inArray(v, $.isArray(val)?val:[val]) >= 0){
		return true;
	} else {
		return false;
	}
}

$(function(){
	//内容区高度=整个父级高度-同级已知部分的高度
	var $ele = $('.common-content');
	$ele.css('height', $ele.parent('.common-wrapper').height()-$ele.siblings('.common-part').height());
})















