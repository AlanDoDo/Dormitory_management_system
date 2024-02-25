package com.itmk.web.dorm_room.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.itmk.utils.ResultUtils;
import com.itmk.utils.ResultVo;
import com.itmk.web.dorm_room.entity.DormRoom;
import com.itmk.web.dorm_room.entity.RoomListParm;
import com.itmk.web.dorm_room.entity.RoomParm;
import com.itmk.web.dorm_room.entity.RoomTree;
import com.itmk.web.dorm_room.service.DormRoomService;
import com.itmk.web.drom_room_bed.entity.DromRoomBed;
import com.itmk.web.drom_room_bed.entity.DromRoomVo;
import com.itmk.web.drom_room_bed.service.DromRoomBedService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * @Author java实战基地
 * @Version 3501754007
 */
@RestController
@RequestMapping("/api/dormRoom")
public class DormRoomController {
    @Autowired
    private DormRoomService dormRoomService;
    @Autowired
    private DromRoomBedService dromRoomBedService;

    //新增
    @PostMapping
    public ResultVo add(@RequestBody RoomParm parm) {
        //起始编号
        int start = parm.getStart();
        List<DormRoom> list = new ArrayList<>();
        while (start <= parm.getEnd()) {
            //房间实体类创建
            DormRoom room = new DormRoom();
            room.setTotalBed(parm.getStuNum());
            room.setRootType(parm.getRootType());
            room.setStoreyId(parm.getStoreyId());
            //构造编号 A100
            if (StringUtils.isNotEmpty(parm.getArea())) {
                room.setRoomCode(parm.getArea() + start);
            } else { // 100
                room.setRoomCode(Integer.toString(start));
            }
            //判断是否重复
            QueryWrapper<DormRoom> query = new QueryWrapper<>();
            query.lambda().eq(DormRoom::getRoomCode, room.getRoomCode());
            DormRoom one = dormRoomService.getOne(query);
            if (one == null) { //没有重复的才放入
                list.add(room);
            }
            //此条件不能少，死循环
            start = start + 1;
        }
        //保存房间
        if (list.size() > 0) {
            dormRoomService.saveBatch(list);
        }
        return ResultUtils.success("设置成功");
    }

    //编辑
    @PutMapping
    public ResultVo edit(@RequestBody DormRoom room) {
        //判断编号是否重复
        QueryWrapper<DormRoom> query = new QueryWrapper<>();
        query.lambda().eq(DormRoom::getRoomCode, room.getRoomCode());
        DormRoom one = dormRoomService.getOne(query);
        if (one != null && one.getRoomId() != room.getRoomId()) {
            return ResultUtils.error("编号重复");
        }
        boolean b = dormRoomService.updateById(room);
        if (b) {
            return ResultUtils.success("编辑成功");
        }
        return ResultUtils.error("编辑失败");
    }

    //删除
    @DeleteMapping("/{roomId}")
    public ResultVo delete(@PathVariable("roomId") Long roomId) {
        //判断房间下面是否住着人
        //如果没有人，才能删除
        boolean b = dormRoomService.removeById(roomId);
        if (b) {
            return ResultUtils.success("删除成功");
        }
        return ResultUtils.error("删除失败");
    }

    //列表查询
//    @GetMapping("/list")
//    public ResultVo getList(RoomListParm parm) {
//        //构造分页对象
//        IPage<DormRoom> page = new Page<>(parm.getCurrentPage(), parm.getPageSize());
//        QueryWrapper<DormRoom> query = new QueryWrapper<>();
//        query.lambda().eq(DormRoom::getStoreyId, parm.getStoreyId());
//        IPage<DormRoom> list = dormRoomService.page(page, query);
//        //查询宿舍对应的床位
//        if (list.getRecords().size() > 0) {
//            for (int i = 0; i < list.getRecords().size(); i++) {
//                //获取宿舍id
//                Long roomId = list.getRecords().get(i).getRoomId();
//                //查询宿舍对应的床位
//                QueryWrapper<DromRoomBed> queryBed = new QueryWrapper<>();
//                queryBed.lambda().eq(DromRoomBed::getRoomId, roomId);
//                List<DromRoomBed> bedList = dromRoomBedService.list(queryBed);
//                list.getRecords().get(i).setBedList(bedList);
//            }
//        }
//        return ResultUtils.success("查询成功", list);
//    }

    @GetMapping("/list")
    public ResultVo getList(RoomListParm parm) {
        //构造分页对象
        IPage<DormRoom> page = new Page<>(parm.getCurrentPage(), parm.getPageSize());
        QueryWrapper<DormRoom> query = new QueryWrapper<>();
        query.lambda().eq(DormRoom::getStoreyId, parm.getStoreyId());
        IPage<DormRoom> list = dormRoomService.page(page, query);
        //查询宿舍对应的床位
        if (list.getRecords().size() > 0) {
            for (int i = 0; i < list.getRecords().size(); i++) {
                //获取宿舍id
                Long roomId = list.getRecords().get(i).getRoomId();
                //查询宿舍对应的床位
                QueryWrapper<DromRoomBed> queryBed = new QueryWrapper<>();
                queryBed.lambda().eq(DromRoomBed::getRoomId, roomId);
                List<DromRoomVo> bedList = dromRoomBedService.getSelectBedList(roomId);
                list.getRecords().get(i).setBedList(bedList);
            }
        }
        return ResultUtils.success("查询成功", list);
    }
    //根据层数id查询宿舍和床位
    @GetMapping("/getRoomByStoreyId")
    public ResultVo getRoomByStoreyId(Long storeyId) {
        List<RoomTree> list = dormRoomService.getRoomTree(storeyId);
        return ResultUtils.success("查询成功",list);
    }

}
