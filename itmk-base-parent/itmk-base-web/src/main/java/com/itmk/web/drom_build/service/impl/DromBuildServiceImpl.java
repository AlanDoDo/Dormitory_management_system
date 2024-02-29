package com.itmk.web.drom_build.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.itmk.web.drom_build.entity.BuildEcharts;
import com.itmk.web.drom_build.entity.BuildVo;
import com.itmk.web.drom_build.entity.DromBuild;
import com.itmk.web.drom_build.mapper.DromBuildMapper;
import com.itmk.web.drom_build.service.DromBuildService;
import com.itmk.web.drom_storey.entity.DromStorey;
import com.itmk.web.drom_storey.service.DromStoreyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * @Author Alan
 * @Version 001
 */
@Service
public class DromBuildServiceImpl extends ServiceImpl<DromBuildMapper, DromBuild> implements DromBuildService {
    @Autowired
    private DromStoreyService dromStoreyService;

    @Override
    @Transactional
    public void addBuild(DromBuild dromBuild) {
        //新增栋数
        int insert = this.baseMapper.insert(dromBuild);
        //新增层数
        if (insert > 0) {
            String[] storey = {"一层", "二层", "三层", "四层", "五层", "六层", "七层", "八层", "九层", "十层", "十一层", "十二层"};
            //存放构建的层数
            List<DromStorey> list = new ArrayList<>();
            for (int i = 0; i < dromBuild.getBuildStorey(); i++) {
                DromStorey dromStorey = new DromStorey();
                dromStorey.setBuildId(dromBuild.getBuildId());
                dromStorey.setStoreyName(storey[i]);
                dromStorey.setOrderNum(i + 1);
                list.add(dromStorey);
            }
            //插入层数表
            dromStoreyService.addDrom(list);
        }
    }

    @Override
    public BuildEcharts getListBuild() {
        List<BuildVo> listBuild = this.baseMapper.getListBuild();
        BuildEcharts echarts = new BuildEcharts();
        List<String> names = new ArrayList<>();
        List<Integer> counts = new ArrayList<>();
        if(listBuild.size()>0){
            for (int i=0;i<listBuild.size();i++){
                names.add(listBuild.get(i).getBuildName());
                counts.add(listBuild.get(i).getStuCount());
            }
        }
        echarts.setNames(names);
        echarts.setCounts(counts);
        return echarts;
    }
}
