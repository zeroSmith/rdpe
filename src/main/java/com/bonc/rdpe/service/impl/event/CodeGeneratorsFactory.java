package com.bonc.rdpe.service.impl.event;

import java.util.HashMap;
import java.util.Map;

import com.bonc.rdpe.exception.RdpeException;
import com.bonc.rdpe.service.event.CodeService;
import com.bonc.rdpe.util.SpringContextUtil;

public class CodeGeneratorsFactory {

	//提取
	public static final String TYPE_DS = "ds";
	//解析
	public static final String TYPE_PARSE = "parse";
	//过滤
	public static final String TYPE_FILTER = "filter";
	//存储
	public static final String TYPE_STORE = "store";
	//转换
	public static final String TYPE_TRANS = "trans";
	//关联
	public static final String TYPE_JOIN = "join";
	//main
	public static final String TYPE_MAIN = "main";
	//func
	public static final String TYPE_FUN = "fun";
	//聚合
	public static final String TYPE_AGGREGATE = "aggregate";
	
	
	private CodeGeneratorsFactory(){
		
	}

	private static Map<String, String> map = new HashMap<>();

	static {
		map.put(TYPE_DS, "sparkDsCodeService");
		map.put(TYPE_PARSE, "sparkParseCodeService");
		map.put(TYPE_FILTER, "sparkFilterCodeService");
		map.put(TYPE_STORE, "sparkStoreCodeService");
		map.put(TYPE_TRANS, "sparkTransCodeService");
		map.put(TYPE_JOIN, "sparkJoinCodeService");
		map.put(TYPE_MAIN, "sparkMainCodeService");
		map.put(TYPE_FUN, "sparkFunCodeService");
		map.put(TYPE_AGGREGATE, "sparkAggregateCodeService");
	}

	public static CodeService getGenerators(String type) throws RdpeException {
		String beanName = map.get(type);
		CodeService codeService = (CodeService) SpringContextUtil.getBean(beanName);
		return codeService;
	}
}
