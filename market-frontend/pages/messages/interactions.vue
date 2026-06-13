<template>
  <view class="interactions-page">
    <view class="header glass-effect">
      <view class="back-btn active-scale" @click="goBack"><text class="material-symbols-outlined">arrow_back</text></view>
      <text class="title">互动消息</text>
    </view>
    <scroll-view scroll-y class="main-content">
      <view class="list">
        <view class="interaction-item active-scale" v-for="item in items" :key="item.id">
          <image class="avatar" :src="item.avatar" mode="aspectFill"></image>
          <view class="info">
            <view class="text-content">
              <text class="user">{{item.user}}</text> <text class="action">{{item.action}}</text>
            </view>
            <text class="time">{{item.time}}</text>
          </view>
          <image class="cover" :src="item.cover" mode="aspectFill"></image>
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
        { id:1, user:'UserA', action:'赞了你的帖子', time:'1小时前', avatar:'https://lh3.googleusercontent.com/aida-public/AB6AXuBfFZbGJuxvmI2uNx-5IsMX3_uotLPtyHCV8dCtB3iJxfT7HHrqmABoHUV1-emVGdjtg2MaOKvpVUMrk7mwAjqTAXiZdUyvncqwTKC9zZKQqJHU0AXoJ1BKVKLSGr_3IHMyCKA5jGjwmKXNiz1_D9zyJdfQzOZ_ut78T-hiwHE4L9xq_awKh7uQFiPGRcOEa13mCtL1Cvm6SKU88oa_eycwyxIt0PjNDDXIgVsXSwNwL4i6sCyEeHGQZcq6rIHFXx6LSODS19TDRDqx', cover:'https://lh3.googleusercontent.com/aida-public/AB6AXuDZayQbW7Q6gFkqRnSNBpL-M3aW8BrZXWw9026KO1h6HrIDkcLaJpRuBPjjG2TQMxT9Ap-vV3LWemQ67OaXL39Ba0vpueIVNfyJQmfp5zLnALZuI0J1ZmHIqmhnj6rjXz7EH4aYqzF7gz4p2im-IiMGdSdKTVNXrMqb1nf1WAR2n5KoaLl-sSZZ3FlHMQdTUXR6cHxIibC4END5uFyNOzTPYiYIaQ1BD-FIXZGlKvPkVvy1r9XfkDwRa7ubbDJ9EZ_UabL04Beheffx' }
      ]
    }
  },
  methods: { goBack() { uni.navigateBack() } }
}
</script>

<style lang="scss" scoped>
.interactions-page { min-height: 100vh; background-color: $color-background; display: flex; flex-direction: column; }
.header { position: fixed; top: 0; width: 100%; height: 100rpx; display: flex; align-items: center; padding: 0 32rpx; padding-top: env(safe-area-inset-top); z-index: 50; }
.back-btn { font-size: 48rpx; margin-right: 32rpx; }
.title { font-size: 36rpx; font-weight: 600; color: $color-primary; }
.main-content { margin-top: calc(100rpx + env(safe-area-inset-top)); flex: 1; }
.list { padding: 24rpx; }
.interaction-item { display: flex; align-items: center; background: $color-surface; padding: 24rpx; border-radius: 24rpx; margin-bottom: 24rpx; }
.avatar { width: 80rpx; height: 80rpx; border-radius: 50%; margin-right: 24rpx; }
.info { flex: 1; display: flex; flex-direction: column; gap: 8rpx; }
.user { font-weight: bold; font-size: 28rpx; color: $color-on-surface; }
.action { font-size: 28rpx; color: $color-on-surface-variant; }
.time { font-size: 24rpx; color: $color-outline; }
.cover { width: 96rpx; height: 96rpx; border-radius: 12rpx; margin-left: 24rpx; }
</style>
