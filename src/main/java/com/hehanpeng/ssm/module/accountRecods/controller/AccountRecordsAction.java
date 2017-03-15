package com.hehanpeng.ssm.module.accountRecods.controller;

import com.hehanpeng.ssm.module.accountRecods.service.AccountRecordsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by 28773 on 2017/3/13.
 */
@Controller
@RequestMapping(value = "/accountRecords")
public class AccountRecordsAction {
    @Autowired
    private AccountRecordsService accountRecordsService;

    @RequestMapping("/selectSupplierPayable")
    @ResponseBody // 如果返回json格式，需要这个注解，这里用来测试环境
    public Object selectSupplierPayable(String start, String end) {
        Map<String, String> paramMap = new HashMap<String, String>();
        paramMap.put("start", start);
        paramMap.put("end", end);
        return accountRecordsService.selectSupplierPayable(paramMap);
    }

}
