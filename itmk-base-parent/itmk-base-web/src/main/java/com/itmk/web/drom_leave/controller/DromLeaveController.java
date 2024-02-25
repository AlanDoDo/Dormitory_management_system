package com.itmk.web.drom_leave.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.itmk.utils.ResultUtils;
import com.itmk.utils.ResultVo;
import com.itmk.web.drom_leave.entity.DromLeave;
import com.itmk.web.drom_leave.entity.LeaveParm;
import com.itmk.web.drom_leave.service.DromLeaveService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * @Author java实战基地
 * @Version 3501754007
 */
@RestController
@RequestMapping("/api/leave")
public class DromLeaveController {
    @Autowired
    private DromLeaveService dromLeaveService;

    //新增
    @PostMapping
    public ResultVo add(@RequestBody DromLeave dromLeave){
        boolean save = dromLeaveService.save(dromLeave);
        if(save){
            return ResultUtils.success("新增成功!");
        }
        return ResultUtils.error("新增失败!");
    }

    //编辑
    @PutMapping
    public ResultVo edit(@RequestBody DromLeave dromLeave){
        boolean save = dromLeaveService.updateById(dromLeave);
        if(save){
            return ResultUtils.success("编辑成功!");
        }
        return ResultUtils.error("编辑失败!");
    }

    //删除
    @DeleteMapping("/{leaveId}")
    public ResultVo delete(@PathVariable("leaveId") Long leaveId){
        boolean b = dromLeaveService.removeById(leaveId);
        if(b){
            return ResultUtils.success("删除成功!");
        }
        return ResultUtils.error("删除失败!");
    }

    //列表
    @GetMapping("/list")
    public ResultVo list(LeaveParm parm){
        //构造分页对象
        IPage<DromLeave> page = new Page<>(parm.getCurrentPage(),parm.getPageSize());
        //构造查询条件
        QueryWrapper<DromLeave> query = new QueryWrapper<>();
        if(StringUtils.isNotEmpty(parm.getClasses())){
            query.lambda().like(DromLeave::getClasses,parm.getClasses());
        }
        if(StringUtils.isNotEmpty(parm.getDromName())){
            query.lambda().like(DromLeave::getDromName,parm.getDromName());
        }
        if(StringUtils.isNotEmpty(parm.getStuName())){
            query.lambda().like(DromLeave::getStuName,parm.getStuName());
        }
        IPage<DromLeave> list = dromLeaveService.page(page, query);
        return ResultUtils.success("查询成功",list);
    }
}
