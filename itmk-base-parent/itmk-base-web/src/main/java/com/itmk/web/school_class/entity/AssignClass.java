package com.itmk.web.school_class.entity;

import lombok.Data;

/**
 * @Author Alan
 * @Version 001
 */
@Data
public class AssignClass {
    private Long classId;
    private Long majorId;
    private String className;
    private String classYear;
    private Integer orderNum;
    private Integer stuCount;
    private Integer manCount;
    private Integer girlCount;
}
