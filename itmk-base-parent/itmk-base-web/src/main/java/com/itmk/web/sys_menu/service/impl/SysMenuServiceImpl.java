package com.itmk.web.sys_menu.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.itmk.web.sys_menu.entity.MakeTree;
import com.itmk.web.sys_menu.entity.SysMenu;
import com.itmk.web.sys_menu.mapper.SysMenuMapper;
import com.itmk.web.sys_menu.service.SysMenuService;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

@Service
public class SysMenuServiceImpl extends ServiceImpl<SysMenuMapper, SysMenu> implements SysMenuService {
//    @Autowired
//    private SysMenuMapper sysMenuMapper;

    @Override
    public List<SysMenu> getList() {
        //查询出所有的菜单
        QueryWrapper<SysMenu> query = new QueryWrapper<>();
        query.lambda().orderByAsc(SysMenu::getOrderNum);
        List<SysMenu> menuList = this.baseMapper.selectList(query);
        //组装树
        List<SysMenu> sysMenus = MakeTree.makeMenuTree(menuList, 0L);
        return sysMenus;
    }

    @Override
    public List<SysMenu> getParentList() {
        //查询类型,只查类型为目录和菜单的
        String[] types = {"0","1"};
        //构造查询条件
        QueryWrapper<SysMenu> query = new QueryWrapper<>();
        query.lambda().in(SysMenu::getType,Arrays.asList(types)).orderByAsc(SysMenu::getOrderNum);
        List<SysMenu> menuList = this.baseMapper.selectList(query);
        //构造一个顶级菜单
        SysMenu menu = new SysMenu();
        menu.setMenuId(0L);
        menu.setTitle("顶级菜单");
        menu.setParentId(-1L);
        menuList.add(menu);
        //组装数据
        List<SysMenu> sysMenus = MakeTree.makeMenuTree(menuList, -1L);
        return sysMenus;
    }

    @Override
    public List<SysMenu> getMenuByUserId(Long userId) {
        return this.baseMapper.getMenuByUserId(userId);
    }

    @Override
    public List<SysMenu> getMenuByRoleId(Long roleId) {
        return this.baseMapper.getMenuByRoleId(roleId);
    }

    @Override
    public List<SysMenu> getStuMenuByUserId(Long stuId) {
        return this.baseMapper.getStuMenuByUserId(stuId);
    }
}
