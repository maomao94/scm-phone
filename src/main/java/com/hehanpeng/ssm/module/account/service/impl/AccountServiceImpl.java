package com.hehanpeng.ssm.module.account.service.impl;

import com.hehanpeng.ssm.module.common.service.impl.BaseServiceImpl;
import com.hehanpeng.ssm.module.account.pojo.Account;
import com.hehanpeng.ssm.module.account.service.AccountService;
import org.springframework.stereotype.Service;

@Service(value = "accountService")
public class AccountServiceImpl extends BaseServiceImpl<Account> implements AccountService {

	@Override
	public Account login(Account account) {
		return accountMapper.login(account);
	}
}
