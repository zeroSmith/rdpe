package com.bonc.rdpe.entity;

import java.util.Date;

import lombok.Data;

@Data
public class HostSpark {
	
	private String id;

	private String hostIp;

	private String hostName;

	private String hostType;

	private String hostUsername;

	private String hostPassword;

	private String sparkVersion;

	private String installPath;

	private String sshPort;
	
	private String createrId;

    private Date createTime;

    private String orgId;

}