package com.itmk.web.apply_change.entity;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * @Author Alan
 * @Version 001
 */
@Data
@TableName("apply_change")
public class ApplyChange {
    @TableId(type = IdType.AUTO)
    private Long applyId;
    private Long applyUserId;
    private Long applyBedId;
    private Long changeUserId;
    private Long changeBedId;
    private String applyUserName;
    private String applyBedCode;
    private String changeUserName;
    private String changeBedCode;
    private String status;
}
