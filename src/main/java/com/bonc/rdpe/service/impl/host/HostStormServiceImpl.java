package com.bonc.rdpe.service.impl.host;

import java.util.List;

import org.springframework.stereotype.Service;

import com.bonc.rdpe.entity.HostStorm;
import com.bonc.rdpe.service.host.HostStormService;
import com.bonc.rdpe.service.impl.base.BaseServiceImpl;

/**
 * storm主机配置
 * 
 * @author jpp
 *
 */
@Service("hostStormService")
public class HostStormServiceImpl extends BaseServiceImpl<HostStorm, String> implements HostStormService{

	@Override
	public List<HostStorm> getNimbusHosts(String createrId) {
		return daoHelper.queryForList(getStatementPrefix() + "getNimbusHosts", createrId);
	}
}
