package com.bonc.rdpe.service.impl.event;

import java.io.File;
import java.io.FileWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Service;
import com.bonc.rdpe.bo.flow.basic.Rect;
import com.bonc.rdpe.comm.util.FreeMarkerUtil;
import com.bonc.rdpe.dao.DaoHelper;
import com.bonc.rdpe.entity.EventOpt;
import com.bonc.rdpe.entity.EventSpark;
import com.bonc.rdpe.entity.FunDef;
import com.bonc.rdpe.entity.def.FunOpt;
import com.bonc.rdpe.exception.RdpeException;
import com.bonc.rdpe.service.event.CodeService;
import com.bonc.rdpe.service.function.FunDefService;
import com.bonc.rdpe.util.AesUtil;
import com.bonc.rdpe.util.JsonUtils;
import com.bonc.rdpe.util.StringUtil;
import freemarker.template.Configuration;
import freemarker.template.Template;
import lombok.extern.log4j.Log4j;

@Log4j
@Service("sparkFunCodeService")
public class SparkFunCodeServiceImpl implements CodeService {

	@Resource
	private DaoHelper daoHelper;
	
	@Resource
	private FunDefService funDefService;
	
	/**
	 * 提取代码生成
	 * 
	 * @throws RdpeException
	 */
	@Override
	public void genCode(EventSpark ent, Rect rect, EventOpt opt, Map<String, String> map) throws RdpeException {
		try {
			Configuration cfg = FreeMarkerUtil.genConfiguration();
			String optDef = opt.getOptDef();
			FunOpt funDef = JsonUtils.toBean(optDef, FunOpt.class);
			String id = funDef.getId();
			String funName = funDef.getFunName();
			String packageName= funDef.getPackageName();
			String className = funDef.getClassName();
			FunDef one = funDefService.getOne(funDefService.getOne(id).getParentId());//得到父类的fundef可以拿到StroePath
			if(one.getStorePath()==null){
				throw new RdpeException("函数结构错误");
			}
			String outPutPath = map.get("outPutPath");
			String storePath=one.getStorePath();
			File srcFile =new File(AesUtil.decrypt(storePath));//源文件
			File destdir= new File(outPutPath);//目标文件夹
			FileUtils.copyFileToDirectory(srcFile,destdir);
			String templateName = "FunStream.scala.ftl";
			StringBuilder fileName = new StringBuilder(StringUtil.captureStr(rect.getId())).append(".scala");
			StringBuilder objectName = new StringBuilder(StringUtil.captureStr(rect.getId()));
			Writer writer = new FileWriter(new File(outPutPath, fileName.toString()));
			Template template = cfg.getTemplate(templateName);
			Map<String, String> modelMap = new HashMap<>();
			modelMap.put("fun", packageName+"."+className+"."+funName+"(ds)");
			modelMap.put("objectName", objectName.toString());
			template.process(modelMap, writer);
			writer.close();
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new RdpeException("函数代码生产服务异常 rectId=" + rect.getId(), e);
		}
	}
}