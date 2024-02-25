package com.itmk.web.dorm_room.entity;

import lombok.Data;

/**
 * @Author java实战基地
 * @Version 3501754007
 */
@Data
public class RoomListParm {
    private Long currentPage;
    private Long pageSize;
    private Long storeyId;
}
