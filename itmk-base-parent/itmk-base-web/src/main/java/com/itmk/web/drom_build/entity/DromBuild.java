package com.itmk.web.drom_build.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.itmk.web.drom_storey.entity.DromStorey;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

/**
 * @Author Alan
 * @Version 001
 */
@Data
@TableName("drom_build")
public class DromBuild {
    @TableId(type = IdType.AUTO)
    private Long buildId;
    private Long userId;
    private Long buildStorey;
    private String sex;
    private String buildName;
    private Integer orderNum;
    //楼栋对应的层数
    @TableField(exist = false)
    private List<DromStorey> storeys = new ArrayList<>();
}
