package com.bonc.rdpe.constant;

public class FlowNodeType {
	
	private FlowNodeType(){}

	// 开始
	public static final String START = "start";
	// 结束
	public static final String END = "end";
	// 提取
	public static final String DS = "ds";
	// 解析
	public static final String PARSE = "parse";
	// 过滤
	public static final String FILTER = "filter";
	// 转换
	public static final String TRANS = "trans";
	// 关联
	public static final String JOIN = "join";
	// 函数
	public static final String FUN = "fun";
	// 聚合
	public static final String AGGREGATE = "aggregate";
	// 存储
	public static final String STORE = "store";
}
