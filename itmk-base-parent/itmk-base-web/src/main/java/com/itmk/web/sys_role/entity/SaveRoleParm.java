package com.itmk.web.sys_role.entity;

import lombok.Data;

import java.util.List;

/**
 * @Author java实战基地
 * @Version 3501754007
 */
@Data
public class SaveRoleParm {
    //角色id
    private Long roleId;
    //菜单的id
    private List<Long> list;
}
