package com.itmk.web.sys_user.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.itmk.utils.ResultUtils;
import com.itmk.utils.ResultVo;
import com.itmk.web.drom_build.service.DromBuildService;
import com.itmk.web.drom_repair.entity.DromRepair;
import com.itmk.web.drom_repair.service.DromRepairService;
import com.itmk.web.school_class.service.SchoolClassService;
import com.itmk.web.school_student.service.SchoolStudentService;
import com.itmk.web.sys_user.entity.TotalVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @Author java实战基地
 * @Version 3501754007
 */
@RestController
@RequestMapping("/api/home")
public class SysHomeController {
    @Autowired
    private SchoolClassService schoolClassService;
    @Autowired
    private SchoolStudentService schoolStudentService;
    @Autowired
    private DromRepairService dromRepairService;
    @Autowired
    private DromBuildService dromBuildService;

    @GetMapping("/getTotal")
    public ResultVo getTotal(){
        TotalVo vo = new TotalVo();
        //班级总数
        int count = schoolClassService.count();
        vo.setClassCount(count);
        //学生
        int count1 = schoolStudentService.count();
        vo.setStuCount(count1);
        //待维修
        QueryWrapper<DromRepair> query = new QueryWrapper<>();
        query.lambda().eq(DromRepair::getStatus,"0");
        int count2 = dromRepairService.count(query);
        vo.setRepairCount(count2);
        //；楼宇
        int count3 = dromBuildService.count();
        vo.setBuildCount(count3);
        ;return ResultUtils.success("查询成功",vo);
    }
}
