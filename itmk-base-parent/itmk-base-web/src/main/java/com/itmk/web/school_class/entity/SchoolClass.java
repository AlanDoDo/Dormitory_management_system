package com.itmk.web.school_class.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * @Author java实战基地
 * @Version 3501754007
 */
@Data
@TableName("school_class")
public class SchoolClass {
    @TableId(type = IdType.AUTO)
    private Long classId;
    private Long majorId;
    @TableField(exist = false)
    private Long collageId;
    private String className;
    @TableField(exist = false)
    private String majorName;
    @TableField(exist = false)
    private String collageName;
    private String classYear;
    private Integer orderNum;
}
