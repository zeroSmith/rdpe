package com.bonc.rdpe.controller.host;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bonc.rdpe.entity.HostSpark;
import com.bonc.rdpe.exception.RdpeException;
import com.bonc.rdpe.service.host.HostSparkService;
import com.bonc.rdpe.util.AesUtil;
import com.bonc.rdpe.util.IdUtil;
import com.bonc.rdpe.util.JsonUtils;
import com.bonc.rdpe.util.UserUtil;

/**
 * 
 * @author xieqianqian
 *
 */
@Controller
@RequestMapping("/hostSpark")
public class HostSparkController {

	@Resource
	private HostSparkService hostSparkService;

	@RequestMapping("/index")
	public String index() {
		return "host/host_spark_manage";
	}

	@ResponseBody
	@RequestMapping("/list")
	public Map<String, Object> list(String start, String length, String jsonStr,HttpServletRequest request) {
		@SuppressWarnings("unchecked")
		Map<String, Object> paramMap = JsonUtils.stringToCollect(jsonStr);
		paramMap.put("createrId", UserUtil.getUserId(request));
		Map<String, Object> retMap = hostSparkService.getAll(start, length, paramMap);
		return retMap;
	}

	@ResponseBody
	@RequestMapping("/addSpark")
	public boolean addSpark(HostSpark hostSpark,HttpServletRequest request) throws RdpeException{
		hostSpark.setId(IdUtil.genUUID());
		hostSpark.setHostPassword(AesUtil.encrypt(hostSpark.getHostPassword()));
		hostSpark.setCreaterId(UserUtil.getUserId(request));
		hostSpark.setCreateTime(new Date());
		hostSpark.setOrgId(UserUtil.getOrgId(request));
		return hostSparkService.add(hostSpark);
	}

	@ResponseBody
	@RequestMapping("/load")
	public Object load(String id) throws RdpeException {
		HostSpark hostSpark = hostSparkService.getOne(id);
		hostSpark.setHostPassword(AesUtil.decrypt(hostSpark.getHostPassword()));
		return hostSpark;
	}

	@ResponseBody
	@RequestMapping("/editSpark")
	public Object editSparkHost(HostSpark hostSpark,HttpServletRequest request) throws RdpeException {
		//有编辑权限
		if(UserUtil.getUserId(request).equals(hostSpark.getCreaterId())){
			hostSpark.setHostPassword(AesUtil.encrypt(hostSpark.getHostPassword()));
			hostSpark.setCreateTime(new Date());
			hostSpark.setOrgId(UserUtil.getOrgId(request));
			return hostSparkService.edit(hostSpark);
		}else{
			return "NoAuthority";
		}
	}

	@ResponseBody
	@RequestMapping("/remove")
	public Object remove(String id,HttpServletRequest request) {
		HostSpark hostSpark = hostSparkService.getOne(id);
		if(UserUtil.getUserId(request).equals(hostSpark.getCreaterId())){
			return hostSparkService.remove(id);
		}else{
			return "NoAuthority";
		}
	}

	@ResponseBody
	@RequestMapping("/getMaster")
	public List<HostSpark> getMasters(HttpServletRequest request) {
		return hostSparkService.getMasterHosts(UserUtil.getUserId(request));
	}

}
