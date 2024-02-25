<template>
  <el-main>
    <!-- 搜索栏 -->
    <el-form :model="searchModel" :inline="true" size="small">
      <el-row :gutter="20">
        <el-col :span="24" :offset="0">
          <el-form-item>
            <el-select
              @change="serchCollogeChange"
              style="width: 100%"
              v-model="searchModel.collageId"
              placeholder="请选择学院"
            >
              <el-option
                v-for="item in searchCollogeList"
                :key="item.collageId"
                :label="item.collageName"
                :value="item.collageId"
              >
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item>
            <el-select
              @change="selectSearchMajorChangeEdit"
              style="width: 100%"
              v-model="searchModel.majorId"
              placeholder="请选择专业"
            >
              <el-option
                v-for="item in searchMajorList"
                :key="item.majorId"
                :label="item.majorName"
                :value="item.majorId"
              >
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item>
            <el-select
              style="width: 100%"
              v-model="searchModel.classId"
              placeholder="请选择专业"
            >
              <el-option
                v-for="item in searchClassList"
                :key="item.classId"
                :label="item.className"
                :value="item.classId"
              >
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item>
            <el-input
              v-model="searchModel.stuName"
              placeholder="请输入学生姓名"
            ></el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <div style="margin-bottom:20px;display: flex;">
        <el-button icon="el-icon-search" style="margin-left:15px;" size="small" @click="searchBtn">搜索</el-button>
        <el-button icon="el-icon-close"  size="small" @click="resetBtn" style="color: #ff7670;margin-left:15px;"
          >重置</el-button
        >
        <el-button
          v-permission="['sys:stuList:add']"
          style="margin-left:15px;"
          type="primary"
          size="small"
          icon="el-icon-plus"
          @click="addBtn"
          >新增</el-button
        >
        <el-button
          style="margin-right:15px;"
          type="success"
          size="small"
          icon="el-icon-bottom"
          @click="exportStu()"
          >导入模板</el-button
        >
        <el-upload
          action=""
          :auto-upload="true"
          :multiple="false"
          :show-file-list="false"
          :http-request="uploadFileFn"
          :file-list="fileList"
        >
          <el-button type="warning" icon="el-icon-plus"  size="small"
            >导入学生</el-button
          >
        </el-upload>
        <el-button
          style="margin-left:15px;"
          type="primary"
          size="small"
          icon="el-icon-bottom"
          @click="getStuInfo()"
          >导出学生</el-button
        >
      </div>
    </el-form>
    <!-- 表格数据 -->
    <el-table :height="tableHeight" :data="tableList" border stripe>
      <el-table-column label="学生姓名" prop="stuName"></el-table-column>
      <el-table-column label="学号" prop="stuNum"></el-table-column>
      <el-table-column label="性别" prop="stuName">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.sex == '0'" type="danger" size="small"
            >男</el-tag
          >
          <el-tag v-if="scope.row.sex == '1'" type="blue" size="small"
            >女</el-tag
          >
        </template>
      </el-table-column>
      <el-table-column label="学生电话" prop="phone"></el-table-column>
      <!-- <el-table-column label="身份证号" prop="idCard"></el-table-column> -->
      <el-table-column label="班级" prop="className"></el-table-column>
      <el-table-column label="专业" prop="majorName"></el-table-column>
      <el-table-column label="学院" prop="collageName"></el-table-column>
      <el-table-column label="宿舍" prop="roomCode"></el-table-column>
      <el-table-column label="床位" prop="bedCode"></el-table-column>
      <el-table-column
        v-if="$checkPermission(['sys:stuList:edit', 'sys:stuList:delete'])"
        label="操作"
        align="center"
        width="300"
      >
        <template slot-scope="scope">
          <el-button
            v-permission="['sys:stuList:edit']"
            icon="el-icon-edit"
            type="primary"
            size="small"
            @click="editBtn(scope.row)"
            >编辑</el-button
          >
          <el-button
            v-permission="['sys:stuList:reset']"
            icon="el-icon-edit"
            type="success"
            size="small"
            @click="resetPasBtn(scope.row)"
            >重置密码</el-button
          >
          <el-button
            v-permission="['sys:stuList:delete']"
            icon="el-icon-delete"
            type="danger"
            size="small"
            @click="deleteBtn(scope.row)"
            >删除</el-button
          >
        </template>
      </el-table-column>
    </el-table>
    <!-- 分页 -->
    <el-pagination
      @size-change="sizeChange"
      @current-change="currentChange"
      :current-page.sync="searchModel.currentPage"
      :page-sizes="[10, 20, 40, 80, 100]"
      :page-size="searchModel.pageSize"
      layout="total, sizes, prev, pager, next, jumper"
      :total="searchModel.total"
      background
    >
    </el-pagination>

    <!-- 弹框 -->
    <sys-dialog
      :title="addDialog.title"
      :width="addDialog.width"
      :height="addDialog.height"
      :visible="addDialog.visible"
      @onClose="onClose"
      @onConfirm="onConfirm"
    >
      <div slot="content">
        <el-form
          :model="addModel"
          ref="addForm"
          :rules="rules"
          label-width="80px"
          :inline="false"
          size="small"
        >
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item prop="collageId" label="所属学院">
                <el-select
                  @change="selectChange"
                  style="width: 100%"
                  v-model="addModel.collageId"
                  placeholder="请选择学院"
                >
                  <el-option
                    v-for="item in collogeList"
                    :key="item.collageId"
                    :label="item.collageName"
                    :value="item.collageId"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item prop="majorId" label="所属专业">
                <el-select
                  @change="selectMajorChange"
                  style="width: 100%"
                  v-model="addModel.majorId"
                  placeholder="请选择专业"
                >
                  <el-option
                    v-for="item in majorList"
                    :key="item.majorId"
                    :label="item.majorName"
                    :value="item.majorId"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item prop="classId" label="所属班级">
                <el-select
                  style="width: 100%"
                  v-model="addModel.classId"
                  placeholder="请选择专业"
                >
                  <el-option
                    v-for="item in classList"
                    :key="item.classId"
                    :label="item.className"
                    :value="item.classId"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item label="姓名" prop="stuName">
                <el-input v-model="addModel.stuName"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item label="学号" prop="stuNum">
                <el-input v-model="addModel.stuNum"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item label="性别" prop="sex">
                <el-radio-group v-model="addModel.sex">
                  <el-radio :label="'0'">男</el-radio>
                  <el-radio :label="'1'">女</el-radio>
                </el-radio-group>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item label="身份证" prop="idCard">
                <el-input v-model="addModel.idCard"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item label="电话" prop="phone">
                <el-input v-model="addModel.phone"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item prop="roleId" label="角色">
                <el-select
                  style="width: 100%"
                  v-model="addModel.roleId"
                  placeholder="请选择角色"
                >
                  <el-option
                    v-for="item in roleList"
                    :key="item.roleId"
                    :label="item.roleName"
                    :value="item.roleId"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
            </el-col>
            <el-col v-if="addModel.type == '0'" :span="12" :offset="0">
              <el-form-item label="密码" prop="password">
                <el-input v-model="addModel.password"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
        </el-form>
      </div>
    </sys-dialog>
  </el-main>
</template>

<script>
import SysDialog from "@/components/dialog/SysDialog.vue";
import { getCollegeListApi } from "@/api/major.js";
import { getMajorListApi } from "@/api/classes.js";
import {
  getClassListApi,
  addApi,
  listApi,
  getByIdApi,
  editApi,
  deleteApi,
  getRoleListApi,
  resetPasswordApi,
  importStuINfoApi
} from "@/api/student.js";
export default {
  components: {
    SysDialog
  },
  data() {
    return {
      fileList: [],
      searchClassList: [],
      searchMajorList: [],
      searchCollogeList: [],
      //表格高度
      tableHeight: 0,
      //表格数据
      tableList: [],
      //学院数据
      collogeList: [],
      //专业数据
      majorList: [],
      //班级数据
      classList: [],
      //表单验证规则
      rules: {
        collageId: [
          {
            trigger: "blur",
            required: true,
            message: "请选择学院"
          }
        ],
        majorId: [
          {
            trigger: "blur",
            required: true,
            message: "请选择专业"
          }
        ],
        classId: [
          {
            trigger: "blur",
            required: true,
            message: "请选择班级"
          }
        ],
        stuName: [
          {
            trigger: "blur",
            required: true,
            message: "请填写姓名"
          }
        ],
        sex: [
          {
            trigger: "blur",
            required: true,
            message: "请选择性别"
          }
        ],
        stuNum: [
          {
            trigger: "blur",
            required: true,
            message: "请填写学号"
          }
        ],
        idCard: [
          {
            trigger: "blur",
            required: true,
            message: "请填写身份证"
          }
        ],
        phone: [
          {
            trigger: "blur",
            required: true,
            message: "请填写电话"
          }
        ]
      },
      //表单绑定的对象
      addModel: {
        type: "",
        stuId: "",
        roleId: "",
        password: "",
        classId: "",
        collageId: "",
        majorId: "",
        stuName: "",
        sex: "",
        stuNum: "",
        idCard: "",
        phone: ""
      },
      //弹框属性
      addDialog: {
        title: "",
        width: 680,
        height: 260,
        visible: false
      },
      //搜索参数
      searchModel: {
        collageName: "",
        majorName: "",
        className: "",
        stuName: "",
        currentPage: 1,
        pageSize: 10,
        total: 0,
        classId: "",
        collageId: "",
        majorId: ""
      },
      roleList: []
    };
  },
  created() {
    this.getLsit();
    this.getRoleList();
    this.getSearchCollogeList();
  },
  mounted() {
    this.$nextTick(() => {
      this.tableHeight = window.innerHeight - 220;
    });
  },
  methods: {
    //导入学生
    async uploadFileFn(param) {
      if (!this.searchModel.collageId) {
        this.$message.warning("请选择学院!");
        return false;
      }
      if (!this.searchModel.majorId) {
        this.$message.warning("请选择专业!");
        return false;
      }
      //判断是否选择班级
      if (!this.searchModel.classId) {
        this.$message.warning("请选择班级!");
        return false;
      }

      const file = param.file;

      // 通过split方法和fileArr方法获取到文件的后缀名
      let fileArr = file.name.split(".");
      let suffix = fileArr[fileArr.length - 1];
      //只能导入.xls和.xlsx文件
      if (!/(xls|xlsx)/i.test(suffix)) {
        this.$message.warning("文件格式不正确");
        return false;
      }
      //不能导入大小超过2Mb的文件
      if (file.size > 2 * 1024 * 1024) {
        this.$message("文件过大,请上传小于2MB的文件〜");
        return false;
      }
      const formData = new FormData();
      formData.append("file", file);
      formData.append("classId", this.searchModel.classId);
      formData.append("collageId", this.searchModel.collageId);
      formData.append("majorId", this.searchModel.majorId);
      let res = await importStuINfoApi(formData);
      if (res && res.code == 200) {
        this.$message.success(res.msg);
        this.getLsit();
      }
    },
    //导出学生
    getStuInfo() {
      if (!this.searchModel.collageId) {
        this.$message.warning("请选择学院!");
        return false;
      }
      if (!this.searchModel.majorId) {
        this.$message.warning("请选择专业!");
        return false;
      }
      //判断是否选择班级
      if (!this.searchModel.classId) {
        this.$message.warning("请选择班级!");
        return false;
      }
      const abtn = document.createElement("a");
      abtn.href =
        process.env.VUE_APP_BASE_API_PRO +
        "/api/student/exportStuInfo?classId=" +
        this.searchModel.classId+"&collageId="+this.searchModel.collageId+
        +"&majorId="+this.searchModel.majorId
      abtn.click();
    },
    //下载模板
    exportStu() {
      const abtn = document.createElement("a");
      abtn.href =
        process.env.VUE_APP_BASE_API_PRO + "/api/student/importStuTemplate";
      abtn.click();
    },
    //搜索查询学院
    async getSearchCollogeList() {
      let res = await getCollegeListApi();
      if (res && res.code == 200) {
        console.log(res);
        this.searchCollogeList = res.data;
      }
    },
    async serchCollogeChange(val) {
      //清空数据
      this.searchModel.majorId = "";
      this.searchMajorList = [];
      this.searchModel.classId = "";
      this.searchClassList = [];
      // console.log(val);
      let res = await getMajorListApi({
        collageId: val
      });
      if (res && res.code == 200) {
        //设置专业数据
        this.searchMajorList = res.data;
      }
    },
    async selectSearchMajorChangeEdit(val) {
      this.searchClassList = [];
      let res = await getClassListApi({
        major: val
      });
      if (res && res.code == 200) {
        this.searchClassList = res.data;
      }
    },
    //角色列表
    async getRoleList() {
      let res = await getRoleListApi();
      if (res && res.code == 200) {
        this.roleList = res.data;
      }
    },
    //页数改变触发
    currentChange(val) {
      this.searchModel.currentPage = val;
      this.getLsit();
    },
    //页容量
    sizeChange(val) {
      this.searchModel.pageSize = val;
      this.getLsit();
    },
    //删除
    async deleteBtn(row) {
      const confrim = await this.$myconfirm("确定删除该数据吗?");
      if (confrim) {
        let res = await deleteApi({
          stuId: row.stuId
        });
        if (res && res.code == 200) {
          this.$message.success(res.msg);
          this.getLsit();
        }
      }
    },
    //编辑
    editBtn(row) {
      //清空表单
      this.$resetForm("addForm", this.addModel);
      //查询编辑的信息
      this.getIfById(row.stuId);
      //查询学院
      this.collogeList = [];
      this.getCollogeList();
      //设置弹框属性
      this.addDialog.title = "编辑学生";
      this.addDialog.visible = true;
      this.addModel.type = "1";
      //密码清空
      this.addModel.password = "";
    },
    //根据学生id查询学生信息
    async getIfById(stuId) {
      let res = await getByIdApi({
        stuId: stuId
      });
      if (res && res.code == 200) {
        //设置编辑的信息
        this.$objCoppy(res.data, this.addModel);
        this.selectChangeEdit(res.data.collageId);
        this.selectMajorChangeEdit(res.data.majorId);
      }
    },
    async selectMajorChangeEdit(val) {
      this.classList = [];
      let res = await getClassListApi({
        major: val
      });
      if (res && res.code == 200) {
        this.classList = res.data;
      }
    },
    async selectChangeEdit(val) {
      //清空数据
      this.majorList = [];
      let res = await getMajorListApi({
        collageId: val
      });
      if (res && res.code == 200) {
        //设置专业数据
        this.majorList = res.data;
      }
    },
    //获取表格数据
    async getLsit() {
      let res = await listApi(this.searchModel);
      if (res && res.code == 200) {
        //设置表格数据
        this.tableList = res.data.records;
        this.searchModel.total = res.data.total;
      }
    },
    //专业选择事件
    async selectMajorChange(val) {
      this.addModel.classId = "";
      this.classList = [];
      let res = await getClassListApi({
        major: val
      });
      if (res && res.code == 200) {
        this.classList = res.data;
      }
      // console.log(this.classList);
    },
    //选用选择事件,返回专业列表
    async selectChange(val) {
      //清空数据
      this.addModel.majorId = "";
      this.majorList = [];
      this.addModel.classId = "";
      this.classList = [];
      // console.log(val);
      let res = await getMajorListApi({
        collageId: val
      });
      if (res && res.code == 200) {
        //设置专业数据
        this.majorList = res.data;
      }
    },
    //弹框确定
    onConfirm() {
      this.$refs.addForm.validate(async valid => {
        if (valid) {
          let res = null;
          if (this.addModel.type == "0") {
            res = await addApi(this.addModel);
          } else {
            res = await editApi(this.addModel);
          }
          if (res && res.code == 200) {
            this.$message.success(res.msg);
            //刷新列表
            this.getLsit();
            this.addDialog.visible = false;
          }
        }
      });
    },
    //弹框关闭
    onClose() {
      this.addDialog.visible = false;
    },
    async resetPasBtn(row) {
      const conirm = await this.$myconfirm(
        "确定重置密码吗？重置之后密码为【666666】"
      );
      if (conirm) {
        let res = await resetPasswordApi({
          stuId: row.stuId,
          password: "666666"
        });
        if (res && res.code == 200) {
          this.$message.success(res.msg);
          this.addDialog.visible = false;
        }
      }
    },
    //新增按钮
    addBtn() {
      //清空表单
      this.$resetForm("addForm", this.addModel);
      //查询学院
      this.collogeList = [];
      this.getCollogeList();
      //设置弹框属性
      this.addDialog.title = "新增学生";
      this.addDialog.visible = true;
      this.addModel.type = "0";
    },
    //查询学院
    async getCollogeList() {
      let res = await getCollegeListApi();
      if (res && res.code == 200) {
        console.log(res);
        this.collogeList = res.data;
      }
    },
    //重置按钮
    resetBtn() {
      this.searchModel.collageId = "";
      this.searchModel.classId = "";
      this.searchModel.majorId = "";
      this.searchModel.stuName = "";
      this.searchModel.currentPage = 1;
      this.getLsit();
    },
    //搜索按钮
    searchBtn() {
      console.log(this.searchModel);
      this.getLsit();
    }
  }
};
</script>

<style lang="scss" scoped></style>
