// 初始化文件上传功能
var initUploader = function(operateType) {
	var $eventId = '';//事件ID
	// 初始化webuploader组件，设置上传等事件监听
	var $list;
	var thumbnailWidth = 100; // 缩略图高度和宽度 （单位是像素），当宽高度是0~1的时候，是按照百分比计算
	var thumbnailHeight = 100;
	var uploader = WebUploader.create({
		// swf文件路径
		swf : webpath + '/resources/plugin/webuploader-0.1.5/Uploader.swf',
		// 文件接收服务端。
		server : webpath + '/file/upload',
		// 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
		resize : false,
		method : 'POST',
		// 可重复上传
		duplicate : true,
		formData : {},
		accept : {
			title : 'content',
			extensions : 'jar' // 接受的文件类型
		}
	});

	// 上传事件对象
	var uploaderObj = {
		'beforeFileQueued' : function(file) {
			uploader.reset();// 文件添加之前重置队列，只为了能够上传一个文件
		},
		'fileQueued' : function(file) {
			$list.empty();
			$list.append("<font style='font-size:13px'>" + file.name + "</font>")

		},
		'uploadProgress' : function(file, percentage) {
			$percent = $('.progress .progress-bar');
			if (!$percent.length) {
				layer.open({
					title : '<i class="iconfont">&#xe649;</i>&nbsp;提示',
					content : '<div class="progress progress-striped active" style="height: 10px;margin-bottom: 2px;">' + '<div class="progress-bar" role="progressbar" >'
							+ '</div></div> <span id="percentage"></span>',
					closeBtn : 0,
					btn : []
				});
			}
			$("#percentage").text(percentage * 100 + '%');
			$percent.css('width', percentage * 100 + '%');

		},
		'uploadSucc' : function(file, result) {// 后台返回的是一个List
			if (result.length > 0) {
				layer.open({
					title : '<i class="iconfont">&#xe649;</i>&nbsp;提示',
					content : "上传成功"
				});
				var filePath = result[0].uploadJarPath;
				if (operateType == "Add") {
					$("#filePathAdd").val(filePath);
					$.ajax({
						url : webpath + "/file/decodeJarPath",
						type : "POST",
						data : {
							"jarPath" : filePath
						},
						dataType : "json",
						async : false,
						success : function(data) {
							$("#add").find("input[name='publishJar']").val(data);
						}
					});
					$("#add").find("#isExistFileNo").hide();
					$("#add").find("#isExistFileYes").show();

				}
				if (operateType == "Update") {
					$("#filePathUpdate").val(filePath);
					$.ajax({
						url : webpath + "/file/decodeJarPath",
						type : "POST",
						data : {
							"jarPath" : filePath
						},
						dataType : "json",
						async : false,
						success : function(data) {
							$("#edit").find("input[name='publishJar']").val(data);
						}
					});
					//对于编辑功能，上传完文件以后，应该更新数据库
					$.ajax({// 文件上传完成更新数据库
						"url" : webpath + "/event/spark/editPath",
						"type" : "POST",
						dataType : "json",
						data : {
							id : $eventId,
							uploadJarPath : filePath 
						},
						success : function(data) {
						}
					});
					$("#edit").find("#isExistFileNo").hide();
					$("#edit").find("#isExistFileYes").show();
				}
				$list.empty();
				isHasUploaded = true;
			} else {
				layer.open({
					title : '<i class="iconfont">&#xe649;</i>&nbsp;提示',
					content : "没有配置文件存放路径"
				});
				isHasUploaded = false;
			}
		},
		'uploadErr' : function(file) {
			$('#' + file.id).find('p.state').text('上传出错');
		},
		'uploadComp' : function(file) {
			$('#' + file.id).find('.progress').fadeOut();
		},
		'error' : function(type) {
			if (type == "Q_TYPE_DENIED") {
				$list.empty();
				layer.msg('请选择.jar文件', {
					time : 2000,
					icon : 6
				});
			}
		},
		'uploadAccept' : function(file, response) {
			if (response.code == 1) {
				// 通过return false来告诉组件，此文件上传有错。
				return false;
			}
		}

	};
	uploader.on('error', uploaderObj.error);
	// 当有文件被添加进队列前
	uploader.on('beforeFileQueued', uploaderObj.beforeFileQueued);
	// 当有文件被添加进队列的时候
	uploader.on('fileQueued', uploaderObj.fileQueued);
	// 文件上传过程中创建进度条实时显示。
	uploader.on('uploadProgress', uploaderObj.uploadProgress);
	// 文件上传成功
	uploader.on('uploadSuccess', uploaderObj.uploadSucc);
	// 文件上传失败，显示上传出错。
	uploader.on('uploadError', uploaderObj.uploadErr);
	// 完成上传完了，成功或者失败，先删除进度条。
	uploader.on('uploadComplete', uploaderObj.uploadComp);

	if (operateType == "Add") {
		uploader.addButton({
			id : '#pickerUpload',
			multiple : false
		});
		$list = $('#thelist');
	}

	if (operateType == "Update") {
		uploader.addButton({
			id : '#pickerUploadUpdate',
			multiple : false
		});
		$list = $('#thelistUpdate');
		$eventId = $("#edit").find("input[name='id']").val();
	}

	return uploader;
}