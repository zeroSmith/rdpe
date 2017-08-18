/**
 * Project Name		[rdpe]
 * File Name		[com.bonc.rdpe.service.impl.event.EventOptServiceImpl.java]
 * Creation Date	[2017年5月4日]
 * <p>
 * Copyright© 2017 www.bonc.com.cn All Rights Reserved
 * <p>
 */
package com.bonc.rdpe.service.impl.event;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.alibaba.fastjson.JSON;
import com.bonc.rdpe.bo.flow.basic.Flow;
import com.bonc.rdpe.bo.flow.basic.Rect;
import com.bonc.rdpe.constant.DataSourceType;
import com.bonc.rdpe.constant.EventOptType;
import com.bonc.rdpe.constant.FlowNodeType;
import com.bonc.rdpe.dao.DaoHelper;
import com.bonc.rdpe.entity.EventOpt;
import com.bonc.rdpe.entity.EventOptKey;
import com.bonc.rdpe.entity.FunDef;
import com.bonc.rdpe.entity.def.AggregateOpt;
import com.bonc.rdpe.entity.def.DsOpt;
import com.bonc.rdpe.entity.def.FilterOpt;
import com.bonc.rdpe.entity.def.FunOpt;
import com.bonc.rdpe.entity.def.JoinOpt;
import com.bonc.rdpe.entity.def.OptField;
import com.bonc.rdpe.entity.def.ParseOpt;
import com.bonc.rdpe.entity.def.StoreOpt;
import com.bonc.rdpe.entity.def.TransOpt;
import com.bonc.rdpe.exception.RdpeException;
import com.bonc.rdpe.service.event.EventOptService;
import com.bonc.rdpe.service.event.EventSparkService;
import com.bonc.rdpe.service.event.FlowService;
import com.bonc.rdpe.service.impl.base.BaseServiceImpl;
import com.bonc.rdpe.util.JsonUtils;
import com.bonc.rdpe.util.MD5Util;

/**
 * @author wangxiaoxing
 * 
 * @date 2017年5月4日 下午2:51:07
 */

@Service("eventOptService")
public class EventOptServiceImpl extends BaseServiceImpl<EventOpt, EventOptKey> implements EventOptService {

	@Resource
	private EventSparkService eventSparkService;

	@Resource
	private FlowService flowService;

	@Resource
	private DaoHelper daoHelper;

	@Override
	public boolean addOrEditParseSeparator(Map<String, Object> map) throws RdpeException {
		String optId = (String) map.get("optId");
		String eventId = (String) map.get("eventId");
		String createId = (String) map.get("createId");
		ParseOpt parseOpt = (ParseOpt) map.get("parseOpt");
		EventOpt parentOpt = getParentEventOpt(eventId, optId).get(0);
		String processType = parentOpt.getProcessType();// 父节点的处理类型
		EventOptKey key = getEventOptKey(eventId, optId);
		EventOpt eventOptPre = getOne(key);
		if (eventOptPre == null) {// 表里没有数据，新增操作
			EventOpt eventOpt = new EventOpt();
			eventOpt.setOptId(optId);
			eventOpt.setEventId(eventId);
			eventOpt.setCreateId(createId);
			eventOpt.setCreateTime(new Date());
			eventOpt.setOptType(FlowNodeType.PARSE);
			eventOpt.setProcessType(processType);
			String optDef = JsonUtils.toJSONString(parseOpt);
			eventOpt.setOptDef(optDef);
			eventOpt.setOptDefMd5(MD5Util.Bit32(processType + optDef));
			return add(eventOpt);
		} else {// 表里已经有数据了，更新操作
			String optDef = JsonUtils.toJSONString(parseOpt);
			eventOptPre.setOptDef(optDef);
			eventOptPre.setProcessType(processType);
			eventOptPre.setOptDefMd5(MD5Util.Bit32(processType + optDef));
			return edit(eventOptPre);
		}
	}
	
	@Override
	public boolean addOrEditParseJson(Map<String, Object> map) throws RdpeException {
		String optId = (String) map.get("optId");
		String eventId = (String) map.get("eventId");
		String createId = (String) map.get("createId");
		String optDef = (String) map.get("parseOpt");
		EventOpt parentOpt = getParentEventOpt(eventId, optId).get(0);
		String processType = parentOpt.getProcessType();// 父节点的处理类型
		EventOptKey key = getEventOptKey(eventId, optId);
		EventOpt eventOptPre = getOne(key);
		if (eventOptPre == null) {// 表里没有数据，新增操作
			EventOpt eventOpt = new EventOpt();
			eventOpt.setOptId(optId);
			eventOpt.setEventId(eventId);
			eventOpt.setCreateId(createId);
			eventOpt.setCreateTime(new Date());
			eventOpt.setOptType(FlowNodeType.PARSE);
			eventOpt.setProcessType(processType);
			eventOpt.setOptDef(optDef);
			eventOpt.setOptDefMd5(MD5Util.Bit32(processType + optDef));
			return add(eventOpt);
		} else {// 表里已经有数据了，更新操作
			eventOptPre.setOptDef(optDef);
			eventOptPre.setProcessType(processType);
			eventOptPre.setOptDefMd5(MD5Util.Bit32(processType + optDef));
			return edit(eventOptPre);
		}
	}

	@Override
	public boolean addOrEditFilter(String createId, FilterOpt filterOpt, EventOptKey key) {
		String processType = "";
		EventOpt eventOptPre = getOne(key);
		EventOpt parentOpt = getParentEventOpt(key.getEventId(), key.getOptId()).get(0);
		if (FlowNodeType.JOIN.equals(parentOpt.getOptType())) {
			processType = EventOptType.OPT_PROCESS_TYPE_STREAM;
		} else {
			processType = parentOpt.getProcessType();
		}
		if (eventOptPre == null) {// 表里没有数据，新增操作
			EventOpt eventOpt = new EventOpt();
			eventOpt.setOptId(key.getOptId());
			eventOpt.setEventId(key.getEventId());
			eventOpt.setCreateId(createId);
			eventOpt.setCreateTime(new Date());
			eventOpt.setOptType(FlowNodeType.FILTER);
			eventOpt.setProcessType(processType);
			String optDef = JsonUtils.toJSONString(filterOpt);
			eventOpt.setOptDef(optDef);
			eventOpt.setOptDefMd5(MD5Util.Bit32(processType + optDef));
			return add(eventOpt);
		} else {// 表里已经有数据了，更新操作
			String optDef = JsonUtils.toJSONString(filterOpt);
			eventOptPre.setProcessType(processType);
			eventOptPre.setOptDef(optDef);
			eventOptPre.setOptDefMd5(MD5Util.Bit32(processType + optDef));
			return edit(eventOptPre);
		}
	}

	@Override
	public Map<String, Object> getOptField(Map<String, Object> map) {
		Map<String, Rect> states = ((Flow) map.get("flow")).getStates();// 获取flow对象的states
		String eventId = (String) map.get("eventId");
		Rect rect = states.get((String) map.get("optId"));// 根据id获取到rect
		List<Rect> rects = rect.getParentNodes();// 获取到rect的父节点
		Map<String, Object> result = new HashMap<>();
		if (rects == null) {
			result.put("parentNode", "wrong");
			return result;
		}
		if (rects.size() == 2) {// 关联节点有两个父节点才能进行配置
			String place = "";
			for (Rect r : rects) {
				EventOpt parentEventOpt = getOne(getEventOptKey(eventId, r.getId()));
				place = parentEventOpt.getProcessType().contains(DataSourceType.DS_ASTYPE_STREAM) ? "left" : "right";
				String optDef = parentEventOpt != null ? parentEventOpt.getOptDef() : null;
				List<OptField> fieldList = new ArrayList<>();
				if (!StringUtils.isEmpty(optDef)) {
					fieldList = getOutputFieldList(optDef, r.getType());
					for (int i = 0; i < fieldList.size(); i++) {
						OptField field = fieldList.get(i);
						field.setEnNameAndCnName(field.getEnName() + "[" + field.getCnName() + "]");// 设置英文和中文拼接的字段
						fieldList.set(i, field);
					}
					result.put(place, JsonUtils.beanToJson(fieldList));
				}
			}
		} else {// 没有添加父节点，或者父节点的个数不是2
			result.put("parentNode", "wrong");
		}
		return result;
	}

	@Override
	public boolean addOrEditJoin(Map<String, Object> map) throws RdpeException {
		String processType = "";
		String optId = (String) map.get("optId");
		String eventId = (String) map.get("eventId");
		String createId = (String) map.get("createId");
		JoinOpt joinOpt = (JoinOpt) map.get("joinOpt");
		List<EventOpt> list = getParentEventOpt(eventId, optId);
		for (EventOpt eventOpt : list) {
			if (!eventOpt.getProcessType().contains(EventOptType.OPT_PROCESS_TYPE_STREAM)) {// 父节点中有处理类型为stream的，或者父节点是关联节点
				processType = EventOptType.OPT_PROCESS_TYPE_STREAM + "+" + eventOpt.getProcessType();
			}
		}
		if ("".equals(processType)) {
			processType = EventOptType.OPT_PROCESS_TYPE_STREAM;
		}
		EventOptKey key = getEventOptKey(eventId, optId);
		EventOpt eventOptPre = getOne(key);
		if (eventOptPre == null) {// 表里没有数据，新增操作
			EventOpt eventOpt = new EventOpt();
			eventOpt.setOptId(optId);
			eventOpt.setEventId(eventId);
			eventOpt.setCreateId(createId);
			eventOpt.setCreateTime(new Date());
			eventOpt.setOptType(FlowNodeType.JOIN);
			eventOpt.setProcessType(processType);
			if (joinOpt != null) {
				String optDef = JsonUtils.toJSONString(joinOpt);
				eventOpt.setOptDef(optDef);
			}
			return add(eventOpt);
		} else {// 表里有数据了，进行更新操作
			if (joinOpt != null) {//
				String optDef = JsonUtils.toJSONString(joinOpt);
				eventOptPre.setOptDef(optDef);
			}
			eventOptPre.setProcessType(processType);
			return edit(eventOptPre);
		}
	}

	/**
	 * 根据操作配置和操作类型，获取输出字段
	 * 
	 * @param optDef
	 * @param optType
	 * @return
	 */
	private List<OptField> getOutputFieldList(String optDef, String optType) {
		List<OptField> fieldList = new ArrayList<>();
		if (optType.equals(FlowNodeType.PARSE)) {// 解析操作
			Map optDefMap = JsonUtils.stringToCollect(optDef);
			//说明是json格式数据
			if(optDefMap.containsKey("jsonProperties")){
				String jsonString = JsonUtils.toJSONString(optDefMap.get("jsonProperties"));
				fieldList = JsonUtils.toList(jsonString, OptField.class);
			}else{
				ParseOpt parseOpt = JsonUtils.toBean(optDef, ParseOpt.class);
				fieldList = parseOpt.getFieldDef();
			}
		} else if (optType.equals(FlowNodeType.FILTER)) {// 过滤操作
			FilterOpt filterOpt = JsonUtils.toBean(optDef, FilterOpt.class);
			fieldList = filterOpt.getOutPutFieldDef();
		} else if (optType.equals(FlowNodeType.TRANS)) {// 转换操作
			List<TransOpt> transOptList = JsonUtils.toList(optDef, TransOpt.class);
			for (TransOpt transOpt : transOptList) {
				OptField field = transOpt.getOutPutFieldDef();
				fieldList.add(field);
			}
		} else if (optType.equals(FlowNodeType.JOIN)) {// 关联操作
			JoinOpt joinOpt = JsonUtils.toBean(optDef, JoinOpt.class);
			fieldList = joinOpt.getOutPutFieldDef();
		} else if (optType.equals(FlowNodeType.AGGREGATE)){//聚合操作
			List<AggregateOpt> aggOpt = JsonUtils.toList(optDef, AggregateOpt.class);
			for (AggregateOpt agg : aggOpt) {
				OptField field = agg.getOutPutFieldDef();
				fieldList.add(field);
			}
		}
		return fieldList;
	}

	@Override
	public boolean addOrEditDs(Map<String, Object> map) {
		String optId = (String) map.get("optId");
		String eventId = (String) map.get("eventId");
		String createId = (String) map.get("createId");
		DsOpt dsOpt = (DsOpt) map.get("dsOpt");
		EventOptKey key = getEventOptKey(eventId, optId);
		EventOpt eventOptPre = getOne(key);
		String processType = getProcessType(dsOpt);
		if (eventOptPre == null) {// 表里没有数据，新增操作
			EventOpt eventOpt = new EventOpt();
			eventOpt.setOptId(optId);
			eventOpt.setEventId(eventId);
			eventOpt.setCreateId(createId);
			eventOpt.setCreateTime(new Date());
			eventOpt.setOptType(FlowNodeType.DS);
			eventOpt.setProcessType(processType);
			String optDef = JsonUtils.toJSONString(dsOpt);
			eventOpt.setOptDef(optDef);
			eventOpt.setOptDefMd5(MD5Util.Bit32(processType + optDef));
			return add(eventOpt);
		} else {// 表里有数据了，进行更新操作
			String optDef = JsonUtils.toJSONString(dsOpt);
			eventOptPre.setOptDef(optDef);
			eventOptPre.setProcessType(processType);
			eventOptPre.setOptDefMd5(MD5Util.Bit32(processType + optDef));
			return edit(eventOptPre);
		}
	}

	private String getProcessType(DsOpt dsOpt) {
		String processType = "";
		String asType = dsOpt.getAsType();
		if (DataSourceType.DS_ASTYPE_STREAM.equals(asType)) {
			processType = EventOptType.OPT_PROCESS_TYPE_STREAM;
		} else if (DataSourceType.DS_ASTYPE_RULE.equals(asType)) {
			String dsType = dsOpt.getDsType();
			if (DataSourceType.DS_TYPE_REDIS.equals(dsType)) {
				processType = EventOptType.OPT_PROCESS_TYPE_SET;
			} else if (DataSourceType.DS_TYPE_HDFS.equals(dsType)) {
				processType = EventOptType.OPT_PROCESS_TYPE_RDD;
			}
		}
		return processType;
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

	@Override
	public boolean addOrEditStore(Map<String, Object> map) {
		String processType = "";
		String optId = (String) map.get("optId");
		String eventId = (String) map.get("eventId");
		String createId = (String) map.get("createId");
		StoreOpt storeOpt = (StoreOpt) map.get("storeOpt");
		EventOpt parentOpt = getParentEventOpt(eventId, optId).get(0);
		if (FlowNodeType.JOIN.equals(parentOpt.getOptType())) {
			processType = EventOptType.OPT_PROCESS_TYPE_STREAM;
		} else {
			processType = parentOpt.getProcessType();
		}
		EventOptKey key = getEventOptKey(eventId, optId);
		EventOpt eventOptPre = getOne(key);
		if (eventOptPre == null) {// 表里没有数据，新增操作
			EventOpt eventOpt = new EventOpt();
			eventOpt.setOptId(optId);
			eventOpt.setEventId(eventId);
			eventOpt.setCreateId(createId);
			eventOpt.setCreateTime(new Date());
			eventOpt.setOptType(FlowNodeType.STORE);
			eventOpt.setProcessType(processType);
			if (storeOpt != null) {
				String optDef = JsonUtils.toJSONString(storeOpt);
				eventOpt.setOptDef(optDef);
			}
			return add(eventOpt);
		} else {// 表里有数据了，进行更新操作
			if (storeOpt != null) {//
				String optDef = JsonUtils.toJSONString(storeOpt);
				eventOptPre.setOptDef(optDef);
			}
			eventOptPre.setProcessType(processType);
			return edit(eventOptPre);
		}
	}

	@Override
	public Map<String, Object> getInputField(Flow flow, String eventId, String optId) {
		Map<String, Object> hashMap = new HashMap<>();
		String parentProcessType = "";
		List<OptField> list = new ArrayList<>();// 存放字段集合
		Map<String, Rect> states = flow.getStates();// 获取所有的rect
		Rect rect = states.get(optId);// 获取当前的rect
		List<Rect> rectList = rect.getParentNodes();// 获取当前rect的父节点
		EventOpt eventOpt = null;
		if (rectList.size() == 1) {
			Rect parentRect = rectList.get(0);
			String parentType = parentRect.getType();// 父节点的类型
			String parentId = "";
			if (parentType.equals(FlowNodeType.FUN)) {// 父节点的函数节点，需要查询函数节点的上级节点
				Rect r = getParentRectOfFun(parentRect);
				parentId = r.getId();
			} else {// 父节点是解析、过滤、关联、转换中的一种
				parentId = parentRect.getId();
			}
			eventOpt = getOne(getEventOptKey(eventId, parentId));// 获取父节点的操作配置
			// 父节点没有保存在数据库
			if (eventOpt == null) {
				return null;
			}
			String optDef = eventOpt.getOptDef();
			String optType = eventOpt.getOptType();
			if (optType.equals(FlowNodeType.JOIN)) {
				parentProcessType = EventOptType.OPT_PROCESS_TYPE_STREAM;
			} else {
				parentProcessType = eventOpt.getProcessType();
			}
			list = getOutputFieldList(optDef, optType);
			for (int i = 0; i < list.size(); i++) {
				OptField field = list.get(i);
				field.setEnNameAndCnName(field.getEnName() + "[" + field.getCnName() + "]");// 设置英文和中文拼接的字段
				list.set(i, field);
			}
		}

		hashMap.put("optFieldList", list);
		hashMap.put("parentProcessType", parentProcessType);
		return hashMap;
	}

	/**
	 * 获取函数节点的上级非函数节点
	 * 
	 * @param rect
	 * @return
	 */
	private Rect getParentRectOfFun(Rect r) {
		List<Rect> rects = r.getParentNodes();
		Rect rect = rects.get(0);
		if (!FlowNodeType.FUN.equals(rect.getType())) {
			return rect;
		} else {
			return getParentRectOfFun(rect);
		}
	}

	@Override
	public String getFilterRule(String eventId, String optId) {
		String rule = "";
		EventOpt eventOpt = getOne(getEventOptKey(eventId, optId));
		if (eventOpt != null) {
			rule = JsonUtils.toBean(eventOpt.getOptDef(), FilterOpt.class).getRuleExp();
		}
		return rule;
	}

	/**
	 * 获取当前操作节点的父节点eventOpt
	 * 
	 * @param eventId
	 * @param optId
	 * @return
	 */
	private List<EventOpt> getParentEventOpt(String eventId, String optId) {
		List<EventOpt> optList = new ArrayList<>();
		Flow flow = flowService.parseJson2Flow(eventSparkService.getOne(eventId).getFlowDef());
		Map<String, Rect> states = flow.getStates();// 获取所有的rect
		Rect rect = states.get(optId);// 获取当前的rect
		List<Rect> rectList = rect.getParentNodes();// 获取当前rect的父节点
		EventOpt eventOpt = new EventOpt();
		if (rectList.size() == 1) {
			Rect parentRect = rectList.get(0);
			eventOpt = getPre(parentRect, eventId);
			optList.add(eventOpt);
		} else if (rectList.size() == 2) {// 有两个父节点，说明当前节点是关联节点
			for (Rect r : rectList) {
				eventOpt = getPre(r, eventId);
				optList.add(eventOpt);
			}
		}
		return optList;
	}

	private EventOpt getPre(Rect rect, String eventId) {
		EventOpt eventOpt = new EventOpt();
		String parentId = rect.getId();// 父节点是解析、过滤、关联、转换、函数中的一种
		eventOpt = getOne(getEventOptKey(eventId, parentId));// 获取父节点的操作配置
		return eventOpt;
	}

	@Override
	public boolean removeByEventId(String eventId) {
		try {
			daoHelper.delete(getStatementPrefix()+"deleteByEventId", eventId);
		} catch (Exception e) {
			return false;
		}
		return true;
	}

	@Override
	public Map<String,String> getDs(String eventId, String optId) {
		Map<String,String> map = new HashMap<>();
		EventOpt parentOpt = getOne(getEventOptKey(eventId, optId));
		if(parentOpt==null){
			map.put("info", "hasNull");
		}
		String optDef = parentOpt.getOptDef();
		DsOpt dsOpt = JSON.parseObject(optDef, DsOpt.class);
		if (!map.containsKey("info") && StringUtils.isEmpty(dsOpt.getAsType().trim())
				&& StringUtils.isEmpty(dsOpt.getDsType().trim()) && StringUtils.isEmpty(dsOpt.getDsName().trim())
				&& StringUtils.isEmpty(dsOpt.getDsFormat().trim())) {//提取节点的所有配置字段都不能为空
			map.put("info", "hasNull");
		}
		if (!map.containsKey("info")) {
			map.put("info", "correct");
			map.put("format", dsOpt.getDsFormat());
		}
		return map;
	}

	@Override
	public String getDsFormat(String eventId, String optId) {
		EventOpt eventOpt = getParentEventOpt(eventId, optId).get(0);
		String optDef = eventOpt.getOptDef();
		String format = null;
		if(FlowNodeType.DS.equals(eventOpt.getOptType())){
			DsOpt dsOpt = JSON.parseObject(optDef, DsOpt.class);
			format = dsOpt.getDsFormat();
		}else{
			FunOpt funOpt = JSON.parseObject(optDef, FunOpt.class);
			FunDef funDef = (FunDef) daoHelper.queryOne("com.bonc.rdpe.entity.FunDef.selectByPrimaryKey", funOpt.getId());
			format = funDef.getParseFormat();
		}
		if("separator".equals(format)){
			return "event/parseSeparator";
		}else if("json".equals(format)){
			return "event/parse_json";
		}else if("xml".equals(format)){
			return "event/parseXml";
		}else{
			return "";
		}
	}
}
