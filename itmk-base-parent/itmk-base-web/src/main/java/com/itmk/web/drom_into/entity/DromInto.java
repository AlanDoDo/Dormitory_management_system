package com.itmk.web.drom_into.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * @Author Alan
 * @Version 001
 */
@Data
@TableName("drom_into")
public class DromInto {
    @TableId(type = IdType.AUTO)
    private Long intoId;
    private String intoTime;
    private String name;
    private String intoText;
    private String userName;
    private String phone;
    private String leader;
    private String status;
}
