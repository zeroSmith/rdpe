package com.bonc.rdpe.service.impl.event;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bonc.rdpe.bo.flow.basic.Flow;
import com.bonc.rdpe.bo.flow.basic.Rect;
import com.bonc.rdpe.comm.util.MapUtil;
import com.bonc.rdpe.constant.FlowNodeType;
import com.bonc.rdpe.constant.SysDictKey;
import com.bonc.rdpe.entity.EventOpt;
import com.bonc.rdpe.entity.EventOptKey;
import com.bonc.rdpe.entity.EventSpark;
import com.bonc.rdpe.entity.HostSpark;
import com.bonc.rdpe.entity.user.User;
import com.bonc.rdpe.exception.RdpeException;
import com.bonc.rdpe.service.RetInfo;
import com.bonc.rdpe.service.event.CodeService;
import com.bonc.rdpe.service.event.EventOptService;
import com.bonc.rdpe.service.event.EventSparkService;
import com.bonc.rdpe.service.event.FlowService;
import com.bonc.rdpe.service.host.HostSparkService;
import com.bonc.rdpe.service.impl.base.BaseServiceImpl;
import com.bonc.rdpe.util.AesUtil;
import com.bonc.rdpe.util.CmdUtil;
import com.bonc.rdpe.util.FilePathUtil;
import com.bonc.rdpe.util.JsonUtils;

import lombok.extern.log4j.Log4j;

@Log4j
@Service("eventSparkService")
public class EventSparkServiceImpl extends BaseServiceImpl<EventSpark, String> implements EventSparkService {

	@Resource
	private FlowService flowService;

	@Resource
	private EventOptService eventOptService;

	@Resource
	private HostSparkService hostSparkService;

	@Override
	public boolean editFlowDef(String id, String flowDef) {
		Flow flow = flowService.parseJson2Flow(flowDef);
		EventSpark eventSpark = getOne(id);
		if (flowDef != null && !flowDef.isEmpty()) {
			eventSpark.setFlowDef(JsonUtils.toJSONString(flow));
		}
		return edit(eventSpark);
	}

	@Override
	public RetInfo genCode(String entId, Map<String, String> map) throws RdpeException {

		EventSpark ent = this.getOne(entId);
		String flowDef = ent.getFlowDef();

		if (flowDef == null || flowDef.trim().isEmpty()) {
			log.error("eventId=" + entId + "  flowDef字段为空");
			throw new RdpeException("事件流程未定义");
		}

		Flow flow = flowService.parseJson2Flow(flowDef);
		Map<String, Rect> statesMap = flow.getStates();

		if (statesMap == null || statesMap.isEmpty()) {
			log.error("eventId=" + entId + "  flowDef没有解析到流程节点");
			throw new RdpeException("事件流程未定义");
		}

		// 输出路径 ${SPARK_UPLOAD_JAR_PATH}/${loginId}/${date}/${eventId}
		// ${SPARK_UPLOAD_JAR_PATH}
		MapUtil.isContainsKeys(map,SysDictKey.SPARK_UPLOAD_JAR_PATH);
		StringBuilder uploadJarPath = new StringBuilder(map.get(SysDictKey.SPARK_UPLOAD_JAR_PATH));
		uploadJarPath.append(File.separator);
		// ${loginId}
		uploadJarPath.append(map.get("loginId"));
		uploadJarPath.append(File.separator);
		// ${date}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String date = sdf.format(new Date());
		uploadJarPath.append(date);
		uploadJarPath.append(File.separator);
		// ${eventId}
		uploadJarPath.append(ent.getId());
		uploadJarPath.append(File.separator);

		String outPutPathStr = uploadJarPath.toString();

		// 如果输出目录不存在 则创建
		File outPutPath = new File(outPutPathStr);
		if (!outPutPath.exists()) {
			try {
				FileUtils.forceMkdir(outPutPath);
			} catch (IOException e) {
				log.error(e.getMessage(), e);
				throw new RdpeException("代码输出目录创建失败", e);
			}
		}

		map.put("outPutPath", outPutPathStr);
		Rect Srect = null;
		for (Map.Entry<String, Rect> entry : statesMap.entrySet()) {
			String rectId = entry.getKey();
			Rect rect = entry.getValue(); // 开始节点和结束节点不生成代码
			if (rect.getType().equals(FlowNodeType.START)) {
				Srect = rect;
			}
			if (rect.getType().equals(FlowNodeType.START) || rect.getType().equals(FlowNodeType.END)) {
				continue;
			}
			EventOptKey key = new EventOptKey();
			key.setEventId(entId);
			key.setOptId(rectId);
			EventOpt opt = eventOptService.getOne(key);
			CodeService codeService = CodeGeneratorsFactory.getGenerators(rect.getType());
			try {
				codeService.genCode(ent, rect, opt, map);
			} catch (RdpeException e) {
				log.error(e.getMessage(), e);
				throw e;
			}
		}
		CodeService codeService = CodeGeneratorsFactory.getGenerators("main");
		codeService.genCode(ent, Srect, null, map);
		String cmds = "cd " + uploadJarPath + " && scalac *.scala && jar -cvf " + entId + ".jar *.class ";
		MapUtil.isContainsKeys(map,SysDictKey.TOMCAT_SERVER_IP,SysDictKey.TOMCAT_SERVER_PORT,SysDictKey.TOMCAT_SERVER_USERNAME,SysDictKey.TOMCAT_SERVER_PASSWORD);
		// 当前tomcat服务进行编译
		CmdUtil cmu = new CmdUtil();
		String ip = map.get(SysDictKey.TOMCAT_SERVER_IP);
		int port = Integer.parseInt(map.get(SysDictKey.TOMCAT_SERVER_PORT));
		String userName = map.get(SysDictKey.TOMCAT_SERVER_USERNAME);
		String passWord = map.get(SysDictKey.TOMCAT_SERVER_PASSWORD);
		cmu.init(ip, port, userName, passWord);
		// 编译源代码
		cmu.execCmds(cmds);
		// 更新jar包所在的路径
		ent.setUploadJarPath(AesUtil.encrypt(outPutPathStr + entId + ".jar"));
		ent.setGenCodeStatus("00");// 00-成功 ff-失败
		RetInfo retInfo = new RetInfo();
		if (edit(ent)) {
			retInfo.setMsg("操作成功");
			retInfo.setSuccessful(true);
		} else {
			retInfo.setMsg("操作失败");
			retInfo.setSuccessful(false);
		}
		return retInfo;
	}

	@Override
	@Transactional
	public RetInfo run(String id) throws RdpeException {
		RetInfo retInfo = new RetInfo();
		EventSpark eventSpark = this.getOne(id);
		String hostid = eventSpark.getSubmitHostId();
		// 客户机
		HostSpark hostSpark = hostSparkService.getOne(hostid);
		CmdUtil submit = new CmdUtil();
		String ip = hostSpark.getHostIp();
		int port = Integer.parseInt(hostSpark.getSshPort());
		String userName = hostSpark.getHostUsername();
		String passWord = AesUtil.decrypt(hostSpark.getHostPassword());
		try {
			submit.init(ip, port, userName, passWord);
		} catch (RdpeException e) {
			eventSpark.setRunStatus("ff");
		}
		// 执行运行参数命令
		String cmds = eventSpark.getExecuteDef();
		if (cmds == null || cmds.isEmpty()) {
			throw new RdpeException("运行参数不能为空");
		}
		// 命令执行结果
		String result = "";
		StringBuffer applicationId = new StringBuffer();
		try {
			 submit.execCmds(cmds);
			//submit.execCmdsNoDestory("spark-submit --master yarn-cluster --class org.apache.spark.examples.SparkPi /opt/beh/core/spark/lib/spark-examples-1.5.0-hadoop2.6.0.jar 1000");
			InputStream is = submit.getSession().getStderr();

			BufferedReader reader = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8));
			String str = "";
			while (null != (str = reader.readLine())) {
				// 执行命令出现错误
				if (str.contains("command not found") || str.contains("Unrecognized option") || str.contains("Exception in")) {
					result = str;
					break;
				}
				// 集群出现问题
				if (str.contains("Connection refused")) {
					result = "集群出现错误";
					break;
				}
				Pattern pattern = Pattern.compile("Submitted application [aplicton]{11}+\\_+[0-9]{13}+\\_+[0-9]{4}"); // application_1498013318022_0004
				Matcher matcher = pattern.matcher(str);
				if (matcher.find()) {
					applicationId.append(matcher.group(0));
					break;
				}
			}
			reader.close();
				//submit.destory();
			if (applicationId.length() > 0) {
				// 提交成功，设置应用id
				eventSpark.setApplicationId(applicationId.toString().substring("Submitted application ".length()));
			}
		} catch (UnsupportedEncodingException e) {
			eventSpark.setRunStatus("ff");
		} catch (IOException e) {
			eventSpark.setRunStatus("ff");
		}
		if (result.trim().isEmpty() && applicationId.length() > 0) {// 命令执行正常
			eventSpark.setRunStatus("00");
		} else {
			eventSpark.setRunStatus("ff");
		}
		if (eventSpark.getRunStatus().equals("00") && edit(eventSpark)) {
			retInfo.setMsg("操作成功");
			retInfo.setSuccessful(true);
		} else {
			retInfo.setMsg("操作失败！" + result);
			retInfo.setSuccessful(true);
		}
		return retInfo;
	}

	@Override
	@Transactional
	public boolean publishEvent(String id, Map<String, String> map, User user) throws RdpeException {
		boolean retFlag = true;
		try {
			EventSpark eventSpark = this.getOne(id);
			String hostid = eventSpark.getSubmitHostId();
			// 客户机
			HostSpark hostSpark = hostSparkService.getOne(hostid);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			MapUtil.isContainsKeys(map,SysDictKey.SPARK_PUBLISH_JAR_PATH);
			StringBuilder remoteTargetDirectory = new StringBuilder(map.get(SysDictKey.SPARK_PUBLISH_JAR_PATH));
			// jar包发布后的存放路径，${SPARK_PUBLISH_JAR_PATH}/${loginId}/${date}/{eventId}/xxxxx.jar
			remoteTargetDirectory.append(File.separator).append(user.getLoginId()).append(File.separator).append(sdf.format(new Date())).append(File.separator).append(id);
			// 编译过后代码的打包路径及外部事件存放的路径
			String codeJarPath = AesUtil.decrypt(eventSpark.getUploadJarPath());
			String[] localFiles = new String[] { codeJarPath };
			String publishJarPath = eventSpark.getPublishJarPath();
			CmdUtil submit = new CmdUtil();
			submit.init(hostSpark.getHostIp(), Integer.parseInt(hostSpark.getSshPort()), hostSpark.getHostUsername(), AesUtil.decrypt(hostSpark.getHostPassword()));
			// 将打好的jar包拷贝在发布目录下
			if (publishJarPath != null && !publishJarPath.trim().isEmpty()) {
				// 事件发布的存放目录一直在第一次发布时的日期目录下
				String decryptPublishJarPath = AesUtil.decrypt(publishJarPath);
				// 删除原始jar包
				CmdUtil deleteOrginJar = new CmdUtil();
				deleteOrginJar.init(hostSpark.getHostIp(), Integer.parseInt(hostSpark.getSshPort()), hostSpark.getHostUsername(), AesUtil.decrypt(hostSpark.getHostPassword()));
				deleteOrginJar.execCmds("rm -rf " + decryptPublishJarPath);
				// 事件发布原始目录
				String originPublishJarPath = FilePathUtil.extractFilePath(decryptPublishJarPath);
				submit.execScp(localFiles, originPublishJarPath);
				eventSpark.setPublishJarPath(AesUtil.encrypt(originPublishJarPath + FilePathUtil.extractFileName(codeJarPath)));
			} else {
				// 没有发布过
				submit.execScp(localFiles, remoteTargetDirectory.toString());
				// 设置发布路径
				eventSpark.setPublishJarPath(AesUtil.encrypt(remoteTargetDirectory.toString() + File.separator + FilePathUtil.extractFileName(codeJarPath)));
			}
			this.edit(eventSpark);

		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw new RdpeException("事件发布失败", e);
		}
		return retFlag;
	}

	@Override
	public RetInfo stop(String applicationId, String eventId) throws RdpeException {
		RetInfo retInfo = new RetInfo();
		EventSpark eventSpark = this.getOne(eventId);
		String hostid = eventSpark.getSubmitHostId();
		// 客户机
		HostSpark hostSpark = hostSparkService.getOne(hostid);
		CmdUtil submit = new CmdUtil();
		String ip = hostSpark.getHostIp();
		int port = Integer.parseInt(hostSpark.getSshPort());
		String userName = hostSpark.getHostUsername();
		String passWord = AesUtil.decrypt(hostSpark.getHostPassword());
		try {
			submit.init(ip, port, userName, passWord);
		} catch (RdpeException e) {
			eventSpark.setRunStatus("kk");
		}
		String cmds = "yarn application -kill " + applicationId;
		submit.execCmds(cmds);
		// 设置发布路径
		eventSpark.setRunStatus("kk");
		// 设置已经运行
		if (edit(eventSpark)) {
			retInfo.setMsg("操作成功");
			retInfo.setSuccessful(true);
		} else {
			retInfo.setMsg("操作失败");
			retInfo.setSuccessful(false);
		}
		return retInfo;
	}

}
