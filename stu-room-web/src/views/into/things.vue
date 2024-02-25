<template>
  <el-main>
    <!-- 搜索栏 -->
    <el-form :model="searchModel" :inline="true" size="small">
      <el-form-item>
        <el-input
          placeholder="请输入物品名称"
          v-model="searchModel.name"
        ></el-input>
      </el-form-item>
      <el-form-item>
        <el-input
          placeholder="请输入用户名称"
          v-model="searchModel.userName"
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
    <!-- 表格 -->
    <el-table :height="tableHeight" :data="tableList" border stripe>
      <el-table-column label="出入时间" prop="intoTime"></el-table-column>
      <el-table-column label="物品名称" prop="name"></el-table-column>
      <el-table-column label="备注" prop="intoText"></el-table-column>
      <el-table-column label="联系人" prop="userName"></el-table-column>
      <el-table-column label="联系电话" prop="phone"></el-table-column>
      <el-table-column label="值班人" prop="leader"></el-table-column>
      <el-table-column label="类型" prop="status">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.status == '2'" type="danger" size="normal"
            >出楼</el-tag
          >
          <el-tag v-if="scope.row.status == '1'" type="success" size="normal"
            >进楼</el-tag
          >
        </template>
      </el-table-column>
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
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item prop="intoTime" label="来访时间">
                <el-date-picker
                  value-format="yyyy-MM-dd HH:mm:ss"
                  v-model="addModel.intoTime"
                  type="datetime"
                  placeholder="选择日期时间"
                >
                </el-date-picker>
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item label="类型" prop="status">
                <el-select v-model="addModel.status" placeholder="请选择">
                  <el-option
                    v-for="item in options"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>
          <el-form-item label="物品名称" prop="name">
            <el-input v-model="addModel.name"></el-input>
          </el-form-item>
          <el-form-item label="备注" prop="intoText">
            <el-input v-model="addModel.intoText"></el-input>
          </el-form-item>
          <el-form-item label="联系人" prop="userName">
            <el-input v-model="addModel.userName"></el-input>
          </el-form-item>
          <el-form-item label="联系电话" prop="phone">
            <el-input v-model="addModel.phone"></el-input>
          </el-form-item>
          <el-form-item label="值班人" prop="leader">
            <el-input v-model="addModel.leader"></el-input>
          </el-form-item>
        </el-form>
      </div>
    </sys-dialog>
  </el-main>
</template>

<script>
import { addApi, listApi, editApi, deleteApi } from "@/api/into.js";
import SysDialog from "@/components/dialog/SysDialog.vue";
export default {
  components: {
    SysDialog,
  },
  data() {
    return {
      tableHeight: 0,
      tableList: [],
      options: [
        {
          value: "1",
          label: "进楼",
        },
        {
          value: "2",
          label: "出楼",
        },
      ],
      addModel: {
        type: "",
        intoId: "",
        intoTime: "",
        name: "",
        intoText: "",
        userName: "",
        phone: "",
        leader: "",
        status: "",
      },
      rules: {
        intoTime: [
          {
            trigger: "blur",
            required: true,
            message: "请选择出入时间",
          },
        ],
        status: [
          {
            trigger: "blur",
            required: true,
            message: "请选择出入类型",
          },
        ],
        name: [
          {
            trigger: "blur",
            required: true,
            message: "请填写物品名称",
          },
        ],
        intoText: [
          {
            trigger: "blur",
            required: true,
            message: "请填写备注",
          },
        ],
        userName: [
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
        leader: [
          {
            trigger: "blur",
            required: true,
            message: "请填写值班人",
          },
        ],
      },
      //弹框属性
      addDialog: {
        title: "",
        height: 330,
        width: 650,
        visible: false,
      },
      searchModel: {
        name: "",
        userName: "",
        currentPage: 1,
        pageSize: 10,
        total: 0,
      },
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
          intoId: row.intoId,
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
      //设置弹框属性
      this.addDialog.title = "编辑登记";
      this.addDialog.visible = true;
      this.addModel.type = "1";
    },
    //获取数据
    async getList() {
      let res = await listApi(this.searchModel);
      if (res && res.code == 200) {
        this.tableList = res.data.records;
        this.searchModel.total = res.data.total;
      }
    },
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
    onClose() {
      this.addDialog.visible = false;
    },
    addBtn() {
      //设置弹框属性
      this.addDialog.title = "新增登记";
      this.addDialog.visible = true;
      this.addModel.type = "0";
    },
    resetBtn() {
      this.searchModel.name = "";
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