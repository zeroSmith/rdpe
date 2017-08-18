package com.bonc.rdpe.constant;

/**
 * 事件类型常量定义
 * @author bianshen
 *
 */
public class EventType {

	private EventType(){}
	
	//storm 简单事件
	public static final String EVENT_TYPE_STORM_SIMPLE="simple";
	//storm trident事件
	public static final String EVENT_TYPE_STORM_TRIDENT="trident";
	//storm 外部事件
	public static final String EVENT_TYPE_STORM_EXTERNAL="external";
	//spark 自定义事件
	public static final String EVENT_TYPE_SPARK_CUSTOM="custom";
	//spark 外部事件
	public static final String EVENT_TYPE_SPARK_EXTERNAL="external";
	
}
