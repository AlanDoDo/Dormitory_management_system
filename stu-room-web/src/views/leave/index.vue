<template>
  <el-main>
    <!-- 搜索栏 -->
    <el-form :model="searchModel" :inline="true" size="small">
      <el-form-item>
        <el-input
          v-model="searchModel.classes"
          placeholder="请输入班级"
        ></el-input>
      </el-form-item>
      <el-form-item>
        <el-input
          v-model="searchModel.stuName"
          placeholder="请输入姓名"
        ></el-input>
      </el-form-item>
      <el-form-item>
        <el-input
          v-model="searchModel.dromName"
          placeholder="请输入宿舍名称"
        ></el-input>
      </el-form-item>
      <el-form-item>
        <el-button @click="searchBtn" icon="el-icon-search">搜索</el-button>
        <el-button @click="resetBtn" icon="el-icon-close" style="color: #ff7670"
          >重置</el-button
        >
        <el-button type="primary" icon="el-icon-plus" @click="addBtn"
          >新增</el-button
        >
      </el-form-item>
    </el-form>
    <!-- 表格 -->
    <el-table :height="tableHeight" :data="tableList" border stripe>
      <el-table-column prop="classes" label="班级"></el-table-column>
      <el-table-column prop="stuName" label="姓名"></el-table-column>
      <el-table-column prop="dromName" label="宿舍"></el-table-column>
      <el-table-column prop="leaveTime" label="缺勤时间"></el-table-column>
      <el-table-column label="操作" align="center" width="220">
        <template slot-scope="scope">
          <el-button
            icon="el-icon-edit"
            type="primary"
            size="small"
            @click="editBtn(scope.row)"
            >编辑</el-button
          >
          <el-button
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
      :height="addDialog.height"
      :width="addDialog.width"
      :visible="addDialog.visible"
      @onClose="onClose"
      @onConfirm="onConfirm"
    >
      <div slot="content">
        <el-form
          style="margin: 0px 10px"
          :model="addModel"
          ref="addForm"
          :rules="rules"
          label-width="50px"
          :inline="false"
          size="small"
        >
          <el-form-item prop="classes" label="班级">
            <el-input v-model="addModel.classes"></el-input>
          </el-form-item>
          <el-form-item prop="stuName" label="姓名">
            <el-input v-model="addModel.stuName"></el-input>
          </el-form-item>
          <el-form-item prop="dromName" label="宿舍">
            <el-input v-model="addModel.dromName"></el-input>
          </el-form-item>
          <el-form-item prop="leaveTime" label="日期">
            <el-date-picker
              style="width: 100%"
              value-format="yyyy-MM-dd"
              v-model="addModel.leaveTime"
              type="date"
              placeholder="选择日期"
            >
            </el-date-picker>
          </el-form-item>
        </el-form>
      </div>
    </sys-dialog>
  </el-main>
</template>

<script>
import { addApi, listApi, editApi, deleteApi } from "@/api/leave.js";
import SysDialog from "@/components/dialog/SysDialog.vue";
export default {
  components: {
    SysDialog,
  },
  data() {
    return {
      tableHeight: 0,
      addModel: {
        type: "",
        leaveId: "",
        classes: "",
        stuName: "",
        dromName: "",
        leaveTime: "",
      },
      rules: {
        leaveTime: [
          {
            trigger: "blur",
            required: true,
            message: "请选择日期",
          },
        ],
        stuName: [
          {
            trigger: "blur",
            required: true,
            message: "请填写姓名",
          },
        ],
        classes: [
          {
            trigger: "blur",
            required: true,
            message: "请填写班级",
          },
        ],
      },
      //弹框属性
      addDialog: {
        title: "",
        height: 230,
        width: 650,
        visible: false,
      },
      searchModel: {
        classes: "",
        stuName: "",
        dromName: "",
        currentPage: 1,
        pageSize: 10,
        total: 0,
      },
      tableList: [],
    };
  },
  created() {
    this.getList();
  },
  mounted() {
    this.$nextTick(() => {
      this.tableHeight = window.innerHeight - 220;
    });
  },
  methods: {
    resetBtn() {
      this.searchModel.stuName = "";
      this.searchModel.dromName = "";
      this.searchModel.classes = "";
      this.searchModel.currentPage = 1;
      this.getList();
    },
    searchBtn() {
      this.getList();
    },
    currentChange(val) {
      this.searchModel.currentPage = val;
      this.getList();
    },
    sizeChange(val) {
      this.searchModel.pageSize = val;
      this.getList();
    },
    //删除按钮
    async deleteBtn(row) {
      const confirm = await this.$myconfirm("确定删除该数据吗?");
      if (confirm) {
        let res = await deleteApi({
          leaveId: row.leaveId,
        });
        if (res && res.code == 200) {
          this.$message.success(res.msg);
          this.getList();
        }
      }
    },
    //编辑按钮
    editBtn(row) {
      //清空表单
      this.$resetForm("addForm", this.addModel);
      this.$objCoppy(row, this.addModel);
      //设置弹框属性
      this.addDialog.title = "编辑考勤";
      this.addDialog.visible = true;
      this.addModel.type = "1";
    },
    //列表获取
    async getList() {
      let res = await listApi(this.searchModel);
      if (res && res.code == 200) {
        //设置表格数据
        this.tableList = res.data.records;
        this.searchModel.total = res.data.total;
      }
    },
    //确定
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
            this.$message.success(res.msg);
            this.getList();
            this.addDialog.visible = false;
          }
        }
      });
    },
    //关闭
    onClose() {
      this.addDialog.visible = false;
    },
    addBtn() {
      //清空表单
      this.$resetForm("addForm", this.addModel);
      //设置弹框属性
      this.addDialog.title = "新增缺勤";
      this.addDialog.visible = true;
      this.addModel.type = "0";
    },
  },
};
</script>

<style lang="scss" scoped>
</style>