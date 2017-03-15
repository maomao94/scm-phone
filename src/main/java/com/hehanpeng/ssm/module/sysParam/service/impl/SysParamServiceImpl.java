package com.hehanpeng.ssm.module.sysParam.service.impl;

import com.hehanpeng.ssm.module.common.service.impl.BaseServiceImpl;
import com.hehanpeng.ssm.module.sysParam.pojo.SysParam;
import com.hehanpeng.ssm.module.sysParam.service.SysParamService;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 28773 on 2017/3/10.
 */
@Service(value = "sysParamService")
public class SysParamServiceImpl extends BaseServiceImpl<SysParam> implements SysParamService {

    @Override
    public Map<String, Object> sysParamMap() {
        //存放系统参数map
        Map<String, Object> sysParamMap = new HashMap<>();
        //存储内部参数的map
        Map<String, Object> fieldMap = null;
        List<SysParam> sysParamsList = sysParamMapper.selectSysParamList(null);
        for (SysParam sysParam : sysParamsList) {
            //仓库的字段参数
            if ("1".equals(sysParam.getSysParamType())) {
                //获取表中sql
                String sql = sysParam.getSysParamValue();
                //执行sql,查询字段表的数据
                List<SysParam> innerTableList = sysParamMapper.selectInnerTable(sql);
                fieldMap = new HashMap<>();
                //遍历放入字段map
                for (SysParam sysParam1 :
                        innerTableList) {
                    fieldMap.put(sysParam1.getSysParamValue(), sysParam1.getSysParamText());
                }
                //字段map放入系统map
                sysParamMap.put(sysParam.getSysParamField(), fieldMap);
            } else {
                //字段不存在系统参数map中，需要新建该字段map，存放系统参数map中
                if (sysParamMap.get(sysParam.getSysParamField()) == null) {
                    fieldMap = new HashMap<>();
                    //存放字段map
                    fieldMap.put(sysParam.getSysParamValue(), sysParam.getSysParamText());
                    //存放系统map
                    sysParamMap.put(sysParam.getSysParamField(), fieldMap);
                } else {
                    fieldMap = (Map<String, Object>) sysParamMap.get(sysParam.getSysParamField());
                    fieldMap.put(sysParam.getSysParamValue(), sysParam.getSysParamText());
                }
            }
        }
        return sysParamMap;
    }
}
