/**
 * 头部的点击出现下拉菜单的js
 */
$(function() {
    $('.tipsScrollDiv').niceScroll({ cursorcolor: "rgba(99,114,131,.7)", cursorborder: "none" });
    bindTipsUserClick();
});

//给点击链接的a标签添加点击事件
var bindTipsUserClick = function() {
	$(".dropdown-a").unbind().click(function(e){
    	preventEvent(e);
    	
    	var $this = $(this)
        ,tipsLeft  = 0
    	,tipsTop  = 48
    	,downInfo = $this.parent().find(".downInfo"),
    	offset = 31;
    	if(!downInfo){
    		return;
    	}
    	if($this.width()>100){
    		tipsLeft  = $this.width()-downInfo.width();
    	}else{
    		tipsLeft  = $this.width()+offset-downInfo.width();
    	}
    	if(downInfo.is(':hidden')){
    		$(".downInfo").hide();
    		downInfo.css({'left':tipsLeft,'top':tipsTop}).show();
    	}else if(downInfo.is(':visible')){
    		downInfo.hide();
    	}
    });
    
    //窗口点击关闭所有class是dropdownTips的弹窗，如果不是点击了排除类的元素
    $(window).click(function(event){
    	$(".downInfo").hide();
    });
    
};