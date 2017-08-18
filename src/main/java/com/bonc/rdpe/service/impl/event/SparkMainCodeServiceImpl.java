package com.bonc.rdpe.service.impl.event;

import java.io.File;
import java.io.FileWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bonc.rdpe.bo.flow.basic.Rect;
import com.bonc.rdpe.comm.util.FreeMarkerUtil;
import com.bonc.rdpe.constant.FlowNodeType;
import com.bonc.rdpe.entity.EventOpt;
import com.bonc.rdpe.entity.EventOptKey;
import com.bonc.rdpe.entity.EventSpark;
import com.bonc.rdpe.exception.RdpeException;
import com.bonc.rdpe.service.event.CodeService;
import com.bonc.rdpe.service.event.EventOptService;
import com.bonc.rdpe.service.event.EventSparkService;
import com.bonc.rdpe.service.event.FlowService;
import com.bonc.rdpe.util.StringUtil;

import freemarker.template.Configuration;
import freemarker.template.Template;
import lombok.extern.log4j.Log4j;

@Log4j
@Service("sparkMainCodeService")
public class SparkMainCodeServiceImpl implements CodeService {

	@Resource
	private FlowService flowService;

	@Resource
	private EventSparkService eventSparkService;

	@Resource
	private EventOptService eventOptService;

	@Override
	public void genCode(EventSpark ent, Rect rect, EventOpt opt, Map<String, String> map) throws RdpeException {
		try {
			StringBuilder str = new StringBuilder(); // join节点个数
			Rect begin = getDsStream(rect, ent.getId());//如果存在没有stream的情况。
			if(begin==null){
				begin=getDs(rect);
			}
			getChild(begin, map, begin.getId(), str, ent.getId());
			String templateName = "main.scala.ftl";
			Map<String, String> modelMap = new HashMap<>();
			String outPutFileName = new String("main.scala");
			modelMap.put("main", str.toString());
			Configuration cfg = FreeMarkerUtil.genConfiguration();
			Template template = cfg.getTemplate(templateName);
			String outPutPath = map.get("outPutPath");
			Writer writer = new FileWriter(new File(outPutPath, outPutFileName));
			template.process(modelMap, writer);
			writer.close();
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw new RdpeException("main方法生成服务异常");
		}
	}

	private Rect getChild(Rect stream, Map<String, String> map, String name, StringBuilder str, String entid) throws RdpeException {
		Rect crect = null;
		if (stream.getChildNodes().size() > 0) {
			crect = stream.getChildNodes().get(0); // 获得子节点
		}
		String newName = stream.getId();
		if (stream.getType().equals(FlowNodeType.DS)) {
			str.append("val " + newName + "= " + StringUtil.captureStr(newName) + ".exec(ssc)");
			str.append("\n");
		} else if (stream.getType().equals(FlowNodeType.STORE)) {
			str.append(StringUtil.captureStr(newName) + ".exec(" + name + ",ssc)");
			str.append("\n");
		} else if (stream.getType().equals(FlowNodeType.JOIN)) {
			String joinRule = getNameFromJoin(stream, map, name, str);// 规则库的名字
			str.append("val " + newName + "=" + StringUtil.captureStr(newName) + ".exec(" + name + "," + joinRule + ",ssc)");
			str.append("\n");
		} else if (stream.getType().equals(FlowNodeType.END)) {
			return stream;////
		} else {
			str.append("val " + newName + "=" + StringUtil.captureStr(newName) + ".exec(" + name + ")");
			str.append("\n");
		}
		return getChild(crect, map, newName, str, entid);

	}

	private String getNameFromJoin(Rect Jrect, Map<String, String> map, String name, StringBuilder str) throws RdpeException {
		Rect otherParent = null;
		List<Rect> nodes = Jrect.getParentNodes();// 两个父类节点
		for (int i = 0; i < nodes.size(); i++) {
			if (!(nodes.get(i).getId().equals(name))) {
				otherParent = nodes.get(i);// 找到另外的一个父节点。
			}
		}
		if (otherParent == null) {
			throw new RdpeException("join父节点为空");
		}
		Rect origin = getOrigin(otherParent);
		String child1 = getAnotherChild(origin, map, name, str);
		return child1;
	}

	/**
	 * 
	 * @param crect
	 * @param map
	 * @param name
	 * @param sb
	 * @return 返回最后一个变量的名字
	 */
	private String getAnotherChild(Rect crect, Map<String, String> map, String name, StringBuilder str) {// join的另外一个节点的拼接

		Rect rect = crect.getChildNodes().get(0);
		String newName = crect.getId();
		if (crect.getType().equals(FlowNodeType.DS)) {
			str.append("val " + newName + "= " + StringUtil.captureStr(newName) + ".exec(ssc)");
			str.append("\n");
		} else if (!crect.getType().equals(FlowNodeType.JOIN)) {
			str.append("val " + newName + "=" + StringUtil.captureStr(newName) + ".exec(" + name + ")");
			str.append("\n");
		}
		if (crect.getType().equals(FlowNodeType.JOIN)) {
			return name;
		} else {
			return getAnotherChild(rect, map, newName, str);
		}
	}

	private EventOpt getOpt(String eventid, String rectid) {
		EventOptKey optKey = new EventOptKey();
		optKey.setEventId(eventid);
		optKey.setOptId(rectid);

		return eventOptService.getOne(optKey);
	}

	/**
	 * 得到stream的那条线
	 * 
	 * @param rect
	 * @param entid
	 * @return
	 */
	private Rect getDsStream(Rect rect, String entid) {
		for (int j = 0; j < rect.getChildNodes().size(); j++) {
			Rect rect2 = rect.getChildNodes().get(j);
			EventOpt opt = getOpt(entid, rect2.getId());
			if (opt.getProcessType().equals("stream")) {
				return rect2;
			}
			;
		}
		return null;
	}

	/**
	 * 返回origin的rect
	 * 
	 * @param rect
	 * @return
	 */
	private Rect getOrigin(Rect rect) {
		if (rect.getType().equals("ds")) {
			return rect;
		} else {
			return getOrigin(rect.getParentNodes().get(0));
		}
	}
	
	private Rect getDs(Rect rect){//如果不存在stream的情况
		return rect.getChildNodes().get(0);
	}
}
