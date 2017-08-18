package com.bonc.rdpe.entity.def;

import java.util.List;

import lombok.Data;

@Data
public class FilterOpt {

	//输入字段定义
	private List<OptField> inputFieldDef;
	//输出字段定义
	private List<OptField> outPutFieldDef;
	//过滤规则表达式
	private String ruleExp;
	
}
