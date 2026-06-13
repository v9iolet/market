<template>
	<view class="category-zone-page">
		<!-- Top Navigation -->
		<view class="header glass-effect">
			<view class="header-content">
				<view class="back-btn active-scale" @click="goBack">
					<text class="material-symbols-outlined text-outline">arrow_back_ios_new</text>
				</view>
				<text class="title">{{ categoryName }}</text>
				<view class="search-btn active-scale">
					<text class="material-symbols-outlined text-outline">search</text>
				</view>
			</view>
		</view>

		<scroll-view scroll-y class="main-content" @scroll="onScroll">
			<!-- Subcategory Tabs -->
			<view class="subcategory-section">
				<scroll-view scroll-x class="subcategory-scroll hide-scrollbar">
					<view class="subcategory-tabs">
						<view 
							class="sub-tab" 
							v-for="(tab, index) in subcategories" 
							:key="index"
							:class="{'active': activeSubIndex === index}"
							@click="selectSubcategory(index)"
						>
							<view class="icon-wrapper" v-if="tab.icon">
								<text class="material-symbols-outlined">{{ tab.icon }}</text>
							</view>
							<text>{{ tab.name }}</text>
						</view>
					</view>
				</scroll-view>
			</view>

			<!-- Filter Bar -->
			<view class="filter-section glass-effect">
				<view class="filter-tabs">
					<view class="tab-btn active">
						<text>综合</text>
						<view class="indicator"></view>
					</view>
					<view class="tab-btn"><text>最新</text></view>
					<view class="tab-btn"><text>附近</text></view>
					<view class="tab-btn"><text>只看全新</text></view>
				</view>
			</view>

			<!-- Waterfall Grid & Empty State -->
			<view class="content-area">
				<EmptyState v-if="filteredProducts.length === 0" />
				
				<view class="product-waterfall" v-else>
					<ProductCard v-for="(item, index) in filteredProducts" :key="index" :product="item" />
				</view>
			</view>
			
			<view class="safe-bottom-area"></view>
		</scroll-view>
	</view>
</template>

<script>
import ProductCard from '@/components/ProductCard/ProductCard.vue';
import EmptyState from '@/components/EmptyState/EmptyState.vue';

export default {
	components: {
		ProductCard,
		EmptyState
	},
	data() {
		return {
			categoryName: '手机数码',
			isScrolled: false,
			activeSubIndex: 0,
			subcategories: [
				{ name: '全部', icon: 'apps' },
				{ name: '手机', icon: 'smartphone' },
				{ name: '平板', icon: 'tablet_mac' },
				{ name: '电脑', icon: 'laptop_mac' },
				{ name: '耳机', icon: 'headphones' },
				{ name: '相机', icon: 'photo_camera' }
			],
			mockProducts: [
				{
					title: 'iPhone 15 Pro 256G 钛金属 官换全新',
					price: '5899',
					originalPrice: '8999',
					image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAiq42KCbumLf_PGZ00EXlvMIdbSec5JAmbRx_eqOJhP1KGlKt_a3t7aj9YOUzHlY6d_w7gnFQxw7Oy7aZ5-mKWg7yvJCdSkSQJb_HNsL1GQydeisa0bBJxjY13bY_92IcuZph2umqcfpcyjCWE-U6iS1NjmYmLFx3KqUfhYgeuqNoo6_WqqiAPD0F2oM3AvlczLIFny3BRgLp_B5VzqG2Hhyh6O_jFBSSnG600vmPbi3FcbYdGTVYHDGxYaYd563fNwS0yzjecwmLx',
					condition: '99新',
					isLiked: false,
					seller: { name: '林小姐', location: '上海·静安', avatar: '' },
					subcategoryId: 1
				},
				{
					title: 'Sony A7M4 全画幅微单 仅快门2k',
					price: '12800',
					originalPrice: '',
					image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuB-GBth_O6vwbFNtAtlaWMdOo5usGp-d5IxXEZUHFPuM9Sfbunj58ssxoRanO1ImfFffhlndmq1Z-v73mnxDwor86zEmLOrKm_doSfGphMDsNCniiwzBiKkOPXmsaLsW7cUQoVqJ7ET-4iMxxqSZ_jUXf2axftbqeyH7VXLRuqOKx4Qvg5zjZ1mGnKmvLeYtwnT8VmQ_TybmwwL5myeWgvurnj0H25xoetb5D5SmL9mXmVjra3jEp2grhw4xq3A4KZoqHjNc-wUTYJx',
					condition: '95新',
					isLiked: false,
					seller: { name: '摄影师老张', location: '杭州·西湖', avatar: '' },
					subcategoryId: 5
				}
			]
		}
	},
	computed: {
		filteredProducts() {
			if (this.activeSubIndex === 0) return this.mockProducts;
			return this.mockProducts.filter(p => p.subcategoryId === this.activeSubIndex);
		}
	},
	onLoad(options) {
		if (options.type) {
			this.categoryName = options.type;
			if (options.type !== '手机数码') {
				// Mock empty state for other categories
				this.mockProducts = [];
			}
		}
	},
	methods: {
		goBack() {
			uni.navigateBack();
		},
		onScroll(e) {
			this.isScrolled = e.detail.scrollTop > 20;
		},
		selectSubcategory(index) {
			this.activeSubIndex = index;
		}
	}
}
</script>

<style lang="scss" scoped>
.category-zone-page {
	min-height: 100vh;
	background-color: $color-background;
}

.text-outline {
	color: $color-outline;
}

/* Top Navigation */
.header {
	position: fixed;
	top: 0;
	width: 100%;
	z-index: 50;
	background-color: rgba(248, 249, 255, 0.8);

	.header-content {
		display: flex;
		align-items: center;
		justify-content: space-between;
		padding: 0 $spacing-container-margin;
		height: 100rpx;
		margin-top: env(safe-area-inset-top);

		.back-btn, .search-btn {
			width: 80rpx;
			height: 80rpx;
			display: flex;
			align-items: center;
			justify-content: center;

			.material-symbols-outlined {
				font-size: 44rpx;
			}
		}

		.title {
			font-size: 34rpx;
			font-weight: 600;
			color: $color-on-surface;
		}
	}
}

.main-content {
	height: 100vh;
	padding-top: calc(100rpx + env(safe-area-inset-top));
	box-sizing: border-box;
}

/* Subcategory Tabs */
.subcategory-section {
	padding: 24rpx 0;
	background-color: transparent;

	.subcategory-scroll {
		width: 100%;
		white-space: nowrap;

		.subcategory-tabs {
			display: inline-flex;
			padding: 0 $spacing-container-margin;
			gap: 24rpx;

			.sub-tab {
				display: flex;
				flex-direction: column;
				align-items: center;
				gap: 12rpx;
				padding: 16rpx 32rpx;
				border-radius: 24rpx;
				background-color: $color-surface-container-low;
				color: $color-on-surface-variant;
				transition: all 0.2s ease;

				&.active {
					background-color: $color-secondary;
					color: $color-on-tertiary;

					.icon-wrapper {
						background-color: rgba(255, 255, 255, 0.2);
					}
				}

				.icon-wrapper {
					width: 64rpx;
					height: 64rpx;
					border-radius: 50%;
					background-color: $color-surface-container-high;
					display: flex;
					align-items: center;
					justify-content: center;

					.material-symbols-outlined {
						font-size: 36rpx;
					}
				}

				text {
					font-size: 24rpx;
					font-weight: 600;
				}
			}
		}
	}
}

/* Filter Bar */
.filter-section {
	padding: 16rpx $spacing-container-margin;
	position: sticky;
	top: 0;
	z-index: 40;
	background-color: rgba(248, 249, 255, 0.95);
	margin-bottom: 24rpx;

	.filter-tabs {
		display: flex;
		align-items: center;
		justify-content: space-between;

		.tab-btn {
			font-size: 28rpx;
			line-height: 40rpx;
			color: $color-on-surface-variant;
			cursor: pointer;
			position: relative;
			padding-bottom: 8rpx;

			&.active {
				font-weight: 700;
				color: $color-primary;

				.indicator {
					position: absolute;
					bottom: 0;
					left: 50%;
					transform: translateX(-50%);
					width: 32rpx;
					height: 6rpx;
					background-color: $color-secondary;
					border-radius: 9999rpx;
				}
			}
		}
	}
}

/* Content Area */
.content-area {
	padding-bottom: 40rpx;
}

.product-waterfall {
	padding: 0 $spacing-container-margin;
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	column-gap: $spacing-gutter;
	row-gap: $spacing-stack-md;
}

.safe-bottom-area {
	height: env(safe-area-inset-bottom);
}
</style>
