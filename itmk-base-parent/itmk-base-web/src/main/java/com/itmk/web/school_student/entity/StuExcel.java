package com.itmk.web.school_student.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;
import lombok.Data;

/**
 * @Author java实战基地
 * @Version 2383404558
 */
@Data
public class StuExcel {
    @Excel(name = "学生角色id", orderNum = "1", width=30)
    private Long roleId;
    @Excel(name = "姓名", orderNum = "2", width=30)
    private String stuName;
    @Excel(name = "性别(0:男1:女)", replace = {"男_0","女_1"}, orderNum = "3", width=20)
    private String sex;
    @Excel(name = "学号", orderNum = "4", width=30)
    private String stuNum;
    @Excel(name = "身份证号码", orderNum = "5", width=30)
    private String idCard;
    @Excel(name = "电话", orderNum = "6", width=30)
    private String phone;
}