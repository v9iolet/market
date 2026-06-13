<template>
	<view class="search-page">
		<!-- TopAppBar -->
		<view class="header glass-effect">
			<view class="header-content">
				<view class="back-btn active-scale" @click="goBack">
					<text class="material-symbols-outlined text-outline">arrow_back_ios_new</text>
				</view>
				<view class="search-bar">
					<text class="material-symbols-outlined icon-search">search</text>
					<input 
						class="search-input" 
						v-model="searchQuery" 
						placeholder="搜索商品..." 
						:focus="true"
					/>
					<text class="material-symbols-outlined icon-close active-scale" v-if="searchQuery" @click="clearSearch">close</text>
				</view>
				<view class="search-action active-scale" @click="doSearch">
					<text class="action-text">搜索</text>
				</view>
			</view>
		</view>

		<scroll-view scroll-y class="main-content">
			<!-- Before search -->
			<view class="pre-search-state" v-if="!searchQuery">
				<view class="section">
					<view class="section-header">
						<text class="section-title">热门搜索</text>
					</view>
					<view class="tags-group">
						<text class="tag" @click="setSearch('iPhone 15')">iPhone 15</text>
						<text class="tag" @click="setSearch('MacBook')">MacBook</text>
						<text class="tag" @click="setSearch('微单')">微单</text>
						<text class="tag" @click="setSearch('包包')">包包</text>
					</view>
				</view>
			</view>
			
			<!-- Results -->
			<view class="results-state" v-else>
				<view class="product-waterfall" v-if="filteredProducts.length > 0">
					<ProductCard v-for="(item, index) in filteredProducts" :key="index" :product="item" />
				</view>
				<view class="empty-state" v-else>
					<text>暂无相关商品</text>
				</view>
			</view>
		</scroll-view>
	</view>
</template>

<script>
	import ProductCard from '@/components/ProductCard/ProductCard.vue';

	export default {
		components: {
			ProductCard
		},
		data() {
			return {
				searchQuery: '',
				mockProducts: [
					{
						title: 'iPhone 15 Pro 256G 钛金属 官换全新',
						price: '5899',
						originalPrice: '8999',
						image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAiq42KCbumLf_PGZ00EXlvMIdbSec5JAmbRx_eqOJhP1KGlKt_a3t7aj9YOUzHlY6d_w7gnFQxw7Oy7aZ5-mKWg7yvJCdSkSQJb_HNsL1GQydeisa0bBJxjY13bY_92IcuZph2umqcfpcyjCWE-U6iS1NjmYmLFx3KqUfhYgeuqNoo6_WqqiAPD0F2oM3AvlczLIFny3BRgLp_B5VzqG2Hhyh6O_jFBSSnG600vmPbi3FcbYdGTVYHDGxYaYd563fNwS0yzjecwmLx',
						condition: '99新'
					},
					{
						title: 'MacBook Air 13 M3 16G 512G 银色',
						price: '7299',
						originalPrice: '9499',
						image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCEWT3fvAl3jhzszqPW7UoW0Mh9gf0cyRZ0LI23QG_vocaoBcID1C5CxJhMCZKuv-LkSfNWW-AM2A3wM9PJUssuFXmD9bpfKgi8PpBToDUP3uXkcaH3DR-2102B_gcKvcfLJ78qV5MKnTfps4pl-Ysje2DJiwmh8XK_jdzDaHq146B9crasADoIu3u9fgqtACQztwfLBRpWWCzs-mPEEJRJLTS8CscEEEABJC1Bi6EjZWFUr7dVLL2gvFFzagMsKV4Kj3-j3IKBiox9',
						condition: '全新'
					},
					{
						title: 'Air Jordan 1 Retro High OG Chicago',
						price: '2450',
						originalPrice: '3299',
						image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuD-84dYRmdRu3fejykvEl3GYDz2VdkKQBkkqaMgW--dRYIsEc0omtbSMyV0_y2cTlLDSlBMdGSQ_GT5eMKIMEFem4uPI8G5TmRNm0yI5JbYg-EdctXVikXSMrN3V6-UfUNAo1Vg5v9zRsg2ZvovtNO5JOPSSUJHOM5_hay8ASMLvLHnFyPz7qzUggaPRHP-iFRYCTMMRyd7gPhKkTfi-GvyuLYfIRZEt6tJw22lfrM8_M22_Km0e1uJjgDQu91GsgUmB_wi3ITGOAw5',
						condition: '99新'
					},
					{
						title: 'Sony A7M4 全画幅微单 仅快门2k',
						price: '12800',
						originalPrice: '',
						image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuB-GBth_O6vwbFNtAtlaWMdOo5usGp-d5IxXEZUHFPuM9Sfbunj58ssxoRanO1ImfFffhlndmq1Z-v73mnxDwor86zEmLOrKm_doSfGphMDsNCniiwzBiKkOPXmsaLsW7cUQoVqJ7ET-4iMxxqSZ_jUXf2axftbqeyH7VXLRuqOKx4Qvg5zjZ1mGnKmvLeYtwnT8VmQ_TybmwwL5myeWgvurnj0H25xoetb5D5SmL9mXmVjra3jEp2grhw4xq3A4KZoqHjNc-wUTYJx',
						condition: '95新'
					}
				]
			}
		},
		computed: {
			filteredProducts() {
				if (!this.searchQuery) return [];
				const lowerQuery = this.searchQuery.toLowerCase();
				return this.mockProducts.filter(p => p.title.toLowerCase().includes(lowerQuery));
			}
		},
		methods: {
			goBack() {
				uni.navigateBack();
			},
			clearSearch() {
				this.searchQuery = '';
			},
			setSearch(query) {
				this.searchQuery = query;
			},
			doSearch() {
				// Action on enter or click search
			}
		}
	}
</script>

<style lang="scss" scoped>
	.search-page {
		min-height: 100vh;
		background-color: $color-background;
		display: flex;
		flex-direction: column;
	}

	.text-outline {
		color: $color-outline;
	}

	/* TopAppBar */
	.header {
		position: fixed;
		top: 0;
		width: 100%;
		z-index: 50;
		background-color: rgba(248, 249, 255, 0.95);
		box-shadow: 0 4rpx 8rpx rgba(0,0,0,0.05);

		.header-content {
			display: flex;
			align-items: center;
			padding: 0 $spacing-container-margin;
			height: 100rpx;
			margin-top: env(safe-area-inset-top);
			gap: 24rpx;

			.back-btn {
				width: 64rpx;
				height: 64rpx;
				display: flex;
				align-items: center;
				justify-content: center;

				.material-symbols-outlined {
					font-size: 40rpx;
				}
			}

			.search-bar {
				flex: 1;
				background-color: $color-surface-container-low;
				border-radius: 9999rpx;
				padding: 12rpx 24rpx;
				display: flex;
				align-items: center;
				gap: 16rpx;
				border: 2rpx solid transparent;
				transition: all 0.3s ease;

				&:focus-within {
					border-color: rgba(9, 20, 38, 0.3);
					box-shadow: 0 0 0 4rpx rgba(0, 108, 73, 0.2);
				}

				.icon-search, .icon-close {
					font-size: 36rpx;
					color: $color-outline;
				}

				.search-input {
					background: transparent;
					border: none;
					padding: 0;
					font-size: 28rpx;
					width: 100%;
					color: $color-on-surface;
				}
			}
			
			.search-action {
				padding: 12rpx 0;
				.action-text {
					font-size: 30rpx;
					font-weight: 600;
					color: $color-primary;
				}
			}
		}
	}

	.main-content {
		flex: 1;
		margin-top: calc(100rpx + env(safe-area-inset-top));
		padding-top: 24rpx;
	}

	.pre-search-state {
		padding: 0 $spacing-container-margin;
		
		.section {
			margin-bottom: 48rpx;
			
			.section-header {
				margin-bottom: 24rpx;
				
				.section-title {
					font-size: 30rpx;
					font-weight: 700;
					color: $color-on-surface;
				}
			}
			
			.tags-group {
				display: flex;
				flex-wrap: wrap;
				gap: 20rpx;
				
				.tag {
					background-color: $color-surface;
					color: $color-on-surface-variant;
					padding: 12rpx 28rpx;
					border-radius: 999rpx;
					font-size: 26rpx;
					box-shadow: 0 2rpx 4rpx rgba(0,0,0,0.05);
				}
			}
		}
	}
	
	.results-state {
		padding-bottom: 40rpx;
		
		.product-waterfall {
			padding: 0 $spacing-container-margin;
			display: grid;
			grid-template-columns: repeat(2, 1fr);
			column-gap: $spacing-gutter;
			row-gap: $spacing-stack-md;
		}
		
		.empty-state {
			display: flex;
			justify-content: center;
			padding: 80rpx 0;
			color: $color-outline;
			font-size: 28rpx;
		}
	}
</style>
