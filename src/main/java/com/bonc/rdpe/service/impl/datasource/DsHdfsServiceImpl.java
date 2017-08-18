package com.bonc.rdpe.service.impl.datasource;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.bonc.rdpe.constant.DataBaseOptType;
import com.bonc.rdpe.entity.DsHdfs;
import com.bonc.rdpe.service.datasource.DsHdfsService;
import com.bonc.rdpe.service.impl.base.BaseServiceImpl;

@Service("dsHdfsService")
public class DsHdfsServiceImpl extends BaseServiceImpl<DsHdfs, String> implements DsHdfsService {
	@Override
	public List<Object> getAllDS() {
		return daoHelper.queryForList(getStatementPrefix()+"selectAll");
	}

	@Override
	public List<DsHdfs> getAllByCreateId(Map<String, String> param) {
		return daoHelper.queryForList(getStatementPrefix() + DataBaseOptType.DB_OPT_SELECTALLBYCONDITION, param);
	}

}
