package com.itmk.web.sys_role_menu.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.itmk.web.sys_role_menu.entity.SysRoleMenu;

import java.util.List;

/**
 * @Author java实战基地
 * @Version 3501754007
 */
public interface SysRoleMenuService extends IService<SysRoleMenu> {
    void saveRoleMenu(Long roleId, List<Long> menuIds);
}
