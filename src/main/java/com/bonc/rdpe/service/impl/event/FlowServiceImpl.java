package com.bonc.rdpe.service.impl.event;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.bonc.rdpe.bo.flow.basic.Flow;
import com.bonc.rdpe.bo.flow.basic.Path;
import com.bonc.rdpe.bo.flow.basic.Rect;
import com.bonc.rdpe.service.event.FlowService;
import com.bonc.rdpe.util.JsonUtils;

/**
 * 
 * @author bianshen
 *
 */
@Service("flowService")
public class FlowServiceImpl implements FlowService {

	@Override
	public Flow parseJson2Flow(String flowJson) {
		if (flowJson == null || flowJson.isEmpty()) {
			return null;
		}

		Flow flow = JsonUtils.toBean(flowJson, Flow.class);
		if (flow != null) {
			// 获取states集合
			Map<String, Rect> states = flow.getStates();
			// 获取paths集合
			Map<String, Path> paths = flow.getPaths();
			// 遍历paths 给属性赋值
			genNewFlow(states, paths);
			return flow;
		} else {
			return null;
		}

	}

	/**
	 * 为flow 里面的rect 设置父节点 子节点 和节点id
	 * 
	 * @param states
	 * @param paths
	 * @param flow
	 * @return
	 */
	private void genNewFlow(Map<String, Rect> states, Map<String, Path> paths) {
		for (Map.Entry<String, Rect> rectMap : states.entrySet()) {
			Rect rect = rectMap.getValue();
			rect.setId(rectMap.getKey());
			List<Rect> parentNodes = rect.getParentNodes() == null ? new ArrayList<Rect>() : rect.getParentNodes();
			List<Rect> childNodes = rect.getChildNodes() == null ? new ArrayList<Rect>() : rect.getChildNodes();

			for (Map.Entry<String, Path> pathMap : paths.entrySet()) {
				Path path = pathMap.getValue();
				path.setId(pathMap.getKey());
				String fromRectId = path.getFrom();// 源节点ID
				String toRectId = path.getTo();// 目标节点ID
				if (rect.getId().equals(fromRectId)) {
					childNodes.add(states.get(toRectId));
				}
				if (rect.getId().equals(toRectId)) {
					parentNodes.add(states.get(fromRectId));
				}
			}

			rect.setChildNodes(childNodes);
			rect.setParentNodes(parentNodes);
		}
	}

	@Override
	public List<Rect> getRectByType(Flow flow, String type) {
		List<Rect> rectList  = new ArrayList<>();
		Map<String, Rect> states = flow.getStates();
		for (Map.Entry<String, Rect> rectMap : states.entrySet()) {
			Rect rect = rectMap.getValue();
			if(rect.getType().equals(type)){
				rectList.add(rect);
			}
		}
		return rectList;
	}
}
