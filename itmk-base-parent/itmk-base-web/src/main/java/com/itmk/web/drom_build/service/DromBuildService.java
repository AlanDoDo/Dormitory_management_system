package com.itmk.web.drom_build.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.itmk.web.drom_build.entity.BuildEcharts;
import com.itmk.web.drom_build.entity.DromBuild;

/**
 * @Author Alan
 * @Version 001
 */
public interface DromBuildService extends IService<DromBuild> {
    //新增
    void addBuild(DromBuild dromBuild);
    BuildEcharts getListBuild();
}
