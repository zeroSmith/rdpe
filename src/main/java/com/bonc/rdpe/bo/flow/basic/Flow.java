package com.bonc.rdpe.bo.flow.basic;

import java.util.Map;

import lombok.Data;

@Data
public class Flow {

	private Props props;
	
	private Map<String,Rect> states;
	
	private Map<String,Path> paths;

}
