package com.bonc.rdpe.service.datasource;



import java.util.List;
import java.util.Map;

import com.bonc.rdpe.entity.DsHdfs;
import com.bonc.rdpe.service.base.IBaseService;

public interface DsHdfsService extends IBaseService<DsHdfs, String>{

	List<Object> getAllDS();

	List<DsHdfs> getAllByCreateId(Map<String, String> param);

}
