/**
 * Project Name		[rdpe]
 * File Name		[com.bonc.rdpe.service.event.EventOptService.java]
 * Creation Date	[2017年5月4日]
 * <p>
 * Copyright© 2017 www.bonc.com.cn All Rights Reserved
 * <p>
 */
package com.bonc.rdpe.service.event;

import java.util.Map;

import com.bonc.rdpe.bo.flow.basic.Flow;
import com.bonc.rdpe.entity.EventOpt;
import com.bonc.rdpe.entity.EventOptKey;
import com.bonc.rdpe.entity.def.FilterOpt;
import com.bonc.rdpe.exception.RdpeException;
import com.bonc.rdpe.service.base.IBaseService;

/**
 * @author wangxiaoxing
 * 
 * @date 2017年5月4日 下午2:50:34
 */
public interface EventOptService extends IBaseService<EventOpt, EventOptKey>{

	/**
	 * 新增或者更新解析操作，数据源格式为分隔符
	 * @param map
	 * @return
	 * @throws RdpeException
	 */
	boolean addOrEditParseSeparator(Map<String,Object> map) throws RdpeException;
	
	/**
	 * 解析json
	 * @param map
	 * @return
	 * @throws RdpeException
	 */
	boolean addOrEditParseJson(Map<String,Object> map) throws RdpeException;

	boolean addOrEditFilter(String createId, FilterOpt filterOpt, EventOptKey key);
	
	/**
	 * 得到关联的父节点的输出字段集合
	 * @param map
	 * @return
	 */
	Map<String, Object> getOptField(Map<String,Object> map);

	/**
	 * 新增或者更新关联操作
	 * @param map
	 * @return
	 */
	boolean addOrEditJoin(Map<String, Object> map) throws RdpeException;

	/**
	 * 新增或更新提取操作
	 * @param map
	 * @return
	 */
	boolean addOrEditDs(Map<String, Object> map);

	/**
	 * 新增或更新存储操作
	 * @param map
	 * @return
	 */
	boolean addOrEditStore(Map<String, Object> map);

	/**
	 * 过滤、转换操作获取父节点的输出字段
	 * @param flow
	 * @param eventId 事件id
	 * @param optId 当前操作id
	 * @return
	 */
	Map<String,Object> getInputField(Flow flow, String eventId, String optId);

	/**
	 * 获取过滤操作的过滤规则
	 * @param eventId
	 * @param optId
	 * @return
	 */
	String getFilterRule(String eventId, String optId);
	
	
	boolean removeByEventId(String eventId);

	/**
	 * 判断解析节点的上级提取节点的属性是否为空
	 * @param eventId
	 * @param optId
	 */
	Map<String,String> getDs(String eventId, String optId);

	String getDsFormat(String eventId, String optId);
}
