package com.itmk.web.dorm_room.entity;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

/**
 * @Author java实战基地
 * @Version 3501754007
 */
@Data
public class RoomTree {
    private Long roomId;
    private String roomCode;
    private String type; //用来区分是宿舍还是 床位  1：宿舍  0：床位
    private List<RoomTree> children = new ArrayList<>();
}
