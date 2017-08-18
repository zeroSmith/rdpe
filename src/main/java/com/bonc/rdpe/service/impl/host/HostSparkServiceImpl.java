package com.bonc.rdpe.service.impl.host;

import java.util.List;

import org.springframework.stereotype.Service;

import com.bonc.rdpe.entity.HostSpark;
import com.bonc.rdpe.service.host.HostSparkService;
import com.bonc.rdpe.service.impl.base.BaseServiceImpl;

/**
 * spark主机配置
 * 
 * @author xieqianqian
 *
 */
@Service("hostSparkService")
public class HostSparkServiceImpl extends BaseServiceImpl<HostSpark, String> implements HostSparkService{

	@Override
	public List<HostSpark> getMasterHosts(String createrId) {
		return daoHelper.queryForList(getStatementPrefix() + "getMasterHosts", createrId);
	}

}
