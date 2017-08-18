package com.bonc.rdpe.service.impl.event;

import java.io.File;
import java.io.FileWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bonc.rdpe.bo.flow.basic.Rect;
import com.bonc.rdpe.comm.util.FreeMarkerUtil;
import com.bonc.rdpe.constant.DataSourceType;
import com.bonc.rdpe.dao.DaoHelper;
import com.bonc.rdpe.entity.DsHdfs;
import com.bonc.rdpe.entity.DsKafka;
import com.bonc.rdpe.entity.DsRedis;
import com.bonc.rdpe.entity.EventOpt;
import com.bonc.rdpe.entity.EventSpark;
import com.bonc.rdpe.entity.def.DsOpt;
import com.bonc.rdpe.exception.RdpeException;
import com.bonc.rdpe.service.event.CodeService;
import com.bonc.rdpe.util.JsonUtils;
import com.bonc.rdpe.util.StringUtil;

import freemarker.template.Configuration;
import freemarker.template.Template;
import lombok.extern.log4j.Log4j;

@Log4j
@Service("sparkDsCodeService")
public class SparkDsCodeServiceImpl implements CodeService {

	@Resource
	private DaoHelper daoHelper;

	/**
	 * 提取代码生成
	 * 
	 * @throws RdpeException
	 */
	@Override
	public void genCode(EventSpark ent, Rect rect, EventOpt opt, Map<String, String> map) throws RdpeException {
		try {
			Configuration cfg = FreeMarkerUtil.genConfiguration();
			String optDef = opt.getOptDef();
			DsOpt dsOpt = JsonUtils.toBean(optDef, DsOpt.class);

			String astype = dsOpt.getAsType();
			String dstype = dsOpt.getDsType();
			String dsid = dsOpt.getDsName();

			String outPutPath = map.get("outPutPath");
			// 实时流KAFKA
			if (DataSourceType.DS_ASTYPE_STREAM.equals(dsOpt.getAsType()) && DataSourceType.DS_TYPE_KAFKA.equals(dstype)) {
				String templateName = "DsStreamKafka.scala.ftl";
				StringBuilder fileName = new StringBuilder(StringUtil.captureStr(rect.getId())).append(".scala");
				StringBuilder objectName = new StringBuilder(StringUtil.captureStr(rect.getId()));
				Writer writer = new FileWriter(new File(outPutPath, fileName.toString()));
				Template template = cfg.getTemplate(templateName);
				DsKafka kafkads = (DsKafka) daoHelper.queryOne("com.bonc.rdpe.entity.DsKafka.selectByPrimaryKey", dsid);
				Map<String, String> modelMap = new HashMap<>();
				modelMap.put("brokerList", kafkads.getBrokerList());
				modelMap.put("groupId", kafkads.getGroupId());
				modelMap.put("topicName", kafkads.getTopicName());
				modelMap.put("objectName", objectName.toString());
				template.process(modelMap, writer);
				writer.close();
			}
			// 实时流HDFS
			if (DataSourceType.DS_ASTYPE_STREAM.equals(astype) && DataSourceType.DS_TYPE_HDFS.equals(dstype)) {
				String templateName = "DsStreamHdfs.scala.ftl";
				// 输出文件名称 格式为: rect的id.scala
				StringBuilder fileName = new StringBuilder(StringUtil.captureStr(rect.getId())).append(".scala");
				StringBuilder objectName = new StringBuilder(StringUtil.captureStr(rect.getId()));
				Writer writer = new FileWriter(new File(outPutPath, fileName.toString()));
				Template template = cfg.getTemplate(templateName);
				DsHdfs hdfsds = (DsHdfs) daoHelper.queryOne("com.bonc.rdpe.entity.DsHdfs.selectByPrimaryKey", dsid);
				Map<String, String> modelMap = new HashMap<>();
				modelMap.put("objectName", objectName.toString());
				modelMap.put("path", hdfsds.getPath());
				template.process(modelMap, writer);
				writer.close();
			}
			// 规则库 HDFS
			if (DataSourceType.DS_ASTYPE_RULE.equals(astype) && DataSourceType.DS_TYPE_HDFS.equals(dstype)) {
				String templateName = "DsRuleHdfs.scala.ftl";
				// 输出文件名称 格式为: rect的id.scala
				StringBuilder fileName = new StringBuilder(StringUtil.captureStr(rect.getId())).append(".scala");
				StringBuilder objectName = new StringBuilder(StringUtil.captureStr(rect.getId()));
				Writer writer = new FileWriter(new File(outPutPath, fileName.toString()));
				Template template = cfg.getTemplate(templateName);
				DsHdfs hdfsds = (DsHdfs) daoHelper.queryOne("com.bonc.rdpe.entity.DsHdfs.selectByPrimaryKey", dsid);
				Map<String, String> modelMap = new HashMap<>();
				modelMap.put("objectName", objectName.toString());
				modelMap.put("path", hdfsds.getPath());
				template.process(modelMap, writer);
				writer.close();
			}
			// 规则库redis
			if (DataSourceType.DS_ASTYPE_RULE.equals(astype) && DataSourceType.DS_TYPE_REDIS.equals(dstype)) {
				String templateName = "DsRuleRedis.scala.ftl";
				// 输出文件名称 格式为: rect的id.scala
				StringBuilder fileName = new StringBuilder(StringUtil.captureStr(rect.getId())).append(".scala");
				StringBuilder objectName = new StringBuilder(StringUtil.captureStr(rect.getId()));
				Writer writer = new FileWriter(new File(outPutPath, fileName.toString()));
				Template template = cfg.getTemplate(templateName);
				DsRedis dsRedis = (DsRedis) daoHelper.queryOne("com.bonc.rdpe.entity.DsRedis.selectByPrimaryKey", dsid);
				Map<String, String> modelMap = new HashMap<>();
				modelMap.put("objectName", objectName.toString());
				modelMap.put("key", dsRedis.getPk());

				modelMap.put("ip", dsRedis.getHostIp());
				modelMap.put("port", dsRedis.getHostPort());
				modelMap.put("password", dsRedis.getPwd());

				template.process(modelMap, writer);
				writer.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new RdpeException("提取代码生产服务异常 rectId=" + rect.getId(), e);
		}
	}
}