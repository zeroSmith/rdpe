package com.bonc.rdpe.controller.datasource;

import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bonc.rdpe.entity.DsRedis;
import com.bonc.rdpe.service.datasource.DsRedisService;
import com.bonc.rdpe.util.IdUtil;
import com.bonc.rdpe.util.JsonUtils;
import com.bonc.rdpe.util.UserUtil;

@Controller
@RequestMapping("/dsredis")
public class DsRedisController {

	@Resource
	private DsRedisService dsRedisService;

	@RequestMapping("/index")
	public String index() {
		return "datasource/redis";
	}

	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping("/list")
	public Map<String, Object> list(String start, String length, String jsonStr,HttpServletRequest request) {
		Map<String, Object> paramMap = JsonUtils.stringToCollect(jsonStr);
		paramMap.put("createId", UserUtil.getUserId(request));
		Map<String, Object> map = dsRedisService.getAll(start, length, paramMap);
		return map;
	}

	@ResponseBody
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public boolean add(DsRedis redis,HttpServletRequest request){
		redis.setId(IdUtil.genUUID());
		redis.setCreateId(UserUtil.getUserId(request));
		redis.setOrgId(UserUtil.getOrgId(request));
		redis.setCreateTime(new Date());
		return dsRedisService.add(redis);
	}

	@ResponseBody
	@RequestMapping(value="/load",method=RequestMethod.POST)
	public DsRedis getRedisById(String dsRedisId){		
		return dsRedisService.getOne(dsRedisId);
	}

	@ResponseBody
	@RequestMapping(value="/remove",method=RequestMethod.POST)
	public boolean remove(String dsRedisId){		
		return dsRedisService.remove(dsRedisId);
	}

	@ResponseBody
	@RequestMapping(value="/edit",method=RequestMethod.POST)
	public boolean edit(DsRedis redis){
		return dsRedisService.edit(redis);
	}

}
