package com.hehanpeng.ssm.module.accountRecods.service.impl;
import com.hehanpeng.ssm.module.accountRecods.pojo.AccountRecords;
import com.hehanpeng.ssm.module.accountRecods.service.AccountRecordsService;
import com.hehanpeng.ssm.module.common.service.impl.BaseServiceImpl;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by 28773 on 2017/3/13.
 */
@Service(value = "accountRecordService")
public class AccountRecordsServiceImpl extends BaseServiceImpl<AccountRecords> implements AccountRecordsService {
    @Override
    public List<Map<String, Object>> selectSupplierPayable(Map<String, String> paramMap) {
        return accountRecordsMapper.selectSupplierPayable(paramMap);
    }
}
