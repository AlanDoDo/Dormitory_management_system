<template>
  <el-main>
    <!-- 搜索栏 -->
    <el-form :model="searchModel" :inline="true" size="small">
      <el-form-item>
        <el-input
          v-model="searchModel.noticeTitle"
          placeholder="请输入公告标题"
        ></el-input>
      </el-form-item>
      <el-form-item>
        <el-button icon="el-icon-search" @click="searchBtn">搜索</el-button>
        <el-button style="color: #ff7670" icon="el-icon-close" @click="resetBtn"
          >重置</el-button
        >
        <el-button
          v-permission="['sys:sysNotice:add']"
          type="primary"
          icon="el-icon-plus"
          @click="addBtn"
          >新增</el-button
        >
      </el-form-item>
    </el-form>
    <!-- 表格 -->
    <el-table :height="tableHeight" :data="tableList" border stripe>
      <el-table-column prop="noticeTitle" label="标题"></el-table-column>
      <el-table-column prop="noticeText" label="内容"></el-table-column>
      <el-table-column prop="createTime" label="发布时间"></el-table-column>
      <el-table-column
        v-if="$checkPermission(['sys:sysNotice:edit', 'sys:sysNotice:delete'])"
        label="操作"
        align="center"
        width="220"
      >
        <template slot-scope="scope">
          <el-button
            v-permission="['sys:sysNotice:edit']"
            type="primary"
            icon="el-icon-edit"
            size="small"
            @click="editBtn(scope.row)"
            >编辑</el-button
          >
          <el-button
            v-permission="['sys:sysNotice:delete']"
            type="danger"
            icon="el-icon-delete"
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
      :current-page.sync="searchModel.currentPage"
      :page-sizes="[10, 20, 40, 80, 100]"
      :page-size="searchModel.pageSize"
      layout="total, sizes, prev, pager, next, jumper"
      :total="searchModel.total"
      background
    >
    </el-pagination>

    <!-- 弹框 -->
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
          <el-form-item prop="noticeTitle" label="标题">
            <el-input v-model="addModel.noticeTitle"></el-input>
          </el-form-item>
          <el-tooltip
            class="item"
            effect="dark"
            content="敏感公告请按：姓名+电话+内容格式发布"
            placement="bottom"
          >
            <el-form-item prop="noticeText" label="公告内容">
              <el-input
                type="textarea"
                v-model="addModel.noticeText"
              ></el-input>
            </el-form-item>
          </el-tooltip>
          <el-form-item prop="types" label="敏感公告">
            <el-radio-group v-model="addModel.types">
              <el-radio :label="'0'">否</el-radio>
              <el-radio :label="'1'">是</el-radio>
            </el-radio-group>
          </el-form-item>
        </el-form>
      </div>
    </sys-dialog>
  </el-main>
</template>

<script>
import { Message } from 'element-ui';
import { addApi, listApi, editApi, deleteApi,getByIdApi } from "@/api/notice.js";
import SysDialog from "@/components/dialog/SysDialog.vue";
export default {
  components: {
    SysDialog
  },
  data() {
    return {
      tableHeight: 0,
      tableList: [],
      rules: {
        noticeTitle: [
          {
            trigger: "blur",
            message: "请输入公告标题",
            required: true
          }
        ],
        noticeText: [
          {
            trigger: "blur",
            message: "请输入公告内容",
            required: true
          }
        ],
        types: [
          {
            trigger: "blur",
            message: "请选择是否是敏感公告",
            required: true
          }
        ]
      },
      addModel: {
        type: "",
        types: "",
        noticeId: "",
        noticeTitle: "",
        noticeText: ""
      },
      //弹框属性
      addDialog: {
        title: "",
        height: 180,
        width: 650,
        visible: false
      },
      searchModel: {
        currentPage: 1,
        pageSize: 10,
        noticeTitle: "",
        total: 0
      }
    };
  },
  created() {
    this.getList();
  },
  mounted() {
    this.$nextTick(() => {
      this.tableHeight = window.innerHeight - 220;
    });
  },
  methods: {
    currentChange(val) {
      this.searchModel.currentPage = val;
      this.getList();
    },
    sizeChange(val) {
      this.searchModel.pageSize = val;
      this.getList();
    },
    async deleteBtn(row) {
      const confirm = await this.$myconfirm("确定删除该数据吗?");
      if (confirm) {
        let res = await deleteApi({
          noticeId: row.noticeId
        });
        if (res && res.code == 200) {
          this.$message.success(res.msg);
          this.getList();
        }
      }
    },
    async editBtn(row) {
      //清空表单
      this.$resetForm("addForm", this.addModel);
      let res = await getByIdApi({
        noticeId:row.noticeId
      })
      if(res && res.code == 200){
        Object.assign(this.addModel,res.data)
      }
      //设置弹框属性
      this.addDialog.title = "编辑公告";
      this.addDialog.visible = true;
      this.addModel.type = "1";
    },
    async getList() {
      let res = await listApi(this.searchModel);
      if (res && res.code == 200) {
        this.tableList = res.data.records;
        this.searchModel.total = res.data.total;
      }
    },
    onConfirm() {
      this.$refs.addForm.validate(async valid => {
        if (valid) {
          if(this.addModel.types == "1"){
            let index = this.addModel.noticeText.indexOf("+");
            let second = this.addModel.noticeText.indexOf("+",index+1);
            if(index == -1 || second == -1){
              Message.warning('敏感公告请按：姓名+学号+内容格式发布')
              return;
            }
          }
          let res = null;
          if (this.addModel.type == "0") {
            res = await addApi(this.addModel);
          } else {
            res = await editApi(this.addModel);
          }
          if (res && res.code == 200) {
            this.$message.success(res.msg);
            this.getList();
            this.addDialog.visible = false;
          }
        }
      });
    },
    onClose() {
      this.addDialog.visible = false;
    },
    addBtn() {
      //清空表单
      this.$resetForm("addForm", this.addModel);
      //设置弹框属性
      this.addDialog.title = "新增公告";
      this.addDialog.visible = true;
      this.addModel.type = "0";
    },
    searchBtn() {
      this.getList();
    },
    resetBtn() {
      this.searchModel.noticeTitle = "";
      this.searchModel.currentPage = 1;
      this.getList();
    }
  }
};
</script>

<style lang="scss" scoped></style>
