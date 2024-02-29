package com.itmk.web.select_bed.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.itmk.web.assign_bed.entity.AssignBed;
import com.itmk.web.assign_bed.service.AssignBedService;
import com.itmk.web.school_student.entity.SchoolStudent;
import com.itmk.web.school_student.service.SchoolStudentService;
import com.itmk.web.select_bed.entity.ChangeStu;
import com.itmk.web.select_bed.entity.StuBed;
import com.itmk.web.select_bed.entity.StuBedVo;
import com.itmk.web.select_bed.mapper.StuBedMapper;
import com.itmk.web.select_bed.service.StuBedService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * @Author Alan
 * @Version 001
 */
@Service
public class StuBedServiceImpl extends ServiceImpl<StuBedMapper, StuBed> implements StuBedService {
    @Autowired
    private AssignBedService assignBedService;
    @Autowired
    private SchoolStudentService schoolStudentService;

    @Override
    public List<StuBedVo> getStuBedList(Long stuId) {
        return this.baseMapper.getStuBedList(stuId);
    }

    @Override
    public List<ChangeStu> getStuList(Long classId) {
        return this.baseMapper.getStuList(classId);
    }

    @Override
    @Transactional
    public void clearBed(Long classId) {
        //清空管理员分配的表
        QueryWrapper<AssignBed> query = new QueryWrapper<>();
        query.lambda().eq(AssignBed::getClassId,classId);
        assignBedService.remove(query);
        //清空学生选择的表数据
        QueryWrapper<SchoolStudent> stuQuery = new QueryWrapper<>();
        stuQuery.lambda().eq(SchoolStudent::getClassId,classId);
        List<SchoolStudent> list = schoolStudentService.list(stuQuery.select("stu_id"));
        List<Long> ids = new ArrayList<>();
        if(list.size() >0){
            for (int i=0;i<list.size();i++){
                ids.add(list.get(i).getStuId());
            }
        }
        QueryWrapper<StuBed> qs = new QueryWrapper<>();
        qs.lambda().in(StuBed::getStuId,ids);
        this.baseMapper.delete(qs);
    }
}
