package com.itmk.web.assign_bed.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.itmk.utils.ResultUtils;
import com.itmk.utils.ResultVo;
import com.itmk.web.assign_bed.entity.*;
import com.itmk.web.assign_bed.service.AssignBedService;
import com.itmk.web.school_student.entity.SchoolStudent;
import com.itmk.web.school_student.service.SchoolStudentService;
import com.itmk.web.select_bed.service.StuBedService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author Alan
 * @Version 001
 */
@RestController
@RequestMapping("/api/assingBed")
public class AssignBedController {
    @Autowired
    private AssignBedService assignBedService;
    @Autowired
    private SchoolStudentService schoolStudentService;
    @Autowired
    private StuBedService stuBedService;

    //分配宿舍保存
    @PostMapping("/assignSaveBed")
    public ResultVo assignSaveBed(@RequestBody List<AssignBed> list) {
        assignBedService.saveBatch(list);
        return ResultUtils.success("分配宿舍成功");
    }

    @GetMapping("/getAssignBedList")
    public ResultVo getAssignBedList(Long classId) {
        //宿舍列表
        List<RoomVo> roomVoList = assignBedService.getRoomVoList(classId);
        if (roomVoList.size() > 0) {
            for (int i = 0; i < roomVoList.size(); i++) {
                //查询宿舍的床位
                List<BedVo> bedVoList = assignBedService.getBedVoList(roomVoList.get(i).getRoomId());
                //设置宿舍的床位
                roomVoList.get(i).setChildren(bedVoList);
            }
        }
        return ResultUtils.success("查询成功", roomVoList);
    }

    //删除
    @DeleteMapping("/{bedId}/{classId}")
    public ResultVo delete(@PathVariable("bedId") Long bedId, @PathVariable("classId") Long classId) {
        QueryWrapper<AssignBed> query = new QueryWrapper<>();
        query.lambda().eq(AssignBed::getBedId, bedId).eq(AssignBed::getClassId, classId);
        boolean remove = assignBedService.remove(query);
        if (remove) {
            return ResultUtils.success("删除成功");
        }
        return ResultUtils.error("删除失败！");
    }

    @GetMapping("/getRoomByClassId")
    public ResultVo getRoomByClassId(Long userId, String userType) {
        if (!userType.equals("0")) {
            return ResultUtils.error("学生才能参与选宿舍!");
        }
        //查询学生信息
        SchoolStudent student = schoolStudentService.getById(userId);
        List<SelectRoom> roomList = null;
        if (student != null) {
            roomList = assignBedService.getRoomByClassId(student.getClassId());
            if (roomList.size() > 0) {
                for (int i = 0; i < roomList.size(); i++) {
                    //床位查询
                    List<SelectBed> bedList = assignBedService.getBedByClassId(student.getClassId(), roomList.get(i).getRoomId());
                    roomList.get(i).setChildren(bedList);
                }
            }
        }
        return ResultUtils.success("查询成功",roomList);
    }

    //清空宿舍
    @PostMapping("/clearBed")
    public ResultVo clearBed(@RequestBody ClearBed clearBed){
        stuBedService.clearBed(clearBed.getClassId());
        return ResultUtils.success("清空成功");
    }
}
