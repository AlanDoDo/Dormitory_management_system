package com.itmk.web.school_student.controller;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.ExcelImportUtil;
import cn.afterturn.easypoi.excel.entity.ExportParams;
import cn.afterturn.easypoi.excel.entity.ImportParams;
import cn.afterturn.easypoi.excel.entity.enmus.ExcelType;
import cn.afterturn.easypoi.excel.entity.result.ExcelImportResult;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.itmk.utils.ResultUtils;
import com.itmk.utils.ResultVo;
import com.itmk.web.school_class.entity.SchoolClass;
import com.itmk.web.school_class.service.SchoolClassService;
import com.itmk.web.school_student.entity.SchoolStudent;
import com.itmk.web.school_student.entity.StuExcel;
import com.itmk.web.school_student.entity.StuExport;
import com.itmk.web.school_student.entity.StuParm;
import com.itmk.web.school_student.service.SchoolStudentService;
import com.itmk.web.stu_role.entity.StuRole;
import com.itmk.web.sys_role.entity.SysRole;
import com.itmk.web.sys_role.service.SysRoleService;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

/**
 * @Author java实战基地
 * @Version 3501754007
 */
@RestController
@RequestMapping("/api/student")
public class SchoolStudentController {
    @Autowired
    private SchoolStudentService schoolStudentService;
    @Autowired
    private SchoolClassService schoolClassService;
    @Autowired
    private SysRoleService sysRoleService;
    //导入学生
    @RequestMapping("/importStuINfo")
    public ResultVo importStuINfo(@RequestParam("file") MultipartFile file, StuParm parm) throws Exception {
        ImportParams importParams = new ImportParams();
        // 数据处理
        importParams.setHeadRows(1);
        ExcelImportResult<StuExcel> result = ExcelImportUtil.importExcelMore(file.getInputStream(), StuExcel.class, importParams);
        List<StuExcel> list = result.getList();
        if (list.size() == 0) {
            return ResultUtils.error("请录入学生信息");
        }
        List<SchoolStudent> studentList = new ArrayList<>();
        //查询学生
        for (int i = 0; i < list.size(); i++) {
            SchoolStudent student = new SchoolStudent();
            BeanUtils.copyProperties(list.get(i),student);
            student.setClassId(Long.parseLong(parm.getClassId()));
            student.setPassword(DigestUtils.md5DigestAsHex("666666".getBytes()));
            studentList.add(student);
        }
        schoolStudentService.importStu(studentList);
        return ResultUtils.success("导入成功!");
    }
    //导入学生excel模板
    @RequestMapping("/importStuTemplate")
    public void importStuTemplate(HttpServletResponse response) throws Exception {
        //导出excel，组装数据
        List<StuExcel> list = new ArrayList<>();
        //导出
        String fileName = "学生信息模板.xlsx";
        ExportParams exportParams = new ExportParams();
        exportParams.setType(ExcelType.XSSF);
        Workbook workbook = ExcelExportUtil.exportExcel(exportParams, StuExcel.class, list);
        downloadExcel(fileName, workbook, response);
    }
    //导出学生
    @RequestMapping("/exportStuInfo")
    public void exportStuInfo(HttpServletResponse response,StuParm parm) throws Exception {
        SchoolClass aClass = schoolClassService.getById(parm.getClassId());
        //查询学生信息
        QueryWrapper<SchoolStudent> query = new QueryWrapper<>();
        query.lambda().eq(SchoolStudent::getClassId,parm.getClassId());
        List<SchoolStudent> list1 = schoolStudentService.exportStu(parm);
         //导出excel，组装数据
        List<StuExport> list = new ArrayList<>();
        if(list1.size()>0){
            for (int i=0;i<list1.size();i++){
                StuExport excel = new StuExport();
                BeanUtils.copyProperties(list1.get(i),excel);
                list.add(excel);
            }
        }
        //导出
        String fileName = aClass.getClassName()+ "学生信息.xlsx";
        ExportParams exportParams = new ExportParams();
        exportParams.setType(ExcelType.XSSF);
        Workbook workbook = ExcelExportUtil.exportExcel(exportParams, StuExport.class, list);
        downloadExcel(fileName, workbook, response);
    }
    public static void downloadExcel(String fileName, Workbook workbook, HttpServletResponse response) throws Exception {
        try {
            if (StringUtils.isEmpty(fileName)) {
                throw new RuntimeException("导出文件名不能为空");
            }
            String encodeFileName = URLEncoder.encode(fileName, "UTF-8");
            response.setHeader("content-Type", "application/vnd.ms-excel; charset=utf-8");
            response.setHeader("Content-Disposition", "attachment;filename=" + encodeFileName);
            response.setHeader("FileName", encodeFileName);
            response.setHeader("Access-Control-Expose-Headers", "FileName");
            workbook.write(response.getOutputStream());
            workbook.close();
        } catch (Exception e) {
            workbook.close();
        }
    }

    //新增
    @PostMapping
    public ResultVo add(@RequestBody SchoolStudent schoolStudent) {
        schoolStudent.setPassword(DigestUtils.md5DigestAsHex(schoolStudent.getPassword().getBytes()));
        schoolStudentService.addStu(schoolStudent);
        return ResultUtils.success("新增成功!");
    }

    @PostMapping("/resetPassword")
    public ResultVo resetPassword(@RequestBody SchoolStudent schoolStudent) {
        schoolStudent.setPassword(DigestUtils.md5DigestAsHex(schoolStudent.getPassword().getBytes()));
        boolean b = schoolStudentService.updateById(schoolStudent);
        if (b) {
            return ResultUtils.success("密码重置成功!");
        }
        return ResultUtils.error("密码重置失败!");
    }

    //编辑
    @PutMapping
    public ResultVo edit(@RequestBody SchoolStudent schoolStudent) {
        schoolStudentService.editStu(schoolStudent);
        return ResultUtils.success("编辑成功!");
    }

    //根据id查询学生信息
    @GetMapping("/getById")
    public ResultVo getById(Long stuId) {
        SchoolStudent stu = schoolStudentService.getStuById(stuId);
        return ResultUtils.success("查询成功", stu);
    }

    //删除
    @DeleteMapping("/{stuId}")
    public ResultVo delete(@PathVariable("stuId") Long stuId) {
        schoolStudentService.deleteStu(stuId);
        return ResultUtils.success("删除成功!");
    }

    //列表
    @GetMapping("/list")
    public ResultVo getList(StuParm parm) {
        IPage<SchoolStudent> stu = schoolStudentService.getList(parm);
        return ResultUtils.success("查询成功", stu);
    }

    //列表
    @GetMapping("/getClassList")
    public ResultVo getClassList(Long major) {
        QueryWrapper<SchoolClass> query = new QueryWrapper<>();
        query.lambda().eq(SchoolClass::getMajorId, major);
        List<SchoolClass> list = schoolClassService.list(query);
        return ResultUtils.success("查询成功", list);
    }

    //查询角色列表
    @GetMapping("/getRoleList")
    public ResultVo getRoleList() {
        List<SysRole> list = sysRoleService.list();
        return ResultUtils.success("查询成功", list);
    }

    //根据班级Id查询学生列表
    @GetMapping("/getClassByClassId")
    public ResultVo getClassByClassId(Long classId) {
        QueryWrapper<SchoolStudent> query = new QueryWrapper<>();
        query.lambda().eq(SchoolStudent::getClassId, classId);
        List<SchoolStudent> list = schoolStudentService.list(query.select("stu_id", "stu_name"));
        return ResultUtils.success("查询成功", list);
    }
}
