package com.hehanpeng.ssm.module.common.mapper;

import com.hehanpeng.ssm.module.common.pojo.Page;

import java.util.List;

public interface BaseMapper<T> {
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

	/***
	 * 关键字分页查询，返回列表数据
	 * 
	 * @param page
	 * @return
	 */
	public List<T> selectPageList(Page<T> page);

	/***
	 * 关键字分页查询，返回总记录数
	 * 
	 * @param page
	 * @return
	 */
	public Integer selectPageCount(Page<T> page);

	/***
	 * 多条件分页查询，返回列表数据
	 * 
	 * @param page
	 * @return
	 */
	public List<T> selectPageListUseDyc(Page<T> page);

	/***
	 * 多条件分页查询，返回总记录数
	 * 
	 * @param page
	 * @return
	 */
	public Integer selectPageCountUseDyc(Page<T> page);
}
