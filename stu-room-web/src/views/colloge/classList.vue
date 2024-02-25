<template>
  <el-main>
    <!-- 搜索栏 -->
    <el-form :model="searchModel" :inline="true" size="small">
      <el-form-item>
        <el-input
          v-model="searchModel.collageName"
          placeholder="请输入学院名称"
        ></el-input>
      </el-form-item>
      <el-form-item>
        <el-input
          v-model="searchModel.majorName"
          placeholder="请输入专业名称"
        ></el-input>
      </el-form-item>
      <el-form-item>
        <el-input
          v-model="searchModel.className"
          placeholder="请输入班级名称"
        ></el-input>
      </el-form-item>
      <el-form-item>
        <el-button icon="el-icon-search" @click="searchBtn">搜索</el-button>
        <el-button icon="el-icon-close" style="color: #ff7670" @click="resetBtn"
          >重置</el-button
        >
        <el-button
          v-permission="['sys:classList:add']"
          icon="el-icon-plus"
          type="primary"
          @click="addBtn"
          >新增</el-button
        >
      </el-form-item>
    </el-form>
    <!-- 表格 -->
    <el-table :height="tableHeight" :data="tableList" border stripe>
      <el-table-column prop="className" label="班级名称"></el-table-column>
      <el-table-column prop="classYear" label="招生年份"></el-table-column>
      <el-table-column prop="collageName" label="学院名称"></el-table-column>
      <el-table-column prop="majorName" label="专业名称"></el-table-column>
      <el-table-column prop="orderNum" label="序号"></el-table-column>
      <el-table-column
        v-if="$checkPermission(['sys:classList:edie', 'sys:classList:delete'])"
        label="操作"
        align="center"
        width="220"
      >
        <template slot-scope="scope">
          <el-button
            v-permission="['sys:classList:edie']"
            icon="el-icon-edit"
            type="primary"
            size="small"
            @click="editBtn(scope.row)"
            >编辑</el-button
          >
          <el-button
            v-permission="['sys:classList:delete']"
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

    <!-- 新增弹框 -->
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
          <el-form-item prop="majorId" label="所属专业">
            <el-select
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
          <el-form-item label="班级名称" prop="className">
            <el-input v-model="addModel.className"></el-input>
          </el-form-item>
          <el-form-item label="招生年份" prop="classYear">
            <el-date-picker
              style="width: 100%"
              v-model="addModel.classYear"
              type="year"
              placeholder="选择年份"
              value-format="yyyy"
            >
            </el-date-picker>
          </el-form-item>
          <el-form-item label="序号">
            <el-input v-model="addModel.orderNum"></el-input>
          </el-form-item>
        </el-form>
      </div>
    </sys-dialog>
  </el-main>
</template>

<script>
import {
  getMajorListApi,
  addApi,
  getListApi,
  editApi,
  deleteApi,
  getClassByIdApi,
} from "@/api/classes.js";
import { getCollegeListApi } from "@/api/major.js";
import SysDialog from "@/components/dialog/SysDialog.vue";
export default {
  components: {
    SysDialog,
  },
  data() {
    return {
      tableHeight: 0,
      //表单绑定的数据对象
      addModel: {
        type: "",
        classId: "",
        majorId: "",
        collageId: "",
        className: "",
        classYear: "",
        orderNum: "",
      },
      //学院列表
      collogeList: [],
      //表单验证规则
      rules: {
        collageId: [
          {
            trigger: "blur",
            message: "请选择学院",
            required: true,
          },
        ],
        majorId: [
          {
            trigger: "blur",
            message: "请选择专业",
            required: true,
          },
        ],
        className: [
          {
            trigger: "blur",
            message: "请填写班级名称",
            required: true,
          },
        ],
        classYear: [
          {
            trigger: "blur",
            message: "请选择招生年份",
            required: true,
          },
        ],
      },
      //弹框属性
      addDialog: {
        title: "",
        width: 650,
        height: 260,
        visible: false,
      },
      //列表参数
      searchModel: {
        className: "",
        majorName: "",
        collageName: "",
        currentPage: 1,
        pageSize: 10,
        total: 0,
      },
      majorList: [],
      tableList: [],
    };
  },
  created() {
    this.getList();
  },
  mounted() {
    this.$nextTick(() => {
      this.tableHeight = window.innerHeight - 230;
    });
  },
  methods: {
    //删除按钮
    async deleteBtn(row) {
      //信息确定
      const confrim = await this.$myconfirm("确定删除该数据吗？");
      if (confrim) {
        let res = await deleteApi({
          classId: row.classId,
        });
        if (res && res.code == 200) {
          //信息提示
          this.$message.success(res.msg);
          this.getList();
        }
      }
    },
    //编辑按钮
    async editBtn(row) {
      //清空数据
      this.$resetForm("addForm", this.addModel);
      this.collogeList = [];
      //获取要编辑的数据
      let classes = await getClassByIdApi({ classId: row.classId });
      if (classes && classes.code == 200) {
        // console.log(classes);
        this.$objCoppy(classes.data, this.addModel);
      }
      let res = await getCollegeListApi();
      if (res && res.code == 200) {
        // console.log(res);
        this.collogeList = res.data;
        let resmajor = await getMajorListApi({
          collageId: this.addModel.collageId,
        });
        if (resmajor && resmajor.code == 200) {
          //设置专业数据
          this.majorList = resmajor.data;
        }
      }
      //设置弹框属性
      this.addDialog.title = "编辑班级";
      this.addDialog.visible = true;
      this.addModel.type = "1";
    },
    //页数改变时触发
    currentChange(val) {
      this.searchModel.currentPage = val;
      this.getList();
    },
    //页容量改变时触发
    sizeChange(val) {
      this.searchModel.pageSize = val;
      this.getList();
    },
    //列表
    async getList() {
      let res = await getListApi(this.searchModel);
      if (res && res.code == 200) {
        console.log(res);
        //设置数据到表格的数据
        this.tableList = res.data.records;
        this.searchModel.total = res.data.total;
      }
    },
    //选用选择事件
    async selectChange(val) {
      //清空数据
      this.addModel.majorId = "";
      this.majorList = [];
      console.log(val);
      let res = await getMajorListApi({
        collageId: val,
      });
      if (res && res.code == 200) {
        //设置专业数据
        this.majorList = res.data;
      }
    },
    //弹框关闭
    onClose() {
      this.addDialog.visible = false;
    },
    //弹框确定
    onConfirm() {
      console.log(this.addModel);
      this.$refs.addForm.validate(async (valid) => {
        if (valid) {
          let res = null;
          if (this.addModel.type == "0") {
            res = await addApi(this.addModel);
          } else {
            res = await editApi(this.addModel);
          }
          if (res && res.code == 200) {
            //信息提示
            this.$message.success(res.msg);
            //刷新列表
            this.getList();
            this.addDialog.visible = false;
          }
        }
      });
    },
    //新增
    async addBtn() {
      //清空数据
      this.$resetForm("addForm", this.addModel);
      this.collogeList = [];
      let res = await getCollegeListApi();
      if (res && res.code == 200) {
        console.log(res);
        this.collogeList = res.data;
      }
      //设置弹框属性
      this.addDialog.title = "新增班级";
      this.addDialog.visible = true;
      this.addModel.type = "0";
    },
    //重置
    resetBtn() {
      this.searchModel.className = "";
      this.searchModel.majorName = "";
      this.searchModel.collageName = "";
      this.searchModel.currentPage = 1;
      this.getList();
    },
    //搜索
    searchBtn() {
      this.getList();
    },
  },
};
</script>

<style lang="scss" scoped>
</style>