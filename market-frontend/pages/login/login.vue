<template>
  <view class="login-page">
    <view class="back-nav" @click="handleBack">
      <text class="material-symbols-outlined">arrow_back_ios_new</text>
    </view>

    <view class="header">
      <view class="mode-tabs">
        <text
          class="tab-item"
          :class="{ active: currentMode === 'login' }"
          @click="currentMode = 'login'"
          >登录</text
        >
        <text
          class="tab-item"
          :class="{ active: currentMode === 'register' }"
          @click="currentMode = 'register'"
          >注册</text
        >
      </view>
      <text class="subtitle">{{
        currentMode === "login"
          ? "欢迎回来，请登录您的账号"
          : "加入我们，体验高级二手交易"
      }}</text>
    </view>

    <view class="form-container">
      <view class="input-group">
        <text class="label">手机号 / 邮箱</text>
        <view class="input-wrapper">
          <input
            class="input"
            type="text"
            placeholder="请输入账号"
            placeholder-class="placeholder-text"
          />
        </view>
      </view>

      <view class="input-group">
        <text class="label">密码</text>
        <view class="input-wrapper">
          <input
            class="input"
            type="password"
            placeholder="请输入密码"
            placeholder-class="placeholder-text"
          />
        </view>
      </view>

      <view class="input-group" v-if="currentMode === 'register'">
        <text class="label">确认密码</text>
        <view class="input-wrapper">
          <input
            class="input"
            type="password"
            placeholder="请再次输入密码"
            placeholder-class="placeholder-text"
          />
        </view>
      </view>

      <view class="action-options" v-if="currentMode === 'login'">
        <text class="forgot-text">忘记密码？</text>
      </view>

      <view class="login-btn active-scale" @click="handleAction">
        <text>{{ currentMode === "login" ? "登录" : "注册" }}</text>
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
          <image
            class="auth-icon"
            src="https://img.icons8.com/color/96/wechat.png"
            mode="aspectFit"
          ></image>
        </view>
        <view class="icon-item active-scale">
          <image
            class="auth-icon"
            src="https://img.icons8.com/color/96/qq.png"
            mode="aspectFit"
          ></image>
        </view>
      </view>
    </view>
  </view>
</template>

<script setup>
import { ref } from "vue";

const currentMode = ref("login");

const handleBack = () => {
  uni.navigateBack();
};

const handleAction = () => {
  // 模拟操作成功，写入状态
  uni.setStorageSync("isLoggedIn", true);

  // 重定向到 profile 页面
  uni.reLaunch({
    url: "/pages/profile/profile",
  });
};
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

  .mode-tabs {
    display: flex;
    align-items: baseline;
    gap: 32rpx;

    .tab-item {
      font-size: 40rpx;
      font-weight: 600;
      color: $color-on-surface-variant;
      transition: all 0.3s ease;
      position: relative;

      &.active {
        font-size: 56rpx;
        font-weight: 700;
        color: $color-primary;

        &::after {
          content: "";
          position: absolute;
          bottom: -8rpx;
          left: 0;
          width: 100%;
          height: 8rpx;
          background-color: $color-secondary;
          border-radius: 4rpx;
        }
      }
    }
  }

  .subtitle {
    font-size: 28rpx;
    color: $color-on-surface-variant;
    margin-top: 8rpx;
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
    background-color: $color-secondary;
    color: $color-on-secondary;
    height: 112rpx;
    border-radius: 24rpx;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 32rpx;
    font-weight: 600;
    box-shadow: 0 16rpx 32rpx -12rpx rgba($color-secondary, 0.4);
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

      .auth-icon {
        width: 56rpx;
        height: 56rpx;
      }
    }
  }
}
</style>
