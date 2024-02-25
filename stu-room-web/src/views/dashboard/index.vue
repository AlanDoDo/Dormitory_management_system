<template>
  <el-main>
    <!-- 统计 -->
    <el-row
      :gutter="20"
      type="flex"
      class="row-bg"
      justify="center"
      style="margin-bottom: 80px"
    >
      <el-col :span="6">
        <div class="show-header" style="background: rgb(45, 183, 245)">
          <div class="show-num">{{ stuCount }}</div>
          <div class="bottom-text">学生总数</div>
        </div>
      </el-col>
      <el-col :span="6">
        <div class="show-header" style="background: rgb(237, 64, 20)">
          <div class="show-num">{{ classCount }}</div>
          <div class="bottom-text">班级总数</div>
        </div>
      </el-col>
      <el-col :span="6">
        <div class="show-header">
          <div class="show-num">{{ repairCount }}</div>
          <div class="bottom-text">待维修数</div>
        </div>
      </el-col>
      <el-col :span="6">
        <div class="show-header" style="background: rgb(255, 153, 0)">
          <div class="show-num">{{ buildCount }}</div>
          <div class="bottom-text">楼宇总数</div>
        </div>
      </el-col>
    </el-row>
    <!-- echarts -->
    <div style="display: flex">
      <!-- 为 ECharts 准备一个定义了高宽的 DOM 容器 -->
      <div id="main" style="width: 800px; height: 300px; flex-grow: 1"></div>
    </div>
    <el-card class="box-card" style="margin-top: 30px">
      <div slot="header" class="clearfix">
        <span style="color: #000000; font-weight: 600">公告列表</span>
      </div>
      <div v-for="(item, index) in noticeList" :key="index" class="text item">
        <span style="font-weight: 600; font-size: 14px">{{
          item.noticeTitle
        }}</span>
        <span style="margin-left: 30px; font-size: 14px">{{
          item.noticeText
        }}</span>
        <span style="margin-left: 30px; font-size: 14px">{{
          item.createTime
        }}</span>
        <el-divider></el-divider>
      </div>
    </el-card>
  </el-main>
</template>

<script>
import { getTopListApi } from "@/api/notice.js";
import { getTotalApi } from "@/api/user.js";
import { getTotalBuildApi } from "@/api/build.js";
export default {
  data() {
    return {
      noticeList: [],
      buildCount: 0,
      classCount: 0,
      repairCount: 0,
      stuCount: 0,
    };
  },
  mounted() {
    this.getTotal();
    this.getTopList();
    this.myecharts1();
  },
  methods: {
    //获取公告列表
    async getTotal() {
      let res = await getTotalApi();
      if (res && res.code == 200) {
        console.log(res);
        this.classCount = res.data.classCount;
        this.buildCount = res.data.buildCount;
        this.repairCount = res.data.repairCount;
        this.stuCount = res.data.stuCount;
      }
    },
    //获取公告列表
    async getTopList() {
      let res = await getTopListApi();
      if (res && res.code == 200) {
        this.noticeList = res.data;
        console.log(this.noticeList);
      }
    },
    async myecharts1() {
      //初始化echarts
      var myChart = this.$echarts.init(document.getElementById("main"));
      // 指定图表的配置项和数据
      var option = {
        title: {
          text: "学生统计",
        },
        tooltip: {},
        legend: {
          data: ["分类"],
        },
        xAxis: {
          data: [],
        },
        yAxis: {},
        series: [
          {
            name: "销量",
            type: "bar",
            data: [],
          },
        ],
      };
      //动态获取数据
      let res = await getTotalBuildApi();
      if (res && res.code == 200) {
        option.xAxis.data = res.data.names;
        option.series[0].data = res.data.counts;
      }
      // 使用刚指定的配置项和数据显示图表。
      myChart.setOption(option);
    },
  },
};
</script>


<style lang="scss" scoped>
.bottom-text {
  bottom: 0;
  width: 100%;
  background: rgba(0, 0, 0, 0.1);
  height: 25px;
  line-height: 25px;
  text-align: center;
  position: absolute;
  font-weight: 600;
}
.show-header {
  background: #00c0ef;
  color: #fff;
  height: 80px;
  border-radius: 5px;
  position: relative;
}
.show-num {
  font-size: 38px;
  font-weight: 600;
  padding: 5px;
}
</style>
