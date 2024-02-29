package com.itmk.web.dorm_room.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.itmk.web.dorm_room.entity.DormRoom;
import com.itmk.web.dorm_room.entity.RoomTree;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author Alan
 * @Version 001
 */
public interface DormRoomMapper extends BaseMapper<DormRoom> {
     List<RoomTree> getRoomTree(@Param("storeyId") Long storeyId);
}
