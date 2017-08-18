/**
 * Project Name		[rdpe]
 * File Name		[com.bonc.rdpe.entity.def.StoreOpt.java]
 * Creation Date	[2017年6月9日]
 * <p>
 * Copyright© 2017 www.bonc.com.cn All Rights Reserved
 * <p>
 */
package com.bonc.rdpe.entity.def;

import java.util.List;

import lombok.Data;

/**
 * @author wangxiaoxing
 * 
 * @date 2017年6月9日 下午2:30:19
 */
@Data
public class StoreOpt {
	// 数据源类型
	private String storeType;
	
	// 数据源ID
	private String storeName;

	//数据存储格式
	private String storeFormat;
	
	//存储字段
	private List<OptField> storeFieldDef;

}
