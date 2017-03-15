package com.hehanpeng.ssm.module.accountRecods.service;

import com.hehanpeng.ssm.module.accountRecods.pojo.AccountRecords;
import com.hehanpeng.ssm.module.common.service.BaseService;

import java.util.List;
import java.util.Map;

public interface AccountRecordsService extends BaseService<AccountRecords> {
    public List<Map<String, Object>> selectSupplierPayable(Map<String, String> paramMap);
}
