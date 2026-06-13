<template>
	<view class="marketplace-home">
		<!-- TopAppBar -->
		<view class="header glass-effect" :class="{'shadow-md': isScrolled}">
			<view class="header-content">
				<view class="search-section">
					<text class="material-symbols-outlined text-primary">center_focus_weak</text>
					<view class="search-bar" :class="{'search-bar-focused': isSearchFocused}">
						<text class="material-symbols-outlined text-outline icon-search">search</text>
						<input 
							class="search-input" 
							placeholder="iPhone 15 Pro..." 
							type="text" 
							@focus="isSearchFocused = true"
							@blur="isSearchFocused = false"
						/>
					</view>
				</view>
				<view class="notification-section active-scale">
					<text class="material-symbols-outlined text-primary">notifications</text>
					<view class="notification-badge"></view>
				</view>
			</view>
		</view>

		<scroll-view scroll-y class="main-content" @scroll="onScroll">
			<!-- Lifestyle Banner -->
			<view class="banner-section">
				<view class="banner-card">
					<image class="banner-image" mode="aspectFill" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBq0CmDLMSAA9igKBySIj_7R7hm3beB_3Wz_WQFsDDISiSLCl1afYuZMTt-nM50aQf4bKav6klGKfDMPa3zJAJEdR3ypCX7n8IBcH7DieJkKzAZNtZuSl_SVrn4N1Xn2D4M-065ce_vTMB9j8Cf8ZcUQ6vtCGkKWOxSTZjq7ZLGt4FB2reCBjJmCTNUWr4U3W3-T82p0kYthUZq3IpaqspuJp_SY8wiDjF1q_UUuKvj2WOkKKQ6l072YEs1_q4m1mu5cglg2T47jo6v"></image>
					<view class="banner-overlay">
						<text class="banner-badge">优质精选</text>
						<text class="banner-title">发现你的下一件奢品</text>
						<text class="banner-subtitle">本周热门好物低至3折起</text>
					</view>
				</view>
			</view>

			<!-- Category Grid -->
			<view class="category-section">
				<scroll-view scroll-x class="category-scroll hide-scrollbar">
					<view class="category-grid">
						<!-- Row 1 -->
						<view class="category-item active-scale">
							<view class="icon-wrapper">
								<text class="material-symbols-outlined text-primary">smartphone</text>
							</view>
							<text class="category-label">手机数码</text>
						</view>
						<view class="category-item active-scale">
							<view class="icon-wrapper">
								<text class="material-symbols-outlined text-primary">checkroom</text>
							</view>
							<text class="category-label">潮鞋服饰</text>
						</view>
						<view class="category-item active-scale">
							<view class="icon-wrapper">
								<text class="material-symbols-outlined text-primary">menu_book</text>
							</view>
							<text class="category-label">图书教材</text>
						</view>
						<view class="category-item active-scale">
							<view class="icon-wrapper">
								<text class="material-symbols-outlined text-primary">fitness_center</text>
							</view>
							<text class="category-label">运动户外</text>
						</view>
						<view class="category-item active-scale">
							<view class="icon-wrapper">
								<text class="material-symbols-outlined text-primary">face_6</text>
							</view>
							<text class="category-label">美妆护肤</text>
						</view>
						
						<!-- Row 2 -->
						<view class="category-item active-scale">
							<view class="icon-wrapper">
								<text class="material-symbols-outlined text-primary">diamond</text>
							</view>
							<text class="category-label">文玩收藏</text>
						</view>
						<view class="category-item active-scale">
							<view class="icon-wrapper">
								<text class="material-symbols-outlined text-primary">piano</text>
							</view>
							<text class="category-label">乐器器械</text>
						</view>
						<view class="category-item active-scale">
							<view class="icon-wrapper">
								<text class="material-symbols-outlined text-primary">sports_esports</text>
							</view>
							<text class="category-label">游戏装备</text>
						</view>
						<view class="category-item active-scale">
							<view class="icon-wrapper">
								<text class="material-symbols-outlined text-primary">edit_note</text>
							</view>
							<text class="category-label">办公文具</text>
						</view>
						<view class="category-item active-scale">
							<view class="icon-wrapper">
								<text class="material-symbols-outlined text-primary">apps</text>
							</view>
							<text class="category-label">全部分类</text>
						</view>
					</view>
				</scroll-view>
			</view>

			<!-- Filter Tabs -->
			<view class="filter-section glass-effect">
				<scroll-view scroll-x class="filter-scroll hide-scrollbar">
					<view class="filter-tabs">
						<view class="tab-btn active">
							<text>推荐</text>
							<view class="indicator"></view>
						</view>
						<view class="tab-btn"><text>最新</text></view>
						<view class="tab-btn"><text>附近</text></view>
						<view class="tab-btn"><text>手机</text></view>
						<view class="tab-btn"><text>电脑</text></view>
					</view>
				</scroll-view>
			</view>

			<!-- Product Waterfall -->
			<view class="product-waterfall">
				<!-- Card 1: iPhone -->
				<view class="product-card active-scale" @click="goDetail">
					<view class="image-wrapper">
						<image class="product-img" mode="aspectFill" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAiq42KCbumLf_PGZ00EXlvMIdbSec5JAmbRx_eqOJhP1KGlKt_a3t7aj9YOUzHlY6d_w7gnFQxw7Oy7aZ5-mKWg7yvJCdSkSQJb_HNsL1GQydeisa0bBJxjY13bY_92IcuZph2umqcfpcyjCWE-U6iS1NjmYmLFx3KqUfhYgeuqNoo6_WqqiAPD0F2oM3AvlczLIFny3BRgLp_B5VzqG2Hhyh6O_jFBSSnG600vmPbi3FcbYdGTVYHDGxYaYd563fNwS0yzjecwmLx"></image>
						<view class="condition-badge">99新</view>
					</view>
					<view class="product-info">
						<text class="product-title">iPhone 15 Pro 256G 钛金属 官换全新</text>
						<view class="price-row">
							<text class="current-price">¥5899</text>
							<text class="original-price">¥8999</text>
						</view>
						<view class="seller-row">
							<view class="seller-info">
								<image class="avatar" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCV9F8O2klRKszo6zXbHBzCyzxOoqyP4SwEYpbbf2kFCtMIOp-koWw-UCVULtcnvEwVmQjJDG13_KOKjGLo-AN7jXusN2mA5CFcCZSXOoJYPxJXiMU7DP2aan_s0DX1E12pdCECM3yo1B34QkNKVk57AdQASf78K4q5EZS-JiDSWN7gkDjLkHULI8lYeOPhGtZ2yZv3LAGnIMjWpjd_3USnnK1WgSANJjqD5Zcld1CtK1AVkdi8KkoYBMCUq0B5l26Mx6eGUmCyn13a"></image>
								<view class="seller-meta">
									<text class="seller-name">林小姐</text>
									<text class="seller-loc">上海·静安</text>
								</view>
							</view>
							<text class="material-symbols-outlined icon-heart">favorite</text>
						</view>
					</view>
				</view>

				<!-- Card 2: MacBook -->
				<view class="product-card active-scale" @click="goDetail">
					<view class="image-wrapper">
						<image class="product-img" mode="aspectFill" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCEWT3fvAl3jhzszqPW7UoW0Mh9gf0cyRZ0LI23QG_vocaoBcID1C5CxJhMCZKuv-LkSfNWW-AM2A3wM9PJUssuFXmD9bpfKgi8PpBToDUP3uXkcaH3DR-2102B_gcKvcfLJ78qV5MKnTfps4pl-Ysje2DJiwmh8XK_jdzDaHq146B9crasADoIu3u9fgqtACQztwfLBRpWWCzs-mPEEJRJLTS8CscEEEABJC1Bi6EjZWFUr7dVLL2gvFFzagMsKV4Kj3-j3IKBiox9"></image>
						<view class="condition-badge">全新</view>
					</view>
					<view class="product-info">
						<text class="product-title">MacBook Air 13 M3 16G 512G 银色</text>
						<view class="price-row">
							<text class="current-price">¥7299</text>
							<text class="original-price">¥9499</text>
						</view>
						<view class="seller-row">
							<view class="seller-info">
								<view class="avatar avatar-placeholder">
									<text class="material-symbols-outlined">person</text>
								</view>
								<view class="seller-meta">
									<text class="seller-name">Apple极客</text>
									<text class="seller-loc">北京·朝阳</text>
								</view>
							</view>
							<text class="material-symbols-outlined icon-heart">favorite</text>
						</view>
					</view>
				</view>

				<!-- Card 3: Shoes -->
				<view class="product-card active-scale" @click="goDetail">
					<view class="image-wrapper">
						<image class="product-img" mode="aspectFill" src="https://lh3.googleusercontent.com/aida-public/AB6AXuD-84dYRmdRu3fejykvEl3GYDz2VdkKQBkkqaMgW--dRYIsEc0omtbSMyV0_y2cTlLDSlBMdGSQ_GT5eMKIMEFem4uPI8G5TmRNm0yI5JbYg-EdctXVikXSMrN3V6-UfUNAo1Vg5v9zRsg2ZvovtNO5JOPSSUJHOM5_hay8ASMLvLHnFyPz7qzUggaPRHP-iFRYCTMMRyd7gPhKkTfi-GvyuLYfIRZEt6tJw22lfrM8_M22_Km0e1uJjgDQu91GsgUmB_wi3ITGOAw5"></image>
						<view class="condition-badge">99新</view>
					</view>
					<view class="product-info">
						<text class="product-title">Air Jordan 1 Retro High OG Chicago</text>
						<view class="price-row">
							<text class="current-price">¥2450</text>
							<text class="original-price">¥3299</text>
						</view>
						<view class="seller-row">
							<view class="seller-info">
								<view class="avatar avatar-placeholder"></view>
								<view class="seller-meta">
									<text class="seller-name">SneakerHead</text>
									<text class="seller-loc">广州·天河</text>
								</view>
							</view>
							<text class="material-symbols-outlined icon-heart heart-filled" style="color: #ba1a1a;">favorite</text>
						</view>
					</view>
				</view>

				<!-- Card 4: Camera -->
				<view class="product-card active-scale" @click="goDetail">
					<view class="image-wrapper">
						<image class="product-img" mode="aspectFill" src="https://lh3.googleusercontent.com/aida-public/AB6AXuB-GBth_O6vwbFNtAtlaWMdOo5usGp-d5IxXEZUHFPuM9Sfbunj58ssxoRanO1ImfFffhlndmq1Z-v73mnxDwor86zEmLOrKm_doSfGphMDsNCniiwzBiKkOPXmsaLsW7cUQoVqJ7ET-4iMxxqSZ_jUXf2axftbqeyH7VXLRuqOKx4Qvg5zjZ1mGnKmvLeYtwnT8VmQ_TybmwwL5myeWgvurnj0H25xoetb5D5SmL9mXmVjra3jEp2grhw4xq3A4KZoqHjNc-wUTYJx"></image>
						<view class="condition-badge">95新</view>
					</view>
					<view class="product-info">
						<text class="product-title">Sony A7M4 全画幅微单 仅快门2k</text>
						<view class="price-row">
							<text class="current-price">¥12800</text>
						</view>
						<view class="seller-row">
							<view class="seller-info">
								<view class="avatar avatar-placeholder"></view>
								<view class="seller-meta">
									<text class="seller-name">摄影师老张</text>
									<text class="seller-loc">杭州·西湖</text>
								</view>
							</view>
							<text class="material-symbols-outlined icon-heart">favorite</text>
						</view>
					</view>
				</view>
			</view>

			<!-- Loading Indicator -->
			<view class="loading-indicator">
				<view class="dot dot-1"></view>
				<view class="dot dot-2"></view>
				<view class="dot dot-3"></view>
			</view>
			
			<!-- Bottom padding for tab bar -->
			<view class="safe-bottom-area"></view>
		</scroll-view>

		<CustomTabBar current="index" />
	</view>
</template>

<script>
	import CustomTabBar from '@/components/CustomTabBar/CustomTabBar.vue';

	export default {
		components: {
			CustomTabBar
		},
		data() {
			return {
				isScrolled: false,
				isSearchFocused: false
			}
		},
		methods: {
			onScroll(e) {
				this.isScrolled = e.detail.scrollTop > 20;
			},
			goDetail() {
				uni.navigateTo({ url: '/pages/detail/detail' });
			}
		}
	}
</script>

<style lang="scss" scoped>
	.marketplace-home {
		min-height: 100vh;
		background-color: $color-background;
	}

	.text-primary {
		color: $color-primary;
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
		background-color: rgba(248, 249, 255, 0.8);
		transition: box-shadow 0.3s ease;

		&.shadow-md {
			box-shadow: 0 8rpx 12rpx -2rpx rgba(0, 0, 0, 0.1), 0 4rpx 8rpx -4rpx rgba(0, 0, 0, 0.1);
		}

		.header-content {
			display: flex;
			align-items: center;
			justify-content: space-between;
			padding: 0 $spacing-container-margin;
			height: 128rpx;
			max-width: 1536rpx;
			margin: 0 auto;
		}

		.search-section {
			display: flex;
			align-items: center;
			gap: 24rpx;
			flex: 1;
			margin-right: 32rpx;

			.search-bar {
				flex: 1;
				background-color: $color-surface-container-low;
				border-radius: 9999rpx;
				padding: 16rpx 32rpx;
				display: flex;
				align-items: center;
				gap: 16rpx;
				border: 2rpx solid rgba(197, 198, 205, 0.2);
				transition: all 0.3s ease;

				&.search-bar-focused {
					border-color: rgba(9, 20, 38, 0.3);
					box-shadow: 0 0 0 4rpx rgba(0, 108, 73, 0.2);
				}

				.icon-search {
					font-size: 40rpx;
				}

				.search-input {
					background: transparent;
					border: none;
					padding: 0;
					font-size: 28rpx;
					line-height: 40rpx;
					width: 100%;
					color: $color-on-surface;
					
					&::placeholder {
						color: rgba(69, 71, 76, 0.6);
					}
				}
			}
		}

		.notification-section {
			position: relative;
			cursor: pointer;

			.notification-badge {
				position: absolute;
				top: 0;
				right: 0;
				width: 16rpx;
				height: 16rpx;
				background-color: $color-error;
				border-radius: 50%;
				border: 4rpx solid $color-surface;
			}
		}
	}

	.main-content {
		height: 100vh;
		padding-top: 160rpx; /* pt-20 */
		box-sizing: border-box;
	}

	/* Lifestyle Banner */
	.banner-section {
		padding: 0 $spacing-container-margin;
		margin-bottom: $spacing-stack-lg;

		.banner-card {
			position: relative;
			height: 384rpx; /* h-48 */
			width: 100%;
			border-radius: 32rpx;
			overflow: hidden;
			box-shadow: 0 40rpx 50rpx -24rpx rgba(0, 0, 0, 0.25);
			
			.banner-image {
				width: 100%;
				height: 100%;
				object-fit: cover;
				transition: transform 0.7s ease;

				&:hover {
					transform: scale(1.05);
				}
			}

			.banner-overlay {
				position: absolute;
				inset: 0;
				background: linear-gradient(to right, rgba(9, 20, 38, 0.6), transparent);
				display: flex;
				flex-direction: column;
				justify-content: center;
				padding: 0 64rpx;
				
				.banner-badge {
					color: $color-on-tertiary;
					background-color: $color-secondary;
					padding: 4rpx 24rpx;
					border-radius: 9999rpx;
					width: max-content;
					font-size: 24rpx;
					line-height: 32rpx;
					letter-spacing: 0.05em;
					font-weight: 600;
					margin-bottom: 16rpx;
				}

				.banner-title {
					color: $color-on-tertiary;
					font-size: 52rpx;
					line-height: 64rpx;
					letter-spacing: -0.02em;
					font-weight: 700;
					max-width: 400rpx;
				}

				.banner-subtitle {
					color: rgba(255, 255, 255, 0.8);
					font-size: 28rpx;
					line-height: 40rpx;
					margin-top: 8rpx;
				}
			}
		}
	}

	/* Category Grid */
	.category-section {
		padding: 0 $spacing-container-margin;
		margin-bottom: $spacing-stack-lg;

		.category-scroll {
			width: 100%;
			white-space: nowrap;

			.category-grid {
				display: grid;
				grid-template-rows: repeat(2, 1fr);
				grid-auto-flow: column;
				row-gap: $spacing-stack-md;
				column-gap: 64rpx;
				min-width: 1000rpx;
				
				.category-item {
					display: flex;
					flex-direction: column;
					align-items: center;
					gap: 16rpx;
					cursor: pointer;

					.icon-wrapper {
						width: 96rpx;
						height: 96rpx;
						border-radius: 24rpx;
						background-color: $color-surface-container-high;
						display: flex;
						align-items: center;
						justify-content: center;

						.material-symbols-outlined {
							font-size: 56rpx;
						}
					}

					.category-label {
						font-size: 24rpx;
						line-height: 32rpx;
						letter-spacing: 0.05em;
						font-weight: 600;
						color: $color-on-surface-variant;
					}
				}
			}
		}
	}

	/* Filter Tabs */
	.filter-section {
		padding: 16rpx $spacing-container-margin;
		margin-bottom: $spacing-stack-md;
		position: sticky;
		top: 0;
		z-index: 40;
		background-color: rgba(248, 249, 255, 0.95);

		.filter-scroll {
			width: 100%;
			white-space: nowrap;

			.filter-tabs {
				display: flex;
				align-items: center;
				gap: 48rpx;

				.tab-btn {
					font-size: 32rpx;
					line-height: 48rpx;
					color: $color-on-surface-variant;
					cursor: pointer;
					position: relative;
					white-space: nowrap;
					transition: color 0.2s ease;

					&:hover {
						color: $color-primary;
					}

					&.active {
						font-size: 40rpx;
						line-height: 56rpx;
						font-weight: 600;
						color: $color-primary;

						.indicator {
							position: absolute;
							bottom: -8rpx;
							left: 50%;
							transform: translateX(-50%);
							width: 32rpx;
							height: 8rpx;
							background-color: $color-secondary;
							border-radius: 9999rpx;
						}
					}
				}
			}
		}
	}

	/* Product Waterfall */
	.product-waterfall {
		padding: 0 $spacing-container-margin;
		display: grid;
		grid-template-columns: repeat(2, 1fr);
		column-gap: $spacing-gutter;
		row-gap: $spacing-stack-md;

		.product-card {
			background-color: $color-surface-container-lowest;
			border-radius: 32rpx;
			overflow: hidden;
			box-shadow: 0 40rpx 50rpx -24rpx rgba(0, 0, 0, 0.25);
			border: 2rpx solid rgba(197, 198, 205, 0.1);
			display: flex;
			flex-direction: column;

			.image-wrapper {
				position: relative;
				width: 100%;
				padding-top: 100%; /* aspect-square */

				.product-img {
					position: absolute;
					top: 0;
					left: 0;
					width: 100%;
					height: 100%;
					object-fit: cover;
				}

				.condition-badge {
					position: absolute;
					top: 16rpx;
					left: 16rpx;
					padding: 4rpx 16rpx;
					background-color: rgba(0, 108, 73, 0.9);
					backdrop-filter: blur(8rpx);
					border-radius: 16rpx;
					color: $color-on-secondary;
					font-size: 20rpx;
					font-weight: 700;
				}
			}

			.product-info {
				padding: 24rpx;

				.product-title {
					font-size: 28rpx;
					font-weight: 700;
					color: $color-on-surface;
					display: -webkit-box;
					-webkit-line-clamp: 2;
					-webkit-box-orient: vertical;
					overflow: hidden;
					line-height: 1.3;
					height: 72rpx;
				}

				.price-row {
					margin-top: 16rpx;
					display: flex;
					align-items: baseline;
					gap: 8rpx;

					.current-price {
						color: $color-primary;
						font-size: 44rpx;
						line-height: 56rpx;
						letter-spacing: -0.01em;
						font-weight: 700;
					}

					.original-price {
						color: rgba(69, 71, 76, 0.4);
						font-size: 22rpx;
						text-decoration: line-through;
					}
				}

				.seller-row {
					margin-top: 24rpx;
					display: flex;
					align-items: center;
					justify-content: space-between;

					.seller-info {
						display: flex;
						align-items: center;
						gap: 12rpx;

						.avatar {
							width: 40rpx;
							height: 40rpx;
							border-radius: 50%;
							background-color: $color-surface-variant;
							display: flex;
							align-items: center;
							justify-content: center;

							.material-symbols-outlined {
								font-size: 28rpx;
								color: $color-outline;
							}
						}

						.seller-meta {
							display: flex;
							flex-direction: column;

							.seller-name {
								font-size: 20rpx;
								font-weight: 700;
								color: $color-on-surface;
								line-height: 1;
							}

							.seller-loc {
								font-size: 18rpx;
								color: rgba(69, 71, 76, 0.6);
								margin-top: 4rpx;
							}
						}
					}

					.icon-heart {
						font-size: 36rpx;
						color: $color-outline;
						cursor: pointer;
						transition: color 0.2s ease;

						&:hover {
							color: $color-error;
						}

						&.heart-filled {
							font-variation-settings: 'FILL' 1;
						}
					}
				}
			}
		}
	}

	/* Loading Indicator */
	.loading-indicator {
		display: flex;
		justify-content: center;
		padding: $spacing-stack-lg 0;
		gap: 8rpx;

		.dot {
			width: 12rpx;
			height: 12rpx;
			border-radius: 50%;
			background-color: $color-outline-variant;
			animation: bounce 1.4s infinite ease-in-out both;

			&.dot-1 { animation-delay: -0.32s; }
			&.dot-2 { animation-delay: -0.16s; }
		}
	}

	@keyframes bounce {
		0%, 80%, 100% { transform: scale(0); }
		40% { transform: scale(1); }
	}

	.safe-bottom-area {
		height: calc(160rpx + env(safe-area-inset-bottom));
	}
</style>
