package com.bonc.rdpe.entity.def;

import lombok.Data;

/**
 * 函数的Opt
 * @author jpp
 *
 */
@Data
public class FunOpt {

	/**
	 * 当前方法的id
	 */
	private String id ;
	
	/**
	 * 方法名称
	 */
	private String funName;

	/**
	 * 方法包名
	 */
	private String packageName;
	
	/**
	 * 方法类名
	 */
	private String className;
}
