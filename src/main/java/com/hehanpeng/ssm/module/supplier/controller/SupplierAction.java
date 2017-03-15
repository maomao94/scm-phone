package com.hehanpeng.ssm.module.supplier.controller;

import com.hehanpeng.ssm.module.common.controller.BaseAction;
import com.hehanpeng.ssm.module.common.pojo.Page;
import com.hehanpeng.ssm.module.supplier.pojo.Supplier;
import com.hehanpeng.ssm.module.supplier.service.SupplierService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "/supplier")
public class SupplierAction extends BaseAction {

	@Autowired
	private SupplierService supplierService;

	@RequestMapping(value = "/insert")
	@ResponseBody
	public Object insert(Supplier supplier) {
		int i = 0;
		i = supplierService.insert(supplier);
		return i;
	}

	@RequestMapping(value = "/delete")
	@ResponseBody
	public Object delete(String pks[]) {
		Integer i = 0;
		i = supplierService.deleteByPk(pks);
		return i;
	}

	// 修改供应商
	@RequestMapping(value = "/update")
	@ResponseBody
	public Object update(Supplier supplier) {
		int i = 0;
		i = supplierService.updateByPk(supplier);
		return i;
	}

	@RequestMapping("/doAjax")
	@ResponseBody // 如果返回json格式，需要这个注解，这里用来测试环境
	public Object doAjax(Supplier supplier) {
		System.out.println("---doAjax.supplier:" + supplier);
		supplier.setSupName("supName1");
		return supplier;
	}

	// 通过单个关键字分页查询
	@RequestMapping("/selectPage")
	@ResponseBody // 如果返回json格式，需要这个注解，这里用来测试环境
	public Object selectPage(Page<Supplier> page) {
		return supplierService.selectPage(page).getPageMap();
	}

	// 通过多个关键字分页查询
	@RequestMapping("/selectPageUseDyc")
	@ResponseBody // 如果返回json格式，需要这个注解，这里用来测试环境
	public Object selectPageUseDyc(Page<Supplier> page, Supplier supplier) {
		page.setParamEntity(supplier);
		return supplierService.selectPageUseDyc(page).getPageMap();
	}

}
