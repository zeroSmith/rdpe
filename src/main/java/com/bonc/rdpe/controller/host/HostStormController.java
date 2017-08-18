package com.bonc.rdpe.controller.host;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bonc.rdpe.entity.HostStorm;
import com.bonc.rdpe.exception.RdpeException;
import com.bonc.rdpe.service.host.HostStormService;
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
@RequestMapping("/hostStorm")
public class HostStormController {

	@Resource
	private HostStormService hostStormService;

	@RequestMapping("/index")
	public String index() {
		return "host/host_storm_manage";
	}

	@ResponseBody
	@RequestMapping("/list")
	public Map<String, Object> list(String start, String length, String jsonStr,HttpServletRequest request) {
		@SuppressWarnings("unchecked")
		Map<String, Object> paramMap = JsonUtils.stringToCollect(jsonStr);
		paramMap.put("createrId", UserUtil.getUserId(request));
		Map<String, Object> retMap = hostStormService.getAll(start, length, paramMap);
		return retMap;
	}

	@ResponseBody
	@RequestMapping("/addStorm")
	public boolean addSpark(HostStorm hostStorm,HttpServletRequest request) throws RdpeException{
		hostStorm.setId(IdUtil.genUUID());
		hostStorm.setHostPassword(AesUtil.encrypt(hostStorm.getHostPassword()));
		hostStorm.setCreaterId(UserUtil.getUserId(request));
		hostStorm.setCreateTime(new Date());
		hostStorm.setOrgId(UserUtil.getOrgId(request));
		return hostStormService.add(hostStorm);
	}

	@ResponseBody
	@RequestMapping("/load")
	public Object load(String id) throws RdpeException {
		HostStorm hostStorm = hostStormService.getOne(id);
		hostStorm.setHostPassword(AesUtil.decrypt(hostStorm.getHostPassword()));
		return hostStorm;
	}

	@ResponseBody
	@RequestMapping("/editStorm")
	public Object editSparkHost(HostStorm hostStorm,HttpServletRequest request) throws RdpeException {
		//有编辑权限
		if(UserUtil.getUserId(request).equals(hostStorm.getCreaterId())){
			hostStorm.setHostPassword(AesUtil.encrypt(hostStorm.getHostPassword()));
			hostStorm.setCreateTime(new Date());
			hostStorm.setOrgId(UserUtil.getOrgId(request));
			return hostStormService.edit(hostStorm);
		}else{
			return "NoAuthority";
		}
	}

	@ResponseBody
	@RequestMapping("/remove")
	public Object remove(String id,HttpServletRequest request) {
		HostStorm hostStorm = hostStormService.getOne(id);
		if(UserUtil.getUserId(request).equals(hostStorm.getCreaterId())){
			return hostStormService.remove(id);
		}else{
			return "NoAuthority";
		}
	}

	@ResponseBody
	@RequestMapping("/getNimbus")
	public List<HostStorm> getNimbus(HttpServletRequest request) {
		return hostStormService.getNimbusHosts(UserUtil.getUserId(request));
	}

}
