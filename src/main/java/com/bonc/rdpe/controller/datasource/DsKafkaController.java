package com.bonc.rdpe.controller.datasource;

import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bonc.rdpe.entity.DsKafka;
import com.bonc.rdpe.service.datasource.DsKafkaService;
import com.bonc.rdpe.util.IdUtil;
import com.bonc.rdpe.util.JsonUtils;
import com.bonc.rdpe.util.UserUtil;

@Controller
@RequestMapping("/dskafka")
public class DsKafkaController {

	@Resource
	private DsKafkaService dskafkaService;

	@RequestMapping("/index")
	public String index() {
		return "datasource/kafka";
	}

	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping("/list")
	public Map<String, Object> list(String start, String length, String jsonStr,HttpServletRequest request) {
		Map<String, Object> paramMap = JsonUtils.stringToCollect(jsonStr);
		paramMap.put("createId", UserUtil.getUserId(request));
		Map<String, Object> map = dskafkaService.getAll(start, length, paramMap);
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public boolean add(DsKafka kafka, HttpServletRequest request) {
		kafka.setId(IdUtil.genUUID());
		kafka.setCreateId(UserUtil.getUserId(request));
		kafka.setOrgId(UserUtil.getOrgId(request));
		kafka.setCreateTime(new Date());
		return dskafkaService.add(kafka);
	}

	@ResponseBody
	@RequestMapping(value = "/load", method = RequestMethod.POST)
	public DsKafka load(String dsKafkaId) {
		return dskafkaService.getOne(dsKafkaId);
	}

	@ResponseBody
	@RequestMapping(value = "/remove", method = RequestMethod.POST)
	public boolean remove(String dsKafkaId) {
		return dskafkaService.remove(dsKafkaId);
	}

	@ResponseBody
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public boolean edit(DsKafka kafka) {
		return dskafkaService.edit(kafka);
	}

}
