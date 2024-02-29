package com.itmk.web.sys_login.entity;

import lombok.Data;

/**
 * @Author Alan
 * @Version 001
 */
@Data
public class LoginParm {
    private String username;
    private String password;
    private String userType;
    private String code;
}