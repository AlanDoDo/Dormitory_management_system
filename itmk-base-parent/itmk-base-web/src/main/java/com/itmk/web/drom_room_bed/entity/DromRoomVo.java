package com.itmk.web.drom_room_bed.entity;

import lombok.Data;

/**
 * @Author Alan
 * @Version 001
 */
@Data
public class DromRoomVo {
    private Long bedId;
    private Long roomId;
    private Long stuId;
    private String bedCode;
    private String stuName;
    private String className;
}
