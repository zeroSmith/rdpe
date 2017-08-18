package com.bonc.rdpe.service.impl.datasource;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.bonc.rdpe.constant.DataBaseOptType;
import com.bonc.rdpe.entity.DsKafka;
import com.bonc.rdpe.service.datasource.DsKafkaService;
import com.bonc.rdpe.service.impl.base.BaseServiceImpl;

@Service("dsKafkaService")
public class DsKafkaServiceImpl extends BaseServiceImpl<DsKafka, String> implements DsKafkaService {

	@Override
	public List<DsKafka> getAllByCreateId(Map<String, String> param) {
		return daoHelper.queryForList(getStatementPrefix() + DataBaseOptType.DB_OPT_SELECTALLBYCONDITION, param);
	}

}