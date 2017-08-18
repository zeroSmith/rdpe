package com.bonc.rdpe.comm.util;

import java.util.Locale;

import freemarker.cache.ClassTemplateLoader;
import freemarker.cache.MultiTemplateLoader;
import freemarker.cache.TemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.Version;

/**
 * 
 * @author bianshen
 *
 */
public class FreeMarkerUtil {

	private static final String TEMPLATEDIR = "../ftl";
	
	private static final Version VERSION  = Configuration.VERSION_2_3_23;
	
	private static Configuration cfg;
	
	private FreeMarkerUtil(){}

	/**
	 * 初始化Configuration
	 */
	public static Configuration genConfiguration() {
		if (null == cfg) {
			cfg = new Configuration(VERSION);
			ClassTemplateLoader spark = new ClassTemplateLoader(FreeMarkerUtil.class, TEMPLATEDIR + "/spark");
			TemplateLoader[] loaders = new TemplateLoader[] {spark};
			MultiTemplateLoader mtl = new MultiTemplateLoader(loaders);
			cfg.setTemplateLoader(mtl);
			cfg.setLocale(Locale.CHINA);
			cfg.setDefaultEncoding("UTF-8");
		}
		return cfg;
	}
}
