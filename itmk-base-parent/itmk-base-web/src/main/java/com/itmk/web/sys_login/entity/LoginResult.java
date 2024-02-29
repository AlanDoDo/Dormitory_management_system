package com.itmk.web.sys_login.entity;

import lombok.Data;

/**
 * @Author Alan
 * @Version 001
 */
@Data
public class LoginResult {
    private Long userId;
    private String username;
    private String token;
    private String userType;
}