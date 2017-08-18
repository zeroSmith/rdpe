package com.bonc.rdpe.entity;

import java.util.Date;

import lombok.Data;

@Data
public class DsHdfs {
	
	private String id;

	private String dsName;

	private String path;

	private String createId;

	private Date createTime;

	private String orgId;
}