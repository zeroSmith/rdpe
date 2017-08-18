package com.bonc.rdpe.service.datasource;


import java.util.List;
import java.util.Map;

import com.bonc.rdpe.entity.DsRedis;
import com.bonc.rdpe.service.base.IBaseService;
public interface DsRedisService extends IBaseService<DsRedis, String>{
	 List<Object> getAllDS();

	List<DsRedis> getAllByCreateId(Map<String, String> param);

}
