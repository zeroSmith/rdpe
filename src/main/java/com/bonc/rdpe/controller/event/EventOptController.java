/**
 * Project Name		[rdpe]
 * File Name		[com.bonc.rdpe.controller.event.EventOptController.java]
 * Creation Date	[2017年5月2日]
 * <p>
 * Copyright© 2017 www.bonc.com.cn All Rights Reserved
 * <p>
 */
package com.bonc.rdpe.controller.event;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bonc.rdpe.bo.flow.basic.Flow;
import com.bonc.rdpe.constant.DataSourceType;
import com.bonc.rdpe.constant.EventOptType;
import com.bonc.rdpe.constant.FlowNodeType;
import com.bonc.rdpe.entity.DsHdfs;
import com.bonc.rdpe.entity.DsKafka;
import com.bonc.rdpe.entity.DsRedis;
import com.bonc.rdpe.entity.EventOpt;
import com.bonc.rdpe.entity.EventOptKey;
import com.bonc.rdpe.entity.EventSpark;
import com.bonc.rdpe.entity.FunDef;
import com.bonc.rdpe.entity.def.DsOpt;
import com.bonc.rdpe.entity.def.FilterOpt;
import com.bonc.rdpe.entity.def.JoinOpt;
import com.bonc.rdpe.entity.def.OptField;
import com.bonc.rdpe.entity.def.ParseOpt;
import com.bonc.rdpe.entity.def.StoreOpt;
import com.bonc.rdpe.exception.RdpeException;
import com.bonc.rdpe.service.datasource.DsHdfsService;
import com.bonc.rdpe.service.datasource.DsKafkaService;
import com.bonc.rdpe.service.datasource.DsRedisService;
import com.bonc.rdpe.service.event.EventOptService;
import com.bonc.rdpe.service.event.EventSparkService;
import com.bonc.rdpe.service.event.FlowService;
import com.bonc.rdpe.service.function.FunDefService;
import com.bonc.rdpe.util.JsonUtils;
import com.bonc.rdpe.util.MD5Util;
import com.bonc.rdpe.util.UserUtil;

import lombok.extern.log4j.Log4j;

/**
 * @author wangxiaoxing
 * 
 * @date 2017年5月2日 下午5:05:38
 */
@Log4j
@Controller
@RequestMapping("/event/opt")
public class EventOptController {


	@Resource
	private EventOptService eventOptService;

	@Resource
	private EventSparkService eventSparkService;

	@Resource
	private FlowService flowService;

	@Resource
	private FunDefService funDefService;

	@Resource
	private DsKafkaService dskafkaService;

	@Resource
	private DsHdfsService dsHdfsService;

	@Resource
	private DsRedisService dsRedisService;

	@RequestMapping("/ds/{eventId}/{optId}")
	public String ds(@PathVariable("eventId") String eventId, @PathVariable("optId") String optId, Model model) {
		EventOpt eventOpt = eventOptService.getOne(getEventOptKey(eventId, optId));
		model.addAttribute("eventOpt", eventOpt);
		return "event/ds";
	}

	@RequestMapping("/parse/{eventId}/{optId}")
	public String parse(@PathVariable("eventId") String eventId, @PathVariable("optId") String optId, Model model) {
		EventOpt eventOpt = eventOptService.getOne(getEventOptKey(eventId, optId));
		if(eventOpt == null){
			eventOpt = new EventOpt();
			eventOpt.setOptDef("{}");
		}
		model.addAttribute("eventOpt", eventOpt);
		return eventOptService.getDsFormat(eventId,optId);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("/filter/{eventId}/{optId}")
	public String filter(@PathVariable("eventId") String eventId, @PathVariable("optId") String optId, ModelMap model) throws RdpeException {
		EventSpark eswb = eventSparkService.getOne(eventId);
		Flow flow = flowService.parseJson2Flow(eswb.getFlowDef());
		Map<String, Object> inputField = eventOptService.getInputField(flow, eventId, optId);
		if(inputField==null||inputField.isEmpty()){
			throw new RdpeException("上级节点未配置输出信息");
		}
		List<OptField> optField = (List<OptField>) inputField.get("optFieldList");
		String rule = eventOptService.getFilterRule(eventId, optId);
		model.addAttribute("optField", JsonUtils.beanToJson(optField));
		model.addAttribute("rule", rule);// 过滤规则
		return "event/filter";
	}

	@RequestMapping("/join/{eventId}/{optId}")
	public String join(@PathVariable("eventId") String eventId, @PathVariable("optId") String optId, Model model) throws RdpeException {
		EventSpark eventSpark = eventSparkService.getOne(eventId);
		if (eventSpark != null) {
			Flow flow = flowService.parseJson2Flow(eventSpark.getFlowDef());// 首先把json串解析成flow对象
			Map<String, Object> map = new HashMap<>();
			map.put("flow", flow);
			map.put("eventId", eventId);
			map.put("optId", optId);
			Map<String, Object> ztreeMap = eventOptService.getOptField(map);
			if(ztreeMap==null||ztreeMap.size()!=2){
				throw new RdpeException("上级节点未配置输出信息");
			}
			model.addAttribute("ztreeMap", ztreeMap);
		}
		List<FunDef> funDefList = funDefService.getFun("field");// 查询出函数类型为field的自定义函数
		model.addAttribute("funDefList", JsonUtils.beanToJson(funDefList));
		EventOpt eventOpt = eventOptService.getOne(getEventOptKey(eventId, optId));
		model.addAttribute("eventOpt", eventOpt);
		return "event/join";
	}

	/**
	 * 加载转换页面
	 * 
	 * @param eventId
	 * @param optId
	 * @param model
	 * @return
	 * @throws RdpeException 
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/trans/{eventId}/{optId}")
	public String trans(@PathVariable("eventId") String eventId, @PathVariable("optId") String optId, Model model) throws RdpeException {
		EventSpark event = eventSparkService.getOne(eventId);
		Flow flow = flowService.parseJson2Flow(event.getFlowDef());
		Map<String, Object> inputField = eventOptService.getInputField(flow, eventId, optId);
		// 比如转换前有一个过滤，但是点击转换时，过滤还没有保存，会出现null值的问题
		if (inputField == null||inputField.isEmpty()) {
			throw new RdpeException("上级节点未配置输出信息");
		}
		List<OptField> optField = (List<OptField>) inputField.get("optFieldList");
		EventOpt eventOpt = eventOptService.getOne(getEventOptKey(eventId, optId));
		// 当前转换操作还没有保存
		if (eventOpt == null) {
			eventOpt = new EventOpt();
			eventOpt.setOptId(optId);
			eventOpt.setEventId(eventId);
			eventOpt.setOptType(FlowNodeType.TRANS);
			eventOpt.setOptDef("[]");// 设为空的数组
		}
		eventOpt.setProcessType(String.valueOf(inputField.get("parentProcessType")));
		model.addAttribute("eventOpt", JsonUtils.beanToJson(eventOpt));
		model.addAttribute("optField", JsonUtils.beanToJson(optField));
		model.addAttribute("funData", JsonUtils.beanToJson(funDefService.getFun("field")));
		return "event/trans";
	}

	@RequestMapping("/store/{eventId}/{optId}")
	public String store(@PathVariable("eventId") String eventId, @PathVariable("optId") String optId, Model model) {
		EventOpt eventOpt = eventOptService.getOne(getEventOptKey(eventId, optId));
		model.addAttribute("eventOpt", eventOpt);
		return "event/store";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("/aggregate/{eventId}/{optId}")
	public String aggregate(@PathVariable("eventId") String eventId, @PathVariable("optId") String optId, Model model) throws RdpeException {
		EventSpark event = eventSparkService.getOne(eventId);
		Flow flow = flowService.parseJson2Flow(event.getFlowDef());
		Map<String, Object> inputField = eventOptService.getInputField(flow, eventId, optId);
		// 比如转换前有一个过滤，但是点击转换时，过滤还没有保存，会出现null值的问题
		if (inputField == null||inputField.isEmpty()) {
			throw new RdpeException("上级节点未配置输出信息");
		}
		List<OptField> optField = (List<OptField>) inputField.get("optFieldList");
		EventOpt eventOpt = eventOptService.getOne(getEventOptKey(eventId, optId));
		// 当前转换操作还没有保存
		if (eventOpt == null) {
			eventOpt = new EventOpt();
			eventOpt.setOptId(optId);
			eventOpt.setEventId(eventId);
			eventOpt.setOptType(FlowNodeType.AGGREGATE);
			eventOpt.setOptDef("[]");// 设为空的数组
		}
		eventOpt.setProcessType(String.valueOf(inputField.get("parentProcessType")));
		model.addAttribute("eventOpt", JsonUtils.beanToJson(eventOpt));
		model.addAttribute("optField", JsonUtils.beanToJson(optField));
		model.addAttribute("funData", JsonUtils.beanToJson(funDefService.getFun("field")));
		return "event/aggregate";
	}
	
	/**
	 * 加载函数页面
	 * 
	 * @param eventId
	 * @param optId
	 * @param model
	 * @return
	 */
	@RequestMapping("/fun/{eventId}/{optId}")
	public String fun(@PathVariable("eventId") String eventId, @PathVariable("optId") String optId, Model model) {
		EventOpt eventOpt = eventOptService.getOne(getEventOptKey(eventId, optId));
		// 当前转换操作还没有保存
		if (eventOpt == null) {
			eventOpt = new EventOpt();
			eventOpt.setOptId(optId);
			eventOpt.setEventId(eventId);
			eventOpt.setOptType(FlowNodeType.FUN);
			eventOpt.setProcessType(EventOptType.OPT_PROCESS_TYPE_STREAM);
			eventOpt.setOptDef("{}");// 设为空的数组
		}
		model.addAttribute("eventOpt", JsonUtils.beanToJson(eventOpt));
		return "event/fun";
	}

	/**
	 * 添加转换操作 函数的添加操作也使用此方法
	 * 
	 * @param request
	 * @param eventOpt
	 *            当前操作的事件
	 * @param transOpt
	 *            转换的规则
	 * @return
	 * @throws RdpeException
	 */
	@ResponseBody
	@RequestMapping("/trans/add")
	public boolean addOrEditTrans(HttpServletRequest request, String eventOptStr, String optDef) {
		EventOpt eventOpt = (EventOpt) JsonUtils.toBean(eventOptStr, EventOpt.class);
		eventOpt.setOptDef(optDef);
		eventOpt.setOptDefMd5(MD5Util.Bit32(eventOpt.getProcessType()+optDef));
		eventOpt.setCreateId(UserUtil.getUserResource(request).getUserId());
		eventOpt.setCreateTime(new Date());
		EventOpt eventOptOld = eventOptService.getOne(getEventOptKey(eventOpt.getEventId(), eventOpt.getOptId()));
		// 判断数据库是否已经有值
		if (eventOptOld == null) {
			// 没有值进行插入操作
			return eventOptService.add(eventOpt);
		} else {
			// 有值执行编辑操作
			return eventOptService.edit(eventOpt);
		}

	}

	@ResponseBody
	@RequestMapping("/ds/add/{eventId}/{optId}")
	public boolean addOrEditDs(HttpServletRequest request, @RequestBody DsOpt dsOpt, @PathVariable("eventId") String eventId, @PathVariable("optId") String optId) {
		String createId = UserUtil.getUserResource(request).getUserId();
		Map<String, Object> map = new HashMap<>();
		map.put("createId", createId);
		map.put("dsOpt", dsOpt);
		map.put("eventId", eventId);
		map.put("optId", optId);
		return eventOptService.addOrEditDs(map);
	}

	@ResponseBody
	@RequestMapping("/parse/separator/add/{eventId}/{optId}")
	public boolean addOrEditParse(HttpServletRequest request, @RequestBody ParseOpt parseOpt, @PathVariable("eventId") String eventId, @PathVariable("optId") String optId) throws RdpeException {
		String createId = UserUtil.getUserResource(request).getUserId();
		Map<String, Object> map = new HashMap<>();
		map.put("createId", createId);
		map.put("parseOpt", parseOpt);
		map.put("eventId", eventId);
		map.put("optId", optId);
		return eventOptService.addOrEditParseSeparator(map);
	}
	
	@ResponseBody
	@RequestMapping("/parse/json/add/{eventId}/{optId}")
	public boolean addOrEditParseJson(HttpServletRequest request,String optDef, @PathVariable("eventId") String eventId, @PathVariable("optId") String optId) throws RdpeException {
		String createId = UserUtil.getUserResource(request).getUserId();
		Map<String, Object> map = new HashMap<>();
		map.put("createId", createId);
		map.put("parseOpt", optDef);
		map.put("eventId", eventId);
		map.put("optId", optId);
		return eventOptService.addOrEditParseJson(map);
	}


	@ResponseBody
	@RequestMapping("/parse/getDs/{eventId}/{optId}")
	public Map<String,String> getDs(@PathVariable("eventId") String eventId, @PathVariable("optId") String optId) throws RdpeException {
		return eventOptService.getDs(eventId,optId);
	}
		
	@ResponseBody
	@RequestMapping("/ds/get")
	public List<Object> getDs(String dstype, HttpServletRequest request) {
		List<Object> dsList = new ArrayList<>();
		Map<String, String> param = new HashMap<>();//查询参数
		String createId = UserUtil.getUserResource(request).getUserId();//当前登录用户
		param.put("createId", createId);
		if (dstype.equals(DataSourceType.DS_TYPE_KAFKA)) {// Kafka
			List<DsKafka> dsKafkaList = dskafkaService.getAllByCreateId(param);
			dsList.addAll(dsKafkaList);
		} else if (dstype.equals(DataSourceType.DS_TYPE_HDFS)) {// hdfs
			List<DsHdfs> dsHdfsList = dsHdfsService.getAllByCreateId(param);
			dsList.addAll(dsHdfsList);
		} else if (dstype.equals(DataSourceType.DS_TYPE_REDIS)) {// redis
			List<DsRedis> dsRedisList = dsRedisService.getAllByCreateId(param);
			dsList.addAll(dsRedisList);
		}
		return dsList;
	}

	@ResponseBody
	@RequestMapping("/filter/add/{eventId}/{optId}")
	public boolean addOrEditfilter(HttpServletRequest request, String ruleExp, String fieldDef, @PathVariable("eventId") String eventId, @PathVariable("optId") String optId) throws RdpeException {
		String createId = UserUtil.getUserResource(request).getUserId();
		FilterOpt filterOpt = new FilterOpt();
		filterOpt.setRuleExp(ruleExp == null ? "" : ruleExp);
		filterOpt.setInputFieldDef(JsonUtils.toList(fieldDef == null ? "" : fieldDef.substring(0, fieldDef.length() - 1), OptField.class));
		filterOpt.setOutPutFieldDef(JsonUtils.toList(fieldDef == null ? "" : fieldDef.substring(0, fieldDef.length() - 1), OptField.class));
		EventOptKey key = new EventOptKey();// t_event_opt表的联合主键
		key.setOptId(optId);
		key.setEventId(eventId);
		return eventOptService.addOrEditFilter(createId, filterOpt, key);
	}

	@ResponseBody
	@RequestMapping("/join/add/{eventId}/{optId}")
	public boolean addOrEditJoin(HttpServletRequest request, @RequestBody JoinOpt joinOpt, @PathVariable("eventId") String eventId, @PathVariable("optId") String optId) {
		boolean result = true;
		try {
			String createId = UserUtil.getUserResource(request).getUserId();
			EventSpark event = eventSparkService.getOne(eventId);
			Flow flow = flowService.parseJson2Flow(event.getFlowDef());
			Map<String, Object> map = new HashMap<>();
			map.put("createId", createId);
			map.put("joinOpt", joinOpt);
			map.put("eventId", eventId);
			map.put("optId", optId);
			map.put("flow", flow);
			result = eventOptService.addOrEditJoin(map);
		} catch (RdpeException e) {
			result = false;
			log.error(e.getMessage(), e);
		}
		return result;
	}

	@ResponseBody
	@RequestMapping("/store/add/{eventId}/{optId}")
	public boolean addOrEditStore(HttpServletRequest request, @RequestBody StoreOpt storeOpt, @PathVariable("eventId") String eventId, @PathVariable("optId") String optId) {
		String createId = UserUtil.getUserResource(request).getUserId();
		Map<String, Object> map = new HashMap<>();
		map.put("createId", createId);
		map.put("storeOpt", storeOpt);
		map.put("eventId", eventId);
		map.put("optId", optId);
		return eventOptService.addOrEditStore(map);
	}

	@ResponseBody
	@RequestMapping("/aggregate/add")
	public boolean addOrEditAggregate(HttpServletRequest request, String eventOptStr, String optDef) {
		EventOpt eventOpt = (EventOpt) JsonUtils.toBean(eventOptStr, EventOpt.class);
		eventOpt.setOptDef(optDef);
		eventOpt.setOptDefMd5(MD5Util.Bit32(eventOpt.getProcessType()+optDef));
		eventOpt.setCreateId(UserUtil.getUserResource(request).getUserId());
		eventOpt.setCreateTime(new Date());
		EventOpt eventOptOld = eventOptService.getOne(getEventOptKey(eventOpt.getEventId(), eventOpt.getOptId()));
		// 判断数据库是否已经有值
		if (eventOptOld == null) {
			// 没有值进行插入操作
			return eventOptService.add(eventOpt);
		} else {
			// 有值执行编辑操作
			return eventOptService.edit(eventOpt);
		}

	}
	
	@ResponseBody
	@RequestMapping(value = "/remove", method = RequestMethod.POST)
	public boolean remove(String optId, String eventId) throws Exception {
		return eventOptService.remove(getEventOptKey(eventId, optId));
	}

	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping("/get/{eventId}/{optId}")
	public List<OptField> get(@PathVariable("eventId") String eventId, @PathVariable("optId") String optId) {
		EventSpark event = eventSparkService.getOne(eventId);
		Flow flow = flowService.parseJson2Flow(event.getFlowDef());
		Map<String, Object> inputField = eventOptService.getInputField(flow, eventId, optId);
		List<OptField> optField = (List<OptField>) inputField.get("optFieldList");
		return optField;
	}

	/**
	 * 根据事件id和操作id得到联合主键
	 * 
	 * @param eventId
	 * @param optId
	 * @return
	 */
	private EventOptKey getEventOptKey(String eventId, String optId) {
		EventOptKey key = new EventOptKey();
		key.setOptId(optId);
		key.setEventId(eventId);
		return key;
	}
}
