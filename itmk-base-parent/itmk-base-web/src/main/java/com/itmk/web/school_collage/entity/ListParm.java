package com.itmk.web.school_collage.entity;

import lombok.Data;

/**
 * @Author java实战基地
 * @Version 3501754007
 */
@Data
public class ListParm {
    private Long currentPage;
    private Long pageSize;
    private String collageName;
}
