package com.bonc.rdpe.entity;

import java.util.Date;

import lombok.Data;

@Data
public class HostStorm {
	
	private String id;

	private String hostIp;

	private String hostName;

	private String hostType;

	private String hostUsername;

	private String hostPassword;

	private String stormVersion;

	private String installPath;

	private String sshPort;
	
	private String createrId;

    private Date createTime;

    private String orgId;

}