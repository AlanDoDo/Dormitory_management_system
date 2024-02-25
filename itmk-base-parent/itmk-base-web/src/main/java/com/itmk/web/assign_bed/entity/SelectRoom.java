package com.itmk.web.assign_bed.entity;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

/**
 * @Author java实战基地
 * @Version 3501754007
 */
@Data
public class SelectRoom {
    private Long roomId;
    private Long classId;
    private String roomCode;
    private String rootType;
    private String className;
    private List<SelectBed> children = new ArrayList<>();
}
