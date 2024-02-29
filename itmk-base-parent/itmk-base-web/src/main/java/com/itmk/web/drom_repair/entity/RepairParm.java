package com.itmk.web.drom_repair.entity;

import lombok.Data;

/**
 * @Author Alan
 * @Version 001
 */
@Data
public class RepairParm {
    private String dromName;
    private Long currentPage;
    private Long pageSize;
}
