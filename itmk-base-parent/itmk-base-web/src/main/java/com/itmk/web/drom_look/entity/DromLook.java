package com.itmk.web.drom_look.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * @Author Alan
 * @Version 001
 */
@Data
@TableName("drom_look")
public class DromLook {
    @TableId(type = IdType.AUTO)
    private Long lookId;
    private String lookTime;
    private String userName;
    private String phone;
    private String lookName;
    private String lookRoom;
    private String leader;
    private String lookText;
}
