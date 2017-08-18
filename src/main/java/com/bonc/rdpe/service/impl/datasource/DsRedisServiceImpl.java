package com.bonc.rdpe.service.impl.datasource;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.bonc.rdpe.constant.DataBaseOptType;
import com.bonc.rdpe.entity.DsRedis;
import com.bonc.rdpe.service.datasource.DsRedisService;
import com.bonc.rdpe.service.impl.base.BaseServiceImpl;



@Service("dsRedisService")
public class DsRedisServiceImpl extends BaseServiceImpl<DsRedis, String> implements DsRedisService {

	@Override
	public List<Object> getAllDS() {
		return daoHelper.queryForList(getStatementPrefix()+"selectAll");
	}

	@Override
	public List<DsRedis> getAllByCreateId(Map<String, String> param) {
		return daoHelper.queryForList(getStatementPrefix() + DataBaseOptType.DB_OPT_SELECTALLBYCONDITION, param);
	}

}

