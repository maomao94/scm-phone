package com.hehanpeng.ssm.module.sysParam.service;

import com.hehanpeng.ssm.module.common.service.BaseService;
import com.hehanpeng.ssm.module.sysParam.pojo.SysParam;

import java.util.Map;

/**
 * Created by 28773 on 2017/3/10.
 */
public interface SysParamService extends BaseService<SysParam> {

    /**
     * 返回系统参数的map
     *
     * @return
     */
    public Map<String, Object> sysParamMap() throws Exception;
}
