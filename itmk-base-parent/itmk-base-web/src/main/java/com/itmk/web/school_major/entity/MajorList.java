package com.itmk.web.school_major.entity;

import lombok.Data;

/**
 * @Author java实战基地
 * @Version 3501754007
 */
@Data
public class MajorList {
    private String majorName;
    private String collageName;
    private Long currentPage;
    private Long pageSize;
}
