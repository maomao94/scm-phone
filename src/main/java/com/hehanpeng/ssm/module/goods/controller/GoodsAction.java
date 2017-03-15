package com.hehanpeng.ssm.module.goods.controller;
import com.hehanpeng.ssm.module.common.pojo.Page;
import com.hehanpeng.ssm.module.goods.pojo.Goods;
import com.hehanpeng.ssm.module.goods.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "/goods")
public class GoodsAction {

	@Autowired
	private GoodsService goodsService;

	//增加商品
	@RequestMapping(value = "/insert")
	@ResponseBody
	public Object insert(Goods goods) {
		int i = 0;
		i = goodsService.insert(goods);
		return i;
	}

	//删除商品
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Object delete(String pks[]) {
		Integer i = 0;
		i = goodsService.deleteByPk(pks);
		return i;
	}

	// 修改商品
	@RequestMapping(value = "/update")
	@ResponseBody
	public Object update(Goods goods) {
		int i = 0;
		i = goodsService.updateByPk(goods);
		return i;
	}

	// 通过多个关键字分页查询
	@RequestMapping("/selectPageUseDyc")
	@ResponseBody // 如果返回json格式，需要这个注解，这里用来测试环境
	public Object selectPageUseDyc(Page<Goods> page, Goods goods) {
		page.setParamEntity(goods);
		return goodsService.selectPageUseDyc(page).getPageMap();
	}

}
