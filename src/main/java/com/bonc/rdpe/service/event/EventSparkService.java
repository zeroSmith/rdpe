package com.bonc.rdpe.service.event;

import java.util.Map;

import com.bonc.rdpe.entity.EventSpark;
import com.bonc.rdpe.entity.user.User;
import com.bonc.rdpe.exception.RdpeException;
import com.bonc.rdpe.service.RetInfo;
import com.bonc.rdpe.service.base.IBaseService;

public interface EventSparkService extends IBaseService<EventSpark, String> {

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
	 * @param applicationId
	 * @param eventId
	 * @return
	 * @throws RdpeException
	 */
	public RetInfo stop(String applicationId,String eventId) throws RdpeException;

}
