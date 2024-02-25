<template>
  <el-main>
    <!-- 搜索栏 -->
    <el-form
      :model="listParm"
      ref="searchRef"
      label-width="80px"
      :inline="true"
      size="small"
    >
      <el-form-item>
        <el-input
          placeholder="请输入角色名称"
          v-model="listParm.roleName"
        ></el-input>
      </el-form-item>
      <el-form-item>
        <el-button @click="searchBtn" icon="el-icon-search">搜索</el-button>
        <el-button @click="resetBtn" style="color: #ff7670" icon="el-icon-close"
          >重置</el-button
        >
        <el-button
          v-permission="['sys:sysRoleList:add']"
          type="primary"
          @click="addBtn"
          icon="el-icon-plus"
          >新增</el-button
        >
      </el-form-item>
    </el-form>
    <!-- 表格 -->
    <el-table
      :height="tableHeight"
      size="small"
      :data="tableData"
      border
      stripe
    >
    <el-table-column prop="roleId" label="角色id"></el-table-column>
      <el-table-column prop="roleName" label="角色名称"></el-table-column>
      <el-table-column prop="remark" label="角色备注"></el-table-column>
      <el-table-column label="操作" align="center" width="300">
        <template slot-scope="scope">
          <el-button
            v-permission="['sys:sysRoleList:edit']"
            type="primary"
            size="small"
            icon="el-icon-edit"
            @click="editBtn(scope.row)"
            >编辑</el-button
          >
          <el-button
            v-permission="['sys:sysRoleList:assign']"
            type="primary"
            size="small"
            icon="el-icon-edit"
            @click="assignBtn(scope.row)"
            >分配权限</el-button
          >
          <el-button
            v-permission="['sys:sysRoleList:delete']"
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
    <!-- 新增编辑弹框 -->
    <sys-dialog
      :title="dialog.title"
      :visible="dialog.visible"
      :height="dialog.height"
      @onClose="onClose"
      @onConfirm="onConfirm"
    >
      <div slot="content">
        <el-form
          :model="addModel"
          ref="addRef"
          :rules="rules"
          label-width="80px"
          size="small"
        >
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item prop="roleName" label="角色名称">
                <el-input v-model="addModel.roleName"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item prop="roleType" label="角色类型">
                <el-select v-model="addModel.roleType" placeholder="请选择">
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
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item label="角色备注">
                <el-input v-model="addModel.remark"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
        </el-form>
      </div>
    </sys-dialog>
    <!-- 分配权限弹框 -->
    <sys-dialog
      :title="assignDialog.title"
      :width="assignDialog.width"
      :height="assignDialog.height"
      :visible="assignDialog.visible"
      @onClose="assignClose"
      @onConfirm="assignConfrim"
    >
      <div slot="content">
        <el-tree
          ref="assignTree"
          :data="assignTreeData"
          node-key="menuId"
          :props="defaultProps"
          empty-text="暂无数据"
          :show-checkbox="true"
          default-expand-all
          :default-checked-keys="assignTreeChecked"
        ></el-tree>
      </div>
    </sys-dialog>
  </el-main>
</template>

<script>
import SysDialog from "@/components/dialog/SysDialog.vue";
import {
  getListApi,
  addRoleApi,
  editRoleApi,
  deleteRoleApi,
  assignRoleApi,
  saveAssignApi,
} from "@/api/role";
import { getUserId } from "@/utils/auth";
export default {
  // 注册组件
  components: {
    SysDialog,
  },
  data() {
    return {
      defaultProps: {
        children: "children",
        label: "title",
      },
      //树数据
      assignTreeData: [],
      //角色原来的权限
      assignTreeChecked: [],
      //角色Id
      roleId: "",
      //分配权限弹框属性
      assignDialog: {
        title: "",
        width: 300,
        height: 450,
        visible: false,
      },
      //角色类型
      options: [
        {
          value: "1",
          label: "系统用户",
        },
        {
          value: "2",
          label: "学生",
        },
      ],
      //表单验证规则
      rules: {
        roleName: [
          {
            trigger: "blur",
            required: true,
            message: "请填写角色名称",
          },
        ],
        roleType: [
          {
            trigger: "blur",
            required: true,
            message: "请选择角色类型",
          },
        ],
      },
      //表单数据
      addModel: {
        type: "", // 0 新增 1： 编辑
        roleId: "",
        roleName: "",
        roleType: "",
        remark: "",
      },
      //弹框属性
      dialog: {
        height: 150,
        visible: false,
        title: "",
      },
      //表格的高度
      tableHeight: 0,
      //表格数据
      tableData: [],
      //列表参数
      listParm: {
        roleName: "",
        currentPage: 1,
        pageSize: 10,
        total: 0,
      },
    };
  },
  mounted() {
    this.$nextTick(() => {
      this.tableHeight = window.innerHeight - 220;
    });
  },
  created() {
    this.getList();
  },
  methods: {
    //分配权限弹框确定
    async assignConfrim() {
      console.log(this.$refs.assignTree.getCheckedKeys());
      console.log(this.$refs.assignTree.getHalfCheckedKeys());
      let ids = this.$refs.assignTree
        .getCheckedKeys()
        .concat(this.$refs.assignTree.getHalfCheckedKeys());
      let parm = {
        roleId: this.roleId,
        list: ids,
      };
      let res = await saveAssignApi(parm);
      if (res && res.code == 200) {
        this.$message.success(res.msg);
        this.assignDialog.visible = false;
      }
    },
    //分配权限弹框关闭
    assignClose() {
      this.assignDialog.visible = false;
    },
    //分配权限按钮
    async assignBtn(row) {
      //清空数据
      this.roleId = "";
      this.assignTreeData = [];
      this.assignTreeChecked = [];
      console.log(row);
      //设置弹框属性
      this.assignDialog.title = "为【" + row.roleName + "】分配权限";
      this.roleId = row.roleId;
      this.assignDialog.visible = true;
      //获取权限树数据
      let parm = {
        roleId: row.roleId,
        userId: getUserId(),
      };
      let res = await assignRoleApi(parm);
      if (res && res.code == 200) {
        //设置树的数据
        console.log(res);
        this.assignTreeData = res.data.menuList;
        //设置回显的数据
        this.assignTreeChecked = res.data.checkList;
      }
      //获取回显的数据
      if (this.assignTreeChecked.length > 0) {
        let newArr = [];
        this.assignTreeChecked.forEach((item) => {
          this.checked(item, this.assignTreeData, newArr);
        });
        //设置选中的节点
        this.assignTreeChecked = newArr;
      }
    },
    //查询回显数据
    checked(id, data, newArr) {
      data.forEach((item) => {
        if (item.menuId == id) {
          //判断是否是最后一个节点
          if (item.children && item.children.length == 0) {
            newArr.push(item.menuId);
          }
        } else {
          if (item.children && item.children.length != 0) {
            //递归调用：自己调用自己
            this.checked(id, item.children, newArr);
          }
        }
      });
    },
    //弹框关闭
    onClose() {
      this.dialog.visible = false;
    },
    //弹框确定
    onConfirm() {
      this.$refs.addRef.validate(async (valid) => {
        if (valid) {
          let res = null;
          if (this.addModel.type == "0") {
            res = await addRoleApi(this.addModel);
          } else {
            res = await editRoleApi(this.addModel);
          }
          if (res && res.code == 200) {
            //信息提示
            this.$message({ type: "success", message: res.msg });
            //刷新列表
            this.getList();
            this.dialog.visible = false;
          }
        }
      });
    },
    //获取表格数据
    async getList() {
      let res = await getListApi(this.listParm);
      if (res && res.code == 200) {
        console.log(res);
        //赋值给表格
        this.tableData = res.data.records;
        this.total = res.data.total;
      }
    },
    //页数改变时触发
    currentChange(val) {},
    //页容量改变时触发
    sizeChange(val) {},
    //删除按钮
    async deleteBtn(row) {
      //提示
      const confirm = await this.$myconfirm("确定删除该数据吗?");
      if (confirm) {
        let res = await deleteRoleApi({ roleId: row.roleId });
        if (res && res.code == 200) {
          //信息提示
          this.$message({ type: "success", message: res.msg });
          //刷新列表
          this.getList();
        }
      }
    },
    //编辑按钮
    editBtn(row) {
      //设置弹框属性
      this.dialog.title = "编辑角色";
      this.dialog.visible = true;
      //清空表单
      this.$resetForm("addRef", this.addModel);
      this.addModel.type = "1";
      //把当前编辑的数据放到表单数据里面
      this.$objCoppy(row, this.addModel);
    },
    //新增按钮
    addBtn() {
      //设置弹框属性
      this.dialog.title = "新增角色";
      this.dialog.visible = true;
      //清空表单
      this.$resetForm("addRef", this.addModel);
      this.addModel.type = "0";
    },
    //重置按钮
    resetBtn() {
      //表单清空
      this.listParm.roleName = "";
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