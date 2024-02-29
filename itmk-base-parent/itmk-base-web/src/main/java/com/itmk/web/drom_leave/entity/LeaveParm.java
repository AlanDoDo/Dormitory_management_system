package com.itmk.web.drom_leave.entity;

import lombok.Data;

/**
 * @Author Alan
 * @Version 001
 */
@Data
public class LeaveParm {
    private String classes;
    private String stuName;
    private String dromName;
    private Long currentPage;
    private Long pageSize;
}
