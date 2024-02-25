package com.itmk.web.sys_user.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.itmk.utils.ResultUtils;
import com.itmk.utils.ResultVo;
import com.itmk.web.sys_role.entity.SysRole;
import com.itmk.web.sys_role.service.SysRoleService;
import com.itmk.web.sys_user.entity.PageParm;
import com.itmk.web.sys_user.entity.SysUser;
import com.itmk.web.sys_user.service.SysUserService;
import com.itmk.web.sys_user_role.entity.SysUserRole;
import com.itmk.web.sys_user_role.service.SysUserRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/api/user")
public class SysUserController {
    @Autowired
    private SysUserService sysUserService;
    @Autowired
    private SysRoleService sysRoleService;
    @Autowired
    private SysUserRoleService sysUserRoleService;

    //新增用户
    @PostMapping
    public ResultVo addUser(@RequestBody SysUser user) {
        //判断账户是否被占用
        QueryWrapper<SysUser> query = new QueryWrapper<>();
        query.lambda().eq(SysUser::getUsername, user.getUsername());
        SysUser one = sysUserService.getOne(query);
        if (one != null) {
            return ResultUtils.error("账户被占用!");
        }
        user.setIsAdmin("0");
        user.setCreateTime(new Date());
        user.setPassword(DigestUtils.md5DigestAsHex(user.getPassword().getBytes()));
        //入库处理
        sysUserService.add(user);
        return ResultUtils.success("新增用户成功!");
    }

    //编辑用户
    @PutMapping
    public ResultVo editUser(@RequestBody SysUser user) {
        //判断账户是否被占用
        QueryWrapper<SysUser> query = new QueryWrapper<>();
        query.lambda().eq(SysUser::getUsername, user.getUsername());
        SysUser one = sysUserService.getOne(query);
        if (one != null && one.getUserId() != user.getUserId()) {
            return ResultUtils.error("账户被占用!");
        }
        user.setUpdateTime(new Date());
        //更新处理
        sysUserService.edit(user);
        return ResultUtils.success("编辑用户成功!");
    }

    //删除用户
    @DeleteMapping("/{userId}")
    public ResultVo deleteUser(@PathVariable("userId") Long userId) {
        boolean remove = sysUserService.removeById(userId);
        if (remove) {
            return ResultUtils.success("删除成功!");
        }
        return ResultUtils.error("删除失败!");
    }

    //列表查询
    @GetMapping("/list")
    public ResultVo getList(PageParm parm) {
        IPage<SysUser> list = sysUserService.list(parm);
        //密码不显示
        list.getRecords().stream().forEach(item -> {
            item.setPassword("");
        });
        return ResultUtils.success("查询成功", list);
    }

    //查询角色列表
    @GetMapping("/roleList")
    public ResultVo getRoleList(){
        List<SysRole> list = sysRoleService.list();
        return ResultUtils.success("查询成功",list);
    }

    //查询用户对应的角色
    @GetMapping("/getRoleByUserId")
    public ResultVo getRoleByUserId(Long userId){
        QueryWrapper<SysUserRole> query = new QueryWrapper<>();
        query.lambda().eq(SysUserRole::getUserId,userId);
        SysUserRole one = sysUserRoleService.getOne(query);
        return ResultUtils.success("查询成功",one);
    }
}
