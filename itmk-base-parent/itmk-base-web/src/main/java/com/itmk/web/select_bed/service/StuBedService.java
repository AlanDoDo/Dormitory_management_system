package com.itmk.web.select_bed.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.itmk.web.select_bed.entity.ChangeStu;
import com.itmk.web.select_bed.entity.StuBed;
import com.itmk.web.select_bed.entity.StuBedVo;

import java.util.List;

/**
 * @Author Alan
 * @Version 001
 */
public interface StuBedService extends IService<StuBed> {
    List<StuBedVo> getStuBedList(Long stuId);
    List<ChangeStu> getStuList(Long classId);
    void clearBed(Long classId);
}
