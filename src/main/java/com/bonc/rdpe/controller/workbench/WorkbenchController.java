package com.bonc.rdpe.controller.workbench;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.httpclient.DefaultHttpMethodRetryHandler;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.params.HttpConnectionManagerParams;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bonc.rdpe.comm.util.MapUtil;
import com.bonc.rdpe.constant.SysDictKey;
import com.bonc.rdpe.entity.EventSpark;
import com.bonc.rdpe.exception.RdpeException;
import com.bonc.rdpe.service.event.EventSparkService;

/**
 * @author 作者: jxw
 * @date 创建时间: 2016-10-4 上午11:31:02
 * @version 版本: 1.0 描述：工作台页面
 */

@Controller
@RequestMapping("/workbench")
public class WorkbenchController {
	
	@Resource
	private EventSparkService eventSparkService;

	// 工作台首页
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String main(Model model) {
		return "workbench/index";
	}

	@ResponseBody
	@RequestMapping("getSparkClusterInfoList")
	public List<Map<String, String>> getSparkClusterInfoList(HttpServletRequest request) throws RdpeException{
		Map<String, String> sysDictMap = (HashMap) request.getSession().getAttribute("SysDictMap");
		HttpClient httpClient = new HttpClient();
		HttpConnectionManagerParams params = httpClient.getHttpConnectionManager().getParams();
		//连接超时时间是10秒
		params.setConnectionTimeout(10000);
		ArrayList<String> urlList = new ArrayList<>();
		ArrayList<Map<String, String>> sparkClusterInfoList = new ArrayList<>();
		MapUtil.isContainsKeys(sysDictMap, SysDictKey.RESOURCEMANAGER_FIRST_SERVER_IP,SysDictKey.RESOURCEMANAGER_SECOND_SERVER_IP,SysDictKey.YARN_WEB_PORT);
		urlList.add("http://"+sysDictMap.get(SysDictKey.RESOURCEMANAGER_FIRST_SERVER_IP)+":"+sysDictMap.get(SysDictKey.YARN_WEB_PORT)+"/ws/v1/cluster/apps");
		urlList.add("http://"+sysDictMap.get(SysDictKey.RESOURCEMANAGER_SECOND_SERVER_IP)+":"+sysDictMap.get(SysDictKey.YARN_WEB_PORT)+"/ws/v1/cluster/apps");
		List<EventSpark> eventSparkList = eventSparkService.getAll();
		Map<String, EventSpark> eventSparkMap = new HashMap<>();
		//将事件以applicationId为key存在map中
		for(EventSpark event : eventSparkList){
			eventSparkMap.put(event.getApplicationId(), event);
		}
		for (String url : urlList) {
			GetMethod getMethod = new GetMethod(url);
			// 请求格式是xml
			getMethod.addRequestHeader("accept", "application/xml");
			getMethod.getParams().setParameter(HttpMethodParams.SO_TIMEOUT, 5000);
			// 使用系统提供的默认的恢复策略
			getMethod.getParams().setParameter(HttpMethodParams.RETRY_HANDLER, new DefaultHttpMethodRetryHandler());
			try {
				int statusCode = httpClient.executeMethod(getMethod);
				if (statusCode != HttpStatus.SC_OK) {
					System.err.println("Method failed: " + getMethod.getStatusLine());
				}
				byte[] responseBody = getMethod.getResponseBody();// 读取为字节数组
				String response = new String(responseBody, "utf-8");
				if (!response.contains("<apps>")) {
					continue;
				}
				Document parseText = DocumentHelper.parseText(response);
				List<Element> selectNodes = parseText.selectNodes("/apps/app");
				SimpleDateFormat simpleFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				for (Element e : selectNodes) {
					Map<String, String> sparkClusterInfo = new LinkedHashMap<>();
					Iterator elementIterator = e.elementIterator();
					while (elementIterator.hasNext()) {
						Element element = (Element) elementIterator.next();
						String name = element.getName();//标签
						String text = element.getText();//标签内容
						if(name.equalsIgnoreCase("id")){
							if(!eventSparkMap.containsKey(text)){//不包含当前事件
								break;
							}
						}
						if (name.equals("startedTime") || name.equals("finishedTime")) {
							text = simpleFormatter.format(new Date(Long.parseLong(text)));
						}
						sparkClusterInfo.put(name, text);
					}
					//id指的是应用Id
					if(sparkClusterInfo.containsKey("id")){
						sparkClusterInfo.put("eventSparkName", eventSparkMap.get(sparkClusterInfo.get("id")).getEventCnName());
						sparkClusterInfo.put("eventSparkId", eventSparkMap.get(sparkClusterInfo.get("id")).getId());
						sparkClusterInfoList.add(sparkClusterInfo);
					}
				}
				if (sparkClusterInfoList.size() > 0) {
					// 集群信息已经有数据
					break;
				}
			} catch (Exception e) {
				throw new RdpeException("出错！请查看集群及系统参数！");
			} finally {
				// 释放资源
				getMethod.releaseConnection();
			}
		}
		return sparkClusterInfoList;
	}
}
