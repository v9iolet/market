<template>
	<view class="category-page">
		<!-- TopAppBar -->
		<view class="header glass-effect">
			<view class="header-content">
				<view class="icon-btn active-scale">
					<text class="material-symbols-outlined icon">menu</text>
				</view>
				<text class="header-title">分类</text>
				<view class="icon-btn active-scale" @click="goToSearch">
					<text class="material-symbols-outlined icon">search</text>
				</view>
			</view>
		</view>

		<view class="main-content">
			<!-- Sidebar (Left Column) -->
			<scroll-view scroll-y class="sidebar hide-scrollbar">
				<view 
					class="sidebar-item" 
					v-for="(category, index) in categories" 
					:key="index"
					:class="{'active': activeIndex === index}"
					@click="activeIndex = index"
				>
					<text class="item-text">{{ category }}</text>
				</view>
			</scroll-view>

			<!-- Main Content (Right Column) -->
			<scroll-view scroll-y class="content-area hide-scrollbar">
				<!-- Promotional Banner -->
				<view class="promo-banner">
					<image class="banner-img" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCfoUn6Io-H7Fb-xs9BX6tfC3eIR76wIiLIe8RdvPD3WEhm29yWmIZNGNnCIZT-cCbkF3w_TdzM_RXjvVTej295bhI1iyf4qNZS9QFCBcM8kH5Yxcvi7qnwtxZ25H-r9iFDGgyHoSHbDVha7yjbSiR6W0H_wU9Fpb0WTQbtlaJvG_sdmqq4CxEt4lhRlNaJuXGRFgBYbT_cBwsw1EHxd6D4R5oHHrUVSSDabO6-1l7glIAtVD8vUfyJmfl4S8PP1yS1zYBjhOadwRoK" mode="aspectFill"></image>
					<view class="banner-overlay">
						<text class="banner-subtitle">精选推荐</text>
						<text class="banner-title">数码焕新季</text>
					</view>
				</view>

				<!-- Dynamic Subcategories -->
				<view class="subcategory-group" v-if="currentSubcategories && currentSubcategories.length > 0">
					<view class="group-header">
						<text class="group-title">{{ categories[activeIndex] }}分类</text>
					</view>
					<view class="grid-container">
						<view 
							class="grid-item active-scale" 
							v-for="(sub, subIdx) in currentSubcategories" 
							:key="subIdx"
						>
							<view class="icon-wrapper">
								<text class="material-symbols-outlined icon">{{ sub.icon || 'apps' }}</text>
							</view>
							<text class="item-label">{{ sub.name }}</text>
						</view>
					</view>
				</view>

				<view class="safe-bottom-area"></view>
			</scroll-view>
		</view>

		<CustomTabBar current="category" />
	</view>
</template>

<script>
	import CustomTabBar from '@/components/CustomTabBar/CustomTabBar.vue';

	import { categoryMap } from '@/utils/categoryData.js';

	export default {
		components: {
			CustomTabBar
		},
		data() {
			return {
				categories: [
					'手机数码', '潮鞋服饰', '图书教材', '运动户外', '美妆护肤', 
					'文玩收藏', '乐器器械', '游戏装备', '办公文具'
				],
				activeIndex: 0
			}
		},
		computed: {
			currentSubcategories() {
				const category = this.categories[this.activeIndex];
				return categoryMap[category] || [{ name: '全部', icon: 'apps' }];
			}
		},
		methods: {
			goToSearch() {
				uni.navigateTo({ url: '/pages/search/search' });
			}
		}
	}
</script>

<style lang="scss" scoped>
	.category-page {
		height: 100vh;
		background-color: $color-background;
		display: flex;
		flex-direction: column;
		overflow: hidden;
	}

	/* TopAppBar */
	.header {
		position: fixed;
		top: 0;
		width: 100%;
		z-index: 50;
		background-color: rgba(248, 249, 255, 0.8);
		box-shadow: 0 2rpx 8rpx rgba(0,0,0,0.05);

		.header-content {
			display: flex;
			align-items: center;
			justify-content: space-between;
			padding: 0 $spacing-container-margin;
			height: 128rpx;
			padding-top: env(safe-area-inset-top);

			.icon-btn {
				padding: 16rpx;
				margin: -16rpx;
				color: $color-primary;
				display: flex;
				align-items: center;
				justify-content: center;
				
				.icon {
					font-size: 48rpx;
				}
			}

			.header-title {
				font-size: 40rpx;
				font-weight: 700;
				color: $color-primary;
			}
		}
	}

	/* Main Content Area */
	.main-content {
		flex: 1;
		display: flex;
		margin-top: calc(128rpx + env(safe-area-inset-top));
		overflow: hidden;
	}

	/* Sidebar */
	.sidebar {
		width: 192rpx; /* 24 * 8px */
		background-color: $color-surface-container-lowest;
		border-right: 2rpx solid $color-surface-variant;
		height: 100%;

		.sidebar-item {
			width: 100%;
			padding: 32rpx 16rpx;
			display: flex;
			align-items: center;
			justify-content: center;
			color: $color-on-surface-variant;
			position: relative;
			box-sizing: border-box;

			.item-text {
				font-size: 28rpx;
			}

			&.active {
				background-color: $color-surface;
				border-left: 8rpx solid $color-secondary;

				.item-text {
					color: $color-secondary;
					font-weight: 700;
				}
			}
		}
	}

	/* Content Area */
	.content-area {
		flex: 1;
		background-color: $color-background;
		padding: $spacing-container-margin;
		box-sizing: border-box;
		height: 100%;
	}

	/* Promotional Banner */
	.promo-banner {
		width: 100%;
		height: 256rpx;
		border-radius: 24rpx;
		background-color: $color-surface-container-high;
		margin-bottom: $spacing-stack-lg;
		position: relative;
		overflow: hidden;
		box-shadow: 0 2rpx 8rpx rgba(0,0,0,0.05);

		.banner-img {
			width: 100%;
			height: 100%;
			opacity: 0.8;
		}

		.banner-overlay {
			position: absolute;
			inset: 0;
			background: linear-gradient(to right, rgba(9, 20, 38, 0.6), transparent);
			padding: 32rpx;
			display: flex;
			flex-direction: column;
			justify-content: center;

			.banner-subtitle {
				font-size: 28rpx;
				color: $color-on-primary;
				opacity: 0.8;
				margin-bottom: 8rpx;
			}

			.banner-title {
				font-size: 40rpx;
				font-weight: 700;
				color: $color-on-primary;
			}
		}
	}

	/* Subcategory Group */
	.subcategory-group {
		margin-bottom: $spacing-section-gap;

		.group-header {
			display: flex;
			align-items: center;
			justify-content: space-between;
			margin-bottom: $spacing-stack-md;

			.group-title {
				font-size: 32rpx;
				font-weight: 700;
				color: $color-primary;
			}

			.icon-more {
				color: $color-outline;
				font-size: 28rpx;
			}
		}

		.grid-container {
			display: grid;
			grid-template-columns: repeat(3, 1fr);
			gap: $spacing-gutter;

			.grid-item {
				display: flex;
				flex-direction: column;
				align-items: center;
				padding: 24rpx;
				background-color: $color-surface-container-lowest;
				border-radius: 24rpx;
				box-shadow: 0 2rpx 8rpx rgba(0,0,0,0.05);

				.icon-wrapper {
					width: 96rpx;
					height: 96rpx;
					border-radius: 50%;
					background-color: $color-surface-container-low;
					display: flex;
					align-items: center;
					justify-content: center;
					margin-bottom: 16rpx;

					.icon {
						font-size: 60rpx;
						color: $color-outline;
					}

					.img-icon {
						width: 64rpx;
						height: 64rpx;
					}
				}

				.item-label {
					font-size: 28rpx;
					color: $color-on-surface;
					text-align: center;
				}
			}
		}
	}

	.safe-bottom-area {
		height: calc(160rpx + env(safe-area-inset-bottom));
	}
</style>
