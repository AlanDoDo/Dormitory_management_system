package com.itmk.web.drom_repair.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.itmk.utils.ResultUtils;
import com.itmk.utils.ResultVo;
import com.itmk.web.drom_repair.entity.DromRepair;
import com.itmk.web.drom_repair.entity.RepairParm;
import com.itmk.web.drom_repair.service.DromRepairService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

/**
 * @Author Alan
 * @Version 001
 */
@RestController
@RequestMapping("/api/repair")
public class DromRepairController {
    @Autowired
    private DromRepairService dromRepairService;

    //新增
    @PostMapping
    public ResultVo add(@RequestBody DromRepair dromRepair){
        dromRepair.setRepairTime(new Date());
        dromRepair.setStatus("0");
        boolean save = dromRepairService.save(dromRepair);
        if(save){
            return ResultUtils.success("报修成功!");
        }
        return ResultUtils.error("报修失败!");
    }

    //编辑
    @PutMapping
    public ResultVo edit(@RequestBody DromRepair dromRepair){
        boolean save = dromRepairService.updateById(dromRepair);
        if(save){
            return ResultUtils.success("编辑成功!");
        }
        return ResultUtils.error("编辑失败!");
    }

    @DeleteMapping("/{repairId}")
    public ResultVo delete(@PathVariable("repairId") Long repairId){
        boolean save = dromRepairService.removeById(repairId);
        if(save){
            return ResultUtils.success("删除成功!");
        }
        return ResultUtils.error("删除失败!");
    }

    @GetMapping("/list")
    public ResultVo list(RepairParm parm){
        //构造分页对象
        IPage<DromRepair> page = new Page<>(parm.getCurrentPage(),parm.getPageSize());
        //构造查询条件
        QueryWrapper<DromRepair> query = new QueryWrapper<>();
        if(StringUtils.isNotEmpty(parm.getDromName())){
            query.lambda().like(DromRepair::getDromName,parm.getDromName());
        }
        query.lambda().orderByDesc(DromRepair::getRepairTime);
        IPage<DromRepair> list = dromRepairService.page(page, query);
        return ResultUtils.success("查询成功",list);
    }
}
