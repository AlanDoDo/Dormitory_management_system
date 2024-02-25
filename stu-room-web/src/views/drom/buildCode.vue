<template>
  <el-main class="build-main">
    <!-- 楼栋布局 -->
    <el-divider content-position="left">楼宇</el-divider>
    <div class="build-list">
      <div
        class="build-item"
        :id="'build' + index"
        @click="btnClick(item.buildId, index)"
        v-for="(item, index) in buildList"
        :key="index"
        :class="{ isActive: isChange === index }"
      >
        {{ item.buildName }}
        <div>
          (<span v-if="item.sex == '0'">男</span>
          <span v-if="item.sex == '1'">女</span>)
        </div>
      </div>
    </div>
    <el-container class="containers">
      <el-aside
        class="leftAsside"
        :style="{ height: leftHeight + 'px' }"
        width="150px"
      >
        <div
          v-for="(item, index) in destoryList"
          :key="index"
          :id="'storey' + index"
          class="storey-item"
          :class="{ destoryActive: isDestory === index }"
          @click="storyClick(item.storeyId, index)"
        >
          {{ item.storeyName }}
        </div>
      </el-aside>
      <el-main class="mains">
        <el-button
          v-permission="['sys:buildCode:add']"
          type="primary"
          icon="el-icon-plus"
          size="small"
          @click="addBtn"
          >设置编号</el-button
        >
        <el-button
          v-permission="['sys:buildCode:initBed']"
          type="primary"
          icon="el-icon-plus"
          size="small"
          @click="initBed"
          >初始化床位</el-button
        >
        <!-- 表格 -->
        <!-- 表格 -->
        <el-table
          :data="tableList"
          :height="tableHeight"
          style="margin-top: 10px"
          border
          stripe
        >
          <el-table-column width="100" type="expand">
            <!-- 子表格
        1；type="expand"
         -->
            <template slot-scope="scope">
              <el-table border :data="scope.row.bedList">
                <el-table-column
                  label="床位编号"
                  prop="bedCode"
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
          <el-table-column prop="roomCode" label="宿舍编号"></el-table-column>
          <el-table-column align="center" prop="roomCode" label="宿舍类型">
            <template slot-scope="scope">
              <el-tag v-if="scope.row.rootType == '1'" size="small"
                >1人间</el-tag
              >
              <el-tag
                v-if="scope.row.rootType == '2'"
                type="danger"
                size="small"
                >2人间</el-tag
              >
              <el-tag
                v-if="scope.row.rootType == '4'"
                type="success"
                size="small"
                >4人间</el-tag
              >
              <el-tag
                v-if="scope.row.rootType == '6'"
                type="warning"
                size="small"
                >6人间</el-tag
              >
            </template>
          </el-table-column>
          <el-table-column
            align="center"
            prop="totalBed"
            label="人数"
          ></el-table-column>
          <el-table-column align="center" label="操作" width="200">
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
          :current-page.sync="listParm.currentPage"
          :page-sizes="[10, 20, 40, 80, 100]"
          :page-size="listParm.pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="listParm.total"
          background
        >
        </el-pagination>
      </el-main>
    </el-container>
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
          <el-form-item prop="area" label="区域">
            <el-input v-model="addModel.area"></el-input>
          </el-form-item>
          <el-row>
            <el-col :span="12" :offset="0">
              <el-form-item prop="start" label="起始编号">
                <el-input v-model="addModel.start"></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="12" :offset="0">
              <el-form-item prop="end" label="结束编号">
                <el-input v-model="addModel.end"></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-form-item prop="rootType" label="类型">
            <el-select
              @change="selectChange"
              v-model="addModel.rootType"
              placeholder="请选择"
            >
              <el-option
                v-for="item in options"
                :key="item.value"
                :label="item.label"
                :value="item.value"
              >
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item prop="stuNum" label="人数">
            <el-input v-model="addModel.stuNum"></el-input>
          </el-form-item>
        </el-form>
      </div>
    </sys-dialog>
    <!-- 编辑弹框 -->
    <sys-dialog
      :title="editDialog.title"
      :height="editDialog.height"
      :width="editDialog.width"
      :visible="editDialog.visible"
      @onClose="editClose"
      @onConfirm="editConfirm"
    >
      <div slot="content">
        <el-form
          :model="editModel"
          ref="editForm"
          :rules="editRules"
          label-width="80px"
          :inline="false"
          size="small"
        >
          <el-form-item prop="roomCode" label="宿舍编号">
            <el-input v-model="editModel.roomCode"></el-input>
          </el-form-item>
          <el-form-item prop="rootType" label="类型">
            <el-select
              style="width: 100%"
              @change="editSelectChange"
              v-model="editModel.rootType"
              placeholder="请选择"
            >
              <el-option
                v-for="item in options"
                :key="item.value"
                :label="item.label"
                :value="item.value"
              >
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item prop="totalBed" label="容纳人数">
            <el-input v-model="editModel.totalBed"></el-input>
          </el-form-item>
        </el-form>
      </div>
    </sys-dialog>
    <!-- 床位编辑弹框 -->
    <sys-dialog
      :title="childDialog.title"
      :height="childDialog.height"
      :width="childDialog.width"
      :visible="childDialog.visible"
      @onClose="childClose"
      @onConfirm="childConfirm"
    >
      <div slot="content">
        <el-form
          :model="childModel"
          ref="childForm"
          :rules="childRules"
          label-width="80px"
          :inline="false"
          size="small"
        >
          <el-form-item prop="bedCode" label="床位编号">
            <el-input v-model="childModel.bedCode"></el-input>
          </el-form-item>
        </el-form>
      </div>
    </sys-dialog>
  </el-main>
</template>

<script>
import SysDialog from "@/components/dialog/SysDialog.vue";
import { getBuildListApi, getDestoryListApi } from "@/api/build.js";
import { editChildApi, deleteChildApi } from "@/api/setCode.js";
import {
  addApi,
  getStoreyListApi,
  editApi,
  deleteApi,
  initBedApi,
} from "@/api/setCode.js";
export default {
  components: {
    SysDialog,
  },
  data() {
    return {
      childRules: {
        bedCode: [
          {
            trigger: "blur",
            required: true,
            message: "请填写床位编号",
          },
        ],
      },
      childModel: {
        bedId: "",
        roomId: "",
        bedCode: "",
      },
      //编辑弹框
      childDialog: {
        title: "",
        height: 100,
        width: 650,
        visible: false,
      },
      storeyId: "",
      //表单验证规则
      editRules: {
        rootType: [
          {
            trigger: "blur",
            required: true,
            message: "请选择类型",
          },
        ],
        roomCode: [
          {
            trigger: "blur",
            required: true,
            message: "请填写编号",
          },
        ],
        totalBed: [
          {
            trigger: "blur",
            required: true,
            message: "请填写人数",
          },
        ],
      },
      //编辑绑定的对象
      editModel: {
        roomId: "",
        storeyId: "",
        rootType: "",
        roomCode: "",
        totalBed: "",
      },
      //编辑弹框属性
      editDialog: {
        title: "",
        height: 180,
        width: 650,
        visible: false,
      },
      tableHeight: 0,
      //类型数据
      options: [
        {
          value: "1",
          label: "1人间",
        },
        {
          value: "2",
          label: "2人间",
        },
        {
          value: "4",
          label: "4人间",
        },
        {
          value: "6",
          label: "6人间",
        },
      ],
      //表单验证规则
      rules: {
        start: [
          {
            trigger: "blur",
            required: true,
            message: "请填写起始编号",
          },
        ],
        end: [
          {
            trigger: "blur",
            required: true,
            message: "请填写结束编号",
          },
        ],
        stuNum: [
          {
            trigger: "blur",
            required: true,
            message: "请填写人数",
          },
        ],
        rootType: [
          {
            trigger: "blur",
            required: true,
            message: "请选择类型",
          },
        ],
      },
      //新增弹框绑定的对象
      addModel: {
        area: "",
        start: "",
        end: "",
        stuNum: "",
        storeyId: "",
        rootType: "",
      },
      //新增弹框属性
      addDialog: {
        title: "",
        height: 250,
        width: 650,
        visible: false,
      },
      //点击颜色切换状态
      isDestory: 0,
      isChange: 0,
      buildList: [],
      destoryList: [],
      leftHeight: 0,
      rightHeight: 0,
      listParm: {
        currentPage: 1,
        pageSize: 10,
        total: 0,
        storeyId: "",
      },
      tableList: [],
    };
  },
  created() {
    this.getBuildList();
  },
  mounted() {
    this.$nextTick(() => {
      this.leftHeight = window.innerHeight - 230;
      this.rightHeight = window.innerHeight - 230;
      this.tableHeight = window.innerHeight - 350;
    });
  },
  methods: {
    childClose() {
      this.childDialog.visible = false;
    },
    childConfirm() {
      this.$refs.childForm.validate(async (valid) => {
        if (valid) {
          let res = await editChildApi(this.childModel);
          if (res && res.code == 200) {
            this.$message.success(res.msg);
            this.getList();
            this.childDialog.visible = false;
          }
        }
      });
    },
    //床位删除
    async childDelete(row) {
      const confirm = await this.$myconfirm("确定删除该数据吗?");
      if (confirm) {
        let res = await deleteChildApi({
          bedId: row.bedId,
        });
        if (res && res.code == 200) {
          this.$message.success(res.msg);
          this.getList();
        }
      }
    },
    //床位编辑
    childEdit(row) {
      this.childDialog.title = "编辑";
      this.childDialog.visible = true;
      //把编辑的数据回显
      this.$objCoppy(row, this.childModel);
    },
    //初始化床位
    async initBed() {
      if (!this.storeyId) {
        this.$message.error("请选择层数");
        return;
      }
      let res = await initBedApi({
        storeyId: this.storeyId,
      });
      if (res && res.code == 200) {
        this.$message.success(res.msg);
        this.getList();
      }
    },
    editSelectChange(val) {
      this.editModel.totalBed = val;
    },
    //编辑确定
    editConfirm() {
      this.$refs.editForm.validate(async (valid) => {
        if (valid) {
          let res = await editApi(this.editModel);
          if (res && res.code == 200) {
            this.$message.success(res.msg);
            this.getList();
            this.editDialog.visible = false;
          }
        }
      });
    },
    //编辑关闭
    editClose() {
      this.editDialog.visible = false;
    },
    async deleteBtn(row) {
      let confirm = await this.$myconfirm("确定删除该数据吗?");
      if (confirm) {
        let res = await deleteApi({
          roomId: row.roomId,
        });
        if (res && res.code == 200) {
          this.$message.success(res.msg);
          this.getList();
        }
      }
    },
    editBtn(row) {
      //清空表单
      this.$resetForm("editForm", this.editModel);
      //设置弹框属性
      this.editDialog.title = "编辑编号";
      this.editDialog.visible = true;
      //设置编辑 数据回显
      this.$objCoppy(row, this.editModel);
      console.log(this.editModel);
    },
    //页数改变时触发
    currentChange(val) {
      this.listParm.currentPage = val;
      this.getList();
    },
    //页容量改变时触发
    sizeChange(val) {
      this.listParm.pageSize = val;
      this.listParm.currentPage = 1;
      this.getList();
    },
    //获取表格数据
    async getList() {
      let res = await getStoreyListApi(this.listParm);
      if (res && res.code == 200) {
        //设置表格数据
        this.tableList = res.data.records;
        this.listParm.total = res.data.total;
      }
    },
    selectChange(val) {
      this.addModel.stuNum = val;
    },
    //新增按钮
    addBtn() {
      //清空表单
      this.$resetForm("addForm", this.addModel);
      //设置弹框属性
      this.addDialog.title = "设置编号";
      this.addDialog.visible = true;
      this.addModel.storeyId = this.storeyId;
    },
    //新增弹框确定
    onConfirm() {
      this.$refs.addForm.validate(async (valid) => {
        if (valid) {
          let res = await addApi(this.addModel);
          if (res && res.code == 200) {
            this.$message.success(res.msg);
            this.getList();
            this.addDialog.visible = false;
          }
        }
      });
    },
    //新增弹框关闭
    onClose() {
      this.addDialog.visible = false;
    },
    //层数点击事件
    storyClick(storeyId, index) {
      console.log("层数点击");
      this.isDestory = index;
      this.storeyId = storeyId;
      this.listParm.storeyId = storeyId;
      this.getList();
    },
    //楼栋点击事件
    btnClick(buildId, index) {
      console.log(index);
      this.isChange = index;
      this.isDestory = 0;
      this.getDestoryList(buildId);
    },
    //获取层数列表
    async getDestoryList(buildId) {
      let res = await getDestoryListApi({
        buildId: buildId,
      });
      if (res && res.code == 200) {
        console.log(res);
        this.destoryList = res.data;
        this.$nextTick(() => {
          document.querySelector("#storey0").click();
        });
      }
    },
    //获取楼栋列表
    async getBuildList() {
      let res = await getBuildListApi();
      if (res && res.code == 200) {
        this.buildList = res.data;
        //点击第一个楼栋,一定要放到 nextTick里面
        this.$nextTick(() => {
          document.querySelector("#build0").click();
        });
      }
    },
  },
};
</script>

<style lang="scss" scoped>
.build-main {
  padding-top: 0px;
}
.build-list {
  display: flex;
  flex-wrap: wrap;
}
.build-item {
  display: flex;
  padding: 8px 30px;
  margin: 10px;
  font-size: 14px;
  border: 1px solid #dedede;
  border-radius: 4px;
  cursor: pointer;
  background: #f8f8f8;
}
.isActive {
  background: #42b983;
  color: #fff;
}
.containers {
  margin-top: 20px;
  border: 1px solid #dcdfe6;
}
.leftAsside {
  border-right: 1px solid #dcdfe6;
  display: flex;
  flex-direction: column;
  align-items: center;
}
.storey-item {
  padding: 8px 30px;
  margin: 10px 10px;
  font-size: 14px;
  border: 1px solid #dedede;
  border-radius: 4px;
  cursor: pointer;
  background-color: #f8f8f8;
}
.destoryActive {
  background: #5fb878 !important;
  border-color: #5fb878 !important;
  color: #fff;
}
.mains {
  padding-top: 10px;
}
</style>