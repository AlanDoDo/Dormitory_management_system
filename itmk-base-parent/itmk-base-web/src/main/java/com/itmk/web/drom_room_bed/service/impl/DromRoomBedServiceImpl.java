package com.itmk.web.drom_room_bed.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.itmk.web.drom_room_bed.entity.DromRoomBed;
import com.itmk.web.drom_room_bed.entity.DromRoomVo;
import com.itmk.web.drom_room_bed.mapper.DromRoomBedMapper;
import com.itmk.web.drom_room_bed.service.DromRoomBedService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author java实战基地
 * @Version 3501754007
 */
@Service
public class DromRoomBedServiceImpl extends ServiceImpl<DromRoomBedMapper, DromRoomBed> implements DromRoomBedService {
    @Override
    public List<DromRoomBed> getBedList(Long roomId) {
        return this.baseMapper.getBedList(roomId);
    }

    @Override
    public List<DromRoomVo> getSelectBedList(Long roomId) {
        return this.baseMapper.getSelectBedList(roomId);
    }
}
