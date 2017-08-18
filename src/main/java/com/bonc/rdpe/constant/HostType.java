package com.bonc.rdpe.constant;

/**
 * 主机类型产量定义
 * @author bianshen
 *
 */
public class HostType {
	
	private HostType(){
		
	}
	
	//kafka主机
	public static final String HOST_TYPE_KAFKA="kafka";
	//spark主机
	public static final String HOST_TYPE_SPARK="spark";
	//storm主机
	public static final String HOST_TYPE_STORM="storm";
	//hadoop主机
	public static final String HOST_TYPE_HADOOP="hadoop";
	//zookeeper主机
	public static final String HOST_TYPE_ZK="zookeeper";
	//redis主机
	public static final String HOST_TYPE_REDIS="redis";
}
