package com.itmk.web.school_student.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.itmk.web.school_student.entity.SchoolStudent;
import com.itmk.web.school_student.entity.StuParm;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author Alan
 * @Version 001
 */
public interface SchoolStudentMapper extends BaseMapper<SchoolStudent> {
    SchoolStudent getStuById(@Param("stuId") Long stuId);
    IPage<SchoolStudent> getList(IPage<SchoolStudent> page, @Param("parm")StuParm parm);
    SchoolStudent getById(@Param("stuId") Long stuId);
    List<SchoolStudent> exportStu(@Param("parm")StuParm parm);
}
