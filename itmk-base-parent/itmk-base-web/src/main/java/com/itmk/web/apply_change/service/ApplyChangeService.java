package com.itmk.web.apply_change.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.itmk.web.apply_change.entity.ApplyChange;
import com.itmk.web.apply_change.entity.ApplyDoParm;
import com.itmk.web.apply_change.entity.ApplyParm;

/**
 * @Author Alan
 * @Version 001
 */
public interface ApplyChangeService extends IService<ApplyChange> {
     void applySave(ApplyParm parm);
     void applyDo(ApplyDoParm change);
}
