<template>
  <view class="notices-page">
    <view class="header glass-effect">
      <view class="back-btn active-scale" @click="goBack">
        <text class="material-symbols-outlined">arrow_back_ios_new</text>
      </view>
      <text class="page-title">交易信息</text>
      <view class="placeholder"></view>
    </view>

    <scroll-view scroll-y class="list-content">
      <view class="notice-list">
        <TransactionNoticeCard 
          v-for="item in notices" 
          :key="item.id" 
          :notice="item" 
        />
      </view>
    </scroll-view>
  </view>
</template>

<script>
import TransactionNoticeCard from '@/components/TransactionNoticeCard.vue';
import { transactionNoticesDemoData } from '@/utils/mockData.js';

export default {
  components: {
    TransactionNoticeCard
  },
  data() {
    return {
      notices: []
    }
  },
  onLoad() {
    this.notices = transactionNoticesDemoData;
  },
  methods: {
    goBack() {
      uni.navigateBack();
    }
  }
}
</script>

<style lang="scss" scoped>
.notices-page {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: $color-background;
}
.header {
  position: fixed;
  top: 0; width: 100%;
  padding: calc(env(safe-area-inset-top) + 24rpx) 32rpx 24rpx;
  display: flex; align-items: center; justify-content: space-between;
  z-index: 50; background-color: $color-surface;
  box-sizing: border-box;

  .page-title {
    font-size: 32rpx;
    font-weight: 600;
    color: $color-on-surface;
  }
}
.back-btn, .placeholder { width: 80rpx; display: flex; }
.back-btn .material-symbols-outlined { font-size: 48rpx; color: $color-on-surface; }

.list-content {
  flex: 1;
  margin-top: calc(env(safe-area-inset-top) + 104rpx);
  box-sizing: border-box;
}

.notice-list {
  padding: 24rpx 32rpx;
}
</style>
