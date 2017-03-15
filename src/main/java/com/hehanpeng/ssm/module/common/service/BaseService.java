package com.hehanpeng.ssm.module.common.service;

import com.hehanpeng.ssm.module.common.pojo.Page;

import java.util.List;

public interface BaseService<T> {
	/**
	 * 添加一条记录
	 * 
	 * @param entity
	 * @return
	 */
	public int insert(T entity);

	/**
	 * 根据主键修改记录
	 * 
	 * @param entity
	 * @return
	 */
	public T selectByPk(T entity);

	/**
	 * 根据对象主键删除
	 * 
	 * @param pks
	 * @return
	 */
	public int deleteByPk(String[] pks);

	/**
	 * 根据对象主键修改
	 * 
	 * @param entity
	 * @return
	 */
	public int updateByPk(T entity);

	/**
	 * 查询多条记录
	 * 
	 * @param entity
	 * @return
	 */
	public List<T> selectUseDyc(T entity);

	/**
	 * 关键字分页查询，返回列表数据
	 * 
	 * @param page
	 * @return
	 */
	public Page<T> selectPage(Page<T> page);

	/***
	 * 多条件分页查询，返回列表数据
	 * 
	 * @param page
	 * @return
	 */
	public Page<T> selectPageUseDyc(Page<T> page);
}
