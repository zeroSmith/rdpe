package com.bonc.rdpe.bo.flow.basic;

import java.util.Map;

import com.alibaba.fastjson.annotation.JSONField;

import lombok.Data;

@Data
public class Props {

	private String id;
	
	private String pkgId;
	
	@JSONField(name="props")  
	private Map<String,Object> propsMap;
	
}