package com.bonc.rdpe.service.impl.base;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.bonc.rdpe.constant.DataBaseOptType;
import com.bonc.rdpe.dao.DaoHelper;
import com.bonc.rdpe.service.base.IBaseService;

import lombok.extern.log4j.Log4j;

/**
 * 该类只用于继承 不能直接注入使用
 * 
 * @author bianshen
 *
 * @param <T>
 * @param <PK>
 */
@Log4j
public class BaseServiceImpl<T, PK> implements IBaseService<T, PK> {

	@Resource
	public DaoHelper daoHelper;

	protected String getStatementPrefix() {
		Type[] type = ((ParameterizedType) this.getClass().getGenericSuperclass()).getActualTypeArguments();
		String nameSpace = type[0].toString();
		if (nameSpace.startsWith("class ")) {
			nameSpace = nameSpace.substring("class ".length());
		}
		return nameSpace + ".";
	}

	/**
	 * 新增数据
	 */
	@Override
	@Transactional
	public boolean add(T t) {
		try {
			daoHelper.insert(this.getStatementPrefix() + DataBaseOptType.DB_OPT_INSERT, t);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return false;
		}
		return true;
	}

	/**
	 * 删除数据
	 */
	@Override
	@Transactional
	public boolean remove(PK pk) {
		try {
			daoHelper.delete(this.getStatementPrefix() + DataBaseOptType.DB_OPT_DELETEBYPRIMARYKEY, pk);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return false;
		}
		return true;
	}

	/**
	 * 更新数据
	 */
	@Override
	@Transactional
	public boolean edit(T t) {
		try {
			daoHelper.update(this.getStatementPrefix() + DataBaseOptType.DB_OPT_UPDATEBYPRIMARYKEYSELECTIVE, t);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return false;
		}
		return true;
	}

	/**
	 * 按照主键查询
	 */
	@Override
	@SuppressWarnings("unchecked")
	public T getOne(PK pk) {
		return (T) daoHelper.queryOne(this.getStatementPrefix() + DataBaseOptType.DB_OPT_SELECTBYPRIMARYKEY, pk);
	}

	/**
	 * 分页查询
	 */
	@Override
	public Map<String, Object> getAll(String start, String length, Map<String, Object> paramMap) {
		return daoHelper.queryForPageList(this.getStatementPrefix() + DataBaseOptType.DB_OPT_SELECTALLBYCONDITION, paramMap, start, length);
	}

	/**
	 * 不分页查询
	 */
	@Override
	public List<T> getAll() {
		return daoHelper.queryForList(this.getStatementPrefix() + DataBaseOptType.DB_OPT_SELECTALL);
	}

}
