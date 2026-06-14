<template>
  <view class="secondary-page">
    <view class="header">
      <view class="back-btn active-scale" @click="goBack">
        <text class="material-symbols-outlined">arrow_back_ios_new</text>
      </view>
      <text class="title">我卖出的</text>
      <view class="placeholder"></view>
    </view>
    
    <view class="content">
      <view class="mock-order active-scale" style="margin-bottom: 40rpx; padding: 40rpx; background: #fff; border-radius: 20rpx;" @click="goLogistics">
        <text style="color: #4B6BFE; font-weight: bold;">[测试] 查看该订单物流</text>
      </view>
      <view class="empty-state">
        <text class="material-symbols-outlined empty-icon">payments</text>
        <text class="empty-text">暂无卖出的订单</text>
      </view>
    </view>
  </view>
</template>

<script setup>
const goBack = () => {
  uni.navigateBack();
};
const goLogistics = () => {
  uni.navigateTo({ url: '/pages/order/logistics-detail' });
};
</script>

<style lang="scss">
.secondary-page {
  min-height: 100vh;
  background-color: $color-background;
  display: flex;
  flex-direction: column;
}

.header {
  padding: calc(env(safe-area-inset-top) + 24rpx) $spacing-container-margin 24rpx;
  display: flex;
  align-items: center;
  justify-content: space-between;
  background-color: $color-surface;
  
  .back-btn {
    width: 80rpx;
    height: 80rpx;
    display: flex;
    align-items: center;
    justify-content: flex-start;
    color: $color-on-surface;
    
    .material-symbols-outlined {
      font-size: 48rpx;
    }
  }
  
  .title {
    font-size: 36rpx;
    font-weight: 600;
    color: $color-on-surface;
  }
  
  .placeholder {
    width: 80rpx;
  }
}

.content {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  
  .empty-state {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 24rpx;
    color: $color-on-surface-variant;
    
    .empty-icon {
      font-size: 120rpx;
      opacity: 0.5;
    }
    
    .empty-text {
      font-size: 28rpx;
    }
  }
}
</style>
