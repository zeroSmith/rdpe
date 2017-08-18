package com.bonc.rdpe.controller.file;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.bonc.rdpe.constant.SysDictKey;
import com.bonc.rdpe.exception.RdpeException;
import com.bonc.rdpe.service.host.HostSparkService;
import com.bonc.rdpe.util.AesUtil;
import com.bonc.rdpe.util.FilePathUtil;
import com.bonc.rdpe.util.UserUtil;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/file")
public class FileController extends MultiActionController {

	@Resource
	private HostSparkService hostSparkService;

	@SuppressWarnings("rawtypes")
	@ResponseBody
	@RequestMapping(value = "/upload")
	public List<Map> upload(HttpServletRequest request) throws RdpeException {
		log.info("--------------文件上传开始--------------");
		long start = System.currentTimeMillis();
		// 上传文件保存的路径
		String uploadBasePath = this.getPath(request, SysDictKey.SPARK_UPLOAD_JAR_PATH);
		// 自定义的路径 rootPath/${loginId}/${date}
		String loginId = UserUtil.getLoginId(request);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String date = sdf.format(new Date());
		StringBuilder uploadPath = new StringBuilder(uploadBasePath);
		uploadPath.append(File.separator).append(loginId).append(File.separator).append(date).append(File.separator);
		MultipartResolver resolver = new CommonsMultipartResolver(request.getSession().getServletContext());
		MultipartHttpServletRequest multipartRequest = resolver.resolveMultipart(request);
		Iterator iter = multipartRequest.getFileNames();
		List<Map> mapList = new ArrayList<>();
		while (iter.hasNext()) {
			// 一次遍历所有文件
			MultipartFile sourceFile = multipartRequest.getFile(iter.next().toString());
			String originalFilename = sourceFile.getOriginalFilename();
			// 文件保存的全路径
			String targetFileStr = uploadPath.append(originalFilename).toString();
			File targetFile = new File(targetFileStr);
			// 文件拷贝
			try {
				FileUtils.copyInputStreamToFile(sourceFile.getInputStream(), targetFile);
			} catch (IOException e) {
				log.error(e.getMessage(), e);
				throw new RdpeException("文件拷贝异常", e);
			}
			long end1 = System.currentTimeMillis();

			log.info("----------------------------文件上传耗时:" + originalFilename + ":" + String.valueOf(end1 - start));
			Map<String, Object> map = new HashMap<>();
			map.put("uploadJarPath", AesUtil.encrypt(targetFileStr));
			mapList.add(map);
		}

		return mapList;
	}

	/**
	 * 
	 * @param response
	 * @param filePathEncode
	 *            加密的文件路径
	 * @throws RdpeException
	 */
	@RequestMapping(value = "/download")
	public void download(HttpServletResponse response, String filePathEncode) throws RdpeException {
		if (filePathEncode != null && !filePathEncode.trim().isEmpty()) {
			String uploadJarpath = AesUtil.decrypt(filePathEncode);
			String fileName = FilePathUtil.extractFileName(uploadJarpath);
			File file = new File(uploadJarpath);
			if (file.exists()) {
				try {
					response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(fileName, "UTF-8"));
					response.setHeader("Content-Length", String.valueOf(file.length()));
					FileUtils.copyFile(file, response.getOutputStream());
				} catch (Exception e) {
					log.error(e.getMessage(), e);
					throw new RdpeException("文件下载服务异常");
				}
			} else {
				throw new RdpeException("文件已经被删除");
			}

		} else {
			throw new RdpeException("文件已经被删除");
		}

	}

	/**
	 * 删除保存在服务器上的文件及已经发布的文件
	 * 
	 * @param request
	 * @param filePath
	 * @param publishJarPath
	 *            发布文件保存的路径
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/delete")
	public boolean delete(HttpServletRequest request, String filePath) {
		try {
			// 删除上传目录
			FileUtils.forceDelete(new File(AesUtil.decrypt(filePath)));
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return false;
		}
		return true;
	}

	@SuppressWarnings("unchecked")
	private String getPath(HttpServletRequest request, String sysDictKey) throws RdpeException {
		String path = "";
		Map<String, String> sysDictMap = (Map<String, String>) request.getSession().getAttribute("SysDictMap");
		if (sysDictMap != null && sysDictMap.containsKey(sysDictKey)) {
			path = sysDictMap.get(sysDictKey);
		} else {
			throw new RdpeException("参数表没有找到" + sysDictKey + "的记录");
		}
		return path;
	}

	@ResponseBody
	@RequestMapping("/decodeJarPath")
	public String decodeJarPath(String jarPath) throws RdpeException {
		String path = AesUtil.decrypt(jarPath);

		return path.replace("\\", "\\\\");
	}
}
