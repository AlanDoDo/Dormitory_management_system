<template>
  <el-main>
    <!-- 搜索栏 -->
    <el-form :model="searchModel" :inline="true" size="small">
      <el-form-item>
        <el-input
          v-model="searchModel.userName"
          placeholder="请输入来访人姓名"
        ></el-input>
      </el-form-item>
      <el-form-item>
        <el-input
          v-model="searchModel.lookRoom"
          placeholder="请输入被访人宿舍"
        ></el-input>
      </el-form-item>
      <el-form-item>
        <el-button icon="el-icon-search" @click="searchBtn">搜索</el-button>
        <el-button style="color: #ff7670" icon="el-icon-close" @click="resetBtn"
          >重置</el-button
        >
        <el-button type="primary" icon="el-icon-plus" @click="addBtn"
          >新增</el-button
        >
      </el-form-item>
    </el-form>
    <!-- 列表查询 -->
    <el-table :height="tableHeight" :data="tableList" border stripe>
      <el-table-column prop="lookTime" label="来访时间"></el-table-column>
      <el-table-column prop="userName" label="来访人姓名"></el-table-column>
      <el-table-column prop="phone" label="来访人电话"></el-table-column>
      <el-table-column prop="lookName" label="被访人姓名"></el-table-column>
      <el-table-column prop="lookRoom" label="被访宿舍"></el-table-column>
      <el-table-column prop="leader" label="值班人"></el-table-column>
      <el-table-column prop="lookText" label="备注"></el-table-column>
      <el-table-column label="操作" align="center" width="220">
        <template slot-scope="scope">
          <el-button
            type="primary"
            icon="el-icon-edit"
            size="small"
            @click="editBtn(scope.row)"
            >编辑</el-button
          >
          <el-button
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
          label-width="100px"
          :inline="false"
          size="small"
        >
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item prop="lookTime" label="来访时间">
                <el-date-picker
                  value-format="yyyy-MM-dd HH:mm:ss"
                  v-model="addModel.lookTime"
                  type="datetime"
                  placeholder="选择日期时间"
                >
                </el-date-picker>
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item label="来访人姓名" prop="userName">
                <el-input v-model="addModel.userName"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item label="来访人电话" prop="phone">
                <el-input v-model="addModel.phone"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item label="被访人姓名" prop="lookName">
                <el-input v-model="addModel.lookName"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item label="被访宿舍" prop="lookRoom">
                <el-input v-model="addModel.lookRoom"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item label="值班员" prop="leader">
                <el-input v-model="addModel.leader"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item label="备注" prop="lookText">
                <el-input
                  type="textarea"
                  v-model="addModel.lookText"
                ></el-input>
              </el-form-item>
            </el-col>
          </el-row>
        </el-form>
      </div>
    </sys-dialog>
  </el-main>
</template>

<script>
import { addApi, listApi, editApi, deleteApi } from "@/api/look.js";
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
        lookId: "",
        lookTime: "",
        userName: "",
        phone: "",
        lookName: "",
        lookRoom: "",
        leader: "",
        lookText: "",
      },
      rules: {
        lookTime: [
          {
            trigger: "blur",
            required: true,
            message: "来访时间",
          },
        ],
        userName: [
          {
            trigger: "blur",
            required: true,
            message: "来访人姓名",
          },
        ],
        phone: [
          {
            trigger: "blur",
            required: true,
            message: "来访人电话",
          },
        ],
        lookName: [
          {
            trigger: "blur",
            required: true,
            message: "被访人姓名",
          },
        ],
        lookRoom: [
          {
            trigger: "blur",
            required: true,
            message: "被访人宿舍",
          },
        ],
        leader: [
          {
            trigger: "blur",
            required: true,
            message: "值班员",
          },
        ],
      },
      addDialog: {
        title: "",
        height: 230,
        width: 680,
        visible: false,
      },
      searchModel: {
        lookRoom: "",
        userName: "",
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
    currentChange(val) {
      this.searchModel.currentPage = val;
      this.getList();
    },
    sizeChange(val) {
      this.searchModel.pageSize = val;
      this.getList();
    },
    async deleteBtn(row) {
      const confirm = await this.$myconfirm("确定删除该数据吗?");
      if (confirm) {
        let res = await deleteApi({
          lookId: row.lookId,
        });
        if (res && res.code == 200) {
          this.$message.success(res.msg);
          this.getList();
        }
      }
    },
    editBtn(row) {
      this.$resetForm("addForm", this.addModel);
      this.$objCoppy(row, this.addModel);
      //弹框属性
      this.addDialog.title = "编辑来访";
      this.addDialog.visible = true;
      this.addModel.type = "1";
    },
    //列表查询
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
      this.$resetForm("addForm", this.addModel);
      //弹框属性
      this.addDialog.title = "新增来访";
      this.addDialog.visible = true;
      this.addModel.type = "0";
    },
    resetBtn() {
      this.searchModel.lookRoom = "";
      this.searchModel.userName = "";
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