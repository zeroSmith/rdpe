package com.bonc.rdpe.entity.def;

import lombok.Data;

@Data
public class OptField {
	//字段父节点
	private String parentId;
	//字段唯一标识
	private String fieldId;
	//中文名称
	private String cnName;
	//英文名称
	private String enName;
	//字段类型
	private String type;
	//长度
	private String len;
	//下标位置 从0开始
	private String index;
	//英文名和中文名
	private String enNameAndCnName;
	
}
