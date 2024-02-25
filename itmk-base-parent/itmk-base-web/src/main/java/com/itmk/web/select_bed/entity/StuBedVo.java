package com.itmk.web.select_bed.entity;

import lombok.Data;

/**
 * @Author java实战基地
 * @Version 3501754007
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
