package com.itmk.web.sys_notice.entity;

import lombok.Data;

/**
 * @Author Alan
 * @Version 001
 */
@Data
public class NoticeParm {
    private Long currentPage;
    private Long pageSize;
    private String noticeTitle;
}
