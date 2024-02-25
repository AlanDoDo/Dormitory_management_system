<template>
  <el-main>
    <!-- 新增按钮 -->
    <el-form size="small">
      <el-form-item>
        <el-button
          v-permission="['sys:sysMenuList:add']"
          type="primary"
          icon="el-icon-plus"
          @click="addBtn"
          >新增</el-button
        >
      </el-form-item>
    </el-form>
    <!-- 表格 -->
    <el-table
      :height="tableHeight"
      :data="tableData"
      style="width: 100%; margin-bottom: 20px"
      row-key="menuId"
      border
      default-expand-all
      :tree-props="{ children: 'children', hasChildren: 'hasChildren' }"
    >
      <el-table-column prop="title" label="菜单名称"> </el-table-column>
      <el-table-column prop="type" label="菜单类型">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.type == '0'">目录</el-tag>
          <el-tag v-if="scope.row.type == '1'" type="success">菜单</el-tag>
          <el-tag v-if="scope.row.type == '2'" type="danger">按钮</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="icon" label="菜单图标">
        <template slot-scope="scope">
          <i :class="scope.row.icon"></i>
        </template>
      </el-table-column>
      <el-table-column prop="name" label="路由名称"> </el-table-column>
      <el-table-column prop="path" label="路由地址"> </el-table-column>
      <el-table-column prop="url" label="组件路径"> </el-table-column>
      <el-table-column prop="code" label="权限字段"> </el-table-column>
      <el-table-column prop="orderNum" label="菜单序号"> </el-table-column>
      <el-table-column
        v-if="
          $checkPermission(['sys:sysMenuList:edit', 'sys:sysMenuList:delete'])
        "
        label="操作"
        align="center"
        width="180"
      >
        <template slot-scope="scope">
          <el-button
            v-permission="['sys:sysMenuList:edit']"
            type="primary"
            size="small"
            icon="el-icon-edit"
            @click="editBtn(scope.row)"
            >编辑</el-button
          >
          <el-button
            v-permission="['sys:sysMenuList:delete']"
            type="danger"
            size="small"
            icon="el-icon-delete"
            @click="deleteBtn(scope.row)"
            >删除</el-button
          >
        </template>
      </el-table-column>
    </el-table>
    <!-- 新增、编辑 -->
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
            <el-col :span="24" :offset="0">
              <el-form-item prop="type" label="菜单类型">
                <el-radio-group v-model="addModel.type">
                  <el-radio :label="'0'">目录</el-radio>
                  <el-radio :label="'1'">菜单</el-radio>
                  <el-radio :label="'2'">按钮</el-radio>
                </el-radio-group>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item prop="parentName" label="上级菜单">
                <el-input
                  @click.native="selectParent"
                  v-model="addModel.parentName"
                ></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item prop="title" label="菜单名称">
                <el-input v-model="addModel.title"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col v-if="addModel.type != '2'" :span="12" :offset="0">
              <el-form-item label="菜单图标">
                <el-input v-model="addModel.icon"></el-input>
              </el-form-item>
            </el-col>
            <el-col v-if="addModel.type != '2'" :span="12" :offset="0">
              <el-form-item prop="name" label="路由名称">
                <el-input v-model="addModel.name"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item label="菜单序号">
                <el-input v-model="addModel.orderNum"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item label="权限字段">
                <el-input v-model="addModel.code"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col v-if="addModel.type == '1'" :span="12" :offset="0">
              <el-form-item prop="url" label="组件路径">
                <el-input v-model="addModel.url"></el-input>
              </el-form-item>
            </el-col>
            <el-col v-if="addModel.type != '2'" :span="12" :offset="0">
              <el-form-item prop="path" label="路由地址">
                <el-input v-model="addModel.path"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
        </el-form>
      </div>
    </sys-dialog>
    <!-- 上级菜单弹框组件 -->
    <sys-dialog
      :title="parentDialog.title"
      :width="parentDialog.width"
      :height="parentDialog.height"
      :visible="parentDialog.visible"
      @onClose="onParentClose"
      @onConfirm="onParentConfirm"
    >
      <div slot="content">
        <el-tree
          ref="parentTree"
          :data="parentData"
          :props="parentDefaultProps"
          node-key="menuId"
          empty-text="暂无数据"
          :show-checkbox="false"
          :highlight-current="true"
          default-expand-all
          :expand-on-click-node="false"
          @node-click="parentHandleNodeClick"
        >
          <div slot-scope="{ node, data }">
            <!-- 如果没有下级，显示文档图标 -->
            <span v-if="data.children.length == 0">
              <i style="margin-left: 3px" class="el-icon-document"></i>
            </span>
            <!-- 有下级，判断是否展开 -->
            <span v-else @click.stop="openBtn(data)">
              <i
                v-if="data.open"
                style="margin-left: 3px"
                class="el-icon-plus"
              ></i>
              <i v-else style="margin-left: 3px" class="el-icon-minus"></i>
            </span>
            <span style="margin-left: 3px">{{ node.label }}</span>
          </div>
        </el-tree>
      </div>
    </sys-dialog>
  </el-main>
</template>

<script>
import SysDialog from "@/components/dialog/SysDialog.vue";
import {
  getListApi,
  getParentListApi,
  addMenuApi,
  editMenuApi,
  deleteMenuApi,
} from "@/api/menu";
export default {
  //注册
  components: {
    SysDialog,
  },
  data() {
    return {
      //选择的上级节点
      selectNode: {
        menuId: "",
        title: "",
      },
      parentDefaultProps: {
        children: "children",
        label: "title",
      },
      //上级菜单树数据
      parentData: [],
      //定义上级菜单弹框属性
      parentDialog: {
        title: "选择上级菜单",
        width: 300,
        height: 450,
        visible: false,
      },
      //表单验证规则
      rules: {
        parentName: [
          {
            trigger: "change",
            required: true,
            message: "请选择上级菜单",
          },
        ],
        title: [
          {
            trigger: "blur",
            required: true,
            message: "请填写菜单名称",
          },
        ],
        code: [
          {
            trigger: "blur",
            required: true,
            message: "请填写权限字段",
          },
        ],
        name: [
          {
            trigger: "blur",
            required: true,
            message: "请填写路由名称",
          },
        ],
        path: [
          {
            trigger: "blur",
            required: true,
            message: "请填写路由地址",
          },
        ],
        url: [
          {
            trigger: "blur",
            required: true,
            message: "请填写组件路径",
          },
        ],
        type: [
          {
            trigger: "blur",
            required: true,
            message: "请选择菜单类型",
          },
        ],
      },
      //表单数据
      addModel: {
        editType: "", // 0:新增 1：编辑
        menuId: "",
        parentId: "",
        title: "",
        code: "",
        name: "",
        path: "",
        url: "",
        type: "",
        icon: "",
        parentName: "",
        orderNum: "",
      },
      //弹框属性
      dialog: {
        title: "",
        visible: false,
        height: 280,
      },
      //表格高度
      tableHeight: 0,
      //表格数据
      tableData: [],
    };
  },
  created() {
    this.getList();
  },
  methods: {
    //上级部门节点加号和减号点击事件
    openBtn(data) {
      data.open = !data.open;
      this.$refs.parentTree.store.nodesMap[data.menuId].expanded = !data.open;
    },
    //上级菜单节点点击事件
    parentHandleNodeClick(node) {
      console.log(node);
      this.selectNode.menuId = node.menuId;
      this.selectNode.title = node.title;
    },
    //选择上级菜单
    async selectParent() {
      //查询树数据
      let res = await getParentListApi();
      if (res && res.code == 200) {
        this.parentData = res.data;
      }
      this.parentDialog.visible = true;
    },
    //上级菜单确定
    onParentConfirm() {
      this.addModel.parentId = this.selectNode.menuId;
      this.addModel.parentName = this.selectNode.title;
      this.parentDialog.visible = false;
    },
    //上级菜单弹框关闭
    onParentClose() {
      this.parentDialog.visible = false;
    },
    //弹框确定
    onConfirm() {
      //表单验证
      this.$refs.addRef.validate(async (valid) => {
        if (valid) {
          let res = null;
          if (this.addModel.editType == "0") {
            res = await addMenuApi(this.addModel);
          } else {
            res = await editMenuApi(this.addModel);
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
    //弹框关闭
    onClose() {
      this.dialog.visible = false;
    },
    //删除按钮
    async deleteBtn(row) {
      //信息确定
      const confirm = await this.$myconfirm("确定删除该数据吗?");
      if (confirm) {
        let res = await deleteMenuApi({ menuId: row.menuId });
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
      this.dialog.title = "编辑菜单";
      this.dialog.visible = true;
      //清空表单
      this.$resetForm("addRef", this.addModel);
      //把要编辑的数据放到表单数据域
      this.$objCoppy(row, this.addModel);
      //设置编辑属性
      this.addModel.editType = "1";
    },
    //新增按钮
    addBtn() {
      //设置弹框属性
      this.dialog.title = "新增菜单";
      this.dialog.visible = true;
      //清空表单
      this.$resetForm("addRef", this.addModel);
      //设置编辑属性
      this.addModel.editType = "0";
    },
    //表格数据获取
    async getList() {
      let res = await getListApi();
      if (res && res.code == 200) {
        console.log(res);
        this.tableData = res.data;
      }
    },
  },
  mounted() {
    this.$nextTick(() => {
      this.tableHeight = window.innerHeight - 200;
    });
  },
};
</script>


<style lang="scss" scoped>
::v-deep .el-tree {
  // 将每一行的设置为相对定位 方便后面before after 使用绝对定位来固定位置
  .el-tree-node {
    position: relative;
    padding-left: 10px;
  }
  // 子集像右偏移 给数线留出距离
  .el-tree-node__children {
    padding-left: 20px;
  }
  //这是竖线
  .el-tree-node :last-child:before {
    height: 40px;
  }
  .el-tree > .el-tree-node:before {
    border-left: none;
  }
  .el-tree > .el-tree-node:after {
    border-top: none;
  }
  //这自定义的线 的公共部分
  .el-tree-node:before,
  .el-tree-node:after {
    content: "";
    left: -4px;
    position: absolute;
    right: auto;
    border-width: 1px;
  }
  .tree :first-child .el-tree-node:before {
    border-left: none;
  }
  // 竖线
  .el-tree-node:before {
    border-left: 1px dotted #d9d9d9;
    bottom: 0px;
    height: 100%;
    top: -25px;
    width: 1px;
  }
  //横线
  .el-tree-node:after {
    border-top: 1px dotted #d9d9d9;
    height: 20px;
    top: 14px;
    width: 24px;
  }
  .el-tree-node__expand-icon.is-leaf {
    width: 8px;
  }
  //去掉elementui自带的展开按钮  一个向下的按钮,打开时向右
  .el-tree-node__content > .el-tree-node__expand-icon {
    display: none;
  }
  //每一行的高度
  .el-tree-node__content {
    line-height: 30px;
    height: 30px;
    padding-left: 10px !important;
  }
}
//去掉最上级的before  after 即是去电最上层的连接线
::v-deep .el-tree > div {
  &::before {
    display: none;
  }
  &::after {
    display: none;
  }
}
</style>