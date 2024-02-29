package com.itmk.web.apply_change.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.itmk.utils.ResultUtils;
import com.itmk.utils.ResultVo;
import com.itmk.web.apply_change.entity.ApplyChange;
import com.itmk.web.apply_change.entity.ApplyDoParm;
import com.itmk.web.apply_change.entity.ApplyListParm;
import com.itmk.web.apply_change.entity.ApplyParm;
import com.itmk.web.apply_change.service.ApplyChangeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * @Author Alan
 * @Version 001
 */
@RestController
@RequestMapping("/api/applyChange")
public class ApplyChangeController {
    @Autowired
    private ApplyChangeService applyChangeService;

    //保存申请
    @PostMapping("/applySave")
    public ResultVo applySave(@RequestBody ApplyParm parm) {
        //查询该学生是否已经申请
        QueryWrapper<ApplyChange> query = new QueryWrapper<>();
        query.lambda().eq(ApplyChange::getApplyUserId, parm.getApplyId())
                .eq(ApplyChange::getStatus, "0");
        ApplyChange one = applyChangeService.getOne(query);
        if (one != null) {
            return ResultUtils.error("您已经提交申请，不重复提交!");
        }
        applyChangeService.applySave(parm);
        return ResultUtils.success("申请成功!");
    }

    //列表查询
    @GetMapping("/getList")
    public ResultVo getList(ApplyListParm parm) {
        IPage<ApplyChange> page = new Page<>(parm.getCurrentPage(), parm.getPageSize());
        if (parm.getUserType().equals("0")) {
            QueryWrapper<ApplyChange> query = new QueryWrapper<>();
            query.lambda().eq(ApplyChange::getApplyUserId, parm.getUserId());
            IPage<ApplyChange> list = applyChangeService.page(page, query);
            return ResultUtils.success("查询成功", list);
        } else {
            IPage<ApplyChange> list = applyChangeService.page(page);
            return ResultUtils.success("查询成功", list);
        }
    }

    @PostMapping("/applyDo")
    public ResultVo applyDo(@RequestBody ApplyDoParm change) {
        if(change.getUserType().equals("0")){
            return ResultUtils.error("您无权限操作!");
        }
        applyChangeService.applyDo(change);
        return ResultUtils.success("操作成功");
    }
}
