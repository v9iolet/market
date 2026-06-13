<template>
  <view class="logistics-page">
    <view class="header glass-effect">
      <view class="back-btn active-scale" @click="goBack">
        <text class="material-symbols-outlined">arrow_back</text>
      </view>
      <text class="title">交易物流</text>
    </view>
    <scroll-view scroll-y class="main-content">
      <view class="timeline">
        <view class="timeline-item" v-for="(item, index) in logistics" :key="index">
          <view class="line-container">
            <view class="dot"></view>
            <view class="line" v-if="index !== logistics.length - 1"></view>
          </view>
          <view class="content">
            <text class="status">{{ item.status }}</text>
            <text class="desc">{{ item.desc }}</text>
            <text class="time">{{ item.time }}</text>
          </view>
        </view>
      </view>
    </scroll-view>
  </view>
</template>

<script>
export default {
  data() {
    return {
      logistics: [
        { status: '派送中', desc: '顺丰速运 快递员正在为您派件', time: '10:42 AM' },
        { status: '已发货', desc: '您的包裹已由顺丰速运揽收', time: '昨天 08:30 PM' },
        { status: '已下单', desc: '卖家已确认订单，等待发货', time: '昨天 10:15 AM' }
      ]
    }
  },
  methods: {
    goBack() {
      uni.navigateBack();
    }
  }
}
</script>

<style lang="scss" scoped>
.logistics-page {
  min-height: 100vh;
  background-color: $color-background;
  display: flex;
  flex-direction: column;
}

.header {
  position: fixed;
  top: 0;
  width: 100%;
  height: 100rpx;
  display: flex;
  align-items: center;
  padding: 0 32rpx;
  padding-top: env(safe-area-inset-top);
  z-index: 50;
}

.back-btn {
  font-size: 48rpx;
  color: $color-on-surface;
  margin-right: 32rpx;
  display: flex;
  align-items: center;
}

.title {
  font-size: 36rpx;
  font-weight: 600;
  color: $color-primary;
}

.main-content {
  margin-top: calc(100rpx + env(safe-area-inset-top));
  flex: 1;
}

.timeline {
  padding: 48rpx 32rpx;
}

.timeline-item {
  display: flex;
  margin-bottom: 32rpx;
}

.line-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-right: 32rpx;
}

.dot {
  width: 24rpx;
  height: 24rpx;
  border-radius: 50%;
  background-color: #4edea3;
  z-index: 2;
}

.line {
  width: 4rpx;
  flex: 1;
  background-color: $color-surface-container-high;
  margin-top: -12rpx;
  margin-bottom: -44rpx;
  z-index: 1;
}

.content {
  flex: 1;
  padding-bottom: 16rpx;
  background: $color-surface;
  padding: 24rpx;
  border-radius: 24rpx;
  box-shadow: 0 4rpx 12rpx rgba(0,0,0,0.03);
}

.status {
  display: block;
  font-weight: 700;
  font-size: 32rpx;
  color: $color-on-surface;
  margin-bottom: 8rpx;
}

.desc {
  display: block;
  font-size: 28rpx;
  color: $color-on-surface-variant;
  margin-bottom: 16rpx;
}

.time {
  display: block;
  font-size: 24rpx;
  color: $color-outline;
}
</style>
