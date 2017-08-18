/**
 * Project Name		[rdpe]
 * File Name		[com.bonc.rdpe.controller.event.EventStormController.java]
 * Creation Date	[2017年8月16日]
 * <p>
 * Copyright© 2017 www.bonc.com.cn All Rights Reserved
 * <p>
 */
package com.bonc.rdpe.controller.event;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bonc.rdpe.entity.EventStorm;
import com.bonc.rdpe.entity.HostStorm;
import com.bonc.rdpe.entity.user.User;
import com.bonc.rdpe.exception.RdpeException;
import com.bonc.rdpe.service.RetInfo;
import com.bonc.rdpe.service.event.EventOptService;
import com.bonc.rdpe.service.event.EventStormService;
import com.bonc.rdpe.service.host.HostStormService;
import com.bonc.rdpe.util.AesUtil;
import com.bonc.rdpe.util.CmdUtil;
import com.bonc.rdpe.util.IdUtil;
import com.bonc.rdpe.util.JsonUtils;
import com.bonc.rdpe.util.UserUtil;

import lombok.extern.log4j.Log4j;

/**
 * @author wangxiaoxing
 * 
 * @date 2017年8月16日 上午11:23:46
 */

@Log4j
@Controller
@RequestMapping("/event/storm")
public class EventStormController {
	@Resource
	private EventStormService eventStormService;
	
	@Resource
	private EventOptService eventOptService;

	@Resource
	private HostStormService hostStormService;


	
	@RequestMapping("/index")
	public String index() {
		return "event/event_storm_manage";
	}
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping("/list")
	public Map<String, Object> list(HttpServletRequest request, String start, String length, String jsonStr) {
		Map<String, Object> paramMap = JsonUtils.stringToCollect(jsonStr);
		paramMap.put("createId", UserUtil.getUserId(request));
		Map<String, Object> retMap = eventStormService.getAll(start, length, paramMap);
		return retMap;
	}

	@ResponseBody
	@RequestMapping("/add")
	public boolean add(HttpServletRequest request, String eventStormJson, String executeDef) {
		EventStorm eventStorm = JsonUtils.toBean(eventStormJson, EventStorm.class);
		eventStorm.setId(IdUtil.genUUID());
		eventStorm.setCreateId(UserUtil.getUserId(request));
		eventStorm.setCreateTime(new Date());
		eventStorm.setExecuteDef(executeDef);
		return eventStormService.add(eventStorm);
	}

	@ResponseBody
	@RequestMapping("/load")
	public EventStorm load(String id) {
		return eventStormService.getOne(id);
	}

	@ResponseBody
	@RequestMapping("/edit")
	public boolean edit(String eventStormJson, String executeDef) {
		EventStorm eventStorm = JsonUtils.toBean(eventStormJson, EventStorm.class);
		eventStorm.setExecuteDef(executeDef);
		return eventStormService.edit(eventStorm);
	}

	@ResponseBody
	@RequestMapping("/remove")
	public boolean remove(HttpServletRequest request, String id) throws RdpeException {
		EventStorm eventStorm = eventStormService.getOne(id);
		HostStorm hostStorm = hostStormService.getOne(eventStorm.getSubmitHostId());

		// 清理发布目录文件
		String publishJarPath = eventStorm.getPublishJarPath();
		if (publishJarPath != null && !publishJarPath.trim().isEmpty()) {
			CmdUtil cmdUtil = new CmdUtil();
			String ip = hostStorm.getHostIp();
			int port = Integer.parseInt(hostStorm.getSshPort());
			String userName = hostStorm.getHostUsername();
			String passWord = AesUtil.decrypt(hostStorm.getHostPassword());
			cmdUtil.init(ip, port, userName, passWord);
			// 删除submit主机上的文件
			String cmd = "rm -rf " + AesUtil.decrypt(publishJarPath);
			cmdUtil.execCmds(cmd);
		}
		// 清理上传目录文件
		String uploadJarPath = eventStorm.getUploadJarPath();
		if (uploadJarPath != null && !uploadJarPath.trim().isEmpty()) {
			File file = new File(AesUtil.decrypt(uploadJarPath));
			try {
				if (file.exists()) {
					FileUtils.forceDelete(file);
				}
			} catch (IOException e) {
				log.error(e.getMessage(), e);
				throw new RdpeException("文件清理失败", e);
			}
		}
		
		if (eventOptService.removeByEventId(id)) {
			return eventStormService.remove(id);
		} else {
			return false;
		}
	}

	@RequestMapping("/process")
	public ModelAndView process(String id) {
		EventStorm eventStorm = eventStormService.getOne(id);
		ModelAndView mv = new ModelAndView();
		mv.addObject("event", eventStorm);
		mv.addObject("classify", "storm");
		mv.setViewName("event/event_storm_process");
		return mv;
	}

	@ResponseBody
	@RequestMapping(value = "/editFlowDef")
	public boolean editFlowDef(String id, String flowDef) {
		return eventStormService.editFlowDef(id, flowDef);
	}

	/**
	 * 事件运行
	 * 
	 * @param request
	 * @param id
	 * @return
	 * @throws RdpeException
	 */
	@ResponseBody
	@RequestMapping(value = "/run")
	public RetInfo run(HttpServletRequest request, String id) throws RdpeException {
		return eventStormService.run(id);
	}

	/**
	 * 生成代码
	 * 
	 * @param request
	 * @param id
	 * @return
	 * @throws RdpeException
	 */
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/gencode")
	public RetInfo genCode(HttpServletRequest request, String id) throws RdpeException{
		Map<String, String> map = (HashMap<String, String>) request.getSession().getAttribute("SysDictMap");
		map.put("loginId", UserUtil.getLoginId(request));
		RetInfo ret = eventStormService.genCode(id, map);
		return ret;
	}

	/**
	 * 
	 * @param id
	 * @param uploadJarPath
	 * @param publishJarPath
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value= "/editPath")
	public boolean editPath(String id,String uploadJarPath){
		EventStorm eventStorm= new EventStorm();
		eventStorm.setId(id);
		eventStorm.setUploadJarPath(uploadJarPath);
		return eventStormService.edit(eventStorm);
	}
	/**
	 * 事件发布
	 * @param request
	 * @param id
	 * @throws RdpeException
	 */
	@ResponseBody
	@RequestMapping(value= "/publish")
	public boolean publish(HttpServletRequest request, String id) throws RdpeException{
		User user = UserUtil.getUserResource(request);
		Map<String, String> map = (HashMap) request.getSession().getAttribute("SysDictMap");
		return eventStormService.publishEvent(id, map, user);
	}
	
	/**
	 * 事件停止
	 * 
	 * @param request
	 * @param id
	 * @return
	 * @throws RdpeException
	 */
	@ResponseBody
	@RequestMapping(value = "/stop")
	public RetInfo stop(HttpServletRequest request, String applicationId,String eventId) throws RdpeException {
		return eventStormService.stop(applicationId,eventId);
	}
	
}
