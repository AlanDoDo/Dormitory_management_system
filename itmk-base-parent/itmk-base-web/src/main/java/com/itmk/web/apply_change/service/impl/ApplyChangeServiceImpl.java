package com.itmk.web.apply_change.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.itmk.web.apply_change.entity.ApplyChange;
import com.itmk.web.apply_change.entity.ApplyDoParm;
import com.itmk.web.apply_change.entity.ApplyParm;
import com.itmk.web.apply_change.entity.StuInfoVo;
import com.itmk.web.apply_change.mapper.ApplyChangeMapper;
import com.itmk.web.apply_change.service.ApplyChangeService;
import com.itmk.web.select_bed.entity.StuBed;
import com.itmk.web.select_bed.service.StuBedService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @Author Alan
 * @Version 001
 */
@Service
public class ApplyChangeServiceImpl extends ServiceImpl<ApplyChangeMapper, ApplyChange> implements ApplyChangeService {
    @Autowired
    private StuBedService  stuBedService;
    @Override
    public void applySave(ApplyParm parm) {
        ApplyChange changeStu = new ApplyChange();
        //查询申请人的信息
        StuInfoVo stuInfo = this.baseMapper.getStuInfo(parm.getApplyId());
        changeStu.setApplyUserId(stuInfo.getStuId());
        changeStu.setApplyBedId(stuInfo.getBedId());
        changeStu.setApplyBedCode(stuInfo.getBedCode());
        changeStu.setApplyUserName(stuInfo.getStuName());
        //查询调换人的信息
        StuInfoVo change = this.baseMapper.getStuInfo(parm.getChangeId());
        changeStu.setChangeBedCode(change.getBedCode());
        changeStu.setChangeBedId(change.getBedId());
        changeStu.setChangeUserId(change.getStuId());
        changeStu.setChangeUserName(change.getStuName());
        changeStu.setStatus("0"); //待审核
        this.baseMapper.insert(changeStu);
    }

    @Override
    @Transactional
    public void applyDo(ApplyDoParm change) {
        //查询申请信息
        ApplyChange select = this.baseMapper.selectById(change.getApplyId());
        if(change.getType().equals("1")){
            //更新审核的状态
            ApplyChange apply = new ApplyChange();
            apply.setApplyId(change.getApplyId());
            apply.setStatus("1");
            int i = this.baseMapper.updateById(apply);
            if(i>0){
               //更换床位
                //1.申请人信息
                Long applyUserId = select.getApplyUserId();
                Long applyBedId = select.getApplyBedId();
                //2.跟换人信息
                Long changeUserId = select.getChangeUserId();
                Long changeBedId = select.getChangeBedId();
                //申请人
                StuBed applyBed = new StuBed();
                applyBed.setStuId(applyUserId);
                applyBed.setBedId(changeBedId);
                //调换人
                StuBed changeBed = new StuBed();
                changeBed.setStuId(changeUserId);
                changeBed.setBedId(applyBedId);
                //删除原来的
                QueryWrapper<StuBed> applyQuery = new QueryWrapper<>();
                applyQuery.lambda().eq(StuBed::getStuId,applyUserId);
                stuBedService.remove(applyQuery);
                QueryWrapper<StuBed> changeQuery = new QueryWrapper<>();
                changeQuery.lambda().eq(StuBed::getStuId,changeUserId);
                stuBedService.remove(changeQuery);
                stuBedService.save(applyBed);
                stuBedService.save(changeBed);
            }
        }else {
            //更新审核的状态
            ApplyChange apply = new ApplyChange();
            apply.setApplyId(change.getApplyId());
            apply.setStatus("2");
            this.baseMapper.updateById(apply);
        }
    }
}
