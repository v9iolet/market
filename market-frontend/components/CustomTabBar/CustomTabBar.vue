<template>
	<view class="custom-tab-bar glass-effect">
		<view class="tab-item active-scale" :class="{ active: current === 'index' }" @click="switchTab('index')">
			<text class="material-symbols-outlined" :class="{ 'icon-filled': current === 'index' }">home</text>
			<text class="tab-label">首页</text>
		</view>
		<view class="tab-item active-scale" :class="{ active: current === 'category' }" @click="switchTab('category')">
			<text class="material-symbols-outlined" :class="{ 'icon-filled': current === 'category' }">grid_view</text>
			<text class="tab-label">分类</text>
		</view>
		<view class="tab-item publish-wrapper active-scale" @click="switchTab('publish')">
			<view class="publish-btn">
				<text class="material-symbols-outlined">add</text>
			</view>
			<text class="tab-label publish-label">发布</text>
		</view>
		<view class="tab-item active-scale" :class="{ active: current === 'messages' }" @click="switchTab('messages')">
			<text class="material-symbols-outlined" :class="{ 'icon-filled': current === 'messages' }">chat_bubble</text>
			<text class="tab-label">消息</text>
		</view>
		<view class="tab-item active-scale" :class="{ active: current === 'profile' }" @click="switchTab('profile')">
			<text class="material-symbols-outlined" :class="{ 'icon-filled': current === 'profile' }">person</text>
			<text class="tab-label">我的</text>
		</view>
	</view>
</template>

<script>
	const ROUTES = {
		index:    '/pages/index/index',
		category: '/pages/category/category',
		publish:  '/pages/publish/publish',
		messages: '/pages/messages/messages',
		profile:  '/pages/profile/profile',
	};

	export default {
		name: 'CustomTabBar',
		props: {
			current: {
				type: String,
				default: 'index'
			}
		},
		methods: {
			switchTab(tab) {
				if (tab === this.current) return;
				uni.navigateTo({
					url: ROUTES[tab],
					fail() {
						// fallback: redirectTo 防止堆栈过深
						uni.redirectTo({ url: ROUTES[tab] });
					}
				});
			}
		}
	}
</script>

<style lang="scss" scoped>
	.custom-tab-bar {
		position: fixed;
		bottom: 0;
		left: 0;
		width: 100%;
		height: 160rpx;
		display: flex;
		justify-content: space-around;
		align-items: center;
		padding: 0 32rpx;
		padding-bottom: env(safe-area-inset-bottom);
		background-color: rgba(248, 249, 255, 0.8);
		border-top: 1rpx solid rgba(197, 198, 205, 0.3);
		box-shadow: 0 -10rpx 30rpx rgba(0, 0, 0, 0.05);
		border-top-left-radius: 24rpx;
		border-top-right-radius: 24rpx;
		z-index: 50;
		box-sizing: border-box;
	}

	.tab-item {
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		color: $color-on-surface-variant;
		cursor: pointer;
		padding: 16rpx;
		border-radius: 24rpx;
		transition: background-color 0.2s ease;

		.material-symbols-outlined {
			font-size: 48rpx;
		}

		.tab-label {
			font-size: 24rpx;
			line-height: 32rpx;
			letter-spacing: 0.05em;
			font-weight: 600;
			margin-top: 8rpx;
		}

		&.active {
			color: $color-secondary;
			
			.icon-filled {
				font-variation-settings: 'FILL' 1;
			}
		}

		&:hover {
			background-color: $color-surface-container-low;
		}
	}

	.publish-wrapper {
		position: relative;
		top: -32rpx;
		
		&:hover {
			background-color: transparent;
		}

		.publish-btn {
			width: 112rpx;
			height: 112rpx;
			background-color: $color-secondary;
			border-radius: 50%;
			display: flex;
			align-items: center;
			justify-content: center;
			box-shadow: 0 10rpx 30rpx rgba(0, 108, 73, 0.4);
			border: 8rpx solid $color-background;

			.material-symbols-outlined {
				color: $color-on-secondary;
				font-size: 64rpx;
			}
		}

		.publish-label {
			margin-top: 16rpx;
			color: $color-on-surface-variant;
		}
	}
</style>
