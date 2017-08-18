package com.bonc.rdpe.service.impl.event;

import java.io.File;
import java.io.FileWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bonc.rdpe.bo.flow.basic.Rect;
import com.bonc.rdpe.comm.util.FreeMarkerUtil;
import com.bonc.rdpe.dao.DaoHelper;
import com.bonc.rdpe.entity.EventOpt;
import com.bonc.rdpe.entity.EventSpark;
import com.bonc.rdpe.entity.def.AggregateOpt;
import com.bonc.rdpe.exception.RdpeException;
import com.bonc.rdpe.service.event.CodeService;
import com.bonc.rdpe.util.JsonUtils;
import com.bonc.rdpe.util.StringUtil;

import freemarker.template.Configuration;
import freemarker.template.Template;

@Service("sparkAggregateCodeService")
public class SparkAggregateCodeServiceImpl implements CodeService {

	@Resource
	private DaoHelper daoHelper;

	/**
	 * 聚合代码生成
	 * 
	 * @throws RdpeException
	 */
	@Override
	public void genCode(EventSpark ent, Rect rect, EventOpt opt, Map<String, String> map) throws RdpeException {
		String optDef = opt.getOptDef();
		List<AggregateOpt> list = JsonUtils.toList(optDef, AggregateOpt.class);
		List<AggregateOpt> sumList = new ArrayList<AggregateOpt>();//sum字段
		List<AggregateOpt> countList = new ArrayList<AggregateOpt>();//count字段
		List<AggregateOpt> unAggList = new ArrayList<AggregateOpt>();//非聚合字段
		List<AggregateOpt> aggList = new ArrayList<AggregateOpt>();//聚合字段
		String outPutPath = map.get("outPutPath");
		
		for(AggregateOpt aggOpt: list){
			String rule = aggOpt.getRuleExp();
			if(rule.isEmpty()){
				unAggList.add(aggOpt);
			}else if(rule.startsWith("sum")){
				sumList.add(aggOpt);
				aggList.add(aggOpt);
			}else if(rule.startsWith("count")){
				countList.add(aggOpt);
				aggList.add(aggOpt);
			}
		}
		
		//StringBuilder redisKey = new StringBuilder(ent.getId()).append("_").append(rect.getId());
		StringBuilder redisKey = new StringBuilder("").append("\"").append(ent.getId()).append("_").append(rect.getId()).append("\"");
		StringBuilder redisKeyByReduce = new StringBuilder("").append("\"").append(ent.getId()).append("_").append(rect.getId()).append("\"");
		for(AggregateOpt agg : unAggList){
			String index = agg.getInputFieldDef().get(0).getIndex();
			redisKey.append("+").append("\"");
			redisKey.append("_").append("\"").append("+").append("arr(").append(index).append(")");
		}
		if(!unAggList.isEmpty()){
			redisKeyByReduce.append("+").append("\"").append("_").append("\"").append("+");
			redisKeyByReduce.append("arr(0).split(\"@\").mkString(\"_\")");
		}
		
		StringBuilder sumIndexArr = new StringBuilder();
		StringBuilder sumEnNameArr = new StringBuilder();
		if(sumList.isEmpty()){
			sumIndexArr.append("Array[Int]()");
			sumEnNameArr.append("Array[String]()");
		}else{
			sumIndexArr.append("Array[Int](");
			sumEnNameArr.append("Array[String](");
			for(AggregateOpt aggOpt : sumList){
				String index = aggOpt.getInputFieldDef().get(0).getIndex();
				String enName = aggOpt.getOutPutFieldDef().getEnName();
				if (sumList.indexOf(aggOpt) == sumList.size() - 1) {
					sumIndexArr.append(index);
					sumEnNameArr.append("\"").append(enName).append("\"");
				}else{
					sumIndexArr.append(index).append(",");
					sumEnNameArr.append("\"").append(enName).append("\"").append(",");
				}
			}
			sumIndexArr.append(")");
			sumEnNameArr.append(")");
		}
		
		StringBuilder countIndexArr = new StringBuilder();
		StringBuilder countEnNameArr = new StringBuilder();
		if(countList.isEmpty()){
			countIndexArr.append("Array[Int]()");
			countEnNameArr.append("Array[String]()");
		}else{
			countIndexArr.append("Array[Int](");
			countEnNameArr.append("Array[String](");
			for(AggregateOpt aggOpt : countList){
				String index = aggOpt.getInputFieldDef().get(0).getIndex();
				String enName = aggOpt.getOutPutFieldDef().getEnName();
				if (countList.indexOf(aggOpt) == countList.size() - 1) {
					countIndexArr.append(index);
					countEnNameArr.append("\"").append(enName).append("\"");
				}else{
					countIndexArr.append(index).append(",");
					countEnNameArr.append("\"").append(enName).append("\"").append(",");
				}
			}
			countIndexArr.append(")");
			countEnNameArr.append(")");
		}
		
		
		
		StringBuilder reduceKey = new StringBuilder();
		if(unAggList.isEmpty()){
			reduceKey.append("\"null\"");
		}else{
			for(AggregateOpt aggOpt : unAggList){
				String index = aggOpt.getInputFieldDef().get(0).getIndex();
				if (unAggList.indexOf(aggOpt) == unAggList.size() - 1) {
					reduceKey.append("arr(").append(index).append(")");
				}else{
					reduceKey.append("arr(").append(index).append(")").append("+").append("\"@\"").append("+");
				}
				
			}
		}
		
		
		StringBuilder aggFieldEnName = new StringBuilder();
		if(aggList.isEmpty()){
			aggFieldEnName.append("Array[String]()");
		}else{
			aggFieldEnName.append("Array[String](");
			for(AggregateOpt aggOpt : aggList){
				String enName = aggOpt.getOutPutFieldDef().getEnName();
				if (aggList.indexOf(aggOpt) == aggList.size() - 1) {
					aggFieldEnName.append("\"").append(enName).append("\"");
				}else{
					aggFieldEnName.append("\"").append(enName).append("\"").append(",");
				}
			}
			aggFieldEnName.append(")");
		}
		
		StringBuilder indexs = new StringBuilder("");
		
		for(AggregateOpt aggOpt : unAggList){
			String index = aggOpt.getOutPutFieldDef().getIndex();
			indexs.append(index).append(",");
		}
		
		for(AggregateOpt aggOpt : aggList){
			String index = aggOpt.getOutPutFieldDef().getIndex();
			indexs.append(index).append(",");
		}
		
		//去掉最后的,
		indexs.deleteCharAt(indexs.length()-1);
		
		StringBuilder indexArr = new  StringBuilder("Array[Int](");
		indexArr.append(indexs).append(")");
		
		try {
			Configuration cfg = FreeMarkerUtil.genConfiguration();
			Template template = cfg.getTemplate("aggregation.scala.ftl");
			StringBuilder objectName = new StringBuilder(StringUtil.captureStr(rect.getId()));
			StringBuilder fileName = new StringBuilder(StringUtil.captureStr(rect.getId())).append(".scala");
			Writer writer = new FileWriter(new File(outPutPath, fileName.toString()));
			Map<String,String> modelMap = new HashMap<>();
			modelMap.put("redisKey", redisKey.toString());
			modelMap.put("redisKeyByReduce", redisKeyByReduce.toString());
			modelMap.put("sumIndexArr", sumIndexArr.toString());
			modelMap.put("sumEnNameArr", sumEnNameArr.toString());
			modelMap.put("countIndexArr", countIndexArr.toString());
			modelMap.put("countEnNameArr", countEnNameArr.toString());
			modelMap.put("reduceKey", reduceKey.toString());
			modelMap.put("aggFieldEnName", aggFieldEnName.toString());
			modelMap.put("indexArr", indexArr.toString());
			modelMap.put("objectName", objectName.toString());
			template.process(modelMap, writer);
			writer.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
	}
}