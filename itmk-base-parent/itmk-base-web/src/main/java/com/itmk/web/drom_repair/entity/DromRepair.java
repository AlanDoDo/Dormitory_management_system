package com.itmk.web.drom_repair.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.Date;

/**
 * @Author java实战基地
 * @Version 3501754007
 */
@Data
@TableName("drom_repair")
public class DromRepair {
    @TableId(type = IdType.AUTO)
    private Long repairId;
    private String username;
    private String phone;
    private String dromName;
    private String repairText;
    private String status; //0 ： 待维修 1： 已维修
    private Date repairTime;
}
