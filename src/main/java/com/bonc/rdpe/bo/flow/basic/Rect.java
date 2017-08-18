package com.bonc.rdpe.bo.flow.basic;

import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.annotation.JSONField;

import lombok.Data;

@Data
public class Rect {
	
	private String id;
	
	private String type;

	private Map<String,Object> text;
	
	private Map<String,Object> attr;
	
	private Map<String,Object> props;
	
	@JSONField(serialize = false)
	private int ord;
	
	@JSONField(serialize = false)
	private transient List<Rect> parentNodes;
	
	@JSONField(serialize = false)
	private transient List<Rect> childNodes;
	
}
