package com.itmk.web.drom_room_bed.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.itmk.web.drom_room_bed.entity.DromRoomBed;
import com.itmk.web.drom_room_bed.entity.DromRoomVo;

import java.util.List;

/**
 * @Author Alan
 * @Version 001
 */
public interface DromRoomBedService extends IService<DromRoomBed> {
     List<DromRoomBed> getBedList(Long roomId);
      List<DromRoomVo> getSelectBedList(Long roomId);
}
