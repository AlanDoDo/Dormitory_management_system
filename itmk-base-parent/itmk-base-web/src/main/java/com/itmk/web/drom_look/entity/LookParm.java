package com.itmk.web.drom_look.entity;

import lombok.Data;

/**
 * @Author java实战基地
 * @Version 3501754007
 */
@Data
public class LookParm {
     private String lookRoom;
    private String userName;
    private Long currentPage;
    private Long pageSize;
}
