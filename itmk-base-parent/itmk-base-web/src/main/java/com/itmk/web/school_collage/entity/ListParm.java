package com.itmk.web.school_collage.entity;

import lombok.Data;

/**
 * @Author Alan
 * @Version 001
 */
@Data
public class ListParm {
    private Long currentPage;
    private Long pageSize;
    private String collageName;
}
