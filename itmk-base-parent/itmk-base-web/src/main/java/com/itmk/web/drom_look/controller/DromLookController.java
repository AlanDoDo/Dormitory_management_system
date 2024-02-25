package com.itmk.web.drom_look.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.itmk.utils.ResultUtils;
import com.itmk.utils.ResultVo;
import com.itmk.web.drom_look.entity.DromLook;
import com.itmk.web.drom_look.entity.LookParm;
import com.itmk.web.drom_look.service.DromLookService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * @Author java实战基地
 * @Version 3501754007
 */
@RestController
@RequestMapping("/api/look")
public class DromLookController {
    @Autowired
    private DromLookService dromLookService;

    //新增
    @PostMapping
    public ResultVo add(@RequestBody DromLook dromLook){
        boolean save = dromLookService.save(dromLook);
        if(save){
            return ResultUtils.success("录入成功");
        }
        return ResultUtils.error("录入失败!");
    }

    //编辑
    @PutMapping
    public ResultVo edit(@RequestBody DromLook dromLook){
        boolean save = dromLookService.updateById(dromLook);
        if(save){
            return ResultUtils.success("编辑成功");
        }
        return ResultUtils.error("编辑失败!");
    }

    //删除
    @DeleteMapping("/{lookId}")
    public ResultVo delete(@PathVariable("lookId") Long lookId){
        boolean save = dromLookService.removeById(lookId);
        if(save){
            return ResultUtils.success("删除成功");
        }
        return ResultUtils.error("删除失败!");
    }

    //列表
    @GetMapping("/list")
    public ResultVo list(LookParm parm){
        //构造分页对象
        IPage<DromLook> page = new Page<>(parm.getCurrentPage(),parm.getPageSize());
        //构造查询条件
        QueryWrapper<DromLook> query = new QueryWrapper<>();
        if(StringUtils.isNotEmpty(parm.getLookRoom())){
            query.lambda().like(DromLook::getLookRoom,parm.getLookRoom());
        }
        if(StringUtils.isNotEmpty(parm.getUserName())){
            query.lambda().like(DromLook::getUserName,parm.getUserName());
        }
        IPage<DromLook> list = dromLookService.page(page, query);
        return ResultUtils.success("查询成功",list);
    }
}
