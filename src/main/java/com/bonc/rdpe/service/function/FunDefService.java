/**
 * Project Name		[rdpe]
 * File Name		[com.bonc.rdpe.service.function.FunctionService.java]
 * Creation Date	[2017年4月25日]
 * <p>
 * Copyright© 2017 www.bonc.com.cn All Rights Reserved
 * <p>
 */
package com.bonc.rdpe.service.function;

import java.util.List;
import java.util.Map;

import com.bonc.rdpe.entity.FunDef;
import com.bonc.rdpe.exception.RdpeException;
import com.bonc.rdpe.service.base.IBaseService;

/**
 * @author wangxiaoxing
 * 
 * 2017年4月25日 上午9:47:15
 */
public interface FunDefService extends IBaseService<FunDef, String>{

	/**
	 * 上传文件
	 * @param multipartRequest
	 * @param path
	 * @param loginId
	 * @param contextPath
	 * @param requestUrl
	 * @param user
	 * @return
	 */
	List<Map<String,Object>> upload(Map<String, Object> map) throws RdpeException;

	/**
	 * 删除文件
	 * @param filePath 文件上传的路径
	 * @param sysDictMap
	 * @return
	 * @throws RdpeException
	 */
	boolean deleteFile(String filePath, Map<String,String> sysDictMap) throws RdpeException;

	/**
	 * 新增自定义函数
	 * @param funDef
	 * @return
	 */
	boolean addFunDef(FunDef funDef);

	/**
	 * 删除自定义函数
	 * @param id
	 * @param sysDictMap
	 * @return
	 */
	boolean removeFunDef(String id) throws Exception;

	/**
	 * 更新自定义函数
	 * @param funDef
	 * @return
	 */
	boolean editFunDef(FunDef funDef);

	/**
	 * 根据传入的参数，进行过滤，获取自定义函数
	 * @param dataType
	 * @return
	 */
	List<FunDef> getFun(String dataType);

	/**
	 * 判断类节点是否含有子节点
	 * @return
	 */
	boolean getChildren(String id);

	List<FunDef> getAllByCreateId(String userId);
}
