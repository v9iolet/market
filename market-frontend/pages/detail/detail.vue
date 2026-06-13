<template>
	<view class="product-detail">
		<!-- Top AppBar -->
		<view class="header glass-effect" :class="{'shadow-xl': isScrolled}">
			<view class="header-content">
				<view class="btn-icon active-scale" @click="goBack">
					<text class="material-symbols-outlined text-primary text-xl">arrow_back</text>
				</view>
				<text class="header-title">商品详情</text>
				<view class="header-actions">
					<view class="btn-icon active-scale">
						<text class="material-symbols-outlined text-primary text-xl">share</text>
					</view>
					<view class="btn-icon active-scale">
						<text class="material-symbols-outlined text-primary text-xl">more_horiz</text>
					</view>
				</view>
			</view>
		</view>

		<scroll-view scroll-y class="main-content" @scroll="onScroll">
			<!-- Gallery Slider -->
			<view class="gallery-section">
				<swiper class="swiper" @change="onSwiperChange" :circular="true">
					<swiper-item v-for="(img, index) in images" :key="index">
						<image class="swiper-img" :src="img" mode="aspectFill"></image>
					</swiper-item>
				</swiper>
				<view class="slide-indicator glass-effect">
					<text class="current">{{currentSlide + 1}}</text>
					<text class="total">/{{images.length}}</text>
				</view>
			</view>

			<!-- Product Content -->
			<view class="product-content">
				<!-- Pricing & Title -->
				<view class="pricing-title-section">
					<view class="price-row">
						<text class="current-price">¥5899</text>
						<text class="original-price">¥8999</text>
						<view class="condition-badge">99新</view>
					</view>
					<text class="product-title">iPhone 15 Pro 256G 钛金属 国行原装</text>
				</view>

				<!-- Seller Card -->
				<view class="seller-card active-scale">
					<view class="avatar-container">
						<image class="avatar" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAaTWQfbsLP5bnvSNoTaj4X_63lpOToUWwXXKRgAD0aN1auCrnwP974seEogSWedN0ClPBhn25VTQehb586KhJqpSRnsxdZec_p3CH-UQC4U03YB6XQrtHO9x1trza1AB2l_dCs3h4bf7HsitCEfw0521PdZcytxbtTIYbclvSYyNw_LSLkjk4nX-QNW1bMvydZo0jOdZjPD6jbKHtnWiY2AFUke5lRzQxy0jrxoohdzFvbLvIraDuKzC3WoYG3HFE-l3OJBS4vPpLO" mode="aspectFill"></image>
						<view class="verified-badge">
							<text class="material-symbols-outlined verified-icon">check</text>
						</view>
					</view>
					<view class="seller-info">
						<view class="seller-name-row">
							<text class="seller-name">林小姐</text>
							<view class="credit-badge">信用极好</view>
						</view>
						<text class="reply-time">3分钟内回复</text>
					</view>
					<view class="follow-btn active-scale">关注</view>
				</view>

				<!-- Description -->
				<view class="description-section">
					<scroll-view scroll-x class="tags-scroll hide-scrollbar">
						<view class="tags-container">
							<view class="tag-item">
								<text class="material-symbols-outlined tag-icon">verified</text>
								<text class="tag-text">官方验机</text>
							</view>
							<view class="tag-item">
								<text class="material-symbols-outlined tag-icon">security</text>
								<text class="tag-text">担保交易</text>
							</view>
							<view class="tag-item">
								<text class="material-symbols-outlined tag-icon">local_shipping</text>
								<text class="tag-text">极速顺丰</text>
							</view>
						</view>
					</scroll-view>
					<view class="article">
						<text class="paragraph">自用机器，国行原装 iPhone 15 Pro 256GB 原色钛金属。整体成色非常新，一直佩戴保护壳和贴膜，几乎没有划痕。电池健康度 98%，充电循环次数极少。</text>
						<text class="paragraph">配件全齐，原装包装盒、充电线都在。无拆无修，面容识别功能正常，各项功能完美。因为换了新手机所以出手，仅限诚心购买者。</text>
					</view>
				</view>

				<!-- Transaction Details -->
				<view class="transaction-details">
					<view class="detail-item">
						<text class="detail-label">发货地</text>
						<view class="detail-value">
							<text class="material-symbols-outlined text-primary text-lg">location_on</text>
							<text class="value-text">上海 · 静安</text>
						</view>
					</view>
					<view class="detail-item">
						<text class="detail-label">物流方式</text>
						<view class="detail-value">
							<text class="material-symbols-outlined text-primary text-lg">package_2</text>
							<text class="value-text">快递包邮/同城面交</text>
						</view>
					</view>
					<view class="detail-item">
						<text class="detail-label">最近浏览</text>
						<view class="detail-value">
							<text class="material-symbols-outlined text-primary text-lg">visibility</text>
							<text class="value-text">342 次</text>
						</view>
					</view>
				</view>
			</view>
			
			<view class="safe-bottom-area"></view>
		</scroll-view>

		<!-- Bottom Bar -->
		<view class="bottom-bar glass-effect">
			<view class="action-icons">
				<view class="action-icon active-scale">
					<text class="material-symbols-outlined icon">favorite</text>
					<text class="label">想要</text>
				</view>
				<view class="action-icon active-scale">
					<text class="material-symbols-outlined icon">help</text>
					<text class="label">咨询</text>
				</view>
			</view>
			<view class="action-buttons">
				<view class="btn btn-chat active-scale">
					<text class="material-symbols-outlined icon-small">chat_bubble</text>
					<text>聊一聊</text>
				</view>
				<view class="btn btn-buy active-scale" @click="goBuy">
					<text class="material-symbols-outlined icon-small">shopping_bag</text>
					<text>立即购买</text>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				isScrolled: false,
				currentSlide: 0,
				images: [
					'https://lh3.googleusercontent.com/aida-public/AB6AXuDHfsnBhtZlXORWB886tNqrtH8_lLEcZAvDBc6LlVLihQ8C5hmdONW8nfoTMkM6v12TXwkJCClItrY_aqLMfWTPoZNU4vL5OEs7j_wjX8HQVYZ5EybJEe6b_rSfdV60XdvRXr2_SiT-SHMFHfcwPlABodUHajujicL10xRosRSNA2sMbsIg6Ul-lz5hHfSvKE_0Lyo_ZOk6Ne403vpiPJGWd760tXeS5d9q6mFs4jLqPSq2S_0d1YRJyCZKLqvK_TYDM0QQWmydN4kp',
					'https://lh3.googleusercontent.com/aida-public/AB6AXuByq_afmhVkdj-Z6EgEhV8c7e0YztKB78RRbLFNZG0vwsSCA3GBn9ExI9QxDTtYJoPOC7rN8gZ7p-CD1gluWX8BRFe9IrOAAREfwYpxOW9Jt8Be_FTL2TB9bicaMb7o_PvhHcycXMtFDfMhAwDNcgsZoPJ4tYBQTLkjWkquU73u85Rp7n3Gdg48SkkpwxkteXe87UVbVeCjdU4GBNWsNsHjPrcZM1n9xIFrojlQ7PkSxrboy_xzBVMzO672UP1qYu7D62HUOERU7sgJ',
					'https://lh3.googleusercontent.com/aida-public/AB6AXuClm_xmrC_qlXB4imnFZD6UhmODWNPikTPy5zyrJWy88zp99n_5pnXFHkQ7mok9h93fDsJM5whn8Ny_ONn0JAoz2i0C22o_1iyV5eAM6zk6wWwW4NCNg38k1ndOM7D70raQwMG_NDbJmYea66gHbqmSjntCAVPQ_P4IHm9NvkR8hQnmQIE0F9s-jlRT56mgKruzw-AJcpMRcpbFxuia59SpCmp__ftN-i76OJ3TEfha-pVcKQKSDmebZuriXK3tjGnoIU0toLim1sM6'
				]
			}
		},
		methods: {
			onScroll(e) {
				this.isScrolled = e.detail.scrollTop > 10;
			},
			onSwiperChange(e) {
				this.currentSlide = e.detail.current;
			},
			goBack() {
				uni.navigateBack();
			},
			goBuy() {
				uni.navigateTo({ url: '/pages/checkout/checkout' });
			}
		}
	}
</script>

<style lang="scss" scoped>
	.product-detail {
		background-color: $color-surface;
		min-height: 100vh;
	}

	.text-primary {
		color: $color-primary;
	}
	.text-xl {
		font-size: 48rpx;
	}
	.text-lg {
		font-size: 36rpx;
	}

	/* Top AppBar */
	.header {
		position: fixed;
		top: 0;
		width: 100%;
		z-index: 50;
		background-color: rgba(248, 249, 255, 0.8);
		transition: box-shadow 0.3s ease;
		
		&.shadow-xl {
			box-shadow: 0 40rpx 50rpx -24rpx rgba(0, 0, 0, 0.25);
		}

		.header-content {
			display: flex;
			justify-content: space-between;
			align-items: center;
			padding: 0 $spacing-container-margin;
			height: 128rpx;
			padding-top: env(safe-area-inset-top);

			.btn-icon {
				display: flex;
				align-items: center;
				justify-content: center;
				cursor: pointer;
			}

			.header-title {
				font-size: 40rpx;
				font-weight: 600;
				color: $color-primary;
			}

			.header-actions {
				display: flex;
				gap: 32rpx;
			}
		}
	}

	.main-content {
		height: 100vh;
		box-sizing: border-box;
	}

	/* Gallery Slider */
	.gallery-section {
		position: relative;
		width: 100%;
		aspect-ratio: 1/1;
		background-color: $color-surface-container;
		margin-top: calc(128rpx + env(safe-area-inset-top));

		.swiper {
			width: 100%;
			height: 100%;

			.swiper-img {
				width: 100%;
				height: 100%;
			}
		}

		.slide-indicator {
			position: absolute;
			bottom: 32rpx;
			right: 32rpx;
			background-color: rgba(9, 20, 38, 0.4);
			color: #fff;
			padding: 8rpx 24rpx;
			border-radius: 9999rpx;
			font-size: 24rpx;
			font-weight: 600;
			letter-spacing: 0.05em;

			.current {
				font-weight: 700;
			}
			.total {
				opacity: 0.8;
			}
		}
	}

	/* Product Content */
	.product-content {
		padding: $spacing-stack-lg $spacing-container-margin;
		display: flex;
		flex-direction: column;
		gap: $spacing-stack-lg;
	}

	/* Pricing & Title */
	.pricing-title-section {
		display: flex;
		flex-direction: column;
		gap: $spacing-stack-sm;

		.price-row {
			display: flex;
			align-items: baseline;
			gap: 16rpx;

			.current-price {
				color: $color-secondary;
				font-size: 56rpx;
				font-weight: 700;
				letter-spacing: -0.01em;
			}

			.original-price {
				color: $color-on-surface-variant;
				font-size: 28rpx;
				text-decoration: line-through;
				opacity: 0.6;
			}

			.condition-badge {
				margin-left: auto;
				background-color: $color-secondary-container;
				color: $color-on-secondary-container;
				padding: 4rpx 16rpx;
				border-radius: 16rpx;
				font-size: 24rpx;
				font-weight: 600;
			}
		}

		.product-title {
			font-size: 52rpx;
			font-weight: 700;
			line-height: 1.2;
			letter-spacing: -0.02em;
			color: #111c2d;
		}
	}

	/* Seller Card */
	.seller-card {
		padding: 32rpx;
		background-color: $color-surface-container-low;
		border-radius: 32rpx;
		box-shadow: 0 40rpx 50rpx -24rpx rgba(0, 0, 0, 0.25);
		display: flex;
		align-items: center;
		gap: $spacing-stack-md;

		.avatar-container {
			position: relative;

			.avatar {
				width: 96rpx;
				height: 96rpx;
				border-radius: 50%;
				border: 4rpx solid #fff;
				box-shadow: 0 4rpx 8rpx rgba(0,0,0,0.1);
			}

			.verified-badge {
				position: absolute;
				bottom: -8rpx;
				right: -8rpx;
				background-color: $color-secondary;
				width: 32rpx;
				height: 32rpx;
				border-radius: 50%;
				border: 4rpx solid $color-surface;
				display: flex;
				align-items: center;
				justify-content: center;

				.verified-icon {
					color: #fff;
					font-size: 20rpx;
					font-variation-settings: 'FILL' 1;
				}
			}
		}

		.seller-info {
			flex: 1;
			overflow: hidden;

			.seller-name-row {
				display: flex;
				align-items: center;
				gap: 16rpx;

				.seller-name {
					font-size: 32rpx;
					font-weight: 600;
					white-space: nowrap;
					overflow: hidden;
					text-overflow: ellipsis;
				}

				.credit-badge {
					background-color: $color-surface-container-highest;
					color: #3c475a;
					padding: 4rpx 12rpx;
					border-radius: 8rpx;
					font-size: 20rpx;
					font-weight: 700;
				}
			}

			.reply-time {
				color: $color-on-surface-variant;
				font-size: 28rpx;
				opacity: 0.7;
				margin-top: 8rpx;
			}
		}

		.follow-btn {
			background-color: $color-primary;
			color: $color-on-primary;
			padding: 16rpx 40rpx;
			border-radius: 9999rpx;
			font-size: 24rpx;
			font-weight: 600;
		}
	}

	/* Description */
	.description-section {
		display: flex;
		flex-direction: column;
		gap: $spacing-stack-md;

		.tags-scroll {
			width: 100%;
			white-space: nowrap;
			padding-bottom: 16rpx;

			.tags-container {
				display: flex;
				gap: 32rpx;

				.tag-item {
					display: inline-flex;
					align-items: center;
					gap: 8rpx;
					color: $color-on-surface-variant;

					.tag-icon {
						font-size: 36rpx;
					}

					.tag-text {
						font-size: 28rpx;
					}
				}
			}
		}

		.article {
			color: $color-on-surface-variant;
			font-size: 32rpx;
			line-height: 1.6;
			display: flex;
			flex-direction: column;
			gap: 32rpx;

			.paragraph {
				display: block;
			}
		}
	}

	/* Transaction Details */
	.transaction-details {
		display: grid;
		grid-template-columns: repeat(2, 1fr);
		gap: 32rpx;
		padding: 48rpx 0;
		border-top: 2rpx solid $color-outline-variant;

		.detail-item {
			display: flex;
			flex-direction: column;
			gap: 8rpx;

			.detail-label {
				color: $color-on-surface-variant;
				font-size: 24rpx;
				font-weight: 600;
				opacity: 0.6;
			}

			.detail-value {
				display: flex;
				align-items: center;
				gap: 8rpx;

				.value-text {
					color: $color-on-surface;
					font-size: 28rpx;
				}
			}
		}
	}

	/* Bottom Bar */
	.bottom-bar {
		position: fixed;
		bottom: 0;
		left: 0;
		width: 100%;
		display: flex;
		align-items: center;
		justify-content: space-between;
		padding: 32rpx $spacing-container-margin;
		padding-bottom: calc(32rpx + env(safe-area-inset-bottom));
		background-color: rgba(248, 249, 255, 0.8);
		border-top-left-radius: 24rpx;
		border-top-right-radius: 24rpx;
		box-shadow: 0 -40rpx 50rpx -24rpx rgba(0, 0, 0, 0.25);
		z-index: 50;
		box-sizing: border-box;

		.action-icons {
			display: flex;
			align-items: center;
			gap: 48rpx;
			padding-right: 32rpx;

			.action-icon {
				display: flex;
				flex-direction: column;
				align-items: center;
				justify-content: center;
				color: $color-on-surface-variant;

				.icon {
					font-size: 48rpx;
				}

				.label {
					font-size: 20rpx;
					font-weight: 600;
					margin-top: 4rpx;
				}
			}
		}

		.action-buttons {
			flex: 1;
			display: flex;
			gap: 24rpx;

			.btn {
				flex: 1;
				display: flex;
				align-items: center;
				justify-content: center;
				height: 96rpx;
				border-radius: 16rpx;
				font-size: 24rpx;
				font-weight: 600;

				.icon-small {
					font-size: 40rpx;
					margin-right: 16rpx;
				}
			}

			.btn-chat {
				background-color: #1e293b;
				color: #8590a6;
			}

			.btn-buy {
				background-color: $color-secondary;
				color: $color-on-secondary;
				box-shadow: 0 20rpx 30rpx rgba(0, 108, 73, 0.2);
			}
		}
	}

	.safe-bottom-area {
		height: calc(200rpx + env(safe-area-inset-bottom));
	}
</style>
