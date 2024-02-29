package com.itmk.web.dorm_room.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.itmk.web.dorm_room.entity.DormRoom;
import com.itmk.web.dorm_room.entity.RoomTree;

import java.util.List;

/**
 * @Author Alan
 * @Version 001
 */
public interface DormRoomService extends IService<DormRoom> {
     List<RoomTree> getRoomTree(Long storeyId);
}
