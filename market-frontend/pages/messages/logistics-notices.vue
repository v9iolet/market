<template>
	<view class="notices-page">
		<view class="header glass-effect">
			<view class="back-btn active-scale" @click="goBack">
				<text class="material-symbols-outlined">arrow_back_ios_new</text>
			</view>
			<view class="tabs">
				<text class="tab-item" :class="{active: currentTab === 0}" @click="switchTab(0)">我买到的</text>
				<text class="tab-item" :class="{active: currentTab === 1}" @click="switchTab(1)">我卖出的</text>
			</view>
			<view class="placeholder"></view>
		</view>

		<swiper class="swiper-box" :current="currentTab" @change="onSwiperChange">
			<!-- 买到的 -->
			<swiper-item>
				<scroll-view scroll-y class="list-content">
					<view class="order-list">
						<OrderLogisticsCard 
							v-for="order in orders" 
							:key="order.orderId" 
							:order="order" 
						/>
					</view>
				</scroll-view>
			</swiper-item>

			<!-- 卖出的 -->
			<swiper-item>
				<scroll-view scroll-y class="list-content">
					<view class="order-list">
						<OrderLogisticsCard 
							v-for="order in orders" 
							:key="'sold-'+order.orderId" 
							:order="order" 
						/>
					</view>
				</scroll-view>
			</swiper-item>
		</swiper>
	</view>
</template>

<script>
import OrderLogisticsCard from '@/components/OrderLogisticsCard.vue';
import { orderDemoData } from '@/utils/mockData.js';

export default {
  components: { OrderLogisticsCard },
  data() {
    return {
      currentTab: 0,
      orders: orderDemoData
    }
  },
  methods: {
    goBack() {
      uni.navigateBack();
    },
    switchTab(index) {
      this.currentTab = index;
    },
    onSwiperChange(e) {
      this.currentTab = e.detail.current;
    }
  }
}
</script>

<style lang="scss" scoped>
.notices-page {
	min-height: 100vh;
	display: flex;
	flex-direction: column;
	background-color: $color-background;
}
.header {
	position: fixed;
	top: 0; width: 100%;
	padding: calc(env(safe-area-inset-top) + 24rpx) 32rpx 24rpx;
	display: flex; align-items: center; justify-content: space-between;
	z-index: 50; background-color: $color-surface;
	box-sizing: border-box;
}
.back-btn, .placeholder { width: 80rpx; display: flex; }
.back-btn .material-symbols-outlined { font-size: 48rpx; color: $color-on-surface; }
.tabs {
	display: flex; gap: 48rpx;
	.tab-item {
		font-size: 32rpx; color: $color-on-surface-variant; font-weight: 500;
		position: relative; padding-bottom: 8rpx; transition: all 0.3s;
		&.active {
			color: $color-primary; font-weight: 700;
			&::after {
				content: ''; position: absolute; bottom: 0; left: 50%; transform: translateX(-50%);
				width: 32rpx; height: 6rpx; border-radius: 4rpx; background-color: $color-primary;
			}
		}
	}
}
.swiper-box {
	flex: 1; margin-top: calc(env(safe-area-inset-top) + 104rpx); height: calc(100vh - env(safe-area-inset-top) - 104rpx);
}
.list-content { height: 100%; box-sizing: border-box; }
.order-list {
	padding: 24rpx $spacing-container-margin;
}
</style>
