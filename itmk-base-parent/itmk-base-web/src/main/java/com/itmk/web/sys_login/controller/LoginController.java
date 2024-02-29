package com.itmk.web.sys_login.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.google.code.kaptcha.impl.DefaultKaptcha;
import com.itmk.config.jwt.JwtUtils;
import com.itmk.utils.ResultUtils;
import com.itmk.utils.ResultVo;
import com.itmk.web.school_student.entity.SchoolStudent;
import com.itmk.web.school_student.service.SchoolStudentService;
import com.itmk.web.sys_login.entity.LoginParm;
import com.itmk.web.sys_login.entity.LoginResult;
import com.itmk.web.sys_login.entity.UpdatePasswordParm;
import com.itmk.web.sys_login.entity.UserInfo;
import com.itmk.web.sys_menu.entity.MakeTree;
import com.itmk.web.sys_menu.entity.RouterVO;
import com.itmk.web.sys_menu.entity.SysMenu;
import com.itmk.web.sys_menu.service.SysMenuService;
import com.itmk.web.sys_user.entity.SysUser;
import com.itmk.web.sys_user.service.SysUserService;
import io.jsonwebtoken.Claims;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.*;
import sun.misc.BASE64Encoder;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @Author Alan
 * @Version 001
 */
@RestController
@RequestMapping("/api/login")
public class LoginController {
    @Autowired
    private SysUserService sysUserService;
    @Autowired
    private JwtUtils jwtUtils;
    @Autowired
    private SchoolStudentService schoolStudentService;
    @Autowired
    private SysMenuService sysMenuService;
    @Autowired
    private DefaultKaptcha defaultKaptcha;

    //生成验证码
    @PostMapping("/image")
    public ResultVo imageCode(HttpServletRequest request) {
        //生成验证码的文文字
        String text = defaultKaptcha.createText();
        //获取session
        HttpSession session = request.getSession();
        //把生成的验证码放到session里面
        session.setAttribute("code", text);
        //生成图片的格式，返回给前端
        BufferedImage bufferedImage = defaultKaptcha.createImage(text);
        ByteArrayOutputStream outputStream = null;
        try {
            outputStream = new ByteArrayOutputStream();
            ImageIO.write(bufferedImage, "jpg", outputStream);
            BASE64Encoder encoder = new BASE64Encoder();
            String base64 = encoder.encode(outputStream.toByteArray());
            String captchaBase64 = "data:image/jpeg;base64," + base64.replaceAll("\r\n", "");
            ResultVo result = new ResultVo("生成成功", 200, captchaBase64);
            return result;
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (outputStream != null) {
                    outputStream.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    //登录
    @PostMapping("/login")
    public ResultVo login(HttpServletRequest request, @RequestBody LoginParm parm) {
        if (StringUtils.isEmpty(parm.getUsername()) || StringUtils.isEmpty(parm.getPassword()) || StringUtils.isEmpty(parm.getUserType())) {
            return ResultUtils.error("用户名或密码不能为空!");
        }
        //获取前端传递的验证码
        String code = parm.getCode();
        //从session里面获取验证码
        HttpSession session = request.getSession();
        String scode = (String) session.getAttribute("code");
        //判断验证码是否正确
        if (StringUtils.isEmpty(scode)) {
            return ResultUtils.error("验证码过期!");
        }
        if (!scode.equals(code)) {
            return ResultUtils.error("验证码错误!");
        }
        //获取密码
        String password = DigestUtils.md5DigestAsHex(parm.getPassword().getBytes());
        if (parm.getUserType().equals("1")) {
            //构造查询条件
            QueryWrapper<SysUser> query = new QueryWrapper<>();
            query.lambda().eq(SysUser::getUsername, parm.getUsername()).eq(SysUser::getPassword, password);
            SysUser user = sysUserService.getOne(query);
            if (user == null) {
                return ResultUtils.error("用户名或密码错误!");
            }
            //生成token
            Map<String, String> map = new HashMap<>();
            map.put("userId", Long.toString(user.getUserId()));
            map.put("username", user.getUsername());
            String token = jwtUtils.generateToken(map);
            //设置返回值
            LoginResult result = new LoginResult();
            result.setUserId(user.getUserId());
            result.setToken(token);
            result.setUsername(user.getUsername());
            result.setUserType(parm.getUserType());
            return ResultUtils.success("登录成功", result);
        } else {
            //构造查询条件
            QueryWrapper<SchoolStudent> query = new QueryWrapper<>();
            query.lambda().eq(SchoolStudent::getStuNum, parm.getUsername())
                    .eq(SchoolStudent::getPassword, password);
            //查询学生信息
            SchoolStudent student = schoolStudentService.getOne(query);
            if (student == null) {
                return ResultUtils.error("用户名或密码错误!");
            }
            //生成token
            Map<String, String> map = new HashMap<>();
            map.put("userId", Long.toString(student.getStuId()));
            map.put("username", student.getStuName());
            String token = jwtUtils.generateToken(map);
            //设置返回值
            LoginResult result = new LoginResult();
            result.setUserId(student.getStuId());
            result.setToken(token);
            result.setUsername(student.getStuName());
            result.setUserType(parm.getUserType());
            return ResultUtils.success("登录成功", result);
        }

    }

    @PostMapping("/updatePassword")
    public ResultVo updatePassword(@RequestBody UpdatePasswordParm parm, HttpServletRequest request) {
        //获取token
        String userType = parm.getUserType();
        //原密码
        String old = DigestUtils.md5DigestAsHex(parm.getOldPassword().getBytes());
        if (userType.equals("1")) { //管理员
            SysUser user = sysUserService.getById(parm.getUserId());
            //密码对比
            if (!old.equals(user.getPassword())) {
                return ResultUtils.error("原密码错误!");
            }
            SysUser sysReader = new SysUser();
            sysReader.setPassword(DigestUtils.md5DigestAsHex(parm.getPassword().getBytes()));
            sysReader.setUserId(parm.getUserId());
            boolean b = sysUserService.updateById(sysReader);
            if (b) {
                return ResultUtils.success("密码修改成功!");
            }
        } else { // 学生
            SchoolStudent user = schoolStudentService.getById(parm.getUserId());
            if (!user.getPassword().equals(old)) {
                return ResultUtils.error("原密码错误!");
            }
            SchoolStudent sysReader = new SchoolStudent();
            sysReader.setPassword(DigestUtils.md5DigestAsHex(parm.getPassword().getBytes()));
            sysReader.setStuId(parm.getUserId());
            boolean b = schoolStudentService.updateById(sysReader);
            if (b) {
                return ResultUtils.success("密码修改成功!");
            }
        }
        return ResultUtils.error("密码修改失败!");
    }

    @GetMapping("/getInfo")
    public ResultVo getInfo(Long userId, String userType) {
        if (userType.equals("1")) {//管理员
            //查询用户信息
            SysUser user = sysUserService.getById(userId);
            UserInfo userInfo = new UserInfo();
            userInfo.setIntroduction(user.getNickName());
            userInfo.setName(user.getUsername());
            userInfo.setAvatar("https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif");
            //查询用户的权限字段
            List<SysMenu> menuList = null;
            if (user.getIsAdmin().equals("1")) {
                menuList = sysMenuService.list();
            } else {
                menuList = sysMenuService.getMenuByUserId(userId);
            }
            //获取code字段
            List<String> collect = menuList.stream().filter(item -> item != null && item.getCode() != null && StringUtils.isNotEmpty(item.getCode()))
                    .map(item -> item.getCode()).collect(Collectors.toList());
            if (collect.size() == 0) {
                return ResultUtils.error("为分配权限，请联系管理员!");
            }
            String[] array = collect.toArray(new String[collect.size()]);
            //设置用户的权限字段
            userInfo.setRoles(array);
            return ResultUtils.success("查询成功", userInfo);
        } else {
            //查询用户信息
            SchoolStudent user = schoolStudentService.getById(userId);
            UserInfo userInfo = new UserInfo();
            userInfo.setIntroduction(user.getStuName());
            userInfo.setName(user.getStuName());
            userInfo.setAvatar("https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif");
            //查询用户的权限字段
            List<SysMenu> menuList = sysMenuService.getStuMenuByUserId(userId);
            //获取code字段
            List<String> collect = menuList.stream().filter(item -> item != null && item.getCode() != null && StringUtils.isNotEmpty(item.getCode()))
                    .map(item -> item.getCode()).collect(Collectors.toList());
            if (collect.size() == 0) {
                return ResultUtils.error("为分配权限，请联系管理员!");
            }
            String[] array = collect.toArray(new String[collect.size()]);
            //设置用户的权限字段
            userInfo.setRoles(array);
            return ResultUtils.success("查询成功", userInfo);
        }
    }

    //查询菜单
    @GetMapping("/getMenuList")
    public ResultVo getMenuList(Long userId, String userType) {
        //根据用户id查询菜单
        List<SysMenu> menuList = null;
        if (userType.equals("1")) {
            //查询用户信息
            SysUser user = sysUserService.getById(userId);
            if (user.getIsAdmin().equals("1")) {
                menuList = sysMenuService.list();
            } else {
                menuList = sysMenuService.getMenuByUserId(userId);
            }
        } else {
            menuList = sysMenuService.getStuMenuByUserId(userId);
        }
        if (menuList == null || menuList.size() == 0) {
            return ResultUtils.error("暂未分配权限，请联系管理员!");
        }
        //帅选出菜单,类型是 目录和菜单
        List<SysMenu> collect = menuList.stream().filter(item -> item != null && !item.getType().equals("2"))
                .collect(Collectors.toList());
        //组装路由数据
        List<RouterVO> router = MakeTree.makeRouter(collect, 0L);
        return ResultUtils.success("查询成功", router);
    }
}
