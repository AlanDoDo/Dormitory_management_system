package com.itmk.web.apply_change.entity;

import lombok.Data;

/**
 * @Author Alan
 * @Version 001
 */
@Data
public class ApplyListParm {
    private Long currentPage;
    private Long pageSize;
    private String userType;
    private Long userId;
}
