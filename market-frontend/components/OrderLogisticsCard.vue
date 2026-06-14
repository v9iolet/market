<template>
  <view class="order-card active-scale">
    <view class="card-header">
      <view class="shop-info">
        <text class="material-symbols-outlined shop-icon">storefront</text>
        <text class="shop-name">官方自营店</text>
        <text class="material-symbols-outlined arrow">chevron_right</text>
      </view>
      <text class="order-status" :class="order.status">{{ order.status }}</text>
    </view>
    
    <view class="product-info">
      <view class="image-wrapper">
        <image class="product-image" :src="order.productInfo.image" mode="aspectFill"></image>
      </view>
      <view class="product-details">
        <text class="product-name line-clamp-2">{{ order.productInfo.name }}</text>
        <text class="product-price">¥{{ order.productInfo.price }}</text>
      </view>
    </view>
    
    <view class="logistics-box" v-if="order.latestLogistics">
      <view class="logistics-content">
        <view class="logistics-icon-wrapper">
          <text class="material-symbols-outlined logistics-icon">local_shipping</text>
        </view>
        <view class="logistics-text-box">
          <text class="logistics-status">{{ order.latestLogistics.statusText }}</text>
          <text class="logistics-time">{{ order.latestLogistics.time }}</text>
        </view>
      </view>
      <text class="material-symbols-outlined arrow">chevron_right</text>
    </view>
    
    <view class="action-buttons">
      <view class="btn outline" v-if="order.status === '待付款'">取消订单</view>
      <view class="btn primary" v-if="order.status === '待付款'">去支付</view>
      <view class="btn outline" v-if="order.status === '待发货'">提醒发货</view>
      <view class="btn outline" v-if="order.status === '待收货'">查看物流</view>
      <view class="btn primary" v-if="order.status === '待收货'">确认收货</view>
      <view class="btn outline" v-if="order.status === '退款中'">查看进度</view>
    </view>
  </view>
</template>

<script setup>
defineProps({
  order: {
    type: Object,
    required: true
  }
});
</script>

<style lang="scss">
.order-card {
  background-color: $color-surface;
  border-radius: $radius-lg;
  padding: 24rpx;
  margin-bottom: 24rpx;
  box-shadow: $shadow-sm;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24rpx;
  
  .shop-info {
    display: flex;
    align-items: center;
    gap: 8rpx;
    
    .shop-icon {
      font-size: 32rpx;
      color: $color-on-surface-variant;
    }
    .shop-name {
      font-size: 28rpx;
      font-weight: 500;
      color: $color-on-surface;
    }
    .arrow {
      font-size: 32rpx;
      color: $color-on-surface-variant;
    }
  }
  
  .order-status {
    font-size: 28rpx;
    font-weight: 500;
    color: $color-primary;
    
    &.待付款 { color: $color-error; }
    &.待收货 { color: $color-primary; }
    &.退款中 { color: $color-on-surface-variant; }
  }
}

.product-info {
  display: flex;
  gap: 20rpx;
  margin-bottom: 24rpx;
  
  .image-wrapper {
    width: 160rpx;
    height: 160rpx;
    border-radius: $radius-md;
    overflow: hidden;
    background-color: $color-background;
    flex-shrink: 0;
    
    .product-image {
      width: 100%;
      height: 100%;
    }
  }
  
  .product-details {
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    
    .product-name {
      font-size: 28rpx;
      color: $color-on-surface;
      line-height: 1.4;
    }
    
    .product-price {
      font-size: 32rpx;
      font-weight: 600;
      color: $color-on-surface;
    }
  }
}

.logistics-box {
  background-color: $color-background;
  border-radius: $radius-md;
  padding: 16rpx 20rpx;
  margin-bottom: 24rpx;
  display: flex;
  justify-content: space-between;
  align-items: center;
  
  .logistics-content {
    display: flex;
    align-items: flex-start;
    gap: 16rpx;
    flex: 1;
    overflow: hidden;
    
    .logistics-icon-wrapper {
      width: 40rpx;
      height: 40rpx;
      background-color: $color-primary;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      flex-shrink: 0;
      margin-top: 4rpx;
      
      .logistics-icon {
        font-size: 24rpx;
        color: #fff;
      }
    }
    
    .logistics-text-box {
      flex: 1;
      display: flex;
      flex-direction: column;
      gap: 4rpx;
      overflow: hidden;
      
      .logistics-status {
        font-size: 26rpx;
        color: $color-primary;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
      }
      
      .logistics-time {
        font-size: 22rpx;
        color: $color-on-surface-variant;
      }
    }
  }
  
  .arrow {
    font-size: 32rpx;
    color: $color-on-surface-variant;
    flex-shrink: 0;
  }
}

.action-buttons {
  display: flex;
  justify-content: flex-end;
  gap: 16rpx;
  
  .btn {
    padding: 12rpx 32rpx;
    border-radius: 100rpx;
    font-size: 26rpx;
    font-weight: 500;
    
    &.outline {
      border: 1px solid $color-outline;
      color: $color-on-surface;
    }
    
    &.primary {
      background-color: $color-primary;
      color: #fff;
    }
  }
}
</style>
