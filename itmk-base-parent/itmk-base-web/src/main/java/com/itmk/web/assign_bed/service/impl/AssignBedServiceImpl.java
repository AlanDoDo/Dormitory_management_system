package com.itmk.web.assign_bed.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.itmk.web.assign_bed.entity.*;
import com.itmk.web.assign_bed.mapper.AssignBedMapper;
import com.itmk.web.assign_bed.service.AssignBedService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author java实战基地
 * @Version 3501754007
 */
@Service
public class AssignBedServiceImpl extends ServiceImpl<AssignBedMapper, AssignBed> implements AssignBedService {
    @Override
    public List<RoomVo> getRoomVoList(Long classId) {
        return this.baseMapper.getRoomVoList(classId);
    }

    @Override
    public List<BedVo> getBedVoList(Long roomId) {
        return this.baseMapper.getBedVoList(roomId);
    }

    @Override
    public List<SelectRoom> getRoomByClassId(Long classId) {
        return this.baseMapper.getRoomByClassId(classId);
    }

    @Override
    public List<SelectBed> getBedByClassId(Long classId, Long roomId) {
        return this.baseMapper.getBedByClassId(classId,roomId);
    }
}
