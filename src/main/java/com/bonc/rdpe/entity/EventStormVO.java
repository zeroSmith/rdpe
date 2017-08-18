package com.bonc.rdpe.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class EventStormVO extends EventStorm {
	
	private String  hostIp;

}
