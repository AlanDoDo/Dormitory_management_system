package com.itmk.web.sys_login.entity;

import lombok.Data;

/**
 * @Author Alan
 * @Version 001
 */
@Data
public class UpdatePasswordParm {
     private Long userId;
    private String oldPassword;
    private String password;
    private String userType;
}
