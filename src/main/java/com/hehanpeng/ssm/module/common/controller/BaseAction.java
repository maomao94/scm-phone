package com.hehanpeng.ssm.module.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

@Controller
@RequestMapping(value="/base")
public class BaseAction {

	@Resource
	protected ServletContext application;

	// 方法参数folder通过@PathVariable指定其值可以从@RequestMapping的{folder}获取，同理file也一样
	@RequestMapping("/goURL/{folder}/{file}")
	public String goURL(@PathVariable String folder, @PathVariable String file) {
		return "forward:/WEB-INF/view/" + folder + "/" + file + ".jsp";
	}
}
