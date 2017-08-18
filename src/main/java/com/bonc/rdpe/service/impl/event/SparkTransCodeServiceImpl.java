package com.bonc.rdpe.service.impl.event;

import java.io.File;
import java.io.FileWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bonc.rdpe.bo.flow.basic.Rect;
import com.bonc.rdpe.comm.util.FreeMarkerUtil;
import com.bonc.rdpe.constant.EventOptType;
import com.bonc.rdpe.dao.DaoHelper;
import com.bonc.rdpe.entity.EventOpt;
import com.bonc.rdpe.entity.EventOptKey;
import com.bonc.rdpe.entity.EventSpark;
import com.bonc.rdpe.entity.def.OptField;
import com.bonc.rdpe.entity.def.TransOpt;
import com.bonc.rdpe.exception.RdpeException;
import com.bonc.rdpe.service.event.CodeService;
import com.bonc.rdpe.util.JsonUtils;
import com.bonc.rdpe.util.StringUtil;

import freemarker.template.Configuration;
import freemarker.template.Template;
import lombok.extern.log4j.Log4j;

@Log4j
@Service("sparkTransCodeService")
public class SparkTransCodeServiceImpl implements CodeService {

	@Resource
	private DaoHelper daoHelper;

	@Override
	public void genCode(EventSpark ent, Rect rect, EventOpt opt, Map<String, String> map) throws RdpeException {
		try {
			List<TransOpt> transOpts = JsonUtils.toList(opt.getOptDef(), TransOpt.class);
			StringBuilder strBuider = new StringBuilder();
			for (TransOpt transOpt : transOpts) {
				if (transOpts.indexOf(transOpt) == transOpts.size() - 1) {
					strBuider.append(genArryParam(transOpt));
				} else {
					strBuider.append(genArryParam(transOpt)).append(",");
				}
			}
			String templateName = this.getTemplateName(ent.getId(), rect);
			StringBuffer fileName = new StringBuffer(StringUtil.captureStr(rect.getId())).append(".scala");
			StringBuilder objectName = new StringBuilder(StringUtil.captureStr(rect.getId()));
			Map<String, String> modelMap = new HashMap<>();
			modelMap.put("objectName", objectName.toString());
			modelMap.put("arry", strBuider.toString());

			Configuration cfg = FreeMarkerUtil.genConfiguration();
			Template template = cfg.getTemplate(templateName);
			Writer writer = new FileWriter(new File(map.get("outPutPath"), fileName.toString()));
			template.process(modelMap, writer);
			writer.close();
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw new RdpeException("转换代码生产服务异常 rectId="+rect.getId(), e);
		}
	}

	/**
	 * 
	 * @return
	 */
	private String genArryParam(TransOpt transOpt) {
		String ruleExp = transOpt.getRuleExp();
		if (ruleExp.isEmpty()) {
			List<OptField> list = transOpt.getInputFieldDef();
			OptField optField = list.get(0);
			StringBuilder strBuider = new StringBuilder();
			strBuider.append("x(").append(optField.getIndex()).append(")");
			return strBuider.toString();
		} else {
			List<String> list = new ArrayList<String>();
			Pattern pattern = Pattern.compile("(\\[[^\\]]*\\])");
			Matcher matcher = pattern.matcher(ruleExp);
			while (matcher.find()) {
				String matchedStr = matcher.group().substring(1, matcher.group().length() - 1);
				list.add(matchedStr);
			}

			List<OptField> optFields = transOpt.getInputFieldDef();
			Map<String, OptField> map = this.convertList2Map(optFields);
			for (String key : list) {
				OptField optField = map.get(key);
				StringBuilder strBuider = new StringBuilder();
				strBuider.append("x(").append(optField.getIndex()).append(")");
				String regex = "\\[" + key + "\\]";
				ruleExp = ruleExp.replaceAll(regex, strBuider.toString());
			}
			return ruleExp;
		}
	}

	private Map<String, OptField> convertList2Map(List<OptField> list) {
		Map<String, OptField> map = new HashMap<>();
		for (OptField optField : list) {
			map.put(optField.getEnName(), optField);
		}
		return map;
	}

	/**
	 * 判断解析节点输出到stream或者rdd或者set
	 * 
	 * @param rect
	 * @return
	 */
	private String getTemplateName(String entId, Rect rect) {
		List<Rect> rests = rect.getParentNodes();
		String templateName = "";
		for (Rect r : rests) {
			EventOptKey key = new EventOptKey();
			key.setEventId(entId);
			key.setOptId(r.getId());
			EventOpt opt = (EventOpt) daoHelper.queryOne("com.bonc.rdpe.entity.EventOpt.selectByPrimaryKey", key);
			switch (opt.getProcessType()) {
			case EventOptType.OPT_PROCESS_TYPE_STREAM:
				templateName = "TransStream.scala.ftl";
				break;
			case EventOptType.OPT_PROCESS_TYPE_RDD:
				templateName = "TransRdd.scala.ftl";
				break;
			case EventOptType.OPT_PROCESS_TYPE_SET:
				templateName = "TransSet.scala.ftl";
				break;
			case EventOptType.OPT_PROCESS_TYPE_STREAM+"+"+EventOptType.OPT_PROCESS_TYPE_RDD:
				templateName = "TransStream.scala.ftl";
				break;
			case EventOptType.OPT_PROCESS_TYPE_STREAM+"+"+EventOptType.OPT_PROCESS_TYPE_SET:
				templateName = "TransStream.scala.ftl";
				break;
			}
		}
		return templateName;
	}
}
