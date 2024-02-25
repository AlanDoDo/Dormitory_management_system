<template>
  <!-- 只需要把element的标签，当做一个普通的div -->
  <el-main>
    <!-- 搜索栏 
    :model： 表单绑定的数据，通常是一个对象
    ref ： 相当于一个div的id,唯一的
    :rules ： 表单验证的规则
    label-width： 表单域标签的宽度，例如 '50px'
    :inline ： 是否在同一行显示
    size： 尺寸
    -->
    <el-form
      :model="listParm"
      ref="form"
      label-width="80px"
      :inline="true"
      size="small"
    >
      <el-form-item>
        <el-input
          placeholder="请输入姓名"
          v-model="listParm.nickName"
        ></el-input>
      </el-form-item>
      <el-form-item>
        <el-input placeholder="请输入电话" v-model="listParm.phone"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button icon="el-icon-search" @click="searchBtn">搜索</el-button>
        <el-button icon="el-icon-close" style="color: #ff7670" @click="resetBtn"
          >重置</el-button
        >
        <el-button v-permission="['sys:user:add']" type="primary" icon="el-icon-plus" @click="addBtn"
          >新增</el-button
        >
      </el-form-item>
    </el-form>
    <!-- 表格 
    :data 表格的数据

    -->
    <el-table :height="tableHeight" :data="tableData" border stripe>
      <el-table-column prop="nickName" label="姓名"></el-table-column>
      <el-table-column prop="phone" label="电话"></el-table-column>
      <el-table-column prop="email" label="邮箱"></el-table-column>
      <el-table-column v-if="$checkPermission(['sys:user:edit','sys:user:delete'])" label="操作" width="180" align="center">
        <template slot-scope="scope">
          <el-button
          v-permission="['sys:user:edit']"
            type="primary"
            size="small"
            icon="el-icon-edit"
            @click="editBtn(scope.row)"
            >编辑</el-button
          >
          <el-button
          v-permission="['sys:user:delete']"
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
      :current-page.sync="listParm.currentPage"
      :page-sizes="[10, 20, 40, 80, 100]"
      :page-size="listParm.pageSize"
      layout="total, sizes, prev, pager, next, jumper"
      :total="listParm.total"
      background
    >
    </el-pagination>
    <!-- 新增或编辑弹框组件 -->
    <sys-dialog
      :title="dialog.title"
      :visible="dialog.visible"
      :width="dialog.width"
      :height="dialog.height"
      @onClose="onClose"
      @onConfirm="onConfirm"
    >
      <div slot="content">
        <!-- el-form :当做一个普通的form标签
        el-input : 相当于 普通的 input标签
          el-form-item ： 表单的每一项
          model ： 表单绑定的数据
          ref ： 相当于一个div的id , 唯一的
          rules : 表单验证规则
          label-width ： 表单域标签的宽度
          inline ： 是否在同一行显示，如果和el-row使用时，不需要该属性
          size ： 尺寸
         -->
        <el-form
          :model="addModel"
          ref="addRef"
          :rules="rules"
          label-width="80px"
          size="small"
          style="margin-right: 40px"
        >
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item prop="nickName" label="姓名">
                <el-input v-model="addModel.nickName"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item prop="phone" label="电话">
                <el-input v-model="addModel.phone"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item label="邮箱">
                <el-input v-model="addModel.email"></el-input>
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
            <el-col :span="12" :offset="0">
              <el-form-item prop="username" label="账户">
                <el-input v-model="addModel.username"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col v-if="addModel.type == '0'" :span="12" :offset="0">
              <el-form-item prop="password" label="密码">
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
import {
  getListApi,
  addUserApi,
  editUserApi,
  deleteUserApi,
  getRoleListApi,
  getRoleByUserIdApi,
} from "@/api/user";
//引入弹框组件
import SysDialog from "@/components/dialog/SysDialog.vue";
export default {
  //注册弹框组件
  components: {
    SysDialog,
  },
  data() {
    return {
      //表单验证规则
      rules: {
        nickName: [
          {
            trigger: "blur",
            required: true,
            message: "请填写姓名",
          },
        ],
        phone: [
          {
            trigger: "blur",
            required: true,
            message: "请填写电话",
          },
        ],
        roleId: [
          {
            trigger: "blur",
            required: true,
            message: "请选择角色",
          },
        ],
        sex: [
          {
            trigger: "blur",
            required: true,
            message: "请选择性别",
          },
        ],
        username: [
          {
            trigger: "blur",
            required: true,
            message: "请填写账户",
          },
        ],
        password: [
          {
            trigger: "blur",
            required: true,
            message: "请填写密码",
          },
        ],
      },
      //表单绑定的数据
      addModel: {
        type: "", //区分是新增还是编辑  0：新增 1：编辑
        userId: "",
        nickName: "",
        phone: "",
        email: "",
        sex: "",
        username: "",
        password: "",
        roleId: "",
      },
      //弹框属性
      dialog: {
        title: "",
        visible: false,
        width: 630,
        height: 220,
      },
      //表格的高度
      tableHeight: 0,
      listParm: {
        total: 0,
        pageSize: 10, //默认每页显示10条数据
        currentPage: 1,
        nickName: "",
        phone: "",
      },
      tableData: [],
      //角色列表
      roleList: [],
    };
  },
  created() {
    this.getList();
    this.getRoleList();
  },
  methods: {
    async getRoleList() {
      let res = await getRoleListApi();
      if (res && res.code == 200) {
        this.roleList = res.data;
      }
    },
    async getList() {
      let res = await getListApi(this.listParm);
      console.log("请求成功");
      console.log(res);
      if (res && res.code == 200) {
        this.tableData = res.data.records;
        this.listParm.total = res.data.total;
      }
    },
    //弹框的确定
    onConfirm() {
      //表单验证
      this.$refs.addRef.validate(async (valid) => {
        if (valid) {
          let res = null;
          if (this.addModel.type == "0") {
            res = await addUserApi(this.addModel);
          } else {
            res = await editUserApi(this.addModel);
          }
          if (res && res.code == 200) {
            //刷新表格
            this.getList();
            //信息提示
            this.$message({ type: "success", message: res.msg });
            this.dialog.visible = false;
          }
        }
      });
    },
    //弹框的取消
    onClose() {
      this.dialog.visible = false;
    },
    //页数改变时触发
    currentChange(val) {
      this.listParm.currentPage = val;
      this.getList();
    },
    //页容量改变时触发
    sizeChange(val) {
      this.listParm.pageSize = val;
      this.getList();
    },
    //编辑按钮
    async editBtn(row) {
      //设置弹框属性
      this.dialog.title = "编辑用户";
      this.dialog.visible = true;
      //清空表单
      this.$resetForm("addRef", this.addModel);
      //把当前要编辑的数据复制到表单数据域
      this.$objCoppy(row, this.addModel);
      //设置type
      this.addModel.type = "1";
       //查询用户的角色
      let res = await getRoleByUserIdApi({ userId: row.userId });
      if (res && res.code == 200 && res.data) {
        console.log(res.data);
        this.addModel.roleId = res.data.roleId;
      }
    },
    //删除按钮
    async deleteBtn(row) {
      let confirm = await this.$myconfirm("确定删除该数据吗?");
      if (confirm) {
        let res = await deleteUserApi({ userId: row.userId });
        if (res && res.code == 200) {
          //刷新表格
          this.getList();
          //信息提示
          this.$message({ type: "success", message: res.msg });
        }
      }
    },
    //搜索按钮
    searchBtn() {
      this.getList();
    },
    //重置按钮
    resetBtn() {
      this.listParm.nickName = "";
      this.listParm.phone = "";
      this.getList();
    },
    //新增按钮
    addBtn() {
      //设置弹框属性
      this.dialog.title = "新增用户";
      this.dialog.visible = true;
      //清空表单
      this.$resetForm("addRef", this.addModel);
      //设置新增还是编辑
      this.addModel.type = "0";
    },
  },
  mounted() {
    this.$nextTick(() => {
      //计算表格的高度
      this.tableHeight = window.innerHeight - 220;
    });
  },
};
</script>

<style lang="scss" scoped>
</style>