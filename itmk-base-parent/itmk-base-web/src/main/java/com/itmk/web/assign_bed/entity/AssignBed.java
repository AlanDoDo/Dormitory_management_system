package com.itmk.web.assign_bed.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * @Author java实战基地
 * @Version 3501754007
 */
@Data
@TableName("assign_bed")
public class AssignBed {
    private Long assignId;
    private Long bedId;
    private Long classId;
}
