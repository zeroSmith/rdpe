package com.bonc.rdpe.service.event;

import java.util.Map;

import com.bonc.rdpe.bo.flow.basic.Rect;
import com.bonc.rdpe.entity.EventOpt;
import com.bonc.rdpe.entity.EventSpark;
import com.bonc.rdpe.exception.RdpeException;

public interface CodeService {
	public void genCode(EventSpark ent,Rect rect,EventOpt opt,Map<String,String> map) throws RdpeException;
}
