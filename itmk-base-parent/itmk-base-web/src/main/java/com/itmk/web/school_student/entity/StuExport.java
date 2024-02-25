package com.itmk.web.school_student.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;
import lombok.Data;

/**
 * @Author java实战基地
 * @Version 2383404558
 */
@Data
public class StuExport {
    @Excel(name = "姓名", orderNum = "1", width=30)
    private String stuName;
    @Excel(name = "性别", replace = {"男_0","女_1"}, orderNum = "3", width=20)
    private String sex;
    @Excel(name = "学号", orderNum = "2", width=30)
    private String stuNum;
    @Excel(name = "身份证号码", orderNum = "3", width=30)
    private String idCard;
    @Excel(name = "电话", orderNum = "4", width=30)
    private String phone;
    @Excel(name = "学院", orderNum = "5", width=30)
    private String collageName;
    @Excel(name = "专业", orderNum = "6", width=30)
    private String majorName;
    @Excel(name = "班级", orderNum = "7", width=30)
    private String className;
    @Excel(name = "床位", orderNum = "8", width=30)
    private String bedCode;
    @Excel(name = "宿舍", orderNum = "9", width=30)
    private String roomCode;
}
