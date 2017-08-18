package com.bonc.rdpe.service;

public class RetInfo {
	
	private boolean successful;//是否成功
	
	private String msg;//返回消息
	
	private String code;//应答码
	
	public boolean isSuccessful() {
		return successful;
	}

	public void setSuccessful(boolean successful) {
		this.successful = successful;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}


	
	
}
