package com.itmk.web.assign_bed.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * @Author Alan
 * @Version 001
 */
@Data
@TableName("assign_bed")
public class AssignBed {
    private Long assignId;
    private Long bedId;
    private Long classId;
}
