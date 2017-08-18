/**
 * Project Name		[rdpe]
 * File Name		[com.bonc.rdpe.service.impl.event.EventStormServiceImpl.java]
 * Creation Date	[2017年8月16日]
 * <p>
 * Copyright© 2017 www.bonc.com.cn All Rights Reserved
 * <p>
 */
package com.bonc.rdpe.service.impl.event;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bonc.rdpe.bo.flow.basic.Flow;
import com.bonc.rdpe.entity.EventStorm;
import com.bonc.rdpe.entity.user.User;
import com.bonc.rdpe.exception.RdpeException;
import com.bonc.rdpe.service.RetInfo;
import com.bonc.rdpe.service.event.EventOptService;
import com.bonc.rdpe.service.event.EventStormService;
import com.bonc.rdpe.service.event.FlowService;
import com.bonc.rdpe.service.host.HostStormService;
import com.bonc.rdpe.service.impl.base.BaseServiceImpl;
import com.bonc.rdpe.util.JsonUtils;

import lombok.extern.log4j.Log4j;

/**
 * @author wangxiaoxing
 * 
 * @date 2017年8月16日 上午11:25:56
 */

@Log4j
@Service("eventStormService")
public class EventStormServiceImpl extends BaseServiceImpl<EventStorm, String> implements EventStormService {
	@Resource
	private EventOptService eventOptService;
	
	@Resource
	private FlowService flowService;

	@Resource
	private HostStormService hostStormService;
	
	@Override
	public boolean editFlowDef(String id, String flowDef) {
		Flow flow = flowService.parseJson2Flow(flowDef);
		EventStorm eventStorm = getOne(id);
		if (flowDef != null && !flowDef.isEmpty()) {
			eventStorm.setFlowDef(JsonUtils.toJSONString(flow));
		}
		return edit(eventStorm);
	}

	@Override
	public RetInfo run(String id) throws RdpeException {
		return null;
	}

	@Override
	public RetInfo genCode(String id, Map<String, String> map) throws RdpeException {
		return null;
	}

	@Override
	public boolean publishEvent(String id, Map<String, String> map, User user) throws RdpeException {
		return false;
	}

	@Override
	public RetInfo stop(String topuId, String eventId) throws RdpeException {
		return null;
	}
}
