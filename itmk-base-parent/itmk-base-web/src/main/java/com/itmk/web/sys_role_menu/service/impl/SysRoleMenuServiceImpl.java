package com.itmk.web.sys_role_menu.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.itmk.web.sys_role_menu.entity.SysRoleMenu;
import com.itmk.web.sys_role_menu.mapper.SysRoleMenuMapper;
import com.itmk.web.sys_role_menu.service.SysRoleMenuService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @Author Alan
 * @Version 001
 */
@Service
public class SysRoleMenuServiceImpl extends ServiceImpl<SysRoleMenuMapper, SysRoleMenu> implements SysRoleMenuService {

    @Override
    @Transactional
    public void saveRoleMenu(Long roleId, List<Long> menuIds) {
        //思路：先删除角色原来id，重新插入
        QueryWrapper<SysRoleMenu> qeury = new QueryWrapper<>();
        qeury.lambda().eq(SysRoleMenu::getRoleId,roleId);
        //删除
        this.baseMapper.delete(qeury);
        //插入
        this.baseMapper.saveRoleMenu(roleId,menuIds);
    }
}
