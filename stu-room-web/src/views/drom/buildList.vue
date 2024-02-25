<template>
  <el-main>
    <!-- 搜索栏 -->
    <el-form :model="searchModel" :inline="true" size="small">
      <el-form-item>
        <el-input
          v-model="searchModel.buildName"
          placeholder="请输入楼栋名称"
        ></el-input>
      </el-form-item>
      <el-form-item>
        <el-button icon="el-icon-search" @click="searchBtn">搜索</el-button>
        <el-button style="color: #ff7670" icon="el-icon-close" @click="resetBtn"
          >重置</el-button
        >
        <el-button
          v-permission="['sys:buildList:add']"
          icon="el-icon-plus"
          type="primary"
          @click="addBtn"
          >新增</el-button
        >
      </el-form-item>
    </el-form>
    <!-- 表格 -->
    <el-table
      :header-cell-style="{ background: '#FAFAFA' }"
      :data="tableList"
      @expand-change="expandChange"
      :height="tableHeight"
      border
      stripe
    >
      <el-table-column width="100" type="expand">
        <!-- 子表格
        1；type="expand"
         -->
        <template slot-scope="scope">
          <el-table border :data="scope.row.storeys">
            <el-table-column
              label="层数"
              align="center"
              prop="storeyName"
            ></el-table-column>
            <el-table-column
              label="序号"
              align="center"
              prop="orderNum"
            ></el-table-column>
            <el-table-column label="操作" align="center" width="180">
              <template slot-scope="scope">
                <el-button
                  round
                  icon="el-icon-edit"
                  type="success"
                  size="mini"
                  @click="childEdit(scope.row)"
                  >编辑</el-button
                >
                <el-button
                  round
                  icon="el-icon-delete"
                  type="warning"
                  size="mini"
                  @click="childDelete(scope.row)"
                  >删除</el-button
                >
              </template>
            </el-table-column>
          </el-table>
        </template>
      </el-table-column>
      <el-table-column prop="buildName" label="名称"></el-table-column>
      <el-table-column prop="sex" label="性别">
        <template slot-scope="scope">
          <el-tag
            v-if="scope.row.sex == '0'"
            type="danger"
            size="small"
            effect="dark"
            >男</el-tag
          >
          <el-tag
            v-if="scope.row.sex == '1'"
            type="blue"
            size="small"
            effect="dark"
            >女</el-tag
          >
        </template>
      </el-table-column>
      <el-table-column prop="buildStorey" label="层数"></el-table-column>
      <el-table-column prop="orderNum" label="序号"></el-table-column>
      <el-table-column
        v-if="
          $checkPermission([
            'sys:buildList:addStorey',
            'sys:buildList:delete',
            'sys:buildList:edit',
          ])
        "
        label="操作"
        align="center"
        width="300"
      >
        <template slot-scope="scope">
          <el-button
            v-permission="['sys:buildList:edit']"
            icon="el-icon-edit"
            type="primary"
            size="mini"
            @click="buildEdit(scope.row)"
            >编辑</el-button
          >
          <el-button
            v-permission="['sys:buildList:delete']"
            icon="el-icon-delete"
            type="danger"
            size="mini"
            @click="buildDelete(scope.row)"
            >删除</el-button
          >
          <el-button
            v-permission="['sys:buildList:addStorey']"
            icon="el-icon-plus"
            type="success"
            size="mini"
            @click="storeyAdd(scope.row)"
            >新增层数</el-button
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
              <el-form-item prop="buildName" label="栋数名称">
                <el-input
                  v-model="addModel.buildName"
                  placeholder="请输入栋数名称"
                ></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item prop="buildStorey" label="层数">
                <el-input
                  :disabled="disabled"
                  type="number"
                  v-model="addModel.buildStorey"
                  placeholder="请输入层数"
                ></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item prop="userId" label="管理员">
                <el-select
                  style="width: 100%"
                  v-model="addModel.userId"
                  placeholder="请选择管理员"
                >
                  <el-option
                    v-for="item in userList"
                    :key="item.userId"
                    :label="item.nickName"
                    :value="item.userId"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item prop="sex" label="性别">
                <el-radio-group v-model="addModel.sex">
                  <el-radio :label="'0'">男</el-radio>
                  <el-radio :label="'1'">女</el-radio>
                </el-radio-group>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item label="序号">
                <el-input
                  type="number"
                  v-model="addModel.orderNum"
                  placeholder="请输入序号"
                ></el-input>
              </el-form-item>
            </el-col>
          </el-row>
        </el-form>
      </div>
    </sys-dialog>
    <!-- 新增层数弹框 -->
    <sys-dialog
      :title="dstireyDialog.title"
      :height="dstireyDialog.height"
      :width="dstireyDialog.width"
      :visible="dstireyDialog.visible"
      @onClose="destoryClose"
      @onConfirm="destoryConfirm"
    >
      <div slot="content">
        <el-form
          :model="destoryModel"
          ref="destoryForm"
          :rules="destoryRules"
          label-width="80px"
          :inline="false"
          size="small"
        >
          <el-form-item prop="storeyName" label="层数名称">
            <el-input v-model="destoryModel.storeyName"></el-input>
          </el-form-item>
          <el-form-item prop="orderNum" label="序号">
            <el-input v-model="destoryModel.orderNum"></el-input>
          </el-form-item>
        </el-form>
      </div>
    </sys-dialog>
  </el-main>
</template>

<script>
import {
  getUserListApi,
  addApi,
  listApi,
  editApi,
  deleteApi,
  addStroyApi,
  editStoryApi,
  deleteStoryApi,
} from "@/api/build.js";
import SysDialog from "@/components/dialog/SysDialog.vue";
export default {
  components: {
    SysDialog,
  },
  data() {
    return {
      destoryRules: {
        storeyName: [
          {
            trigger: "blur",
            required: true,
            message: "请填写层数名称",
          },
        ],
        orderNum: [
          {
            trigger: "blur",
            required: true,
            message: "请填写序号",
          },
        ],
      },
      destoryModel: {
        storeyId: "",
        type: "",
        buildId: "",
        storeyName: "",
        orderNum: "",
      },
      //层数弹框属性
      dstireyDialog: {
        title: "",
        height: 150,
        width: 650,
        visible: false,
      },
      disabled: false,
      tableHeight: 0,
      //表单验证规则
      rules: {
        userId: [
          {
            trigger: "blur",
            required: true,
            message: "请选择管理员",
          },
        ],
        buildStorey: [
          {
            trigger: "blur",
            required: true,
            message: "请填写层数",
          },
        ],
        sex: [
          {
            trigger: "blur",
            required: true,
            message: "请选择性别",
          },
        ],
        buildName: [
          {
            trigger: "blur",
            required: true,
            message: "请填写栋数名称",
          },
        ],
      },
      //弹框属性
      addDialog: {
        title: "",
        height: 200,
        width: 650,
        visible: false,
      },
      //表单绑定的对象
      addModel: {
        type: "",
        buildId: "",
        userId: "",
        buildStorey: "",
        sex: "",
        buildName: "",
        orderNum: "",
      },
      //查询列表的参数
      searchModel: {
        buildName: "",
        total: 0,
        currentPage: 1,
        pageSize: 10,
      },
      userList: [],
      tableList: [],
    };
  },
  mounted() {
    this.$nextTick(() => {
      this.tableHeight = window.innerHeight - 230;
    });
  },
  created() {
    this.getUserList();
    this.getList();
  },
  methods: {
    //新增层数弹框确定
    destoryConfirm() {
      this.$refs.destoryForm.validate(async (valid) => {
        console.log(this.destoryModel);
        if (valid) {
          console.log(this.destoryModel);
          let res = null;
          if (this.destoryModel.type == "0") {
            res = await addStroyApi(this.destoryModel);
          } else {
            res = await editStoryApi(this.destoryModel);
          }
          if (res && res.code == 200) {
            this.$message.success(res.msg);
            this.getList();
            this.dstireyDialog.visible = false;
          }
        }
      });
    },
    //新增层数关闭
    destoryClose() {
      this.dstireyDialog.visible = false;
    },
    //层删除按钮
    async childDelete(row) {
      console.log(row);
      const confirm = await this.$myconfirm("确定删除该数据吗?");
      if (confirm) {
        let res = await deleteStoryApi({
          buildId: row.buildId,
          storeyId: row.storeyId,
        });
        if (res && res.code == 200) {
          this.$message.success(res.msg);
          this.getList();
        }
      }
    },
    //层编辑按钮
    childEdit(row) {
      //清空表单
      this.$resetForm("destoryForm", this.destoryModel);
      //设置编辑回显的数据
      this.$objCoppy(row, this.destoryModel);
      this.destoryModel.type = "1";
      this.dstireyDialog.title = "编辑层数";
      this.dstireyDialog.visible = true;
      this.destoryModel.buildId = row.buildId;
    },
    //删除按钮
    async buildDelete(row) {
      //信息确定
      const confirm = await this.$myconfirm("确定删除该数据吗?");
      if (confirm) {
        let res = await deleteApi({
          buildId: row.buildId,
        });
        if (res && res.code == 200) {
          this.$message.success(res.msg);
          //刷新列表
          this.getList();
        }
      }
    },
    //编辑按钮
    buildEdit(row) {
      console.log(row);
      this.$resetForm("addForm", this.addModel);
      //数据回显
      this.$objCoppy(row, this.addModel);
      this.disabled = true;
      //弹框属性设置
      this.addDialog.title = "编辑栋数";
      this.addDialog.visible = true;
      this.addModel.type = "1";
    },
    //页数改变时触发
    currentChange(val) {
      this.searchModel.currentPage = val;
      this.getList()
    },
    //页容量改变时触发
    sizeChange(val) {
      this.searchModel.pageSize = val;
      this.getList()
    },
    //新增层数事件
    storeyAdd(row) {
      //清空表单
      this.$resetForm("destoryForm", this.destoryModel);
      this.destoryModel.type = "0";
      this.dstireyDialog.title = "新增层数";
      this.dstireyDialog.visible = true;
      this.destoryModel.buildId = row.buildId;
    },
    expandChange(row, expandedRows) {
      console.log(row);
      console.log(expandedRows);
    },
    //列表查询
    async getList() {
      let res = await listApi(this.searchModel);
      if (res && res.code == 200) {
        //设置表格数据
        this.tableList = res.data.records;
        this.searchModel.total = res.data.total;
      }
    },
    //管理员数据
    async getUserList() {
      let res = await getUserListApi();
      if (res && res.code) {
        this.userList = res.data;
      }
    },
    //弹框确定
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
    //弹框关闭
    onClose() {
      this.addDialog.visible = false;
    },
    //新增按钮
    addBtn() {
      this.$resetForm("addForm", this.addModel);
      //弹框属性设置
      this.disabled = false;
      this.addDialog.title = "新增栋数";
      this.addDialog.visible = true;
      this.addModel.type = "0";
    },
    //重置按钮
    resetBtn() {
      this.searchModel.buildName = "";
      this.searchModel.currentPage = 1;
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