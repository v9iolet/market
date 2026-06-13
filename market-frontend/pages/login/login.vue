<template>
  <view class="login-page">
    <view class="back-nav" @click="handleBack">
      <text class="material-symbols-outlined">arrow_back_ios_new</text>
    </view>
    
    <view class="header">
      <text class="title">欢迎使用</text>
      <text class="subtitle">登录或注册高级二手交易平台</text>
    </view>

    <view class="form-container">
      <view class="input-group">
        <text class="label">手机号 / 邮箱</text>
        <view class="input-wrapper">
          <input class="input" type="text" placeholder="请输入账号" placeholder-class="placeholder-text" />
        </view>
      </view>

      <view class="input-group">
        <text class="label">密码</text>
        <view class="input-wrapper">
          <input class="input" type="password" placeholder="请输入密码" placeholder-class="placeholder-text" />
        </view>
      </view>

      <view class="action-options">
        <text class="forgot-text">忘记密码？</text>
      </view>

      <view class="login-btn active-scale" @click="handleLogin">
        <text>登录</text>
      </view>
    </view>

    <view class="third-party">
      <view class="divider">
        <view class="line"></view>
        <text class="text">其他方式登录</text>
        <view class="line"></view>
      </view>
      <view class="icon-group">
        <view class="icon-item active-scale">
          <text class="material-symbols-outlined">chat</text>
        </view>
        <view class="icon-item active-scale">
          <text class="material-symbols-outlined">apple</text>
        </view>
      </view>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'

const handleBack = () => {
  uni.navigateBack()
}

const handleLogin = () => {
  // 模拟登录成功，写入状态
  uni.setStorageSync('isLoggedIn', true)
  
  // 返回 profile 页面
  uni.navigateBack()
}
</script>

<style lang="scss">
.login-page {
  min-height: 100vh;
  background-color: $color-background;
  padding: 0 $spacing-container-margin;
  display: flex;
  flex-direction: column;
  padding-top: calc(env(safe-area-inset-top) + 24rpx);
}

.back-nav {
  width: 80rpx;
  height: 80rpx;
  display: flex;
  align-items: center;
  margin-left: -16rpx;
  color: $color-on-surface;
  
  .material-symbols-outlined {
    font-size: 48rpx;
  }
}

.header {
  margin-top: 64rpx;
  margin-bottom: 80rpx;
  display: flex;
  flex-direction: column;
  gap: 16rpx;

  .title {
    font-size: 56rpx;
    font-weight: 700;
    color: $color-primary;
  }

  .subtitle {
    font-size: 28rpx;
    color: $color-on-surface-variant;
  }
}

.form-container {
  display: flex;
  flex-direction: column;
  gap: 40rpx;

  .input-group {
    display: flex;
    flex-direction: column;
    gap: 16rpx;

    .label {
      font-size: 28rpx;
      font-weight: 600;
      color: $color-on-surface;
    }

    .input-wrapper {
      background-color: $color-surface-container-lowest;
      border: 2rpx solid rgba(211, 228, 254, 0.3);
      border-radius: 24rpx;
      height: 112rpx;
      padding: 0 32rpx;
      display: flex;
      align-items: center;
      transition: border-color 0.3s;

      &:focus-within {
        border-color: $color-primary;
      }

      .input {
        flex: 1;
        font-size: 32rpx;
        color: $color-on-surface;
        height: 100%;
      }

      .placeholder-text {
        color: $color-outline;
      }
    }
  }

  .action-options {
    display: flex;
    justify-content: flex-end;
    margin-top: -16rpx;

    .forgot-text {
      font-size: 24rpx;
      color: $color-primary;
      font-weight: 600;
    }
  }

  .login-btn {
    margin-top: 16rpx;
    background-color: $color-primary;
    color: $color-on-primary;
    height: 112rpx;
    border-radius: 24rpx;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 32rpx;
    font-weight: 600;
    box-shadow: 0 16rpx 32rpx -12rpx rgba($color-primary, 0.4);
  }
}

.third-party {
  margin-top: auto;
  margin-bottom: calc(env(safe-area-inset-bottom) + 64rpx);
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 48rpx;

  .divider {
    display: flex;
    align-items: center;
    width: 100%;
    gap: 32rpx;

    .line {
      flex: 1;
      height: 2rpx;
      background-color: rgba(197, 198, 205, 0.3);
    }

    .text {
      font-size: 24rpx;
      color: $color-on-surface-variant;
    }
  }

  .icon-group {
    display: flex;
    gap: 48rpx;

    .icon-item {
      width: 96rpx;
      height: 96rpx;
      border-radius: 50%;
      background-color: $color-surface-container-lowest;
      border: 2rpx solid rgba(211, 228, 254, 0.3);
      display: flex;
      align-items: center;
      justify-content: center;
      color: $color-on-surface;

      .material-symbols-outlined {
        font-size: 48rpx;
      }
    }
  }
}
</style>
