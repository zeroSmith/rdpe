package com.bonc.rdpe.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class EventSparkVO extends EventSpark {
	
	private String  hostIp;

}
