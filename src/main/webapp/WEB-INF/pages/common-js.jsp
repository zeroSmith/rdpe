<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script src="<%=request.getContextPath() %>/resources/plugin/forIE/browser-fix.js"></script>
<script src="<%=request.getContextPath() %>/resources/plugin/jquery/jquery-1.10.2.js"></script>
<script src="<%=request.getContextPath() %>/resources/plugin/bootstrap-3.3.6/dist/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/plugin/bootstrap-menu/BootstrapMenu.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/plugin/datatables/media/js/jquery.dataTables.min.js"></script>
<script type="text/javascript">
	$.extend( $.fn.dataTable.defaults, {
		"searching": false,
	    "ordering":  false,
	    "info": false,
	    "lengthChange": false,
    	"bAutoWidth": true,
    	"bPaginate": true, //翻页功能
		"bLengthChange": false, //改变每页显示数据数量
		"bFilter": false, //过滤功能
		"pageLength": 10,
		"bSort": false, //排序功能
		"bInfo": false,//页脚信息
		"serverSide": true,
		"pagingType":   "full_numbers",
		"oLanguage":{   //设置中文文本 
		    "sProcessing":   "处理中...",
		    "sLengthMenu":   "显示 _MENU_ 项结果",
		    "sZeroRecords":  "没有匹配结果",
		    "sInfo":         "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项",
		    "sInfoEmpty":    "显示第 0 至 0 项结果，共 0 项",
		    "sInfoFiltered": "(由 _MAX_ 项结果过滤)",
		    "sInfoPostFix":  "",
		    "sSearch":       "搜索:",
		    "sUrl":          "",
		    "sEmptyTable":     "表中数据为空",
		    "sLoadingRecords": "载入中...",
		    "sInfoThousands":  ",",
		    "oPaginate": {
		        "sFirst":    "首 页",
		        "sPrevious": "上一页",
		        "sNext":     "下一页",
		        "sLast":     "末 页"
		    },
		    "oAria": {
		        "sSortAscending":  ": 以升序排列此列",
		        "sSortDescending": ": 以降序排列此列"
		    }
		}
	});
</script>
<script src="<%=request.getContextPath() %>/resources/plugin/ztree/js/jquery.ztree.all.js"></script>
<script src="<%=request.getContextPath() %>/resources/plugin/layer/layer.js"></script>
<script type="text/javascript">
	//定义全局使用的layer样式
	layer.config({
	 	 skin: 'layui-layer-ext'
	});
</script>
<!--[if lte IE 9]>
<script src="<%=request.getContextPath() %>/resources/plugin/forIE/html5shiv.js"></script>
<script src="<%=request.getContextPath() %>/resources/plugin/forIE/respond.js"></script>
<![endif]-->
<script src="<%=request.getContextPath() %>/resources/plugin/nicescroll/jquery.nicescroll.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/plugin/validator/dist/jquery.validator.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/plugin/validator/dist/local/zh-CN.js"></script>
<script src="<%=request.getContextPath() %>/resources/plugin/frame-fix/ajax-fix.js"></script>
<script src="<%=request.getContextPath() %>/resources/plugin/utils/jquery-ext.js"></script>
<script src="<%=request.getContextPath() %>/resources/plugin/utils/json.js"></script>
<script src="<%=request.getContextPath() %>/resources/plugin/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script src="<%=request.getContextPath() %>/resources/plugin/jquery-ui-1.12.1/datepicker-zh-CN.js"></script>
<script src="<%=request.getContextPath() %>/resources/plugin/My97Date/My97DatePicker/WdatePicker.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/common.js"></script>
<script type="text/javascript">
	$.datepicker.setDefaults( $.datepicker.regional[ "zh-CN" ] );//jqueryui datepicker日期使用中文
	$.extend( $.datepicker._defaults, {
		"changeMonth": true,
	    "changeYear":  true
	});
    var webpath = "<%=request.getContextPath() %>";
    var $jQuery = $;
</script>