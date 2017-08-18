package com.bonc.rdpe.controller.datasource;

import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bonc.rdpe.entity.DsHdfs;
import com.bonc.rdpe.service.datasource.DsHdfsService;
import com.bonc.rdpe.util.IdUtil;
import com.bonc.rdpe.util.JsonUtils;
import com.bonc.rdpe.util.UserUtil;

@Controller
@RequestMapping("/dshdfs")
public class DsHdfsController {

	@Resource
	private DsHdfsService dsHdfsService;

	@RequestMapping("/index")
	public String index() {
		return "datasource/hdfs";
	}

	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping("/list")
	public Map<String, Object> list(String start, String length, String jsonStr,HttpServletRequest request) {
		
		Map<String, Object> paramMap = JsonUtils.stringToCollect(jsonStr);
		paramMap.put("createId", UserUtil.getUserId(request));
		Map<String, Object> map = dsHdfsService.getAll(start, length, paramMap);
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public boolean add(DsHdfs hdfs, HttpServletRequest request) {
		hdfs.setId(IdUtil.genUUID());
		hdfs.setCreateId(UserUtil.getUserId(request));
		hdfs.setOrgId(UserUtil.getOrgId(request));
		hdfs.setCreateTime(new Date());
		return dsHdfsService.add(hdfs);
	}

	@ResponseBody
	@RequestMapping(value = "/load", method = RequestMethod.POST)
	public DsHdfs getHdfsById(String dsHdfsId) {
		return dsHdfsService.getOne(dsHdfsId);
	}

	@ResponseBody
	@RequestMapping(value = "/remove", method = RequestMethod.POST)
	public boolean remove(String dsHdfsId) {
		return dsHdfsService.remove(dsHdfsId);
	}

	@ResponseBody
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public boolean edit(DsHdfs hdfs) {
		return dsHdfsService.edit(hdfs);
	}

}
