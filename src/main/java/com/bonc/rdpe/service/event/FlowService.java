package com.bonc.rdpe.service.event;

import java.util.List;

import com.bonc.rdpe.bo.flow.basic.Flow;
import com.bonc.rdpe.bo.flow.basic.Rect;

/** 
 *
 * @author qxl
 * @date 2016年11月14日 上午10:16:52 
 * @version 1.0.0
 */
public interface FlowService {
	
	/**
	 * 解析json成flow对象
	 * @param json
	 * @return
	 * @throws Exception
	 */
	public Flow parseJson2Flow(String json);
	
	/**
	 * 按照类型获取rect集合
	 * @param flow
	 * @return
	 */
	public List<Rect> getRectByType(Flow flow,String type);
}
