package com.itmk.web.assign_bed.entity;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

/**
 * @Author java实战基地
 * @Version 3501754007
 */
@Data
public class RoomVo {
    private Long roomId;
    private String rootType;
    private String roomCode;
    private List<BedVo> children = new ArrayList<>();
}
