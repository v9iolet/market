<template>
  <view class="notices-page">
    <view class="header glass-effect">
      <view class="back-btn active-scale" @click="goBack"><text class="material-symbols-outlined">arrow_back</text></view>
      <text class="title">通知消息</text>
    </view>
    <scroll-view scroll-y class="main-content">
      <view class="list">
        <view class="notice-item active-scale" v-for="item in items" :key="item.id">
          <view class="icon-circle">
            <text class="material-symbols-outlined">campaign</text>
          </view>
          <view class="info">
            <view class="title-row">
              <text class="notice-title">{{item.title}}</text>
              <text class="time">{{item.time}}</text>
            </view>
            <text class="desc">{{item.desc}}</text>
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
      items: [
        { id:1, title:'系统维护通知', desc:'今晚凌晨2:00将进行系统升级。', time:'昨天' },
        { id:2, title:'优惠券到账', desc:'您有一张满200减20的优惠券。', time:'12/05' }
      ]
    }
  },
  methods: { goBack() { uni.navigateBack() } }
}
</script>

<style lang="scss" scoped>
.notices-page { min-height: 100vh; background-color: $color-background; display: flex; flex-direction: column; }
.header { position: fixed; top: 0; width: 100%; height: 100rpx; display: flex; align-items: center; padding: 0 32rpx; padding-top: env(safe-area-inset-top); z-index: 50; }
.back-btn { font-size: 48rpx; margin-right: 32rpx; }
.title { font-size: 36rpx; font-weight: 600; color: $color-primary; }
.main-content { margin-top: calc(100rpx + env(safe-area-inset-top)); flex: 1; }
.list { padding: 24rpx; }
.notice-item { display: flex; background: $color-surface; padding: 24rpx; border-radius: 24rpx; margin-bottom: 24rpx; }
.icon-circle { width: 80rpx; height: 80rpx; border-radius: 50%; background: $color-primary-container; color: #8590a6; display: flex; align-items: center; justify-content: center; margin-right: 24rpx; }
.info { flex: 1; display: flex; flex-direction: column; }
.title-row { display: flex; justify-content: space-between; margin-bottom: 8rpx; }
.notice-title { font-weight: bold; font-size: 32rpx; color: $color-on-surface; }
.time { font-size: 24rpx; color: $color-outline; }
.desc { font-size: 28rpx; color: $color-on-surface-variant; }
</style>
