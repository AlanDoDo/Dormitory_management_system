package com.itmk.web.drom_look.entity;

import lombok.Data;

/**
 * @Author Alan
 * @Version 001
 */
@Data
public class LookParm {
     private String lookRoom;
    private String userName;
    private Long currentPage;
    private Long pageSize;
}
