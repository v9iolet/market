<template>
  <view class="secondary-page">
    <view class="header">
      <view class="back-btn active-scale" @click="goBack">
        <text class="material-symbols-outlined">arrow_back_ios_new</text>
      </view>
      <text class="title">退款/售后</text>
      <view class="placeholder"></view>
    </view>
    
    <scroll-view scroll-y class="content-scroll">
      <view class="order-list">
        <OrderLogisticsCard 
          v-for="order in orders" 
          :key="order.orderId" 
          :order="order" 
        />
      </view>
    </scroll-view>
  </view>
</template>

<script>
import OrderLogisticsCard from '@/components/OrderLogisticsCard.vue';
import { orderDemoData } from '@/utils/mockData.js';

export default {
  components: { OrderLogisticsCard },
  data() {
    return {
      orders: []
    }
  },
  created() {
    this.orders = orderDemoData.filter(o => o.status === '退款中');
  },
  methods: {
    goBack() {
      uni.navigateBack();
    }
  }
}
</script>

<style lang="scss">
.secondary-page {
  height: 100vh;
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
  flex-shrink: 0;
  
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

.content-scroll {
  flex: 1;
  height: 0;
}

.order-list {
  padding: 24rpx $spacing-container-margin;
}
</style>
