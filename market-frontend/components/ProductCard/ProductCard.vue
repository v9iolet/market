<template>
	<view class="product-card active-scale" @click="goDetail">
		<view class="image-wrapper">
			<image class="product-img" mode="aspectFill" :src="product.image"></image>
			<view class="condition-badge" v-if="product.condition">{{ product.condition }}</view>
		</view>
		<view class="product-info">
			<text class="product-title">{{ product.title }}</text>
			<view class="price-row">
				<text class="current-price">¥{{ product.price }}</text>
				<text class="original-price" v-if="product.originalPrice">¥{{ product.originalPrice }}</text>
			</view>
			<view class="seller-row">
				<view class="seller-info">
					<image v-if="product.seller && product.seller.avatar" class="avatar" :src="product.seller.avatar"></image>
					<view v-else class="avatar avatar-placeholder">
						<text class="material-symbols-outlined">person</text>
					</view>
					<view class="seller-meta">
						<text class="seller-name">{{ product.seller ? product.seller.name : '' }}</text>
						<text class="seller-loc">{{ product.seller ? product.seller.location : '' }}</text>
					</view>
				</view>
				<text class="material-symbols-outlined icon-heart" :class="{'heart-filled': product.isLiked}" :style="product.isLiked ? 'color: #ba1a1a;' : ''">favorite</text>
			</view>
		</view>
	</view>
</template>

<script>
export default {
	name: 'ProductCard',
	props: {
		product: {
			type: Object,
			required: true
		}
	},
	methods: {
		goDetail() {
			uni.navigateTo({ url: '/pages/detail/detail' });
		}
	}
}
</script>

<style lang="scss" scoped>
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
</style>
