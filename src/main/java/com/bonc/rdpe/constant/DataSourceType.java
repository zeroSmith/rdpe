package com.bonc.rdpe.constant;

/**
 * 数据源类型常量定义
 * @author bianshen
 *
 */
public class DataSourceType {
	
	private DataSourceType(){}
	
	//实时流
	public static final String DS_ASTYPE_STREAM="stream";
	//规则库
	public static final String DS_ASTYPE_RULE="rule";
	//数据源类型  kafka
	public static final String DS_TYPE_KAFKA="kafka";
	//数据源类型  hdfs
	public static final String DS_TYPE_HDFS="hdfs";
	//数据源类型  redis
	public static final String DS_TYPE_REDIS="redis";
	
}
