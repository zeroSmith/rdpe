package com.bonc.rdpe.entity.def;

import java.util.List;

import lombok.Data;

@Data
public class ParseOpt {
	
	/**
	 * 一级分割符
	 */
	private String firstSeparator;
	
	/**
	 * 二级分隔符
	 */
	private String secondSeparator;
	
	/**
	 * 三级分隔符
	 */
	private String thirdSeparator;
	/**
	 * 字段定义
	 */
	private List<OptField> fieldDef;

}
