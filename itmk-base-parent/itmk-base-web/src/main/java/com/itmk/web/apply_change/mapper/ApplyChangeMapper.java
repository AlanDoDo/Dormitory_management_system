package com.itmk.web.apply_change.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.itmk.web.apply_change.entity.ApplyChange;
import com.itmk.web.apply_change.entity.StuInfoVo;
import org.apache.ibatis.annotations.Param;

/**
 * @Author Alan
 * @Version 001
 */
public interface ApplyChangeMapper extends BaseMapper<ApplyChange> {
    StuInfoVo getStuInfo(@Param("stuId") Long stuId);
}
