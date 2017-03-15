package com.hehanpeng.ssm.module.account.controller;

import com.hehanpeng.ssm.module.common.controller.BaseAction;
import com.hehanpeng.ssm.module.account.pojo.Account;
import com.hehanpeng.ssm.module.account.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping(value = "/account")
public class AccountAction extends BaseAction {

	@Autowired
	private AccountService accountService;

	@RequestMapping("/login")
	public String login(HttpServletRequest request, HttpSession session, Account account) {
		try {
			Account acc = accountService.login(account);
			if (acc != null) {
				session.setAttribute("account", acc);
				return "main";
			} else {
				request.setAttribute("errmsg", "用户名或密码错误");
				return "forward:/login.jsp";
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
}
