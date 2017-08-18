package com.bonc.rdpe.service.base;

import java.util.List;
import java.util.Map;

public interface IBaseService<T, PK> {

	public boolean add(T t);

	public boolean remove(PK pk);

	public boolean edit(T t);

	public T getOne(PK pk);
	
	public Map<String, Object> getAll(String start, String length, Map<String, Object> paramMap);
	
	public List<T> getAll();

}