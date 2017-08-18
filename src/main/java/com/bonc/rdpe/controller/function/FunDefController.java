/**
 * Project Name		[rdpe]
 * File Name		[com.bonc.rdpe.controller.function.FunctionController.java]
 * Creation Date	[2017年4月25日]
 * <p>
 * Copyright© 2017 www.bonc.com.cn All Rights Reserved
 * <p>
 */
package com.bonc.rdpe.controller.function;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.bonc.rdpe.entity.FunDef;
import com.bonc.rdpe.exception.RdpeException;
import com.bonc.rdpe.service.function.FunDefService;
import com.bonc.rdpe.util.UserUtil;

/**
 * @author wangxiaoxing
 * 
 *         2017年4月25日 上午9:45:51
 */

@Controller
@RequestMapping("/funDef")
public class FunDefController {

	@Resource
	private FunDefService funDefService;

	@RequestMapping("/index")
	public String index() {
		return "function/fun_def";
	}

	@ResponseBody
	@RequestMapping("/list")
	public List<FunDef> list(HttpServletRequest request) {
//		return funDefService.getAll();
		String userId = UserUtil.getUserId(request);
		return funDefService.getAllByCreateId(userId);
		
	}

	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public boolean add(FunDef funDef, HttpServletRequest request) {
		funDef.setCreateId(UserUtil.getUserResource(request).getUserId());
		return funDefService.addFunDef(funDef);
	}

	@ResponseBody
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public boolean edit(FunDef funDef) {
		boolean result = true;
		try {
			result = funDefService.editFunDef(funDef);
		} catch (Exception e) {
			result = false;
		}
		return result;
	}

	@ResponseBody
	@RequestMapping(value = "/remove", method = RequestMethod.POST)
	public String remove(String id, HttpServletRequest request){
		String result = "true";
		try {
			result = funDefService.removeFunDef(id)+"";
		} catch (Exception e) {
			if(e.getClass().equals(RdpeException.class)){//如果捕获的异常是rdpeException
				result = e.getMessage();
			}else{
				result = "false";
			}
		}
		return result;
	}

	@ResponseBody
	@RequestMapping(value = "/getChildren", method = RequestMethod.POST)
	public boolean getChildren(String id) throws Exception {
		return funDefService.getChildren(id);
	}
	
	@ResponseBody
	@RequestMapping(value = "/get", method = RequestMethod.POST)
	public List<FunDef> get() throws Exception {
		return funDefService.getFun("stream");// 参数为需要的函数类型
	}

	@ResponseBody
	@RequestMapping(value = "/getFieldFun", method = RequestMethod.POST)
	public List<FunDef> getFieldFun() throws Exception {
		return funDefService.getFun("field");// 参数为需要的函数类型
	}

	@SuppressWarnings({ "unchecked" })
	@ResponseBody
	@RequestMapping(value = "/upload")
	public List<Map<String, Object>> upload(HttpServletRequest request, String path) throws RdpeException {
		MultipartResolver resolver = new CommonsMultipartResolver(request.getSession().getServletContext());
		MultipartHttpServletRequest multipartRequest = resolver.resolveMultipart(request);
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
		String loginId = UserUtil.getLoginId(request);
		Map<String, String> sysDictMap = (Map<String, String>) request.getSession().getAttribute("SysDictMap");
		Map<String, Object> map = new HashMap<>();
		map.put("fileMap", fileMap);
		map.put("path", path);
		map.put("loginId", loginId);
		map.put("sysDictMap", sysDictMap);
		return funDefService.upload(map);
	}

	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/deleteFile")
	public boolean deleteFile(HttpServletRequest request, String filePath) throws RdpeException {
		Map<String, String> sysDictMap = (Map<String, String>) request.getSession().getAttribute("SysDictMap");
		return funDefService.deleteFile(filePath, sysDictMap);
	}
}
