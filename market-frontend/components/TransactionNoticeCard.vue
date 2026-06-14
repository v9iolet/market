<template>
  <view class="notice-card" @click="handleCardClick">
    <view class="card-header">
      <text class="status-title">{{ notice.statusTitle }}</text>
      <text class="time-text">{{ notice.time }}</text>
    </view>
    <view class="card-content">
      <image class="product-img" :src="notice.productImg" mode="aspectFill"></image>
      <view class="order-info">
        <text class="product-name">{{ notice.productName }}</text>
        <text class="desc">{{ notice.desc }}</text>
      </view>
    </view>
  </view>
</template>

<script>
export default {
  name: 'TransactionNoticeCard',
  props: {
    notice: {
      type: Object,
      required: true
    }
  },
  methods: {
    handleCardClick() {
      uni.navigateTo({
        url: `/pages/order/detail?id=${this.notice.orderId}`
      });
    }
  }
}
</script>

<style lang="scss" scoped>
.notice-card {
  background-color: #ffffff;
  border-radius: 12px;
  padding: 16px;
  margin-bottom: 12px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.05);

  .card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 12px;

    .status-title {
      font-size: 16px;
      font-weight: 600;
      color: #333;
    }

    .time-text {
      font-size: 12px;
      color: #999;
    }
  }

  .card-content {
    display: flex;
    align-items: center;

    .product-img {
      width: 48px;
      height: 48px;
      border-radius: 6px;
      margin-right: 12px;
      flex-shrink: 0;
      background-color: #f5f5f5;
    }

    .order-info {
      flex: 1;
      display: flex;
      flex-direction: column;

      .product-name {
        font-size: 14px;
        color: #333;
        margin-bottom: 4px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
      }

      .desc {
        font-size: 12px;
        color: #666;
        line-height: 1.4;
        display: -webkit-box;
        -webkit-box-orient: vertical;
        -webkit-line-clamp: 2;
        overflow: hidden;
      }
    }
  }
}
</style>
