/**
 * Project Name		[rdpe]
 * File Name		[com.bonc.rdpe.service.impl.function.FunDefServiceImpl.java]
 * Creation Date	[2017年4月26日]
 * <p>
 * Copyright© 2017 www.bonc.com.cn All Rights Reserved
 * <p>
 */
package com.bonc.rdpe.service.impl.function;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.bonc.rdpe.constant.SysDictKey;
import com.bonc.rdpe.entity.FunDef;
import com.bonc.rdpe.entity.FunParam;
import com.bonc.rdpe.exception.RdpeException;
import com.bonc.rdpe.service.function.FunDefService;
import com.bonc.rdpe.service.impl.base.BaseServiceImpl;
import com.bonc.rdpe.util.AesUtil;
import com.bonc.rdpe.util.IdUtil;
import com.bonc.rdpe.util.JsonUtils;
import com.bonc.rdpe.util.StringUtil;
import com.bonc.rdpe.util.SystemUtil;

import lombok.extern.log4j.Log4j;

/**
 * @author wangxiaoxing
 * 
 *         2017年4月26日 上午10:42:49
 * @param <PK>
 */
@Log4j
@Service("funDefService")
public class FunDefServiceImpl extends BaseServiceImpl<FunDef, String> implements FunDefService {

	@Override
	public boolean addFunDef(FunDef funDef) {
		boolean result = true;
		try {
			String id = IdUtil.genUUID();
			funDef.setId(id);
			List<FunParam> params = funDef.getParams();
			if (params != null && !params.isEmpty()) {// 新增方法时，才有参数类型
				String inputParam = JsonUtils.toJSONString(params);
				funDef.setInputParam(inputParam);
			}
			String parentId = funDef.getParentId();
			String funTypeId = funDef.getFunTypeId();
			if ("2".equals(funTypeId)) {// 类型为2，表明新增的是方法
				FunDef parentFunDef = getOne(parentId);
				String dataType = parentFunDef.getDataType();
				if (dataType != null && !dataType.trim().isEmpty()) {
					funDef.setDataType(dataType);
				}
			}
			funDef.setPath(funDef.getPath() + "/" + id);
			funDef.setCreateTime(new Date());
			result = add(funDef);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			result = false;
		}
		return result;
	}

	@Override
	public boolean editFunDef(FunDef funDef) {
		boolean result = true;
		try {
			List<FunParam> params = funDef.getParams();
			if (params != null && params.size() != 0) {
				String inputParam = JsonUtils.toJSONString(params);
				funDef.setInputParam(inputParam);
			}
			result = edit(funDef);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			result = false;
		}
		return result;
	}

	@Override
	public boolean removeFunDef(String id) throws RdpeException {
		boolean result = true;
		FunDef funDef = getOne(id);
		try {
			if("0".equals(funDef.getFunTypeId())){//当前删除的是文件夹
				int count = (int) daoHelper.queryOne(getStatementPrefix() + "selectChildFunDef", id);
				if (count > 0) {
					result = false;
					throw new RdpeException("文件夹下有子文件，请先删除子文件后再删除该文件夹。");
				}
			}
			if ("1".equals(funDef.getFunTypeId())) {// 当前删除的是类，需要删除上传的文件
				String filePath = funDef.getStorePath();
				FileUtils.forceDelete(new File(AesUtil.decrypt(filePath)));//删除文件
				daoHelper.delete(getStatementPrefix()+"deleteChildFunDef", id);//删除当前类节点下的所有方法子节点
			}
			result = remove(id);
		} catch (IOException e) {
			if(e.getClass().equals(FileNotFoundException.class)){
				if ("1".equals(funDef.getFunTypeId())) {
					daoHelper.delete(getStatementPrefix()+"deleteChildFunDef", id);
				}
				result = remove(id);
			}else{
				result = false;
			}
			log.error(e.getMessage(), e);
		}
		return result;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List<Map<String, Object>> upload(Map<String, Object> params) throws RdpeException {
		Map<String, String> sysDictMap = (Map<String, String>) params.get("sysDictMap");
		String loginId = (String) params.get("loginId");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String path = (String) params.get("path");
		String dir = null;
		if (StringUtil.isEmpty(path)) {
			dir = this.getSTF(sysDictMap) + SystemUtil.getFileSeparator() + loginId + SystemUtil.getFileSeparator() + sdf.format(new Date());
		} else {
			String newPath = null;
			if (path.contains(".")) {// 有两级以上目录
				newPath = path.replace(".", SystemUtil.getFileSeparator());
			}
			dir = this.getSTF(sysDictMap) + SystemUtil.getFileSeparator() + newPath;
		}
		try {
			FileUtils.forceMkdir(new File(dir));
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return new ArrayList<>();
		}
		List<Map<String, Object>> mapList = new ArrayList<>();
		Map<String, MultipartFile> fileMap = (Map<String, MultipartFile>) params.get("fileMap");
		Set set = fileMap.keySet();
		Iterator iterator = set.iterator();
		while (iterator.hasNext()) {
			MultipartFile file = fileMap.get(iterator.next());
			String fileName = file.getOriginalFilename();
			if (!copyFile(new File(dir + SystemUtil.getFileSeparator() + fileName), file)) {
				log.error("保存文件失败");
				return new ArrayList<>();
			}
			Map<String, Object> map = new HashMap<>();
			map.put("error", 0);
			// 将路径进行AES加密
			map.put("path", AesUtil.encrypt(dir + SystemUtil.getFileSeparator() + fileName));
			map.put("fileSize", file.getSize());
			map.put("fileName", fileName);
			log.info(dir + SystemUtil.getFileSeparator() + fileName);
			mapList.add(map);
		}
		return mapList;
	}

	/**
	 * 复制文件方法,出入源文件为springMVC提供的对象
	 * 
	 * @param target
	 * @param multipartFile
	 * @return
	 */
	private boolean copyFile(File target, MultipartFile multipartFile) {
		try {
			InputStream ips = multipartFile.getInputStream();
			OutputStream ops = new FileOutputStream(target);
			byte[] buffer = new byte[1024];
			int length = 0;
			while ((length = ips.read(buffer)) > 0) {
				ops.write(buffer, 0, length);
			}
			ops.close();
			ips.close();
		} catch (IOException e) {
			log.error(e.getMessage(), e);
			return false;
		}
		return true;
	}

	/**
	 * 得到静态资源的路径
	 * 
	 * @return
	 * @throws RdpeException 
	 */
	public String getSTF(Map<String, String> sysDictMap) throws RdpeException {
		String path = "";
		if (SystemUtil.isWindows()) {
			path = "D:\\function";
		} else {
			if (sysDictMap != null && sysDictMap.containsKey(SysDictKey.FUN_DEF_CLASS_PATH)) {
				path = sysDictMap.get(SysDictKey.FUN_DEF_CLASS_PATH);
			} else {
				throw new RdpeException("参数表没有找到" + SysDictKey.FUN_DEF_CLASS_PATH + "的记录");
			}
		}
		return path;
	}

	@Override
	public boolean deleteFile(String filePath, Map<String, String> sysDictMap) throws RdpeException {
		File file = new File(AesUtil.decrypt(filePath));
		boolean result = false;
		String path = this.getSTF(sysDictMap);
		String parent = file.getParent();

		if (parent.equals(path)) {// 如果文件的上级目录是静态资源的根路径
			if (!file.exists()) {
				return result;
			}
			result = file.delete();
		} else {
			//FilePathUtil.isDeleteDir(path, file);
//			FileUtils.forceDelete();
		}

		return result;
	}

	@Override
	public List<FunDef> getFun(String dataType) {
		Map<String, FunDef> allFunDef = new HashMap<>();
		Map<String, FunDef> map2 = new HashMap<>();
		List<FunDef> funList = new ArrayList<>();
		List<FunDef> all = getAll();
		for (FunDef funDef : all) {
			allFunDef.put(funDef.getId(), funDef);
		}
		List<FunDef> list = daoHelper.queryForList(getStatementPrefix() + "selectByDataType", dataType);
		funList.addAll(list);
		for (FunDef funDef : list) {
			if ("1".equals(funDef.getFunTypeId()) && !map2.containsKey(funDef.getParentId())) {// 当前的是类节点
				map2.putAll(getParentFunDef(funDef.getParentId(), allFunDef));
			}
		}
		for (Map.Entry<String, FunDef> entry : map2.entrySet()) {
			FunDef funDef = entry.getValue();
			funList.add(funDef);
		}
		return funList;
	}

	/**
	 * 递归查询出上级节点
	 * 
	 * @param parentId
	 * @param all
	 * @return
	 */
	private Map<String, FunDef> getParentFunDef(String parentId, Map<String, FunDef> all) {
		Map<String, FunDef> map = new HashMap<>();
		Map<String, FunDef> mapMap = new HashMap<>();
		if (!"ROOT".equals(parentId)) {// 说明当前节点不是根节点
			FunDef fun = all.get(parentId);
			if (!map.containsKey(parentId)) {
				map.put(parentId, fun);
			}
			String pId = fun.getParentId();
			mapMap = getParentFunDef(pId, all);
			map.putAll(mapMap);
		}
		return map;
	}

	@Override
	public boolean getChildren(String id) {
		int count = (int) daoHelper.queryOne(getStatementPrefix() + "selectChildFunDef", id);
		if (count > 0) {
			return true;
		}
		return false;
	}

	@Override
	public List<FunDef> getAllByCreateId(String userId) {
		return daoHelper.queryForList(getStatementPrefix() + "selectByCreateId", userId);
	}

}
