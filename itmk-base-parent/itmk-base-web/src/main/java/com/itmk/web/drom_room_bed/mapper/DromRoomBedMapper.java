package com.itmk.web.drom_room_bed.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.itmk.web.drom_room_bed.entity.DromRoomBed;
import com.itmk.web.drom_room_bed.entity.DromRoomVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author java实战基地
 * @Version 3501754007
 */
public interface DromRoomBedMapper extends BaseMapper<DromRoomBed> {
     List<DromRoomBed> getBedList(@Param("roomId") Long roomId);
     List<DromRoomVo> getSelectBedList(@Param("roomId") Long roomId);
}
