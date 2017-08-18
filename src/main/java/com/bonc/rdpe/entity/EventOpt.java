package com.bonc.rdpe.entity;

import java.util.Date;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class EventOpt extends EventOptKey {

	private String optType;

	private String optDefMd5;

	private String createId;

	private Date createTime;

	private String optDef;
	
	private String processType;//stream、rdd、set
	
}