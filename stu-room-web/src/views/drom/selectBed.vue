<template>
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
            >(共{{ item.children.length }}个床位,已选{{
              item.children | getHasNum
            }})人</span
          >
        </template>
        <!-- 床位列表 -->
        <div class="bedList">
          <div v-for="(bed, bindex) in item.children" :key="bindex">
            <div @click="hasBtn()" v-if="bed.stuName" class="bed-item-active">
              <span class="num-text">{{ bed.bedCode }}</span>
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
                <div v-else style="color: #aeb5b5">暂未选择</div>
              </div>
            </div>
            <dir @click="selectBtn(bed)" v-else class="bed-item">
              <span class="num-text">{{ bed.bedCode }}</span>
              <div class="bed-main">
                <svg-icon class="bed-svg" icon-class="bed-no" />
                <div style="color: #aeb5b5">暂未选择</div>
              </div>
            </dir>
          </div>
        </div>
      </el-collapse-item>
    </el-collapse>
  </el-main>
</template>

<script>
import { getRoomByClassIdApi, saveSelectBedApi } from "@/api/setAssign.js";
import { getUserId, getUserType } from "@/utils/auth.js";
export default {
  data() {
    return {
      tableList: [],
      accordionHeight: 0,
    };
  },
  filters: {
    getHasNum(children) {
      let num = 0;
      if (children && children.length > 0) {
        for (let i = 0; i < children.length; i++) {
          if (children[i].stuName) {
            num = num + 1;
          }
        }
      }
      return num;
    },
  },
  created() {
    this.getRoomByClassId();
  },
  mounted() {
    this.$nextTick(() => {
      this.accordionHeight = window.innerHeight - 200;
    });
  },
  methods: {
    hasBtn() {
      this.$message.success("该床位已经被选择!");
      return;
    },
    //床位点击事件
    async selectBtn(bed) {
      console.log(bed);
      const confirm = await this.$myconfirm("确定选择该宿舍吗?");
      if (confirm) {
        let res = await saveSelectBedApi({
          bedId: bed.bedId,
          stuId: getUserId(),
        });
        if(res && res.code == 200){
          this.$message.success(res.msg)
          this.getRoomByClassId()
        }
      }
    },
    async getRoomByClassId() {
      let res = await getRoomByClassIdApi({
        userId: getUserId(),
        userType: getUserType(),
      });
      console.log(res);
      if (res && res.code == 200) {
        this.tableList = res.data;
      }
    },
  },
};
</script>


<style lang="scss" scoped>
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