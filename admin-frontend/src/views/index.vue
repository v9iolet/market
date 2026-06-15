<template>
  <div class="app-container home">
    <el-row :gutter="20">
      <el-col :sm="24" :lg="24" style="padding-left: 20px">
        <h2>欢迎使用二手集市控制台</h2>
        <p>
          二手集市控制台是为您量身打造的高效能后台管理系统，致力于提供卓越的用户体验和强大的数据管理能力。
        </p>
        <p>
          <b>当前版本:</b> <span>v{{ version }}</span>
        </p>
      </el-col>
    </el-row>
    <el-divider />
    <el-row :gutter="20">
      <el-col :xs="24" :sm="24" :md="12" :lg="12">
        <el-card class="box-card">
          <template v-slot:header>
            <div class="clearfix">
              <span>系统概览</span>
            </div>
          </template>
          <div class="body">
            <p>
              这是一个极简的控制台主页，您可以在此查看系统的核心指标和运行状态。
            </p>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup name="Index">
import { ref } from 'vue'

const version = ref('1.0.0')
</script>

<style scoped lang="scss">
.home {
  font-family: "open sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
  font-size: 13px;
  color: #676a6c;
  overflow-x: hidden;

  h2 {
    margin-top: 10px;
    font-size: 26px;
    font-weight: 100;
  }

  p {
    margin-top: 10px;
    b {
      font-weight: 700;
    }
  }
}
</style>
