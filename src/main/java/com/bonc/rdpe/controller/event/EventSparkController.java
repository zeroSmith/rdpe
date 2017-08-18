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

import com.bonc.rdpe.entity.EventSpark;
import com.bonc.rdpe.entity.HostSpark;
import com.bonc.rdpe.entity.user.User;
import com.bonc.rdpe.exception.RdpeException;
import com.bonc.rdpe.service.RetInfo;
import com.bonc.rdpe.service.event.EventOptService;
import com.bonc.rdpe.service.event.EventSparkService;
import com.bonc.rdpe.service.host.HostSparkService;
import com.bonc.rdpe.util.AesUtil;
import com.bonc.rdpe.util.CmdUtil;
import com.bonc.rdpe.util.IdUtil;
import com.bonc.rdpe.util.JsonUtils;
import com.bonc.rdpe.util.UserUtil;

import lombok.extern.log4j.Log4j;


@Log4j
@Controller
@RequestMapping("/event/spark")
public class EventSparkController {

	@Resource
	private EventSparkService eventSparkService;

	@Resource
	private EventOptService eventOptService;

	@Resource
	private HostSparkService hostSparkService;

	@RequestMapping("/index")
	public String index() {
		return "event/event_spark_manage";
	}

	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping("/list")
	public Map<String, Object> list(HttpServletRequest request, String start, String length, String jsonStr) {
		Map<String, Object> paramMap = JsonUtils.stringToCollect(jsonStr);
		paramMap.put("createId", UserUtil.getUserId(request));
		Map<String, Object> retMap = eventSparkService.getAll(start, length, paramMap);
		return retMap;
	}

	@ResponseBody
	@RequestMapping("/add")
	public boolean add(HttpServletRequest request, String eventSparkJson, String executeDef) {
		EventSpark eventSpark = JsonUtils.toBean(eventSparkJson, EventSpark.class);
		eventSpark.setId(IdUtil.genUUID());
		eventSpark.setCreateId(UserUtil.getUserId(request));
		eventSpark.setCreateTime(new Date());
		eventSpark.setExecuteDef(executeDef);
		return eventSparkService.add(eventSpark);
	}

	@ResponseBody
	@RequestMapping("/load")
	public EventSpark load(String id) {
		return eventSparkService.getOne(id);
	}

	@ResponseBody
	@RequestMapping("/edit")
	public boolean edit(String eventSparkJson, String executeDef) {
		EventSpark eventSpark = JsonUtils.toBean(eventSparkJson, EventSpark.class);
		eventSpark.setExecuteDef(executeDef);
		return eventSparkService.edit(eventSpark);
	}

	@ResponseBody
	@RequestMapping("/remove")
	public boolean remove(HttpServletRequest request, String id) throws RdpeException {
		EventSpark eventSpark = eventSparkService.getOne(id);
		HostSpark hostSpark = hostSparkService.getOne(eventSpark.getSubmitHostId());

		// 清理发布目录文件
		String publishJarPath = eventSpark.getPublishJarPath();
		if (publishJarPath != null && !publishJarPath.trim().isEmpty()) {
			CmdUtil cmdUtil = new CmdUtil();
			String ip = hostSpark.getHostIp();
			int port = Integer.parseInt(hostSpark.getSshPort());
			String userName = hostSpark.getHostUsername();
			String passWord = AesUtil.decrypt(hostSpark.getHostPassword());
			cmdUtil.init(ip, port, userName, passWord);
			// 删除submit主机上的文件
			String cmd = "rm -rf " + AesUtil.decrypt(publishJarPath);
			cmdUtil.execCmds(cmd);
		}
		// 清理上传目录文件
		String uploadJarPath = eventSpark.getUploadJarPath();
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
			return eventSparkService.remove(id);
		} else {
			return false;
		}
	}

	@RequestMapping("/process")
	public ModelAndView process(String id) {
		EventSpark eventSpark = eventSparkService.getOne(id);
		ModelAndView mv = new ModelAndView();
		mv.addObject("event", eventSpark);
		mv.setViewName("event/event_process");
		return mv;
	}

	@ResponseBody
	@RequestMapping(value = "/editFlowDef")
	public boolean editFlowDef(String id, String flowDef) {
		return eventSparkService.editFlowDef(id, flowDef);
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
		return eventSparkService.run(id);
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
		RetInfo ret = eventSparkService.genCode(id, map);
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
		EventSpark eventSpark = new EventSpark();
		eventSpark.setId(id);
		eventSpark.setUploadJarPath(uploadJarPath);
		return eventSparkService.edit(eventSpark);
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
		return eventSparkService.publishEvent(id, map, user);
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
		return eventSparkService.stop(applicationId,eventId);
	}
}
