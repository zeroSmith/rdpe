package com.bonc.rdpe.service.datasource;

import java.util.List;
import java.util.Map;

import com.bonc.rdpe.entity.DsKafka;
import com.bonc.rdpe.service.base.IBaseService;

public interface DsKafkaService extends IBaseService<DsKafka, String> {

	List<DsKafka> getAllByCreateId(Map<String, String> param);

}