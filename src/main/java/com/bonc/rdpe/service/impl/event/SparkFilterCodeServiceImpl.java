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

import org.springframework.stereotype.Service;

import com.bonc.rdpe.bo.flow.basic.Rect;
import com.bonc.rdpe.comm.util.FreeMarkerUtil;
import com.bonc.rdpe.entity.EventOpt;
import com.bonc.rdpe.entity.EventSpark;
import com.bonc.rdpe.entity.def.FilterOpt;
import com.bonc.rdpe.entity.def.OptField;
import com.bonc.rdpe.exception.RdpeException;
import com.bonc.rdpe.service.event.CodeService;
import com.bonc.rdpe.util.JsonUtils;
import com.bonc.rdpe.util.StringUtil;

import freemarker.template.Configuration;
import freemarker.template.Template;
import lombok.extern.log4j.Log4j;

@Log4j
@Service("sparkFilterCodeService")
public class SparkFilterCodeServiceImpl implements CodeService {

	@Override
	public void genCode(EventSpark ent, Rect rect, EventOpt opt, Map<String, String> map) throws RdpeException {
		try {
			String optDef = opt.getOptDef();
			FilterOpt filterOpt = JsonUtils.toBean(optDef, FilterOpt.class);
			String ruleExp = filterOpt.getRuleExp();
			String templateName = "";
			List<String> list = new ArrayList<String>();
			Pattern pattern = Pattern.compile("(\\[[^\\]]*\\])");
			Matcher matcher = pattern.matcher(ruleExp);
			while (matcher.find()) {
				String matchedStr = matcher.group().substring(1, matcher.group().length() - 1);
				list.add(matchedStr);
			}

			List<OptField> inputFieldDef = filterOpt.getInputFieldDef();

			for (String s : list) {
				for (OptField optField : inputFieldDef) {
					if (s.equals(optField.getEnName())) {
						String exp = "line(" + optField.getIndex() + ")";
						String type = optField.getType();
						String method = getTransMethod(type);
						ruleExp = ruleExp.replaceAll(s, "string".equals(type) ? exp : method + exp + ")");
					}
				}
			}

			ruleExp = ruleExp.replaceAll("\\[", "");
			ruleExp = ruleExp.replaceAll("\\]", "");
			ruleExp = ruleExp.replaceAll("\\\\", "");
			ruleExp = ruleExp.substring(1, ruleExp.length() - 1);
			Map<String, String> modelMap = new HashMap<>();
			modelMap.put("filter", ruleExp);
			if (opt.getProcessType().equals("rdd")) {
				templateName = "FilterRdd.scala.ftl";//不同的模板
			} else if (opt.getProcessType().equals("set")) {
				templateName = "FilterSet.scala.ftl";
			} else {
				templateName = "FilterStream.scala.ftl";
			}
			// 输出文件名称 格式为: 模板名称[0]+rect的id.scala
			StringBuilder fileName = new StringBuilder(StringUtil.captureStr(rect.getId())).append(".scala");
			StringBuilder objectName = new StringBuilder(StringUtil.captureStr(rect.getId()));
			modelMap.put("objectName", objectName.toString());

			Configuration cfg = FreeMarkerUtil.genConfiguration();
			Template template = cfg.getTemplate(templateName);

			Writer writer = new FileWriter(new File(map.get("outPutPath"), fileName.toString()));
			template.process(modelMap, writer);
			writer.close();
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw new RdpeException("过滤代码生产服务异常 rectId=" + rect.getId(), e);
		}
	}

	private String getTransMethod(String type) {
		switch (type) {
		case "int":
			return "java.lang.Integer.parseInt(";
		case "long":
			return "java.lang.Long.parseLong(";
		case "float":
			return "java.lang.Float.parseFloat(";
		case "double":
			return "java.lang.Double.parseDouble(";
		default:
			return "";
		}
	}
}