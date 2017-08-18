package com.bonc.rdpe.service.host;

import java.util.List;

import com.bonc.rdpe.entity.HostSpark;
import com.bonc.rdpe.service.base.IBaseService;

public interface HostSparkService extends IBaseService<HostSpark, String> {

	/**
	 * 获取主机列表
	 * @param createrId
	 * @return
	 */
	List<HostSpark> getMasterHosts(String createrId);

}