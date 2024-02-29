package com.itmk.web.school_class.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.itmk.utils.ResultUtils;
import com.itmk.utils.ResultVo;
import com.itmk.web.school_class.entity.AssignClass;
import com.itmk.web.school_class.entity.AssignClassParm;
import com.itmk.web.school_class.entity.ListParm;
import com.itmk.web.school_class.entity.SchoolClass;
import com.itmk.web.school_class.service.SchoolClassService;
import com.itmk.web.school_major.entity.SchoolMajor;
import com.itmk.web.school_major.service.SchoolMajorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author Alan
 * @Version 001
 */
@RestController
@RequestMapping("/api/class")
public class SchoolClassController {
    @Autowired
    private SchoolClassService schoolClassService;
    @Autowired
    private SchoolMajorService schoolMajorService;

    //新增
    @PostMapping
    public ResultVo add(@RequestBody SchoolClass schoolClass){
        boolean save = schoolClassService.save(schoolClass);
        if(save){
            return ResultUtils.success("新增成功!");
        }
        return ResultUtils.error("新增失败!");
    }

     //编辑
    @PutMapping
    public ResultVo edit(@RequestBody SchoolClass schoolClass){
        boolean save = schoolClassService.updateById(schoolClass);
        if(save){
            return ResultUtils.success("编辑成功!");
        }
        return ResultUtils.error("编辑失败!");
    }

    //编辑回显
    @GetMapping("/getClassById")
    public ResultVo getClassById(Long classId){
        SchoolClass schoolClass = schoolClassService.getSchoolClassById(classId);
        return ResultUtils.success("查询成功",schoolClass);
    }


    //删除
    @DeleteMapping("/{classId}")
    public ResultVo delete(@PathVariable("classId") Long classId){
        boolean b = schoolClassService.removeById(classId);
        if(b){
            return ResultUtils.success("删除成功!");
        }
        return ResultUtils.error("删除失败!");
    }

    //列表查询
    @GetMapping("/list")
    public ResultVo getList(ListParm parm){
        IPage<SchoolClass> list = schoolClassService.getList(parm);
        return ResultUtils.success("查询成功",list);
    }

    //根据学院id查询专业列表
    @GetMapping("/getMajorList")
    public ResultVo getMajorList(Long collageId){
        QueryWrapper<SchoolMajor> query = new QueryWrapper<>();
        query.lambda().eq(SchoolMajor::getCollageId,collageId);
        List<SchoolMajor> list = schoolMajorService.list(query);
        return ResultUtils.success("查询成功",list);
    }

    //分配宿舍，查询班级列表
    @GetMapping("/getAssignClass")
    public ResultVo getAssignClass(AssignClassParm parm){
        IPage<AssignClass> assignClass = schoolClassService.getAssignClass(parm);
        return ResultUtils.success("查询成功",assignClass);
    }

    //查询班级列表
    @GetMapping("/getListForAssign")
    public ResultVo getListForAssign(){
        List<SchoolClass> list = schoolClassService.list();
        return ResultUtils.success("查询成功",list);
    }
}
