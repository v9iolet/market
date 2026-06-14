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
					<view class="notice-card active-scale" v-for="item in boughtNotices" :key="item.id" @click="goDetail">
						<view class="card-header">
							<text class="status">{{item.status}}</text>
							<text class="time">{{item.time}}</text>
						</view>
						<view class="card-body">
							<image class="cover" :src="item.cover" mode="aspectFill"></image>
							<view class="info">
								<text class="desc">{{item.desc}}</text>
								<text class="tracking">快递单号：{{item.trackingNo}}</text>
							</view>
						</view>
					</view>
				</scroll-view>
			</swiper-item>

			<!-- 卖出的 -->
			<swiper-item>
				<scroll-view scroll-y class="list-content">
					<view class="empty-state">
						<text class="material-symbols-outlined empty-icon">inbox</text>
						<text>暂无卖出的物流通知</text>
					</view>
				</scroll-view>
			</swiper-item>
		</swiper>
	</view>
</template>

<script>
export default {
	data() {
		return {
			currentTab: 0,
			boughtNotices: [
				{
					id: 1,
					status: '已发货',
					time: '10:42 AM',
					desc: '您的包裹已交由顺丰速运揽收',
					trackingNo: 'SF1234567890',
					cover: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDZayQbW7Q6gFkqRnSNBpL-M3aW8BrZXWw9026KO1h6HrIDkcLaJpRuBPjjG2TQMxT9Ap-vV3LWemQ67OaXL39Ba0vpueIVNfyJQmfp5zLnALZuI0J1ZmHIqmhnj6rjXz7EH4aYqzF7gz4p2im-IiMGdSdKTVNXrMqb1nf1WAR2n5KoaLl-sSZZ3FlHMQdTUXR6cHxIibC4END5uFyNOzTPYiYIaQ1BD-FIXZGlKvPkVvy1r9XfkDwRa7ubbDJ9EZ_UabL04Beheffx'
				}
			]
		}
	},
	methods: {
		goBack() { uni.navigateBack(); },
		switchTab(index) { this.currentTab = index; },
		onSwiperChange(e) { this.currentTab = e.detail.current; },
		goDetail() { uni.navigateTo({ url: '/pages/order/logistics-detail' }); }
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
.list-content { height: 100%; padding: 32rpx; box-sizing: border-box; }
.notice-card {
	background-color: $color-surface; border-radius: 24rpx; padding: 32rpx;
	margin-bottom: 24rpx; box-shadow: 0 4rpx 12rpx rgba(0,0,0,0.03);
	.card-header {
		display: flex; justify-content: space-between; margin-bottom: 24rpx;
		.status { font-weight: 600; font-size: 32rpx; color: $color-primary; }
		.time { font-size: 24rpx; color: $color-outline; }
	}
	.card-body {
		display: flex; gap: 24rpx;
		.cover { width: 120rpx; height: 120rpx; border-radius: 16rpx; }
		.info {
			flex: 1; display: flex; flex-direction: column; justify-content: center; gap: 12rpx;
			.desc { font-size: 28rpx; color: $color-on-surface; }
			.tracking { font-size: 24rpx; color: $color-on-surface-variant; }
		}
	}
}
.empty-state {
	display: flex; flex-direction: column; align-items: center; justify-content: center; height: 100%; color: $color-outline; gap: 16rpx;
	.empty-icon { font-size: 96rpx; opacity: 0.5; }
}
</style>
