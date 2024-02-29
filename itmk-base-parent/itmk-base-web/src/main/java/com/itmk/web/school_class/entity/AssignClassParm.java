package com.itmk.web.school_class.entity;

import lombok.Data;

/**
 * @Author Alan
 * @Version 001
 */
@Data
public class AssignClassParm {
    private Long currentPage;
    private Long pageSize;
    private String className;
    private String classYear;
}
