<template>
  <el-main class="build-main">
    <!-- 楼栋布局 -->
    <div class="build-list">
      <div
        class="build-item"
        :id="'build' + index"
        @click="btnClick(item.buildId, index)"
        v-for="(item, index) in buildList"
        :key="index"
        :class="{ isActive: isChange === index }"
      >
        <span>{{ item.buildName }}</span>
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
        <!-- 表格 -->
        <el-collapse
          style="overflow-y: auto"
          accordion
          :style="{ height: accordionHeight + 'px' }"
        >
          <el-collapse-item
            class="collapse-main"
            v-for="(item, index) in tableList"
            :key="index"
          >
            <template slot="title" class="room-title-header">
              <span class="room-title">{{ item.roomCode }}宿舍</span>
              <span class="room-type" v-if="item.rootType == '1'">1人间</span>
              <span class="room-type" v-if="item.rootType == '2'">2人间</span>
              <span class="room-type" v-if="item.rootType == '4'">4人间</span>
              <span class="room-type" v-if="item.rootType == '6'">6人间</span>
              <span class="room-type"
                >(共{{ item.totalBed }}个床位,已入住{{
                  item.bedList | getHasNum
                }}人)</span
              >
            </template>
            <!-- 床位列表 -->
            <div class="bedList">
              <div v-for="(bed, bindex) in item.bedList" :key="bindex">
                <!-- 已经入住 -->
                <div v-if="bed.stuId" class="bed-item-active">
                  <div class="name-icon">
                    <div class="num-text">{{ bed.bedCode }}</div>
                    <i
                      @click="deleteBtn(bed)"
                      style="color: #ff7670; font-size: 14px"
                      class="el-icon-delete"
                    ></i>
                  </div>
                  <div class="bed-main">
                    <svg-icon
                      v-if="bed.stuName"
                      class="bed-svg"
                      icon-class="bed-active"
                    />
                    <svg-icon v-else class="bed-svg" icon-class="bed-no" />
                    <div v-if="bed.stuName" class="stuInfo">
                      <div>
                        <div>
                          <span>姓名：</span>
                          <span>{{ bed.stuName }}</span>
                        </div>
                        <div>
                          <span>班级：</span>
                          <span>{{ bed.className }}</span>
                        </div>
                      </div>
                    </div>
                    <div v-else style="color: #aeb5b5">暂未入住</div>
                  </div>
                </div>
                <!-- 未入住 -->
                <dir v-else class="bed-item">
                  <div class="no-into">
                    <span class="num-text">{{ bed.bedCode }}</span>
                    <i
                      @click="addBtn(bed)"
                      style="color: #ff7670; font-size: 14px"
                      class="el-icon-plus"
                    ></i>
                  </div>
                  <div class="bed-main">
                    <svg-icon class="bed-svg" icon-class="bed-no" />
                    <div style="color: #aeb5b5">暂未入住</div>
                  </div>
                </dir>
              </div>
            </div>
          </el-collapse-item>
        </el-collapse>
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
    <!-- 学生入住弹框 -->
    <sys-dialog
      :title="addDialog.title"
      :height="addDialog.height"
      :width="addDialog.width"
      :visible="addDialog.visible"
      @onClose="onClose"
      @onConfirm="onConfirm"
    >
      <div slot="content">
        <el-form label-width="50px" size="small">
          <el-form-item label="班级">
            <el-select
              @change="selectStu"
              style="width: 100%"
              v-model="classId"
              placeholder="请选择班级"
            >
              <el-option
                v-for="item in options"
                :key="item.classId"
                :label="item.className"
                :value="item.classId"
              >
              </el-option>
            </el-select>
          </el-form-item>
        </el-form>
        <el-transfer
          v-model="value"
          :data="studentList"
          :props="{
            key: 'stuId',
            label: 'stuName',
          }"
          filterable
          :filter-method="filterMethod"
          filter-placeholder="请输入姓名"
          @left-check-change="leftChange"
          @change="btnChange"
        ></el-transfer>
      </div>
    </sys-dialog>
  </el-main>
</template>

<script>
import { getListForAssignApi } from "@/api/classes.js";
import { getClassByClassIdApi } from "@/api/student.js";
import SysDialog from "@/components/dialog/SysDialog.vue";
import { getBuildListApi, getDestoryListApi } from "@/api/build.js";
import { deleteBedApi } from "@/api/mybed";
import { saveSelectBedApi } from "@/api/setAssign.js";
import { getStoreyListApi } from "@/api/setCode.js";
export default {
  components: {
    SysDialog,
  },
  data() {
    return {
      bedId: "",
      value: [],
      studentList: [],
      classId: "",
      options: [],
      //新增弹框属性
      addDialog: {
        title: "",
        height: 400,
        width: 750,
        visible: false,
      },
      accordionHeight: 0,
      storeyId: "",
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
  filters: {
    getHasNum(children) {
      let num = 0;
      if (children && children.length > 0) {
        for (let i = 0; i < children.length; i++) {
          if (children[i].stuId) {
            num = num + 1;
          }
        }
      }
      return num;
    },
  },
  mounted() {
    this.$nextTick(() => {
      this.leftHeight = window.innerHeight - 230;
      this.rightHeight = window.innerHeight - 230;
      this.tableHeight = window.innerHeight - 350;
      this.accordionHeight = window.innerHeight - 300;
    });
  },
  methods: {
    btnChange(select, index) {
      let item = this.value;
      if (item.length > 0) {
        for (let i = 0; i < item.length; i++) {
          for (let j = 0; j < select.length; j++) {
            if (item[i] != select[j]) {
              item.splice(i, 1);
            }
          }
        }
      }
    },
    leftChange(item, index) {
      if (item.length > 0) {
        for (let i = 0; i < item.length; i++) {
          for (let j = 0; j < index.length; j++) {
            if (item[i] != index[j]) {
              item.splice(i, 1);
            }
          }
        }
      }
    },
    filterMethod(query, item) {
      return item.stuName.indexOf(query) > -1;
    },
    async selectStu(val) {
      console.log(val);
      let res = await getClassByClassIdApi({
        classId: val,
      });
      if (res && res.code == 200) {
        console.log(res);
        this.studentList = res.data;
        console.log(this.studentList);
      }
    },
    //获取班级列表
    async getListForAssign() {
      let res = await getListForAssignApi();
      if (res && res.code == 200) {
        console.log(res);
        this.options = res.data;
      }
    },
    async onConfirm() {
      console.log(this.value[0]);
      if(!this.value[0]){
        this.$message.error('请选择学生!');
        return;
      }
      let parm = {
        bedId: this.bedId,
        stuId: this.value[0],
      };
      console.log(parm);
      let res = await saveSelectBedApi(parm);
      if (res && res.code == 200) {
        this.$message.success(res.msg);
        this.getList();
        this.addDialog.visible = false;
      }
    },
    onClose() {
      this.addDialog.visible = false;
    },
    addBtn(item) {
      console.log(item);
      this.bedId = item.bedId;
      this.value = [];
      this.studentList = [];
      this.classId = '';
      //获取班级列表
      this.getListForAssign();
      // console.log(item);
      //设置弹框属性
      this.addDialog.title = "分配宿舍";
      this.addDialog.visible = true;
    },
    async deleteBtn(item) {
      console.log(item);
      const confirm = await this.$myconfirm("确定删除该学生吗?");
      if (confirm) {
        let res = await deleteBedApi({
          stuId: item.stuId,
          bedId: item.bedId,
        });
        if (res && res.code == 200) {
          this.$message.success(res.msg);
          this.getList();
        }
      }
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
.no-into {
  display: flex;
  justify-content: space-between;
  padding: 5px;
}
.name-icon {
  display: flex;
  justify-content: space-between;
  padding: 5px;
}
.room-title-header {
  display: flex;
  background: #f8f8f8;
}
.collapse-main {
  background: #f8f8f8;
  border: 1px solid #dcdfe6;
  margin: 5px 0px;
}
.stuInfo {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.bedList {
  display: flex;
  flex-wrap: wrap;
}
.room-type {
  //   color: #ff7670;
  flex-grow: 1;
  font-weight: 600;
}
.bed-main {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.bed-item {
  border: 1px solid #dedede;
  border-radius: 4px;
  background-color: #f8f8f8;
  height: 180px;
  width: 180px;
  margin: 15px 15px;
  padding-left: 0px !important;
  display: flex;
  flex-direction: column;
  cursor: pointer;
}
.bed-item-active {
  background: #f2feff;
  border: 1px solid #ddeff1;
  border-radius: 4px;
  height: 180px;
  width: 180px;
  margin: 15px 15px;
  display: flex;
  flex-direction: column;
  cursor: pointer;
}
.num-text {
  color: #8a8a8a;
}
.active-num-text {
  color: #42b983;
  font-weight: 600;
}
.bed-svg {
  font-size: 100px;
}
.build-main {
  padding-top: 25px;
  background: #f3f3f4;
}
.build-list {
  display: flex;
  flex-wrap: wrap;
  background: #fff;
}
.build-item {
  display: flex;
  padding: 8px 30px;
  margin: 10px;
  font-size: 14px;
  border: 1px solid #dedede;
  border-radius: 4px;
  cursor: pointer;
  background: #fff;
}
.isActive {
  background: #42b983;
  color: #fff;
}
.containers {
  margin-top: 20px;
  border: 1px solid #dcdfe6;
}
.room-title {
  padding-left: 15px;
  //   color: #5fb878;
  font-size: 13px;
  font-weight: 600;
  flex-grow: 1;
}
.leftAsside {
  border-right: 1px solid #dcdfe6;
  display: flex;
  flex-direction: column;
  align-items: center;
  background: #fff;
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
  background: #fff;
}
</style>