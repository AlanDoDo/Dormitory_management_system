package com.itmk.web.stu_role.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * @Author java实战基地
 * @Version 3501754007
 */
@Data
@TableName("stu_role")
public class StuRole {
    @TableId(type = IdType.AUTO)
    private Long stuRoleId;
    private Long stuId;
    private Long roleId;
}
