/*
 * @Author: 金术静
 * @Date:   2017-01-11
 * @Last Modified by:   金术静
 * @Last Modified time: 2017-01-11 16:22:46
 */
'use strict';
// 之前写个分号防止其他js的不规范影响到插件代码的效果
;
(function($) {
	// 内部方法
	var initBarObj;

	var onclickFun = function(title, url, id) {
		console.log('点击了' + title + '菜单 url:' + url + ' id:' + id);
	}

	var bindOnclickFun = function() {
		$('.hasOutClickFun').each(function() {
			$(this).bind({
				click : function(e) {
					var $this = $(this);
					var title = $this.find('.menuText').text();
					var url = $this.attr('nav-url');
					var id = $this.attr('id');
					initBarObj.onClick(title, url, id);
				}
			})
		});
	}
	// 生成子菜单
	var genHasChildrenHtml = function(childrenObj, lev) {
		var i = 0, html = '<b class="arrow"></b><ul class="submenu">';
		for (i = 0; i < childrenObj.length; i++) {
			var tempObj = childrenObj[i];
			var iconTxt = '&#xe604;', linkStr = '#', aCls = '', bCls = '', liCls = '', closeTxt = '', aId = '', onclickFun = '';
			if (i === childrenObj.length - 1) {
				liCls = 'lastli';
			}
			if (tempObj.id) {
				aId = tempObj.id;
			}
			if (tempObj.url) {
				linkStr = tempObj.url;
			}
			if (tempObj.children && tempObj.children.length > 0) {
				aCls = 'dropdown-toggle';
				bCls = 'closeArrow';
				closeTxt = '&#xe601;';
			} else {
				onclickFun = ' hasOutClickFun';
			}
			html += '<li class="level' + lev + ' ' + liCls + '"><a id="' + aId + '" href="javascript:void(0);" nav-url="' + linkStr + '" class="' + aCls + onclickFun + '" alt="' + tempObj.text + '">';
			html += '<i class="sIcon levelIcon"></i><span class="menuText">' + tempObj.text + '</span>';
			html += '<b class="sIcon iconfont arrow ' + bCls + '">' + closeTxt + '</b></a>';
			if (tempObj.children != undefined && tempObj.children.length > 0) {
				var levChild = parseInt(lev) + 1;
				html += genHasChildrenHtml(tempObj.children, levChild);
			}
			html += '</li>';
		}
		html += '</ul>';
		return html;
	};

	// 生成所有左侧菜单，传入菜单层级对象和添加到目标对象的id
	var initHtml = function(container, obj) {
		if (!obj.data)
			return;
		var leftNavArr = obj.data;
		var $tag = $(container);
		var i = 0, j = 0, k = 0, htmlChild = '';
		var htmlAll = '<div id="leftBar"><div id="sideBarHead"><div class="lBarCtrl"><i class="sIcon iconfont funIcon">&#xe654;</i><span>功能菜单</span>'
		htmlAll += '<i class="sIcon toggleIcon lsbOpening iconfont" id="toggleSideBar">&#xe603;</i></div></div>';

		if (leftNavArr.length != 0) {
			htmlAll += '<ul class="bonc-nav">';
			for (i = 0; i < leftNavArr.length; i++) {
				var tempObj = leftNavArr[i];
				// 添加一级菜单
				var iconTxt = '&#xe66f;', linkStr = '#', aCls = '', bCls = '', closeTxt = '', aId = '', onclickFun = '';
				if (tempObj.icon) {
					iconTxt = tempObj.icon;
				}
				if (tempObj.id) {
					aId = tempObj.id;
				}
				if (tempObj.url) {
					linkStr = tempObj.url;
				}
				if (tempObj.children && tempObj.children.length > 0) {
					aCls = 'dropdown-toggle';
					bCls = ' closeArrow';
					closeTxt = '&#xe601;';
				} else {
					onclickFun = ' hasOutClickFun';
				}
				htmlAll += '<li class="level0"><a id="' + aId + '" href="javascript:void(0);" nav-url="' + linkStr + '" class="' + aCls + onclickFun + '" alt="' + tempObj.text + '">';
				htmlAll += '<i class="sIcon iconfont">' + iconTxt + '</i><span class="menuText">' + tempObj.text + '</span>';
				htmlAll += '<b class="sIcon arrow iconfont' + bCls + '">' + closeTxt + '</b></a>';
				if (tempObj.children != undefined && tempObj.children.length > 0) {
					htmlAll += genHasChildrenHtml(tempObj.children, '1');
				}
				htmlAll += '</li>';
			}
			htmlAll += '</ul></div>';

			$tag.html(htmlAll);
		}
		;

	}

	// 关闭其他菜单或所有菜单
	var closeMenus = function($li) {
		if ($li) {
			// 关闭初本li外的所有菜单
			$($li).siblings().removeClass('open');
			$($li).siblings().each(function(e) {
				var $a = $('>a', $(this));
				if ($a.siblings('ul').length > 0) {
					$a.siblings('ul').slideUp('1000').removeClass('openSub');
					$('>b', $a).removeClass('openArrow').addClass('closeArrow').html('&#xe601;');
				}
			});
		} else {
			// 关闭所有菜单
			$("li[class^='level']").removeClass('open');
			$("li[class^='level']").each(function(e) {
				var $a = $('>a', $(this));
				if ($a.siblings('ul').length > 0) {
					$a.siblings('ul').slideUp('1000').removeClass('openSub');
					$('>b', $a).removeClass('openArrow').addClass('closeArrow').html('&#xe601;');
				}
			});
		}

	};

	// 绑定左侧菜单函数
	var bindLeftBarFun = function(container, obj) {
		// 定义打开收起左侧菜单按钮事件
		$('#toggleSideBar').unbind();
		$('#toggleSideBar').click(function() {
			var cls = $(this).attr('class');
			$(this).toggleClass('lsbOpening');
			$('#leftBar').toggleClass('simpleLBar');
			if (cls.indexOf('lsbOpening') >= 0) {
				// 收起左侧菜单
				initBarObj.BeforeCollapseFun();

				var minWidth = initBarObj.barsWidth.minWidth;
				$('.level0').removeClass('open');
				$('#leftBar').parent().width(minWidth);
				$('.submenu').hide();
				$('.simpleLBar ul ul').hide();

				initBarObj.AfterCollapseFun();
			} else {
				// 打开左侧菜单
				initBarObj.BeforeExpandFun();
				var leftBarW = initBarObj.barsWidth.ExpandWidth2;
				var LeftBar2 = initBarObj.barsWidth.ExpandWidth1;
				var line0 = initBarObj.barsWidth.mediaWidth;
				if ($(window).width() < line0) {
					leftBarW = LeftBar2;
				}
				var ulHoverShowCls = $('.hoverShow').attr('class');
				if (ulHoverShowCls && ulHoverShowCls.indexOf('openSub') < 0) {
					$('.hoverShow').hide();
				}
				$('.hoverShow').removeClass('hoverShow');
				$('.level0 > a >.menuText').removeAttr('style');
				$('#leftBar').parent().width(leftBarW);

				initBarObj.AfterExpandFun();

				closeMenus();
			}
		});

		// 左侧菜单点击事件和mouseenter、mouseout事件

		$('.bonc-nav li a').unbind().click(function(e) {
			var $cur = $(this);
			var hasCld = $cur.siblings('ul').length;
			var $li = $(this).parent();
			var url, title, id;

			// 打开关闭子层菜单
			if (hasCld <= 0 || ($('.simpleLBar').length > 0 && $li.attr('class').indexOf('level0') >= 0))
				return;

			if ($li.attr('class').indexOf('open') < 0) {
				// 关闭其他的菜单
				closeMenus($li);
				// 打开菜单
				$cur.siblings('ul').slideDown('1000').addClass('openSub');
				$('b', $cur).removeClass('closeArrow').addClass('openArrow').html('&#xe68d;');
				$li.toggleClass('open');
			} else {
				// 关闭菜单
				$cur.siblings('ul').slideUp('1000', function() {
					$li.toggleClass('open');
				}).removeClass('openSub');
				$('b', $cur).removeClass('openArrow').addClass('closeArrow').html('&#xe601;');
			}

		});

		$('.bonc-nav > li > a').each(function() {
			var _tagA = $(this);
			var _dropdownmenu = _tagA.siblings('ul');
			var _level0Tips = $('.menuText', _tagA);
			var _tagAPLi = $(this).parent();
			_tagA.mouseenter(function() {
				clearTimeout(_tagA.timer);
				var liCls = $(this).parent().attr('class');
				if ($('.simpleLBar').length === 0)
					return;
				if (liCls.indexOf('level0') < 0)
					return;

				_tagA.flag = false;
				// 鼠标进去展开浮动的子层
				var liTop = $(this).offset().top + $(window).scrollTop();
				var ulTop = liTop + $(this).height();
				$('.bonc-nav > li').removeClass('open');
				$('.hoverShow').hide().removeClass('hoverShow');
				$('.menuText').removeAttr('style');
				$('.menuText', $(this)).css('top', liTop).show();

				if ($(this).siblings('ul').length > 0) {
					$(this).siblings('ul').css('top', ulTop);
					$(this).siblings('ul').addClass('hoverShow').show();
					$('.openSub', $(this).siblings('ul')).show();
					_tagAPLi.addClass('open');
				}
			}).mouseleave(function() {

				// 写简单左侧菜单的mouse离开导航条触发事件
				if ($('.simpleLBar').length === 0)
					return;
				clearTimeout(_tagA.timer);
				clearTimeout(_dropdownmenu.timer);
				clearTimeout(_level0Tips.timer);

				_tagA.timer = setTimeout(function() {
					if (_tagA.flag) {
						return;
					}
					// 关闭子菜单
					if ($('.simpleLBar').length === 0)
						return;
					$('.menuText', _tagA).removeAttr('style');
					_tagA.siblings('ul').removeClass('hoverShow').removeAttr('style').hide();
					_tagAPLi.removeClass('open');
				}, 1000);

				_dropdownmenu.on('mouseenter', function() {
					_tagA.flag = true;
					clearTimeout(_tagA.timer);
					clearTimeout(_dropdownmenu.timer);
					clearTimeout(_level0Tips.timer);
				}).on('mouseleave', function() {
					clearTimeout(_tagA.timer);
					clearTimeout(_dropdownmenu.timer);
					clearTimeout(_level0Tips.timer);
					_dropdownmenu.timer = setTimeout(function() {
						if ($('.simpleLBar').length === 0)
							return;
						_tagA.siblings('ul').removeClass('hoverShow').removeAttr('style').hide();
						$('.menuText', _tagA).removeAttr('style');
						_tagAPLi.removeClass('open');
					}, 1000);
				});

				_level0Tips.on('mouseenter', function() {
					_tagA.flag = true;
					clearTimeout(_tagA.timer);
					clearTimeout(_dropdownmenu.timer);
					clearTimeout(_level0Tips.timer);
				}).on('mouseleave', function() {
					clearTimeout(_tagA.timer);
					clearTimeout(_dropdownmenu.timer);
					clearTimeout(_level0Tips.timer);
					_level0Tips.timer = setTimeout(function() {
						if ($('.simpleLBar').length === 0)
							return;
						_tagA.siblings('ul').removeClass('hoverShow').removeAttr('style').hide();
						$('.menuText', _tagA).removeAttr('style');
						_tagAPLi.removeClass('open');
					}, 1000);
				});

			});
		});

	};

	var LBarBeforeExpandFun = function() {
		console.log("哇塞！ LBarBeforeExpandFun has runned~ ");
	}
	var LBarAfterExpandFun = function() {
		console.log("哇塞！ LBarAfterExpandFun has runned~ ");
	}
	var LBarBeforeCollapseFun = function() {
		console.log("哇塞！ LBarBeforeCollapseFun has runned~ ");
	}
	var LBarAfterCollapseFun = function() {
		console.log("哇塞！ LBarAfterCollapseFun has runned~ ");
	}
	$.fn.boncLeftBar = function(options) {
		if (typeof options == 'string') { // 如果options不是对象，而是字符串，默认调用其方法，参数传递进来
			return $.fn.boncMenu.methods[options](this, param);
		}
		// 创建一些默认值，拓展任何被提供的选项
		var options = $.extend({
			data : [],
			"onClick" : onclickFun,
			"BeforeExpandFun" : LBarBeforeExpandFun,
			"AfterExpandFun" : LBarAfterExpandFun,
			"BeforeCollapseFun" : LBarBeforeCollapseFun,
			"AfterCollapseFun" : LBarAfterCollapseFun,
			"barsWidth" : {
				"minWidth" : "42",
				"ExpandWidth1" : "185",
				"ExpandWidth2" : "12%",
				"mediaWidth" : "1400",
			}
		}, options);

		return this.each(function() {
			// 插件代码
			initBarObj = options;
			initHtml(this, options);
			bindLeftBarFun(this, options);
			bindOnclickFun();
		});
	};
	// 对外提供的方法
	$.fn.boncLeftBar.methods = {};

})(jQuery);
