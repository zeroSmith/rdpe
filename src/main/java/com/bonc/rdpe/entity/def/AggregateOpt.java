package com.bonc.rdpe.entity.def;

import java.util.List;

import lombok.Data;

/**
 * @author wangxiaoxing
 * 
 */
@Data
public class AggregateOpt {
	// 输入字段定义
	private List<OptField> inputFieldDef;
	// 输出字段定义
	private OptField outPutFieldDef;
	// 转换规则表达式
	private String ruleExp;
}
