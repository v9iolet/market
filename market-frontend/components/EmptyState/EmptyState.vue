<template>
	<view class="empty-state">
		<view class="icon-wrapper">
			<text class="material-symbols-outlined">inventory_2</text>
		</view>
		<text class="empty-title">{{ title }}</text>
		<text class="empty-subtitle" v-if="subtitle">{{ subtitle }}</text>
	</view>
</template>

<script>
export default {
	name: 'EmptyState',
	props: {
		title: {
			type: String,
			default: '暂无相关商品'
		},
		subtitle: {
			type: String,
			default: ''
		}
	}
}
</script>

<style lang="scss" scoped>
.empty-state {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	padding: 128rpx 32rpx;
	width: 100%;
	
	.icon-wrapper {
		width: 160rpx;
		height: 160rpx;
		border-radius: 50%;
		background-color: $color-surface-container-highest;
		display: flex;
		align-items: center;
		justify-content: center;
		margin-bottom: 24rpx;

		.material-symbols-outlined {
			font-size: 80rpx;
			color: $color-outline;
			opacity: 0.6;
		}
	}

	.empty-title {
		font-size: 32rpx;
		color: $color-on-surface-variant;
		font-weight: 600;
		margin-bottom: 8rpx;
	}

	.empty-subtitle {
		font-size: 24rpx;
		color: rgba(69, 71, 76, 0.6);
	}
}
</style>
