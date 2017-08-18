/**
 * Project Name		[rdpe]
 * File Name		[com.bonc.rdpe.service.event.EventStormService.java]
 * Creation Date	[2017年8月16日]
 * <p>
 * Copyright© 2017 www.bonc.com.cn All Rights Reserved
 * <p>
 */
package com.bonc.rdpe.service.event;

import java.util.Map;

import com.bonc.rdpe.entity.EventStorm;
import com.bonc.rdpe.entity.user.User;
import com.bonc.rdpe.exception.RdpeException;
import com.bonc.rdpe.service.RetInfo;
import com.bonc.rdpe.service.base.IBaseService;

/**
 * @author wangxiaoxing
 * 
 * @date 2017年8月16日 上午11:24:32
 */
public interface EventStormService extends IBaseService<EventStorm, String>{
	/**
	 * 更新flowDef字段的json值
	 * 
	 * @param id
	 * @param flowDef
	 * @return
	 */
	public boolean editFlowDef(String id, String flowDef);

	/**
	 * 事件运行
	 * 
	 * @param id
	 * @param map
	 * @param user
	 * @return
	 */
	public RetInfo run(String id) throws RdpeException;

	/**
	 * 生成代码
	 * 
	 * @param id
	 * @param map
	 * @return
	 */
	public RetInfo genCode(String id, Map<String, String> map) throws RdpeException;

	/**
	 * 发布事件
	 * 
	 * @param id
	 *            事件ID
	 * @param map
	 * @param user
	 * @return
	 */
	public boolean publishEvent(String id, Map<String, String> map, User user) throws RdpeException;
	
	/**
	 * 事件停止
	 * @param topuId
	 * @param eventId
	 * @return
	 * @throws RdpeException
	 */
	public RetInfo stop(String topuId,String eventId) throws RdpeException;
}
