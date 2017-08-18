package com.bonc.rdpe.bo.flow.basic;

import java.util.List;
import java.util.Map;

import lombok.Data;

@Data
public class Path {
	
	private String id;

	private String from;
	
	private String to;
	
	private List<Object> dots;
	
	private Map<String,Object> text;
	
	private Map<String,Object> props;
	
}
