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
import com.bonc.rdpe.entity.def.JoinOpt;
import com.bonc.rdpe.entity.def.OptField;
import com.bonc.rdpe.exception.RdpeException;
import com.bonc.rdpe.service.event.CodeService;
import com.bonc.rdpe.util.JsonUtils;
import com.bonc.rdpe.util.StringUtil;

import freemarker.template.Configuration;
import freemarker.template.Template;
import lombok.extern.log4j.Log4j;

@Log4j
@Service("sparkJoinCodeService")
public class SparkJoinCodeServiceImpl implements CodeService {

	@Resource
	private DaoHelper daoHelper;

	@Override
	public void genCode(EventSpark ent, Rect rect, EventOpt opt, Map<String, String> map) throws RdpeException {
		try {
			JoinOpt joinOpt = JsonUtils.toBean(opt.getOptDef(), JoinOpt.class);
			Map<String, String> modelMap = new HashMap<>();
			String isbroadcast = joinOpt.getIsBroadcast();
			modelMap.put("isBroadCast", isbroadcast);
			List<OptField> streamList = joinOpt.getStreamFieldDef();
			List<OptField> ruleList = joinOpt.getRuleFieldDef();
			String joinRule = joinOpt.getJoinRule();
			Pattern pattern = Pattern.compile("(\\[[^\\]]*\\])");
			Matcher matcher = pattern.matcher(joinRule);
			List<String> list = new ArrayList<String>();
			while (matcher.find()) {
				String matchedStr = matcher.group().substring(1, matcher.group().length() - 1);
				list.add(matchedStr);
			}
			String streamKeyName = list.get(0);
			String dskey = "";
			for (OptField optField : streamList) {
				if (optField.getEnName().equals(streamKeyName)) {
					dskey = "x(" + optField.getIndex() + ")";
				}
			}
			modelMap.put("dskey", dskey);

			String ruleKeyName = list.get(1);
			String rulekey = "";
			for (OptField optField : ruleList) {
				if (optField.getEnName().equals(ruleKeyName)) {
					rulekey = "x(" + optField.getIndex() + ")";
				}
			}
			modelMap.put("rulekey", rulekey);

			String templateName = this.getTemplateName(ent.getId(), rect);
			StringBuilder fileName = new StringBuilder(StringUtil.captureStr(rect.getId())).append(".scala");
			StringBuilder objectName = new StringBuilder(StringUtil.captureStr(rect.getId()));
			
			modelMap.put("objectName", objectName.toString());
			Configuration cfg = FreeMarkerUtil.genConfiguration();
			Template template = cfg.getTemplate(templateName);
			Writer writer = new FileWriter(new File(map.get("outPutPath"), fileName.toString()));
			template.process(modelMap, writer);
			writer.close();
		}catch(Exception e){
			log.error(e.getMessage(), e);
			throw new RdpeException("关联代码生产服务异常 rectId="+rect.getId(), e);
		}
	}

	private String getTemplateName(String entId, Rect rect) {
		List<Rect> rectList = rect.getParentNodes();
		String templateName = "";
		boolean flag = false;
		for (Rect r : rectList) {
			if (flag) {
				break;
			}
			EventOptKey key = new EventOptKey();
			key.setEventId(entId);
			key.setOptId(r.getId());
			EventOpt opt = (EventOpt) daoHelper.queryOne("com.bonc.rdpe.entity.EventOpt.selectByPrimaryKey", key);
			switch (opt.getProcessType()) {
			case EventOptType.OPT_PROCESS_TYPE_RDD:
				templateName = "JoinRdd.scala.ftl";
				flag = true;
				break;
			case EventOptType.OPT_PROCESS_TYPE_SET:
				templateName = "JoinSet.scala.ftl";
				flag = true;
				break;
			}
		}
		return templateName;
	}
}
