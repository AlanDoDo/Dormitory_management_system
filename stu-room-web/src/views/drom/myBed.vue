<template>
  <el-main>
    <el-table :data="tableList" border stripe>
      <el-table-column prop="stuName" label="姓名"></el-table-column>
      <el-table-column prop="className" label="班级"></el-table-column>
      <el-table-column prop="buildName" label="栋数"></el-table-column>
      <el-table-column prop="storeyName" label="层数"></el-table-column>
      <el-table-column prop="roomCode" label="宿舍"></el-table-column>
      <el-table-column prop="bedCode" label="床位"></el-table-column>
      <el-table-column prop="bedCode" label="床位">
        <template slot-scope="scope">
          <span class="room-type" v-if="scope.row.rootType == '1'">1人间</span>
          <span class="room-type" v-if="scope.row.rootType == '2'">2人间</span>
          <span class="room-type" v-if="scope.row.rootType == '4'">4人间</span>
          <span class="room-type" v-if="scope.row.rootType == '6'">6人间</span>
        </template>
      </el-table-column>
      <el-table-column prop="bedCode" label="操作" align="center" width="150">
        <template slot-scope="scope">
          <el-button
            icon="el-icon-plus"
            type="primary"
            size="small"
            @click="applyBtn(scope.row)"
            >调换宿舍</el-button
          >
        </template>
      </el-table-column>
    </el-table>
    <!-- 弹框 -->
    <sys-dialog
      :title="dialog.title"
      :height="dialog.height"
      :width="dialog.width"
      :visible="dialog.visible"
      @onClose="onClose"
      @onConfirm="onConfirm"
    >
      <div slot="content">
        <el-transfer
          v-model="value"
          :data="stuList"
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
import SysDialog from "@/components/dialog/SysDialog.vue";
import { getStuBedListApi, getStuListApi, applySaveApi } from "@/api/mybed.js";
import { getUserId,getUserType } from "@/utils/auth.js";
export default {
  components: {
    SysDialog,
  },
  data() {
    return {
      value: [],
      //弹框的属性
      dialog: {
        title: "",
        height: 320,
        width: 620,
        visible: false,
      },
      tableList: [],
      stuList: [],
    };
  },
  created() {
    this.getStuBedList();
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
    async onConfirm() {
      console.log(this.value);
      let res = await applySaveApi({
        applyId: getUserId(),
        changeId: this.value[0],
      });
      if (res && res.code == 200) {
        this.$message.success(res.msg);
        this.dialog.visible = false;
      }
    },
    onClose() {
      this.dialog.visible = false;
    },
    applyBtn(row) {
      this.value = []
      //查询学生信息
      this.getStuList();
      this.dialog.title = "申请调换";
      this.dialog.visible = true;
    },
    //查询调换的学生信息
    async getStuList() {
      let res = await getStuListApi({
        stuId: getUserId(),
      });
      if (res && res.code == 200) {
        this.stuList = res.data;
        console.log(this.stuList);
      }
    },
    async getStuBedList() {
      let res = await getStuBedListApi({
        stuId: getUserId(),
        userType:getUserType()
      });
      if (res && res.code == 200) {
        this.tableList = res.data;
      }
    },
  },
};
</script>

<style lang="scss" scoped>
</style>