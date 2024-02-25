<template>
  <el-main>
    <!-- 搜索栏-->
    <el-form :model="searchModel" :inline="true" size="small">
      <el-form-item>
        <el-input
          v-model="searchModel.dromName"
          placeholder="宿舍名称"
        ></el-input>
      </el-form-item>
      <el-form-item>
        <el-button icon="el-icon-search" @click="searchBtn">搜索</el-button>
        <el-button icon="el-icon-close" @click="resetBtn">重置</el-button>
        <el-button v-permission="['sys:repair:add']" type="primary" icon="el-icon-plus" @click="addBtn"
          >新增</el-button
        >
      </el-form-item>
    </el-form>
    <!-- 表格 -->
    <el-table :height="tableHeight" :data="tableList" border stripe>
      <el-table-column prop="dromName" label="宿舍名称"></el-table-column>
      <el-table-column prop="username" label="联系人"></el-table-column>
      <el-table-column prop="phone" label="联系电话"></el-table-column>
      <el-table-column prop="repairText" label="维修说明"></el-table-column>
      <el-table-column prop="status" label="维修状态">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.status == '0'" type="danger" size="small"
            >未处理</el-tag
          >
          <el-tag v-if="scope.row.status == '1'" type="success" size="small"
            >已处理</el-tag
          >
        </template>
      </el-table-column>
      <el-table-column v-if="$checkPermission(['sys:repair:edit','sys:repair:delete','sys:repair:apply'])" label="操作" align="center" width="280">
        <template slot-scope="scope">
          <el-button
          v-permission="['sys:repair:edit']"
            type="primary"
            size="small"
            icon="el-icon-edit"
            @click="editBtn(scope.row)"
            >编辑</el-button
          >
          <el-button
          v-permission="['sys:repair:apply']"
            type="success"
            size="small"
            icon="el-icon-edit"
            @click="doBtn(scope.row)"
            >处理</el-button
          >
          <el-button
          v-permission="['sys:repair:delete']"
            type="danger"
            size="small"
            icon="el-icon-delete"
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
          <el-form-item prop="dromName" label="宿舍名称">
            <el-input v-model="addModel.dromName"></el-input>
          </el-form-item>
          <el-form-item prop="username" label="联系人">
            <el-input v-model="addModel.username"></el-input>
          </el-form-item>
          <el-form-item prop="phone" label="联系电话">
            <el-input v-model="addModel.phone"></el-input>
          </el-form-item>
          <el-form-item prop="repairText" label="报修内容">
            <el-input type="textarea" v-model="addModel.repairText"></el-input>
          </el-form-item>
        </el-form>
      </div>
    </sys-dialog>
  </el-main>
</template>

<script>
import { addApi, listApi, editApi, deleteApi } from "@/api/repair.js";
import SysDialog from "@/components/dialog/SysDialog.vue";
export default {
  components: {
    SysDialog,
  },
  data() {
    return {
      tableHeight: 0,
      rules: {
        username: [
          {
            trigger: "blur",
            required: true,
            message: "请填写联系人",
          },
        ],
        phone: [
          {
            trigger: "blur",
            required: true,
            message: "请填写联系电话",
          },
        ],
        dromName: [
          {
            trigger: "blur",
            required: true,
            message: "请填写宿舍名称",
          },
        ],
        repairText: [
          {
            trigger: "blur",
            required: true,
            message: "请填写报修内容",
          },
        ],
      },
      addModel: {
        repairId: "",
        username: "",
        phone: "",
        dromName: "",
        repairText: "",
        type: "",
      },
      addDialog: {
        title: "",
        width: 650,
        height: 230,
        visible: false,
      },
      searchModel: {
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
    async doBtn(row) {
      if (row.status != "0") {
        this.$message.warning("该报修已经处理，不用重复处理!");
        return;
      }
      const confirm = await this.$myconfirm("确定处理该维修?");
      if (confirm) {
        let parm = {
          repairId: row.repairId,
          status: "1",
        };
        let res = await editApi(parm);
        if (res && res.code == 200) {
          this.$message.success("处理成功");
          this.getList();
        }
      }
    },
    currentChange(val) {
      this.searchModel.currentPage = val;
      this.getList();
    },
    sizeChange(val) {
      this.searchModel.pageSize = val;
      this.getList();
    },
    async deleteBtn(row) {
      const confirm = await this.$myconfirm("确定删除该维修?");
      if (confirm) {
        let res = await deleteApi({
          repairId: row.repairId,
        });
        if (res && res.code == 200) {
          this.$message.success(res.msg);
          this.getList();
        }
      }
    },
    editBtn(row) {
      //清空表单
      this.$resetForm("addForm", this.addModel);
      this.$objCoppy(row, this.addModel);
      this.addModel.type = "1";
      //设置弹框属性
      this.addDialog.title = "编辑报修";
      this.addDialog.visible = true;
    },
    //获取列表
    async getList() {
      let res = await listApi(this.searchModel);
      if (res && res.code == 200) {
        console.log(res);
        this.tableList = res.data.records;
        this.searchModel.total = res.data.total;
      }
    },
    onConfirm() {
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
    onClose() {
      this.addDialog.visible = false;
    },
    addBtn() {
      //清空表单数据
      this.$resetForm("addForm", this.addModel);
      //设置弹框属性
      this.addDialog.title = "新增报修";
      this.addDialog.visible = true;
      this.addModel.type = "0";
    },
    resetBtn() {
      this.searchModel.dromName = "";
      this.searchModel.currentPage = 1;
      this.getList();
    },
    searchBtn() {
      this.getList();
    },
  },
};
</script>

<style lang="scss" scoped>
</style>