package com.itmk.web.school_student.entity;

import lombok.Data;

/**
 * @Author java实战基地
 * @Version 3501754007
 */
@Data
public class StuParm {
    private String classId;
    private String collageId;
    private String majorId;
    private String stuName;
    private String className;
    private String majorName;
    private String collageName;
    private Long currentPage;
    private Long pageSize;
}
