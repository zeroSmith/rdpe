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
import com.bonc.rdpe.dao.DaoHelper;
import com.bonc.rdpe.entity.DsHdfs;
import com.bonc.rdpe.entity.DsKafka;
import com.bonc.rdpe.entity.EventOpt;
import com.bonc.rdpe.entity.EventOptKey;
import com.bonc.rdpe.entity.EventSpark;
import com.bonc.rdpe.entity.def.OptField;
import com.bonc.rdpe.entity.def.StoreOpt;
import com.bonc.rdpe.exception.RdpeException;
import com.bonc.rdpe.service.event.CodeService;
import com.bonc.rdpe.service.event.EventOptService;
import com.bonc.rdpe.util.JsonUtils;
import com.bonc.rdpe.util.StringUtil;

import freemarker.template.Configuration;
import freemarker.template.Template;
import lombok.extern.log4j.Log4j;

@Log4j
@Service("sparkStoreCodeService")
public class SparkStoreCodeServiceImpl implements CodeService {

	@Resource
	private DaoHelper daoHelper;
	@Resource
	private EventOptService eventOptService;

	/**
	 * 存储代码生成
	 * 
	 * @throws RdpeException
	 */
	@Override
	public void genCode(EventSpark ent, Rect rect, EventOpt opt, Map<String, String> map) throws RdpeException {
		try {
			StoreOpt storeOpt = (StoreOpt) JsonUtils.toBean(opt.getOptDef(), StoreOpt.class);
			String dsType = storeOpt.getStoreType(); // "separator" json xml
			String dsId = storeOpt.getStoreName();
			String separator = storeOpt.getStoreFormat();

			String templateName = "";
			String brokers = "";
			String topic = "";
			String path = "";
			List<Rect> rects = rect.getParentNodes();
			Rect rectt = rects.get(0);// 存放数据为一个父节点。
			EventOptKey optkey = new EventOptKey();
			optkey.setEventId(ent.getId());
			optkey.setOptId(rectt.getId());

			// 数据落地类型：kafka，hdfs
			if ("kafka".equals(dsType)) { // 落地到kafaka
				DsKafka dsKafka = (DsKafka) daoHelper.queryOne("com.bonc.rdpe.entity.DsKafka.selectByPrimaryKey", dsId);
				brokers = dsKafka.getBrokerList();
				topic = dsKafka.getTopicName();
				templateName = "StoreKafka.scala.ftl";
			}
			if ("hdfs".equals(dsType)) {
				DsHdfs dsHdfs = (DsHdfs) daoHelper.queryOne("com.bonc.rdpe.entity.DsHdfs.selectByPrimaryKey", dsId);
				path = dsHdfs.getPath();
				templateName = "StoreHdfs.scala.ftl";
			}
			// 存放数据：

			String[] nameArr = templateName.split("\\.");
			StringBuffer fileName = new StringBuffer("").append(StringUtil.captureStr(rect.getId())).append(".").append(nameArr[1]);
			StringBuilder objectName = new StringBuilder(StringUtil.captureStr(rect.getId()));
			
			Map<String, String> modelMap = new HashMap<>();
			if ("kafka".equals(dsType)) {
				modelMap.put("objectName", objectName.toString());
				modelMap.put("brokers", brokers.toString());
				modelMap.put("topic", topic.toString());
				List<OptField> optFields = storeOpt.getStoreFieldDef();
				StringBuilder data = new StringBuilder();
				for (OptField optField : optFields) {
					if (optFields.indexOf(optField) == optFields.size() - 1) {
						data.append("x(").append(optField.getIndex()).append(")");
					} else {
						data.append("x(").append(optField.getIndex()).append(")").append("+\"" + separator + "\"+");
					}
				}

				if (!("json".equals(dsType) || "xml".equals(dsType))) {
					modelMap.put("data", data.toString());
				}
			}
			if ("hdfs".equals(dsType)) {
				modelMap.put("path", path);
			}
			Configuration cfg = FreeMarkerUtil.genConfiguration();
			Template template = cfg.getTemplate(templateName);
			Writer writer = new FileWriter(new File(map.get("outPutPath"), fileName.toString()));
			template.process(modelMap, writer);
			writer.close();
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw new RdpeException("存储代码生产服务异常 rectId=" + rect.getId(), e);
		}
	}

}