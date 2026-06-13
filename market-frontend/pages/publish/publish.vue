<template>
	<view class="publish-page">
		<!-- TopAppBar Section -->
		<view class="header glass-effect">
			<view class="header-content">
				<view class="cancel-btn active-scale" @click="goBack">取消</view>
				<text class="header-title">发布闲置</text>
				<view class="publish-btn active-scale">发布</view>
			</view>
		</view>

		<scroll-view scroll-y class="main-content">
			<!-- Media Upload Section -->
			<view class="media-section">
				<view class="media-grid">
					<view class="upload-btn active-scale">
						<text class="material-symbols-outlined icon-add">add_a_photo</text>
						<text class="upload-label">添加照片/视频</text>
					</view>
					<view class="empty-slot">
						<text class="material-symbols-outlined icon-empty">image</text>
					</view>
					<view class="empty-slot">
						<text class="material-symbols-outlined icon-empty">image</text>
					</view>
					<view class="empty-slot">
						<text class="material-symbols-outlined icon-empty">image</text>
					</view>
				</view>
			</view>

			<!-- Input Section -->
			<view class="input-section">
				<view class="title-input-group" :class="{ 'focused': isTitleFocused }">
					<input 
						class="title-input" 
						placeholder="请输入宝贝品牌和型号" 
						placeholder-class="input-placeholder"
						@focus="isTitleFocused = true"
						@blur="isTitleFocused = false"
					/>
					<view class="underline"></view>
				</view>
				<view class="desc-input-group">
					<textarea 
						class="desc-input" 
						placeholder="描述您的宝贝，购买渠道、成色瑕疵等" 
						placeholder-class="input-placeholder"
						:auto-height="true"
					></textarea>
				</view>
				<view class="tag-hint active-scale">
					<text class="material-symbols-outlined icon-tag">sell</text>
					<text class="tag-label">添加标签，让更多人看到</text>
				</view>
			</view>

			<!-- Form Rows Section -->
			<view class="form-section">
				<!-- Category -->
				<view class="form-row active-scale">
					<view class="row-left">
						<text class="material-symbols-outlined row-icon">category</text>
						<text class="row-label">分类</text>
					</view>
					<view class="row-right">
						<text class="row-value placeholder-value">选择分类</text>
						<text class="material-symbols-outlined icon-arrow">chevron_right</text>
					</view>
				</view>
				<!-- Condition -->
				<view class="form-row active-scale">
					<view class="row-left">
						<text class="material-symbols-outlined row-icon">check_circle</text>
						<text class="row-label">成色</text>
					</view>
					<view class="row-right">
						<text class="row-value">全新/非全新</text>
						<text class="material-symbols-outlined icon-arrow">chevron_right</text>
					</view>
				</view>
				<!-- Price -->
				<view class="form-row active-scale">
					<view class="row-left">
						<text class="material-symbols-outlined row-icon">payments</text>
						<text class="row-label">价格</text>
					</view>
					<view class="row-right">
						<text class="price-symbol">¥</text>
						<input class="price-input" type="digit" placeholder="0.00" placeholder-class="price-placeholder" />
						<text class="material-symbols-outlined icon-arrow">chevron_right</text>
					</view>
				</view>
				<!-- Delivery -->
				<view class="form-row active-scale no-border">
					<view class="row-left">
						<text class="material-symbols-outlined row-icon">local_shipping</text>
						<text class="row-label">发货方式</text>
					</view>
					<view class="row-right">
						<text class="row-value">快递/自提</text>
						<text class="material-symbols-outlined icon-arrow">chevron_right</text>
					</view>
				</view>
			</view>

			<!-- Location Badge -->
			<view class="location-badge active-scale">
				<view class="loc-left">
					<text class="material-symbols-outlined icon-loc">location_on</text>
					<text class="loc-text">上海市 浦东新区</text>
				</view>
				<text class="material-symbols-outlined icon-sync">sync</text>
			</view>

			<view class="safe-bottom-area"></view>
		</scroll-view>

		<CustomTabBar current="publish" />
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
				isTitleFocused: false
			};
		},
		methods: {
			goBack() {
				uni.navigateBack();
			}
		}
	}
</script>

<style lang="scss" scoped>
	.publish-page {
		min-height: 100vh;
		background-color: $color-background;
	}

	/* TopAppBar */
	.header {
		position: fixed;
		top: 0;
		width: 100%;
		z-index: 50;
		background-color: rgba(248, 249, 255, 0.8);
		box-shadow: 0 40rpx 50rpx -24rpx rgba(0, 0, 0, 0.15);

		.header-content {
			display: flex;
			align-items: center;
			justify-content: space-between;
			padding: 0 $spacing-container-margin;
			height: 128rpx;
			padding-top: env(safe-area-inset-top);

			.cancel-btn {
				color: $color-on-surface-variant;
				font-size: 28rpx;
				padding: 16rpx 0;
				cursor: pointer;
			}

			.header-title {
				font-size: 40rpx;
				font-weight: 600;
				color: $color-primary;
			}

			.publish-btn {
				background-color: #1e293b; /* primary-container */
				color: $color-on-secondary;
				padding: 12rpx 32rpx;
				border-radius: 16rpx;
				font-size: 24rpx;
				font-weight: 600;
				cursor: pointer;
			}
		}
	}

	.main-content {
		height: 100vh;
		padding-top: calc(128rpx + env(safe-area-inset-top));
		padding-left: $spacing-container-margin;
		padding-right: $spacing-container-margin;
		box-sizing: border-box;
		display: flex;
		flex-direction: column;
		gap: $spacing-stack-lg;
	}

	/* Media Upload Section */
	.media-section {
		margin-top: $spacing-stack-lg;

		.media-grid {
			display: grid;
			grid-template-columns: repeat(3, 1fr);
			gap: 24rpx;

			.upload-btn {
				aspect-ratio: 1/1;
				border-radius: 24rpx;
				border: 4rpx dashed $color-outline-variant;
				display: flex;
				flex-direction: column;
				align-items: center;
				justify-content: center;
				background-color: $color-surface-container-low;
				cursor: pointer;

				.icon-add {
					color: $color-outline;
					font-size: 60rpx;
					margin-bottom: 8rpx;
				}

				.upload-label {
					font-size: 20rpx;
					font-weight: 600;
					color: $color-on-surface-variant;
				}
			}

			.empty-slot {
				aspect-ratio: 1/1;
				border-radius: 24rpx;
				background-color: $color-surface-container-lowest;
				border: 2rpx solid $color-outline-variant;
				display: flex;
				align-items: center;
				justify-content: center;
				opacity: 0.6;

				.icon-empty {
					color: $color-outline-variant;
					font-size: 48rpx;
				}
			}
		}
	}

	/* Input Section */
	.input-section {
		background-color: #ffffff;
		border-radius: 32rpx;
		padding: 40rpx;
		box-shadow: 0 40rpx 50rpx -24rpx rgba(0, 0, 0, 0.1);
		display: flex;
		flex-direction: column;
		gap: $spacing-stack-md;

		.input-placeholder {
			color: #8d9092;
		}

		.title-input-group {
			position: relative;

			.title-input {
				width: 100%;
				font-size: 40rpx;
				font-weight: 600;
				color: $color-on-surface;
				background: transparent;
				border: none;
				padding: 16rpx 0;
			}

			.underline {
				height: 2rpx;
				width: 100%;
				background-color: $color-outline-variant;
				margin-top: 16rpx;
				transition: background-color 0.3s ease;
			}

			&.focused .underline {
				background-color: $color-secondary;
			}
		}

		.desc-input-group {
			padding-top: 16rpx;

			.desc-input {
				width: 100%;
				min-height: 200rpx;
				font-size: 28rpx;
				line-height: 1.6;
				color: $color-on-surface;
				background: transparent;
				border: none;
				padding: 0;
			}
		}

		.tag-hint {
			display: flex;
			align-items: center;
			gap: 16rpx;
			color: $color-secondary;
			cursor: pointer;
			margin-top: 16rpx;

			.icon-tag {
				font-size: 36rpx;
				font-variation-settings: 'FILL' 1;
			}

			.tag-label {
				font-size: 24rpx;
				font-weight: 600;
			}
		}
	}

	/* Form Rows Section */
	.form-section {
		background-color: #ffffff;
		border-radius: 32rpx;
		overflow: hidden;
		box-shadow: 0 40rpx 50rpx -24rpx rgba(0, 0, 0, 0.1);
		display: flex;
		flex-direction: column;

		.form-row {
			display: flex;
			align-items: center;
			justify-content: space-between;
			padding: 40rpx;
			border-bottom: 2rpx solid $color-surface-container;
			cursor: pointer;

			&.no-border {
				border-bottom: none;
			}

			.row-left {
				display: flex;
				align-items: center;
				gap: 24rpx;

				.row-icon {
					color: $color-on-surface-variant;
					font-size: 48rpx;
				}

				.row-label {
					font-size: 32rpx;
					color: $color-on-surface;
				}
			}

			.row-right {
				display: flex;
				align-items: center;
				
				.row-value {
					font-size: 28rpx;
					color: $color-on-surface;
					margin-right: 8rpx;

					&.placeholder-value {
						color: #8d9092;
					}
				}

				.icon-arrow {
					color: #8d9092;
					font-size: 40rpx;
				}

				.price-symbol {
					color: $color-secondary;
					font-size: 44rpx;
					font-weight: 700;
					margin-right: 8rpx;
				}

				.price-input {
					width: 160rpx;
					text-align: right;
					color: $color-secondary;
					font-size: 44rpx;
					font-weight: 700;
					background: transparent;
					border: none;
				}

				.price-placeholder {
					color: rgba(0, 108, 73, 0.3);
				}
			}
		}
	}

	/* Location Badge */
	.location-badge {
		display: flex;
		align-items: center;
		justify-content: space-between;
		background-color: $color-surface-container-low;
		border-radius: 9999rpx;
		padding: 24rpx 32rpx;
		box-shadow: 0 4rpx 8rpx rgba(0, 0, 0, 0.05);
		margin-bottom: $spacing-stack-md;
		cursor: pointer;

		.loc-left {
			display: flex;
			align-items: center;
			gap: 16rpx;

			.icon-loc {
				color: $color-secondary;
				font-size: 36rpx;
			}

			.loc-text {
				font-size: 24rpx;
				font-weight: 600;
				color: $color-on-surface-variant;
			}
		}

		.icon-sync {
			color: #8d9092;
			font-size: 36rpx;
		}
	}

	.safe-bottom-area {
		height: calc(160rpx + env(safe-area-inset-bottom));
	}
</style>
