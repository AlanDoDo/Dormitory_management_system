package com.itmk.web.sys_role.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.itmk.utils.ResultUtils;
import com.itmk.utils.ResultVo;
import com.itmk.web.sys_role.entity.*;
import com.itmk.web.sys_role.service.SysRoleService;
import com.itmk.web.sys_role_menu.service.SysRoleMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

@RestController
@RequestMapping("/api/role")
public class SysRoleController {
    @Autowired
    private SysRoleService sysRoleService;
    @Autowired
    private SysRoleMenuService sysRoleMenuService;
    //新增
    @PostMapping
    public ResultVo addRole(@RequestBody SysRole role){
        role.setCreateTime(new Date());
        boolean save = sysRoleService.save(role);
        if(save){
            return ResultUtils.success("新增角色成功!");
        }
        return ResultUtils.error("新增角色失败!");
    }

    //编辑
    @PutMapping
    public ResultVo editRole(@RequestBody SysRole role){
        role.setUpdateTime(new Date());
        boolean save = sysRoleService.updateById(role);
        if(save){
            return ResultUtils.success("编辑角色成功!");
        }
        return ResultUtils.error("编辑角色失败!");
    }

    //删除
    @DeleteMapping("/{roleId}")
    public ResultVo deleteRole(@PathVariable("roleId") Long roleId){
        boolean remove = sysRoleService.removeById(roleId);
        if(remove){
            return ResultUtils.success("删除成功");
        }
        return ResultUtils.error("删除失败!");
    }

    //角色列表
    @GetMapping("/list")
    public ResultVo getList(RoleParm parm){
        IPage<SysRole> list = sysRoleService.list(parm);
        return ResultUtils.success("查询成功",list);
    }

    //分配权限回显
    @GetMapping("/getAssingShow")
    public ResultVo getAssingShow(AssignParm parm){
        AssignVo show = sysRoleService.getAssignShow(parm);
        return ResultUtils.success("查询成功",show);
    }

    @PostMapping("/saveRoleMenu")
    public ResultVo saveRoleMenu(@RequestBody SaveRoleParm parm){
        sysRoleMenuService.saveRoleMenu(parm.getRoleId(),parm.getList());
        return ResultUtils.success("分配权限成功!");
    }
}
