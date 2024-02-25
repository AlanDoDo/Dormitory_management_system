package com.itmk.web.sys_user.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.itmk.web.sys_user.entity.PageParm;
import com.itmk.web.sys_user.entity.SysUser;

public interface SysUserService extends IService<SysUser> {
    IPage<SysUser> list(PageParm parm);
    //新增
    void add(SysUser user);
    //编辑
    void edit(SysUser user);
}
