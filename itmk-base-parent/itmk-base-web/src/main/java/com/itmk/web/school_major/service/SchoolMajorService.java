package com.itmk.web.school_major.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.itmk.web.school_major.entity.MajorList;
import com.itmk.web.school_major.entity.SchoolMajor;


/**
 * @Author java实战基地
 * @Version 3501754007
 */
public interface SchoolMajorService extends IService<SchoolMajor> {
    IPage<SchoolMajor> getList(MajorList majorList);
}
