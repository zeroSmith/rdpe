package com.bonc.rdpe.entity.def;

import lombok.Data;

@Data
public class DsOpt {

	//处理方式
	private String asType;
	//数据源类型
	private String dsType;
	//数据源ID
	private String dsName;
	//数据源格式
	private String dsFormat;
}
