package com.bonc.rdpe.entity.def;

import java.util.List;

import lombok.Data;

@Data
public class JoinOpt {

	private List<OptField> streamFieldDef;// 实时流字段定义
	
	private List<OptField> ruleFieldDef;// 规则库字段定义
	
	private List<OptField> outPutFieldDef;// 输出字段定义

	private String joinRule;//关联规则
	
	private String isBroadcast;//是否为广播变量;true-是，false-否

}
