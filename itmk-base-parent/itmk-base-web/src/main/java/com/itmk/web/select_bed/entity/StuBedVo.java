package com.itmk.web.select_bed.entity;

import lombok.Data;

/**
 * @Author Alan
 * @Version 001
 */
@Data
public class StuBedVo {
    private Long stuId;
    private Long bedId;
    private Long roomId;
    private String roomCode;
    private String rootType;
    private String bedCode;
    private String storeyName;
    private String buildName;
    private String stuName;
    private String className;
}
