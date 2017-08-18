package com.bonc.rdpe.comm.util;

import java.util.Map;

import com.bonc.rdpe.exception.RdpeException;

public class MapUtil {

	/**
	 * 判断系统参数是否配置
	 * @param map
	 * @param keys
	 * @return
	 * @throws RdpeException
	 */
	public static void isContainsKeys(Map map, String... keys) throws RdpeException{
		StringBuilder message = new StringBuilder();
		message.append("系统参数需要配置：<br>");
		boolean isContainsKeys = true;
		for (String key : keys) {
			//不包含某个key
			if(!map.containsKey(key)){
				isContainsKeys = false;
				message.append(key + "<br>");
			}
		}
		if(!isContainsKeys){
			throw new RdpeException(message.toString());
		}
	}

}
