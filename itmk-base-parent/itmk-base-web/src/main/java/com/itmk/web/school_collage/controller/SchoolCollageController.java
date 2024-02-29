package com.itmk.web.school_collage.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.itmk.utils.ResultUtils;
import com.itmk.utils.ResultVo;
import com.itmk.web.school_collage.entity.ListParm;
import com.itmk.web.school_collage.entity.SchoolCollage;
import com.itmk.web.school_collage.service.SchoolCollageService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

/**
 * @Author Alan
 * @Version 001
 */
@RestController
@RequestMapping("/api/collage")
public class SchoolCollageController {
    @Autowired
    private SchoolCollageService schoolCollageService;

    //新增
    @PostMapping
    public ResultVo add(@RequestBody SchoolCollage schoolCollage){
        //设置创建时间
        schoolCollage.setCreateTime(new Date());
        boolean save = schoolCollageService.save(schoolCollage);
        if(save){
            return ResultUtils.success("新增学院成功!");
        }
        return ResultUtils.error("新增学院失败!");
    }

    //编辑
    @PutMapping
    public ResultVo edit(@RequestBody SchoolCollage schoolCollage){

        boolean save = schoolCollageService.updateById(schoolCollage);
        if(save){
            return ResultUtils.success("编辑学院成功!");
        }
        return ResultUtils.error("编辑学院失败!");
    }

    //删除
    @DeleteMapping("/{collageId}")
    public ResultVo delete(@PathVariable("collageId") Long collageId){
        boolean b = schoolCollageService.removeById(collageId);
        if(b){
            return ResultUtils.success("删除学院成功!");
        }
        return ResultUtils.error("删除学院失败!");

    }

    //列表
    @GetMapping("/list")
    public ResultVo getList(ListParm listParm){
        //构造查询条件
        QueryWrapper<SchoolCollage> query = new QueryWrapper<>();
        if(StringUtils.isNotEmpty(listParm.getCollageName())){
            query.lambda().like(SchoolCollage::getCollageName,listParm.getCollageName());
        }
        //构造分页对象
        IPage<SchoolCollage> page = new Page<>(listParm.getCurrentPage(),listParm.getPageSize());
        //查询
        IPage<SchoolCollage> list = schoolCollageService.page(page, query);
        return ResultUtils.success("查询成功",list);
    }

}
