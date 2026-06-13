<template>
  <view class="chat-page">
    <view class="header glass-effect">
      <view class="back-btn active-scale" @click="goBack"><text class="material-symbols-outlined">arrow_back</text></view>
      <text class="title">{{ contactName }}</text>
    </view>
    <scroll-view scroll-y class="chat-area" :scroll-into-view="lastId">
      <view class="bubble-wrapper" v-for="msg in messages" :key="msg.id" :id="'msg-'+msg.id" :class="{'me': msg.isMe, 'other': !msg.isMe}">
        <image class="avatar" v-if="!msg.isMe" :src="contactAvatar" mode="aspectFill"></image>
        <view class="bubble">
          <text>{{ msg.text }}</text>
        </view>
        <image class="avatar me-avatar" v-if="msg.isMe" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDZayQbW7Q6gFkqRnSNBpL-M3aW8BrZXWw9026KO1h6HrIDkcLaJpRuBPjjG2TQMxT9Ap-vV3LWemQ67OaXL39Ba0vpueIVNfyJQmfp5zLnALZuI0J1ZmHIqmhnj6rjXz7EH4aYqzF7gz4p2im-IiMGdSdKTVNXrMqb1nf1WAR2n5KoaLl-sSZZ3FlHMQdTUXR6cHxIibC4END5uFyNOzTPYiYIaQ1BD-FIXZGlKvPkVvy1r9XfkDwRa7ubbDJ9EZ_UabL04Beheffx" mode="aspectFill"></image>
      </view>
      <view class="safe-bottom-pad"></view>
    </scroll-view>

    <!-- Bottom Input Area -->
    <view class="input-area">
      <!-- Quick Replies -->
      <scroll-view scroll-x class="quick-replies" :show-scrollbar="false">
        <view class="chip active-scale" @click="sendQuick('你好，这件还在吗？')">你好，这件还在吗？</view>
        <view class="chip active-scale" @click="sendQuick('能包邮吗？')">能包邮吗？</view>
        <view class="chip active-scale" @click="sendQuick('有实物图吗？')">有实物图吗？</view>
      </scroll-view>
      
      <view class="input-bar">
        <text class="material-symbols-outlined icon-btn">mic</text>
        <input class="input-box" v-model="inputText" placeholder="输入消息..." @confirm="sendMsg" confirm-type="send" />
        <text class="material-symbols-outlined icon-btn" @click="sendMsg">sentiment_satisfied</text>
        <text class="material-symbols-outlined icon-btn">add_circle</text>
      </view>
    </view>
  </view>
</template>

<script>
export default {
  data() {
    return {
      contactName: 'Anna Studio',
      contactAvatar: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBfFZbGJuxvmI2uNx-5IsMX3_uotLPtyHCV8dCtB3iJxfT7HHrqmABoHUV1-emVGdjtg2MaOKvpVUMrk7mwAjqTAXiZdUyvncqwTKC9zZKQqJHU0AXoJ1BKVKLSGr_3IHMyCKA5jGjwmKXNiz1_D9zyJdfQzOZ_ut78T-hiwHE4L9xq_awKh7uQFiPGRcOEa13mCtL1Cvm6SKU88oa_eycwyxIt0PjNDDXIgVsXSwNwL4i6sCyEeHGQZcq6rIHFXx6LSODS19TDRDqx',
      inputText: '',
      messages: [
        { id: 1, text: '您好，这款Vintage包包还在吗？', isMe: false },
        { id: 2, text: '在的，直接拍即可。', isMe: true }
      ]
    }
  },
  onLoad(options) {
    if (options.name) {
      this.contactName = decodeURIComponent(options.name);
    }
  },
  computed: {
    lastId() { return this.messages.length > 0 ? 'msg-' + this.messages[this.messages.length - 1].id : ''; }
  },
  methods: {
    goBack() { uni.navigateBack() },
    sendQuick(text) {
      this.messages.push({ id: Date.now(), text, isMe: true });
    },
    sendMsg() {
      if (!this.inputText.trim()) return;
      this.messages.push({ id: Date.now(), text: this.inputText, isMe: true });
      this.inputText = '';
    }
  }
}
</script>

<style lang="scss" scoped>
.chat-page { height: 100vh; background-color: $color-background; display: flex; flex-direction: column; overflow: hidden; }
.header { position: fixed; top: 0; width: 100%; height: 100rpx; display: flex; align-items: center; padding: 0 32rpx; padding-top: env(safe-area-inset-top); z-index: 50; }
.back-btn { font-size: 48rpx; margin-right: 32rpx; }
.title { font-size: 36rpx; font-weight: 600; color: $color-primary; }
.chat-area { flex: 1; margin-top: calc(100rpx + env(safe-area-inset-top)); padding: 24rpx; box-sizing: border-box; }
.bubble-wrapper { display: flex; align-items: flex-start; margin-bottom: 32rpx; }
.bubble-wrapper.me { justify-content: flex-end; }
.avatar { width: 80rpx; height: 80rpx; border-radius: 50%; }
.me-avatar { margin-left: 16rpx; }
.bubble-wrapper.other .avatar { margin-right: 16rpx; }
.bubble { max-width: 60%; padding: 20rpx 32rpx; border-radius: 32rpx; font-size: 28rpx; word-break: break-all; }
.bubble-wrapper.other .bubble { background: $color-surface; color: $color-on-surface; border-top-left-radius: 8rpx; }
.bubble-wrapper.me .bubble { background: $color-primary; color: $color-on-primary; border-top-right-radius: 8rpx; }
.safe-bottom-pad { height: 200rpx; }

.input-area { background: $color-surface-container-low; padding-bottom: env(safe-area-inset-bottom); display: flex; flex-direction: column; }
.quick-replies { white-space: nowrap; padding: 16rpx 24rpx; }
.chip { display: inline-block; background: $color-surface-container-high; color: $color-on-surface; padding: 12rpx 24rpx; border-radius: 32rpx; font-size: 24rpx; margin-right: 16rpx; }
.input-bar { display: flex; align-items: center; padding: 16rpx 24rpx; }
.input-box { flex: 1; background: $color-surface; height: 72rpx; border-radius: 36rpx; padding: 0 32rpx; font-size: 28rpx; color: $color-on-surface; margin: 0 16rpx; }
.icon-btn { font-size: 56rpx; color: $color-on-surface-variant; }
</style>
