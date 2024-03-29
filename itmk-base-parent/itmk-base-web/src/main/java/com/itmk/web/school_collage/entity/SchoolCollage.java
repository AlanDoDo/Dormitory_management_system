package com.itmk.web.school_collage.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.Date;

/**
 * @Author Alan
 * @Version 001
 */
@Data
@TableName("school_collage")
public class SchoolCollage {
    @TableId(type = IdType.AUTO)
    private Long collageId;
    private String collageName;
    private Integer orderNum;
    private Date createTime;
}
