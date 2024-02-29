package com.itmk.web.drom_leave.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

/**
 * @Author Alan
 * @Version 001
 */
@Data
public class DromLeave {
    @TableId(type = IdType.AUTO)
    private Long leaveId;
    private String classes;
    private String stuName;
    private String dromName;
    private String leaveTime;
}
