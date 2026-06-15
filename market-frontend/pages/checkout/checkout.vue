<template>
	<view class="checkout-page">
		<!-- TopAppBar -->
		<view class="header glass-effect">
			<view class="header-content">
				<view class="icon-btn active-scale" @click="goBack">
					<text class="material-symbols-outlined icon">arrow_back</text>
				</view>
				<text class="header-title">确认支付</text>
				<view class="icon-btn placeholder-btn"></view>
			</view>
		</view>

		<scroll-view scroll-y class="main-content">
			<!-- Total Amount -->
			<view class="amount-section">
				<text class="amount-label">应付金额</text>
				<view class="amount-value">
					<text class="currency">¥</text>
					<text class="price">{{ finalPrice }}</text>
				</view>
				<view class="discount-tag" v-if="discountRate < 1">
					<text class="material-symbols-outlined icon-small">diamond</text>
					<text>{{ levelName }}专享 {{(discountRate * 10).toFixed(1)}}折 (已省 ¥{{ savedAmount }})</text>
				</view>
			</view>

			<!-- Product Summary Card -->
			<view class="product-card">
				<view class="img-wrapper">
					<image class="product-img" src="https://lh3.googleusercontent.com/aida/AP1WRLuwP0eIeMdJIjlnSFFwrtfLQn8hq00-S1K0yZohJesgsrogNkBSrQO8mlQTrbtWUwWq6GU-05fYxEAsnT7wvqamWgs7I71OLyYQCh2RMvVgdsNAtmSX0xBF4OCEiGaqnbMlXkNBL9fMEA61InTrUvYyZ--In0c3yM6ferlfj2_XbbH2b9FZkmb8MnDp1H-P4rDqTNVvEb7weaYE7HHuI4jCJgzBQoRBKHegjcnozvwxsjYwN7LhOmTjinuz" mode="aspectFill"></image>
				</view>
				<view class="product-info">
					<text class="product-title">Apple iPhone 15 Pro 256GB 原色钛金属</text>
					<view class="location-row">
						<text class="material-symbols-outlined icon-loc">location_on</text>
						<text class="loc-text">上海·静安</text>
					</view>
				</view>
			</view>

			<!-- Payment Methods -->
			<view class="payment-methods">
				<text class="section-title">支付方式</text>
				<view class="methods-list">
					<!-- Alipay -->
					<label class="method-item active-scale" :class="{ active: selectedMethod === 'alipay' }" @click="selectedMethod = 'alipay'">
						<view class="method-left">
							<view class="icon-wrapper alipay">
								<text class="material-symbols-outlined icon-fill">payments</text>
							</view>
							<text class="method-name">支付宝</text>
						</view>
						<view class="radio-circle">
							<view class="radio-inner"></view>
						</view>
					</label>

					<!-- WeChat Pay -->
					<label class="method-item active-scale" :class="{ active: selectedMethod === 'wechat' }" @click="selectedMethod = 'wechat'">
						<view class="method-left">
							<view class="icon-wrapper wechat">
								<text class="material-symbols-outlined icon-fill">chat_bubble</text>
							</view>
							<text class="method-name">微信支付</text>
						</view>
						<view class="radio-circle">
							<view class="radio-inner"></view>
						</view>
					</label>

					<!-- Offline -->
					<label class="method-item active-scale" :class="{ active: selectedMethod === 'offline' }" @click="selectedMethod = 'offline'">
						<view class="method-left">
							<view class="icon-wrapper offline">
								<text class="material-symbols-outlined">handshake</text>
							</view>
							<view class="method-info">
								<text class="method-name">线下交易</text>
								<text class="method-desc">当面验货，确认无误后付款</text>
							</view>
						</view>
						<view class="radio-circle">
							<view class="radio-inner"></view>
						</view>
					</label>
				</view>
			</view>

			<view class="safe-bottom-area"></view>
		</scroll-view>

		<!-- Bottom Action Bar -->
		<view class="bottom-bar glass-effect">
			<view class="bar-content">
				<view class="total-section">
					<text class="total-label">合计</text>
					<text class="total-price">¥{{ finalPrice }}</text>
				</view>
				<view class="pay-btn active-scale">
					<text>立即支付</text>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				selectedMethod: 'alipay',
				originalPrice: 5899.00,
				levelName: '黄金会员',
				discountRate: 0.95
			};
		},
		computed: {
			finalPrice() {
				return (this.originalPrice * this.discountRate).toFixed(2);
			},
			savedAmount() {
				return (this.originalPrice - this.finalPrice).toFixed(2);
			}
		},
		methods: {
			goBack() {
				uni.navigateBack();
			}
		}
	}
</script>

<style lang="scss" scoped>
	view, scroll-view, text, image, label {
		box-sizing: border-box;
	}

	.checkout-page {
		min-height: 100vh;
		background-color: $color-background;
		display: flex;
		flex-direction: column;
	}

	.icon-fill {
		font-variation-settings: 'FILL' 1;
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
				width: 80rpx;
				height: 80rpx;
				display: flex;
				align-items: center;
				justify-content: center;
				color: $color-on-surface-variant;
				
				.icon {
					font-size: 48rpx;
				}
			}

			.placeholder-btn {
				visibility: hidden;
			}

			.header-title {
				font-size: 40rpx;
				font-weight: 700;
				color: $color-on-surface;
			}
		}
	}

	.main-content {
		flex: 1;
		margin-top: calc(128rpx + env(safe-area-inset-top));
		padding: 0 $spacing-container-margin;
		padding-top: 64rpx;
		display: flex;
		flex-direction: column;
		gap: $spacing-stack-lg;
	}

	/* Total Amount */
	.amount-section {
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		padding-bottom: 32rpx;

		.amount-label {
			font-size: 28rpx;
			color: $color-on-surface-variant;
			margin-bottom: 16rpx;
		}

		.amount-value {
			display: flex;
			align-items: baseline;
			gap: 8rpx;
			color: $color-on-surface;

			.currency {
				font-size: 44rpx;
				font-weight: 700;
			}

			.price {
				font-size: 64rpx;
				font-weight: 700;
				letter-spacing: -0.02em;
			}
		}

		.discount-tag {
			display: inline-flex;
			align-items: center;
			background-color: rgba(255, 215, 0, 0.1);
			color: #b8860b;
			padding: 8rpx 24rpx;
			border-radius: 9999rpx;
			font-size: 24rpx;
			font-weight: 600;
			margin-top: 16rpx;

			.icon-small {
				font-size: 28rpx;
				margin-right: 8rpx;
				font-variation-settings: 'FILL' 1;
			}
		}
	}

	/* Product Summary Card */
	.product-card {
		background-color: $color-surface-container-lowest;
		border-radius: 32rpx;
		padding: 32rpx;
		box-shadow: 0 40rpx 50rpx -24rpx rgba(0, 0, 0, 0.1);
		border: 2rpx solid $color-surface-container-high;
		display: flex;
		align-items: center;
		gap: $spacing-stack-md;

		.img-wrapper {
			width: 160rpx;
			height: 160rpx;
			border-radius: 24rpx;
			overflow: hidden;
			background-color: $color-surface-variant;
			flex-shrink: 0;

			.product-img {
				width: 100%;
				height: 100%;
			}
		}

		.product-info {
			flex: 1;
			display: flex;
			flex-direction: column;
			justify-content: space-between;
			height: 100%;

			.product-title {
				font-size: 32rpx;
				color: $color-on-surface;
				line-height: 1.4;
				display: -webkit-box;
				-webkit-line-clamp: 2;
				-webkit-box-orient: vertical;
				overflow: hidden;
			}

			.location-row {
				display: flex;
				align-items: center;
				gap: 8rpx;
				color: $color-on-surface-variant;
				margin-top: 16rpx;

				.icon-loc {
					font-size: 32rpx;
				}

				.loc-text {
					font-size: 28rpx;
				}
			}
		}
	}

	/* Payment Methods */
	.payment-methods {
		display: flex;
		flex-direction: column;
		gap: $spacing-stack-md;
		margin-top: 32rpx;

		.section-title {
			font-size: 24rpx;
			font-weight: 600;
			color: $color-on-surface-variant;
			text-transform: uppercase;
			letter-spacing: 0.05em;
			padding-left: 16rpx;
		}

		.methods-list {
			display: flex;
			flex-direction: column;
			gap: $spacing-stack-sm;

			.method-item {
				background-color: $color-surface-container-lowest;
				border: 2rpx solid $color-outline-variant;
				border-radius: 24rpx;
				padding: 32rpx;
				display: flex;
				align-items: center;
				justify-content: space-between;
				transition: all 0.2s ease;

				&.active {
					border-color: $color-secondary;
					background-color: $color-secondary-container;

					.radio-circle {
						border-color: $color-secondary;

						.radio-inner {
							background-color: $color-secondary;
							transform: scale(1);
							opacity: 1;
						}
					}
				}

				.method-left {
					display: flex;
					align-items: center;
					gap: $spacing-stack-md;

					.icon-wrapper {
						width: 80rpx;
						height: 80rpx;
						border-radius: 50%;
						display: flex;
						align-items: center;
						justify-content: center;

						&.alipay {
							background-color: rgba(22, 119, 255, 0.1);
							color: #1677FF;
						}

						&.wechat {
							background-color: rgba(9, 184, 62, 0.1);
							color: #09B83E;
						}

						&.offline {
							background-color: $color-surface-variant;
							color: $color-on-surface-variant;
						}
					}

					.method-info {
						display: flex;
						flex-direction: column;

						.method-desc {
							font-size: 24rpx;
							color: $color-on-surface-variant;
							margin-top: 4rpx;
						}
					}

					.method-name {
						font-size: 32rpx;
						color: $color-on-surface;
					}
				}

				.radio-circle {
					width: 48rpx;
					height: 48rpx;
					border-radius: 50%;
					border: 4rpx solid $color-outline-variant;
					display: flex;
					align-items: center;
					justify-content: center;
					transition: border-color 0.2s ease;

					.radio-inner {
						width: 24rpx;
						height: 24rpx;
						border-radius: 50%;
						background-color: transparent;
						transform: scale(0);
						opacity: 0;
						transition: all 0.2s ease;
					}
				}
			}
		}
	}

	.safe-bottom-area {
		height: calc(200rpx + env(safe-area-inset-bottom));
	}

	/* Bottom Action Bar */
	.bottom-bar {
		position: fixed;
		bottom: 0;
		left: 0;
		width: 100%;
		z-index: 50;
		background-color: rgba(248, 249, 255, 0.85);
		border-top: 2rpx solid rgba(197, 198, 205, 0.2);
		box-shadow: 0 -20rpx 50rpx -10rpx rgba(0, 0, 0, 0.05);

		.bar-content {
			display: flex;
			align-items: center;
			justify-content: space-between;
			padding: 32rpx $spacing-container-margin;
			padding-bottom: calc(32rpx + env(safe-area-inset-bottom));

			.total-section {
				display: flex;
				flex-direction: column;

				.total-label {
					font-size: 28rpx;
					color: $color-on-surface-variant;
				}

				.total-price {
					font-size: 44rpx;
					font-weight: 700;
					color: $color-secondary;
				}
			}

			.pay-btn {
				background-color: $color-primary;
				color: $color-on-primary;
				font-size: 40rpx;
				font-weight: 600;
				padding: 24rpx 64rpx;
				border-radius: 24rpx;
				box-shadow: 0 8rpx 16rpx rgba(0,0,0,0.1);
				display: flex;
				align-items: center;
				justify-content: center;
				min-width: 280rpx;
			}
		}
	}
</style>
