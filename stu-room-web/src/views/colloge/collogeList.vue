<template>
  <el-main>
    <!-- 搜索栏 -->
    <el-form :model="searchForm" label-width="80px" :inline="true" size="mini">
      <el-form-item>
        <el-input
          v-model="searchForm.collageName"
          placeholder="请输入学院的名称"
        ></el-input>
      </el-form-item>
      <el-form-item>
        <el-button icon="el-icon-search" @click="searchBtn">搜索</el-button>
        <el-button style="color: #ff7670" icon="el-icon-close" @click="resetBtn"
          >重置</el-button
        >
        <el-button
          v-permission="['sys:collogeList:add']"
          icon="el-icon-plus"
          type="primary"
          @click="addBtn"
          >新增</el-button
        >
      </el-form-item>
    </el-form>
    <!-- 列表 -->
    <el-table :height="tableHeight" :data="tableList" border stripe>
      <el-table-column prop="collageName" label="学院名称"></el-table-column>
      <el-table-column prop="orderNum" label="序号"></el-table-column>
      <el-table-column
        v-if="
          $checkPermission(['sys:collogeList:edit', 'sys:collogeList:delete'])
        "
        label="操作"
        align="center"
        width="250"
      >
        <template slot-scope="scope">
          <el-button
            v-permission="['sys:collogeList:edit']"
            type="primary"
            icon="el-icon-edit"
            size="small"
            @click="editBtn(scope.row)"
            >编辑</el-button
          >
          <el-button
            v-permission="['sys:collogeList:delete']"
            type="danger"
            icon="el-icon-delete"
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
      :current-page.sync="searchForm.currentPage"
      :page-sizes="[10, 20, 40, 80, 100]"
      :page-size="searchForm.pageSize"
      layout="total, sizes, prev, pager, next, jumper"
      :total="searchForm.total"
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
          :model="addModel"
          ref="addForm"
          :rules="rules"
          label-width="80px"
          :inline="false"
          size="small"
        >
          <el-form-item prop="collageName" label="学院名称">
            <el-input
              v-model="addModel.collageName"
              placeholder="请输入学院名称"
            ></el-input>
          </el-form-item>
          <el-form-item label="序号">
            <el-input
              v-model="addModel.orderNum"
              placeholder="请输入序号"
            ></el-input>
          </el-form-item>
        </el-form>
      </div>
    </sys-dialog>
  </el-main>
</template>

<script>
import { addApi, listApi, editApi, deleteApi } from "@/api/college.js";
import SysDialog from "@/components/dialog/SysDialog.vue";
export default {
  //注册组件
  components: {
    SysDialog,
  },
  data() {
    return {
      //表格高度
      tableHeight: 0,
      //表单验证规则
      rules: {
        collageName: [
          {
            trigger: "blur",
            required: true,
            message: "请输入学院名称",
          },
        ],
      },
      //表单绑定对象
      addModel: {
        type: "", //区分是新增还是编辑 0：新增 1：编辑
        collageId: "",
        collageName: "",
        orderNum: "",
      },
      //弹框属性
      addDialog: {
        title: "",
        height: 150,
        width: 650,
        visible: false,
      },
      //搜索表单
      searchForm: {
        collageName: "",
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
    //页数改变时触发
    currentChange(page) {
      this.searchForm.currentPage = page;
      this.getList();
    },
    //页容量改变时触发
    sizeChange(size) {
      this.searchForm.pageSize = size;
      this.getList();
    },
    //删除按钮
    async deleteBtn(row) {
      //信息提示
      let confirm = await this.$myconfirm("确定删除该数据吗?");
      if (confirm) {
        let res = await deleteApi({
          collageId: row.collageId,
        });
        if (res && res.code == 200) {
          //信息提示
          this.$message.success(res.msg);
          //刷新列表
          this.getList();
        }
      }
    },
    //编辑按钮
    editBtn(row) {
      //清空表单
      this.$resetForm("addForm", this.addModel);
      //把要编辑的数据设置到表单绑定的对象
      this.$objCoppy(row, this.addModel);
      //设置编辑的属性
      this.addModel.type = "1";
      //设置弹框属性
      this.addDialog.title = "编辑学院";
      this.addDialog.visible = true;
    },
    //获取列表
    async getList() {
      let res = await listApi(this.searchForm);
      if (res && res.code == 200) {
        console.log(res);
        //设置表格数据
        this.tableList = res.data.records;
        //总条数
        this.searchForm.total = res.data.total;
      }
    },
    //弹框关闭
    onClose() {
      this.addDialog.visible = false;
    },
    //弹框确定
    onConfirm() {
      //表单验证
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
            this.addDialog.visible = false;
            //刷新列表
            this.getList();
          }
        }
      });
    },
    //新增
    addBtn() {
      //清空表单
      this.$resetForm("addForm", this.addModel);
      //设置弹框属性
      this.addDialog.title = "新增学院";
      this.addDialog.visible = true;
      //设置编辑的属性
      this.addModel.type = "0"; //新增
    },
    //重置按钮
    resetBtn() {
      this.searchForm.currentPage = 1;
      this.searchForm.collageName = "";
      this.getList();
    },
    //搜索按钮
    searchBtn() {
      this.getList();
    },
  },
};
</script>

<style lang="scss" scoped>
</style>