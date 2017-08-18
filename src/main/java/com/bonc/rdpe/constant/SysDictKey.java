package com.bonc.rdpe.constant;

public class SysDictKey {

	private SysDictKey() {

	}

	// spark事件上传路径
	public static final String SPARK_UPLOAD_JAR_PATH = "sparkUploadJarPath";
	// spark事件发布路径
	public static final String SPARK_PUBLISH_JAR_PATH = "sparkPublishJarPath";
	// 自定义函数中定义的类上传路径
	public static final String FUN_DEF_CLASS_PATH = "funDefClassPath";
	// tomcat服务器IP地址
	public static final String TOMCAT_SERVER_IP = "tomcatServerIp";
	// tomcat服务器端口号
	public static final String TOMCAT_SERVER_PORT = "tomcatServerPort";
	// tomcat服务器ssh用户名
	public static final String TOMCAT_SERVER_USERNAME = "tomcatServerUserName";
	// tomcat服务器ssh密码
	public static final String TOMCAT_SERVER_PASSWORD = "tomcatServerPassWord";
	
	public static final String RESOURCEMANAGER_FIRST_SERVER_IP= "resourceManagerFirstServerIp";
	
	public static final String RESOURCEMANAGER_SECOND_SERVER_IP= "resourceManagerSecondServerIp";
	
	public static final String YARN_WEB_PORT= "yarnWebPort";

}
