package com.itmk.web.assign_bed.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.itmk.web.assign_bed.entity.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author Alan
 * @Version 001
 */
public interface AssignBedMapper extends BaseMapper<AssignBed> {
     //根据班级id查询分配的宿舍
    List<RoomVo> getRoomVoList(@Param("classId") Long classId);
    //根据宿舍id查询床位
    List<BedVo> getBedVoList(@Param("roomId") Long roomId);
    //根据班级id查询分配的宿舍
    List<SelectRoom> getRoomByClassId(@Param("classId") Long classId);
    //查询床位
    List<SelectBed> getBedByClassId(@Param("classId") Long classId, @Param("roomId") Long roomId);
}
