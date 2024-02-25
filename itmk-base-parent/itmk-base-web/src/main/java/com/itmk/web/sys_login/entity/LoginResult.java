package com.itmk.web.sys_login.entity;

import lombok.Data;

/**
 * @Author java实战基地
 * @Version 3501754007
 */
@Data
public class LoginResult {
    private Long userId;
    private String username;
    private String token;
    private String userType;
}