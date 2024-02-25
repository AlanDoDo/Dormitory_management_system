package com.itmk.web.sys_login.entity;

import lombok.Data;

/**
 * @Author java实战基地
 * @Version 2383404558
 */
@Data
public class UpdatePasswordParm {
     private Long userId;
    private String oldPassword;
    private String password;
    private String userType;
}
