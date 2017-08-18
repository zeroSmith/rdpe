package com.bonc.rdpe.service.impl.event;

import java.io.File;
import java.io.FileWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.bonc.rdpe.bo.flow.basic.Rect;
import com.bonc.rdpe.comm.util.FreeMarkerUtil;
import com.bonc.rdpe.constant.EventOptType;
import com.bonc.rdpe.entity.EventOpt;
import com.bonc.rdpe.entity.EventSpark;
import com.bonc.rdpe.entity.def.OptField;
import com.bonc.rdpe.entity.def.ParseOpt;
import com.bonc.rdpe.exception.RdpeException;
import com.bonc.rdpe.service.event.CodeService;
import com.bonc.rdpe.util.JsonUtils;
import com.bonc.rdpe.util.StringUtil;

import freemarker.template.Configuration;
import freemarker.template.Template;
import lombok.extern.log4j.Log4j;


@Log4j
@Service("sparkParseCodeService")
public class SparkParseCodeServiceImpl implements CodeService {

	@Override
	public void genCode(EventSpark ent, Rect rect,EventOpt opt,Map<String,String> map) throws RdpeException{
		try {
			String processType = opt.getProcessType();
			String templateName = "";
			
			if(EventOptType.OPT_PROCESS_TYPE_STREAM.equals(processType)){
				templateName = "ParseStream.scala.ftl";
			}
			if(EventOptType.OPT_PROCESS_TYPE_RDD.equals(processType)){
				templateName = "ParseRdd.scala.ftl";
			}
			if(EventOptType.OPT_PROCESS_TYPE_SET.equals(processType)){
				templateName = "ParseSet.scala.ftl";
			}
			
			String[] nameArr = templateName.split("\\.");
			// 输出文件名称 格式为: 模板名称[0]+rect的id.scala
			StringBuilder outPutFileName = new StringBuilder("").append(StringUtil.captureStr(rect.getId())).append(".").append(nameArr[1]);
			StringBuilder objectName = new StringBuilder(StringUtil.captureStr(rect.getId()));
			
			
			Map<String, String> modelMap = new HashMap<>();
			
			modelMap.put("objectName", objectName.toString());
			String optDef = opt.getOptDef();
			ParseOpt parseOpt = JsonUtils.toBean(optDef, ParseOpt.class);
			List<OptField> fields = parseOpt.getFieldDef();
			StringBuilder buff = new StringBuilder("");
			for(OptField optField:fields){
				if(fields.indexOf(optField)==fields.size()-1){
					buff.append(optField.getIndex());
				}else{
					buff.append(optField.getIndex()).append(",");
				}
			}
			modelMap.put("separator", parseOpt.getFirstSeparator());
			modelMap.put("indexs", buff.toString());
			
			
			Configuration cfg = FreeMarkerUtil.genConfiguration();
			Template template = cfg.getTemplate(templateName);
			Writer writer = new FileWriter(new File(map.get("outPutPath"), outPutFileName.toString()));
			template.process(modelMap, writer);
			writer.close();
		}catch(Exception e){
			log.error(e.getMessage(), e);
			throw new RdpeException("解析代码生产服务异常 rectId="+rect.getId(), e);
		}
	}
}