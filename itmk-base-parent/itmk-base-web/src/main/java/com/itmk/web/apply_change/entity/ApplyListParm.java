package com.itmk.web.apply_change.entity;

import lombok.Data;

/**
 * @Author java实战基地
 * @Version 3501754007
 */
@Data
public class ApplyListParm {
    private Long currentPage;
    private Long pageSize;
    private String userType;
    private Long userId;
}
