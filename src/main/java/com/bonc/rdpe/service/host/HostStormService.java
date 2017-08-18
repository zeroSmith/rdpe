package com.bonc.rdpe.service.host;

import java.util.List;

import com.bonc.rdpe.entity.HostStorm;
import com.bonc.rdpe.service.base.IBaseService;

public interface HostStormService extends IBaseService<HostStorm, String> {

	/**
	 * 获取主机列表
	 * @param createrId
	 * @return
	 */
	List<HostStorm> getNimbusHosts(String createrId);

}