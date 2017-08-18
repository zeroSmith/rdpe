package com.bonc.base.test;

import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;

import com.bonc.rdpe.bo.flow.basic.Flow;
import com.bonc.rdpe.bo.flow.basic.Rect;
import com.bonc.rdpe.dao.DaoHelper;
import com.bonc.rdpe.entity.EventOpt;
import com.bonc.rdpe.entity.EventOptKey;
import com.bonc.rdpe.entity.EventSpark;
import com.bonc.rdpe.exception.RdpeException;
import com.bonc.rdpe.service.event.CodeService;
import com.bonc.rdpe.service.event.FlowService;

public class GenCodeTest extends BaseJunit4Test {
	
	@Resource
	private DaoHelper daoHelper;
	
	@Resource
	private FlowService flowService;
	
	@Resource
	private CodeService sparkTransCodeService;
	
	@Test
	public void testGenCode() throws RdpeException{
		EventSpark event = (EventSpark)daoHelper.queryOne("com.bonc.rdpe.entity.EventSpark.selectByPrimaryKey", "AE64BA5DBB004F0183359CB948BB1506");
		Flow flow = flowService.parseJson2Flow(event.getFlowDef());
		Map<String, Rect> map = flow.getStates();
		Rect rect = map.get("rect8");
		EventOptKey key = new EventOptKey();
		key.setEventId("AE64BA5DBB004F0183359CB948BB1506");
		key.setOptId("rect8");
		EventOpt opt = (EventOpt)daoHelper.queryOne("com.bonc.rdpe.entity.EventOpt.selectByPrimaryKey", key);
		sparkTransCodeService.genCode(event, rect, opt, null);
	}

}
