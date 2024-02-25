package com.itmk.web.drom_leave.entity;

import lombok.Data;

/**
 * @Author java实战基地
 * @Version 3501754007
 */
@Data
public class LeaveParm {
    private String classes;
    private String stuName;
    private String dromName;
    private Long currentPage;
    private Long pageSize;
}
