package com.bonc.rdpe.entity;

import java.util.Date;

import lombok.Data;

@Data
public class DsRedis {
	
	private String id;

	private String dsName;

	private String hostIp;

	private String hostPort;

	private String pwd;

	private String pk;

	private String resultsetType;

	private String createId;

	private Date createTime;

	private String orgId;
}