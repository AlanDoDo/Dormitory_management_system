package com.itmk.web.school_class.entity;

import lombok.Data;

/**
 * @Author java实战基地
 * @Version 3501754007
 */
@Data
public class AssignClassParm {
    private Long currentPage;
    private Long pageSize;
    private String className;
    private String classYear;
}
