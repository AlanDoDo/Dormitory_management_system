<template>
  <el-container>
    <el-header class="header">
      <el-form :model="searchModel" :inline="true" size="small">
        <el-form-item style="margin-top: 0px; margin-bottom: 0px">
          <el-date-picker
            style="width: 100%"
            v-model="searchModel.classYear"
            type="year"
            placeholder="选择年份"
            value-format="yyyy"
          >
          </el-date-picker>
        </el-form-item>
        <el-form-item style="margin-top: 0px; margin-bottom: 0px">
          <el-input
            v-model="searchModel.className"
            placeholder="请输入班级"
          ></el-input>
        </el-form-item>
        <el-form-item style="margin-top: 0px; margin-bottom: 0px">
          <el-button icon="el-icon-search" @click="searchBtn">搜索</el-button>
          <el-button
            @click="resetBtn"
            style="color: #ff7670"
            icon="el-icon-close"
            >重置</el-button
          >
          <el-button icon="el-icon-plus" type="primary" @click="assignBtn('0')"
            >分配男生宿舍</el-button
          >
          <el-button icon="el-icon-plus" type="success" @click="assignBtn('1')"
            >分配女生宿舍</el-button
          >
          <el-button icon="el-icon-plus" type="danger" @click="clearBtn()"
            >清空宿舍</el-button
          >
        </el-form-item>
      </el-form>
    </el-header>
    <el-container>
      <el-aside width="270px" class="leftside">
        <div class="item-container" :style="{ height: assideHeight + 'px' }">
          <div
            v-for="(item, index) in classList"
            :key="index"
            class="side-item"
            :id="'class' + index"
            @click="itemClick(item, index)"
            :class="{ isActive: isChange === index }"
          >
            <div class="item-left">
              <div class="class-title">
                {{ item.className
                }}<span style="margin-left: 10px; font-size: 12px"
                  >(总共:{{ item.stuCount }}人)</span
                >
              </div>
              <div class="class-sex">
                <div class="man">男:{{ item.manCount }}人</div>
                <div class="girl">女:{{ item.girlCount }}人</div>
              </div>
            </div>
            <i class="el-icon-arrow-right item-right"></i>
          </div>
        </div>
        <!-- 分页 -->
        <el-pagination
          class="pages"
          @size-change="sizeChange"
          @current-change="currentChange"
          :current-page.sync="searchModel.currentPage"
          :page-sizes="[10, 20, 40, 80, 100]"
          :page-size="searchModel.pageSize"
          layout="prev, next"
          prev-text="上一页"
          next-text="下一页"
          :total="searchModel.total"
          small
        >
        </el-pagination>
      </el-aside>
      <el-main>
        <!-- 表格 -->
        <el-table
          :data="tableList"
          :height="tableHeight"
          style="margin-top: 0px"
          border
          stripe
        >
          <el-table-column width="100" type="expand">
            <template slot-scope="scope">
              <el-table border :data="scope.row.children">
                <el-table-column
                  label="床位编号"
                  prop="bedCode"
                ></el-table-column>
                <el-table-column label="操作" align="center" width="180">
                  <template slot-scope="scope">
                    <el-button
                      round
                      icon="el-icon-delete"
                      type="danger"
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
        </el-table>
      </el-main>
    </el-container>
    <!-- 分配弹框 -->
    <sys-dialog
      :title="assignDialog.title"
      :width="assignDialog.width"
      :height="assignDialog.height"
      :visible="assignDialog.visible"
      @onConfirm="onConfirm"
      @onClose="onClose"
    >
      <div slot="content">
        <el-container style="height: 500px">
          <el-header style="border-bottom: 1px solid #dcdfe6; height: 40px">
            <el-form :inline="true" size="small">
              <el-form-item style="margin-buttom: 0px" label="楼栋">
                <el-select
                  @change="selectBuildChange"
                  v-model="parms.buildId"
                  placeholder="请选择楼栋"
                >
                  <el-option
                    v-for="item in buildList"
                    :key="item.buildId"
                    :label="item.buildName"
                    :value="item.buildId"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
              <el-form-item style="margin-buttom: 0px" label="楼层">
                <el-select
                  @change="selectDestory"
                  v-model="parms.storeyId"
                  placeholder="请选择楼层"
                >
                  <el-option
                    v-for="item in storeyList"
                    :key="item.storeyId"
                    :label="item.storeyName"
                    :value="item.storeyId"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
              <el-form-item style="margin-buttom: 0px">
                <el-button icon="el-icon-search">查询</el-button>
                <el-button style="color: #ff7670" icon="el-icon-close"
                  >取消</el-button
                >
              </el-form-item>
            </el-form>
          </el-header>
          <el-main>
            <el-tree
              ref="assignTree"
              default-expand-all
              :data="roomList"
              show-checkbox
              node-key="roomId"
              :props="defaultProps"
            >
            </el-tree>
          </el-main>
        </el-container>
      </div>
    </sys-dialog>
  </el-container>
</template>

<script>
import SysDialog from "@/components/dialog/SysDialog.vue";
import { getAssignClassApi } from "@/api/classes.js";
import { getBuildListBySexApi, getDestoryListApi } from "@/api/build.js";
import {
  getRoomByStoreyIdApi,
  assignSaveBedApi,
  getAssignBedListApi,
  deleteAssignApi,
  clearBedApi,
} from "@/api/setAssign.js";
export default {
  components: {
    SysDialog,
  },
  data() {
    return {
      tableHeight: 0,
      tableList: [],
      defaultProps: {
        children: "children",
        label: "roomCode",
      },
      roomList: [],
      storeyList: [],
      parms: {
        buildId: "",
        storeyId: "",
      },
      buildList: [],
      bed: {
        classId: "",
        className: "",
        girlCount: 0,
        manCount: 0,
        total: 0,
        sex: "",
      },
      //弹框属性
      assignDialog: {
        title: "",
        height: 500,
        width: 800,
        visible: false,
      },
      isChange: 0,
      assideHeight: 0,
      classList: [],
      searchModel: {
        currentPage: 1,
        pageSize: 10,
        className: "",
        classYear: "",
        total: 0,
      },
    };
  },
  created() {
    this.getAssignClass();
  },
  mounted() {
    this.$nextTick(() => {
      this.assideHeight = window.innerHeight - 200;
      this.tableHeight = window.innerHeight - 200;
    });
  },
  methods: {
    //清空宿舍
    async clearBtn() {
      if (!this.bed.classId) {
        this.$message.warning("请选择要清空宿舍的班级!");
        return;
      }
      const confirm = await this.$myconfirm(
        "确定清空【" + this.bed.className + "】的宿舍吗?"
      );
      if (confirm) {
        let parm = {
          classId: this.bed.classId,
        };
        let res = await clearBedApi(parm);
        if (res && res.code == 200) {
          this.$message.success(res.msg);
          this.getAssignBedList(this.bed.classId);
        }
        console.log(parm);
      }
    },
    //重置按钮
    resetBtn() {
      this.searchModel.className = "";
      this.searchModel.classYear = "";
      this.getAssignClass();
    },
    //搜索按钮
    searchBtn() {
      this.getAssignClass();
    },
    //删除床位
    async childDelete(row) {
      console.log(row);
      const confirm = await this.$myconfirm("确定删除该数据吗?");
      if (confirm) {
        let parm = {
          bedId: row.bedId,
          classId: this.bed.classId,
        };
        let res = await deleteAssignApi(parm);
        if (res && res.code == 200) {
          this.$message.success(res.msg);
          this.getAssignBedList(this.bed.classId);
        }
      }
    },
    //根据班级id查询宿舍
    async getAssignBedList(classId) {
      let res = await getAssignBedListApi({
        classId: classId,
      });
      if (res && res.code == 200) {
        this.tableList = res.data;
      }
    },
    //层数选项事件
    async selectDestory(val) {
      let res = await getRoomByStoreyIdApi({
        storeyId: val,
      });
      if (res && res.code == 200) {
        this.roomList = res.data;
      }
    },
    async selectBuildChange(val) {
      //清空层数
      this.parms.storeyId = "";
      this.storeyList = [];
      this.roomList = [];
      //查询楼栋的层数
      let res = await getDestoryListApi({
        buildId: val,
      });
      if (res && res.code == 200) {
        this.storeyList = res.data;
      }
    },
    //分配取消
    onClose() {
      this.assignDialog.visible = false;
    },
    //分配确定
    async onConfirm() {
      //判断是否选择班级
      if (!this.bed.classId) {
        this.$message.warning("请选择班级");
        return;
      }
      let ids = this.$refs.assignTree.getCheckedNodes();
      if (ids.length == 0) {
        this.$message.warning("请选择宿舍");
        return;
      }
      //存放组装的数据
      let list = [];
      //组装数据
      for (let i = 0; i < ids.length; i++) {
        if (ids[i].type == "0") {
          let obj = {};
          obj.bedId = ids[i].roomId;
          obj.classId = this.bed.classId;
          list.push(obj);
        }
      }
      console.log(list);
      //提交数据保存
      let res = await assignSaveBedApi(list);
      if (res && res.code == 200) {
        this.$message.success(res.msg);
        this.assignDialog.visible = false;
        this.getAssignBedList(this.bed.classId);
      }
    },
    //分配按钮点击事件
    async assignBtn(type) {
      //清空楼栋
      this.parms.buildId = "";
      this.parms.storeyId = "";
      this.buildList = [];
      this.roomList = [];
      this.storeyList = [];
      //获取楼栋列表
      let res = await getBuildListBySexApi({
        type: type,
      });
      if (res && res.code == 200) {
        this.buildList = res.data;
      }
      type == "0" ? (this.bed.sex = "男生") : (this.bed.sex = "女生");
      type == "0"
        ? (this.bed.total = this.bed.manCount)
        : (this.bed.total = this.bed.girlCount);
      //设置弹框属性
      this.assignDialog.title =
        "为【" +
        this.bed.className +
        "】分配【" +
        this.bed.sex +
        "】宿舍,需要【" +
        this.bed.total +
        "】个床位";
      this.assignDialog.visible = true;
    },
    //页数改变时触发
    currentChange(val) {
      this.searchModel.currentPage = val;
      this.getAssignClass();
    },
    //页容量改变时触发
    sizeChange(val) {
      this.searchModel.pageSize = val;
      this.getAssignClass();
    },
    //左侧班级点击事件
    itemClick(item, index) {
      console.log("点击班级");
      this.isChange = index;
      console.log(item);
      this.bed.classId = item.classId;
      this.bed.className = item.className;
      this.bed.girlCount = item.girlCount;
      this.bed.manCount = item.manCount;
      this.getAssignBedList(this.bed.classId);
    },
    async getAssignClass() {
      let res = await getAssignClassApi(this.searchModel);
      if (res && res.code == 200) {
        console.log(res);
        this.classList = res.data.records;
        this.searchModel.total = res.data.total;
        this.$nextTick(() => {
          document.querySelector("#class0").click();
        });
      }
    },
  },
};
</script>

<style lang="scss" scoped>
.header {
  // height: 50px !important;
  border-bottom: 1px solid #dcdfe6;
  display: flex;
  align-items: center;
}
.item-container {
  display: flex;
  flex-direction: column;
}
.leftside {
  border-right: 1px solid #dcdfe6;
  border-bottom: 1px solid #dcdfe6;
  display: flex;
  flex-direction: column;
  .side-item {
    display: flex;
    height: 55px;
    border-bottom: 1px solid #dcdfe6;
    align-items: center;
    cursor: pointer;
    .item-left {
      padding-left: 10px;
      flex-grow: 1;
      .class-title {
        color: #686868;
        font-size: 13px;
      }
      .class-sex {
        display: flex;
        color: #999;
        font-size: 12px;
        padding-top: 8px;
        .man {
          flex-grow: 1;
        }
        .girl {
          flex-grow: 1;
        }
      }
    }
    .item-right {
      padding-right: 10px;
      color: #b2b2b2;
    }
  }
}
.pages {
  text-align: center;
}
.isActive {
  background: #f8f8f8;
}
</style>