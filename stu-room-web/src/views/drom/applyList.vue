<template>
  <el-main>
    <el-table :data="tableList" border stripe>
      <el-table-column prop="applyUserName" label="申请人"></el-table-column>
      <el-table-column prop="applyBedCode" label="申请人床位"></el-table-column>
      <el-table-column prop="changeUserName" label="调换人"></el-table-column>
      <el-table-column prop="changeBedCode" label="调换床位"></el-table-column>
      <el-table-column prop="status" label="申请状态">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.status == '2'" type="danger" size="normal"
            >拒绝</el-tag
          >
          <el-tag v-if="scope.row.status == '1'" type="success" size="normal"
            >审核通过</el-tag
          >
          <el-tag v-if="scope.row.status == '0'" type="warning" size="normal"
            >审核中</el-tag
          >
        </template>
      </el-table-column>
      <el-table-column
        v-if="$checkPermission(['sys:applyList:apply', 'sys:applyList:return'])"
        label="操作"
        align="center"
        width="220"
      >
        <template slot-scope="scope">
          <el-button
            v-permission="['sys:applyList:apply']"
            icon="el-icon-edit"
            type="primary"
            size="small"
            @click="applyBtn(scope.row)"
            >同意</el-button
          >
          <el-button
            v-permission="['sys:applyList:return']"
            icon="el-icon-delete"
            type="danger"
            size="small"
            @click="returnBtn(scope.row)"
            >拒绝</el-button
          >
        </template>
      </el-table-column>
    </el-table>
  </el-main>
</template>

<script>
import { getListApi, applyDoApi } from "@/api/mybed.js";
import { getUserType, getUserId } from "@/utils/auth.js";
export default {
  data() {
    return {
      tableList: [],
      parm: {
        currentPage: 1,
        pageSize: 10,
        userType: getUserType(),
        userId: getUserId(),
        total: 0,
      },
    };
  },
  created() {
    this.getList();
  },
  methods: {
    async returnBtn(row) {
      if (row.status != "0") {
        this.$message.warning("您已经处理了，无需再次操作!");
        return;
      }
      const confirm = await this.$myconfirm("确定拒绝吗?");
      if (confirm) {
        this.applyDo("2", row.applyId);
      }
    },
    async applyBtn(row) {
      if (row.status != "0") {
        this.$message.warning("您已经处理了，无需再次操作!");
        return;
      }
      const confirm = await this.$myconfirm("确定同意吗?");
      if (confirm) {
        this.applyDo("1", row.applyId);
      }
    },
    async applyDo(type, applyId) {
      let res = await applyDoApi({
        applyId: applyId,
        type: type,
        userType: getUserType(),
      });
      if (res && res.code == 200) {
        this.$message.success(res.msg);
        this.getList();
      }
    },
    async getList() {
      let res = await getListApi(this.parm);
      if (res && res.code == 200) {
        console.log(res);
        this.tableList = res.data.records;
        this.parm.total = res.data.total;
      }
    },
  },
};
</script>

<style lang="scss" scoped>
</style>