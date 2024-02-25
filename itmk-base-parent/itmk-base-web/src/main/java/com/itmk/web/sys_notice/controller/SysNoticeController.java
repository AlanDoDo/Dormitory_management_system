package com.itmk.web.sys_notice.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.itmk.utils.ResultUtils;
import com.itmk.utils.ResultVo;
import com.itmk.utils.Utils;
import com.itmk.web.sys_notice.entity.NoticeParm;
import com.itmk.web.sys_notice.entity.SysNotice;
import com.itmk.web.sys_notice.service.SysNoticeService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

/**
 * @Author java实战基地
 * @Version 3501754007
 */
@RestController
@RequestMapping("/api/notice")
public class SysNoticeController {
    @Autowired
    private SysNoticeService sysNoticeService;
    //新增
    @PostMapping
    public ResultVo add(@RequestBody SysNotice sysNotice){
        sysNotice.setCreateTime(new Date());
        boolean save = sysNoticeService.save(sysNotice);
        if(save){
            return ResultUtils.success("新增成功");
        }
        return ResultUtils.error("新增失败!");
    }
    //编辑
    @PutMapping
    public ResultVo edit(@RequestBody SysNotice sysNotice){
        boolean save = sysNoticeService.updateById(sysNotice);
        if(save){
            return ResultUtils.success("编辑成功");
        }
        return ResultUtils.error("编辑失败!");
    }

    //删除
    @DeleteMapping("/{noticeId}")
    public ResultVo delete(@PathVariable("noticeId") Long noticeId){
        boolean b = sysNoticeService.removeById(noticeId);
        if(b){
            return ResultUtils.success("删除成功");
        }
        return ResultUtils.error("删除失败!");
    }
    //列表查询
    @GetMapping("/list")
    public ResultVo list(NoticeParm parm){
        //构造分页对象
        IPage<SysNotice> page = new Page<>(parm.getCurrentPage(),parm.getPageSize());
        //查询条件
        QueryWrapper<SysNotice> query = new QueryWrapper<>();
        if(StringUtils.isNotEmpty(parm.getNoticeTitle())){
            query.lambda().like(SysNotice::getNoticeTitle,parm.getNoticeTitle());
        }
        query.lambda().orderByDesc(SysNotice::getCreateTime);
        IPage<SysNotice> list = sysNoticeService.page(page, query);
        list.getRecords().stream().forEach(item ->{
            if(item.getTypes().equals("1")){
                String content = item.getNoticeText();
                String first = content.substring(0, content.indexOf("+"));

                //截切第二个+之后的内容
                int index = content.indexOf("+");
                int second = content.indexOf("+",index+1);
                String snum = content.substring(index+1,second);
                String newtext = content.substring(second+1);
                String newContent = Utils.subName(first) + "," + Utils.subNum(snum) + "," + newtext;
                item.setNoticeText(newContent);
            }
        });
        return ResultUtils.success("查询成功",list);
    }
    //首页公告
    @GetMapping("/getTopList")
    public ResultVo getTopList(){
        QueryWrapper<SysNotice> query = new QueryWrapper<>();
        query.lambda().orderByDesc(SysNotice::getCreateTime).last("limit 3");
        List<SysNotice> list = sysNoticeService.list(query);
        list.stream().forEach(item ->{
            if(item.getTypes().equals("1")){
                String content = item.getNoticeText();
                String first = content.substring(0, content.indexOf("+"));

                //截切第二个+之后的内容
                int index = content.indexOf("+");
                int second = content.indexOf("+",index+1);
                String snum = content.substring(index+1,second);
                String newtext = content.substring(second+1);
                String newContent = Utils.subName(first) + "," + Utils.subNum(snum) + "," + newtext;
                item.setNoticeText(newContent);
            }
        });
        return ResultUtils.success("查询成功",list);
    }

    //根据id查询
    @GetMapping("/getById")
    public ResultVo getById(Long noticeId){
        SysNotice notice = sysNoticeService.getById(noticeId);
        return ResultUtils.success("查询成功",notice);
    }
}
