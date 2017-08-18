package com.bonc.rdpe.entity;

import java.util.Date;

import lombok.Data;

@Data
public class DsKafka {
	private String id;

	private String dsName;

	private String topicName;

	private String zkList;

	private String brokerList;

	private String groupId;

	private String createId;

	private Date createTime;

	private String orgId;
}