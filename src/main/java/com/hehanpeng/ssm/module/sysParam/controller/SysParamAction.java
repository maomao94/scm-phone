package com.hehanpeng.ssm.module.sysParam.controller;

import com.hehanpeng.ssm.module.common.controller.BaseAction;
import com.hehanpeng.ssm.module.supplier.pojo.Supplier;
import com.hehanpeng.ssm.module.sysParam.service.SysParamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.PostConstruct;

@Controller
@RequestMapping(value = "/sysParam")
public class SysParamAction extends BaseAction {

    @Autowired
    private SysParamService sysParamService;

    //insert

    //delete


    //update

    /**
     * 给前台加载application参数
     *
     * @return null
     */
    @RequestMapping("/reloadSysParam")
    @ResponseBody
    public Object reload() {
        sysParamInit();
        return null;
    }

    /**
     * 初始化系统参数
     */
    @PostConstruct
    public void sysParamInit() {
        try {
            application.setAttribute("sysParam", sysParamService.sysParamMap());
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }
}
