package com.itmk.web.sys_menu.entity;

import com.itmk.web.sys_menu.entity.RouterVO;
import org.springframework.beans.BeanUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
//生成树的工具类
public class MakeTree {
    public static List<SysMenu> makeMenuTree(List<SysMenu> menuList, Long pid) {
        //定义一个组装树的容器
        List<SysMenu> list = new ArrayList<>();
        Optional.ofNullable(menuList).orElse(new ArrayList<>())
                .stream()
                .filter(item -> item != null && item.getParentId() == pid)
                .forEach(dom -> {
                    SysMenu menu = new SysMenu();
                    BeanUtils.copyProperties(dom, menu);
                    //查询下级菜单，递归调用
                    List<SysMenu> children = makeMenuTree(menuList, dom.getMenuId());
                    menu.setChildren(children);
                    list.add(menu);
                });
        return list;
    }
    //组装路由数据
    public static List<RouterVO> makeRouter(List<SysMenu> menuList,Long pid){
        //定义接收组装数据之后的集合
        List<RouterVO> list = new ArrayList<>();
        //组装数据格式
        Optional.ofNullable(menuList).orElse(new ArrayList<>())
                .stream()
                .filter(item -> item != null && item.getParentId() == pid)
                .forEach(item ->{
                    RouterVO router = new RouterVO();
                    router.setName(item.getName());
                    router.setPath(item.getPath());
                    if(item.getParentId() == 0L){
                        router.setComponent("Layout");
                        router.setAlwaysShow(true);
                    }else{
                        router.setComponent(item.getUrl());
                        router.setAlwaysShow(false);
                    }
                    router.setMeta(router.new Meta(
                            item.getTitle(),
                            item.getIcon(),
                            item.getCode().split(",")
                    ));
                    //查询下级,递归调用：自己调用自己
                    List<RouterVO> children = makeRouter(menuList, item.getMenuId());
                    router.setChildren(children);
                    if(router.getChildren().size() >0){
                        router.setAlwaysShow(true);
                    }
                    list.add(router);
                });

        return list;
    }
}
