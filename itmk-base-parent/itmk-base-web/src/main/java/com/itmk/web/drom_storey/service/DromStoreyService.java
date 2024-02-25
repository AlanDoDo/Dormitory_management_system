package com.itmk.web.drom_storey.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.itmk.web.drom_storey.entity.DromStorey;

import java.util.List;

/**
 * @Author java实战基地
 * @Version 3501754007
 */
public interface DromStoreyService extends IService<DromStorey> {
    //新增
    void addDrom(List<DromStorey> list);
    void add(DromStorey dromStorey);
    void eidt(DromStorey dromStorey);
    void delete(Long buildId,Long storeyId);
    //初始化床位
    void initBed(DromStorey dromStorey);
}
