<template>
	<view class="edit-profile-page">
		<view class="header glass-effect">
			<view class="header-content">
				<view class="icon-btn active-scale" @click="goBack">
					<text class="material-symbols-outlined icon">arrow_back</text>
				</view>
				<text class="header-title">编辑资料</text>
				<view class="save-btn active-scale" @click="handleSave">
					<text>保存</text>
				</view>
			</view>
		</view>

		<view class="main-content">
			<view class="avatar-section" @click="changeAvatar">
				<view class="avatar-wrapper">
					<image v-if="profile.avatar" class="avatar" :src="profile.avatar" mode="aspectFill"></image>
					<view v-else class="avatar empty-avatar">
						<text class="material-symbols-outlined">person</text>
					</view>
					<view class="edit-badge">
						<text class="material-symbols-outlined">photo_camera</text>
					</view>
				</view>
				<text class="avatar-hint">点击更换头像</text>
			</view>

			<view class="form-container">
				<view class="form-group">
					<text class="label">昵称</text>
					<view class="input-wrapper">
						<input class="input" v-model="profile.nickname" placeholder="请输入昵称" maxlength="20" />
					</view>
				</view>

				<view class="form-group">
					<text class="label">个人简介</text>
					<view class="textarea-wrapper">
						<textarea class="textarea" v-model="profile.bio" placeholder="介绍一下你自己..." maxlength="100"></textarea>
						<text class="word-count">{{ profile.bio.length }}/100</text>
					</view>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				profile: {
					avatar: '',
					nickname: '',
					bio: ''
				}
			}
		},
		onLoad() {
			// 将在 Task 4 实现
		},
		methods: {
			goBack() {
				uni.navigateBack();
			},
			changeAvatar() {
				// 将在 Task 4 实现
			},
			handleSave() {
				// 将在 Task 4 实现
			}
		}
	}
</script>

<style lang="scss" scoped>
	.edit-profile-page {
		min-height: 100vh;
		background-color: $color-background;
		display: flex;
		flex-direction: column;
		width: 100%;
		overflow-x: hidden;
		box-sizing: border-box;
	}

	.header {
		position: fixed;
		top: 0;
		width: 100%;
		z-index: 50;
		background-color: rgba(248, 249, 255, 0.8);
		box-shadow: 0 40rpx 50rpx -24rpx rgba(0, 0, 0, 0.1);

		.header-content {
			display: flex;
			align-items: center;
			justify-content: space-between;
			padding: 0 $spacing-container-margin;
			height: 128rpx;
			padding-top: env(safe-area-inset-top);

			.header-title {
				font-size: 36rpx;
				font-weight: 700;
				color: $color-primary;
			}

			.icon-btn {
				width: 80rpx;
				height: 80rpx;
				display: flex;
				align-items: center;
				justify-content: flex-start;
				color: $color-on-surface;
				
				.icon {
					font-size: 48rpx;
				}
			}

			.save-btn {
				height: 64rpx;
				padding: 0 32rpx;
				display: flex;
				align-items: center;
				justify-content: center;
				background-color: $color-primary;
				color: $color-on-primary;
				border-radius: 32rpx;
				font-size: 28rpx;
				font-weight: 600;
			}
		}
	}

	.main-content {
		flex: 1;
		margin-top: calc(128rpx + env(safe-area-inset-top));
		padding: $spacing-stack-xl $spacing-container-margin;
	}

	.avatar-section {
		display: flex;
		flex-direction: column;
		align-items: center;
		margin-bottom: 64rpx;

		.avatar-wrapper {
			position: relative;
			margin-bottom: 24rpx;
			
			.avatar {
				width: 200rpx;
				height: 200rpx;
				border-radius: 50%;
				border: 8rpx solid $color-surface-container;
				box-shadow: 0 16rpx 32rpx rgba(0, 0, 0, 0.1);
			}

			.empty-avatar {
				background-color: $color-surface-container-high;
				display: flex;
				align-items: center;
				justify-content: center;
				color: $color-on-surface-variant;
				
				.material-symbols-outlined {
					font-size: 100rpx;
				}
			}

			.edit-badge {
				position: absolute;
				bottom: 8rpx;
				right: 8rpx;
				width: 56rpx;
				height: 56rpx;
				background-color: $color-primary;
				border-radius: 50%;
				display: flex;
				align-items: center;
				justify-content: center;
				color: $color-on-primary;
				border: 6rpx solid $color-surface;

				.material-symbols-outlined {
					font-size: 32rpx;
				}
			}
		}

		.avatar-hint {
			font-size: 24rpx;
			color: $color-on-surface-variant;
			letter-spacing: 0.05em;
		}
	}

	.form-container {
		background-color: $color-surface-container-lowest;
		border-radius: 32rpx;
		padding: 40rpx;
		box-shadow: 0 40rpx 50rpx -24rpx rgba(0, 0, 0, 0.1);
		border: 2rpx solid rgba(211, 228, 254, 0.2);

		.form-group {
			margin-bottom: 48rpx;

			&:last-child {
				margin-bottom: 0;
			}

			.label {
				display: block;
				font-size: 28rpx;
				font-weight: 600;
				color: $color-primary;
				margin-bottom: 16rpx;
			}

			.input-wrapper, .textarea-wrapper {
				background-color: $color-surface-container;
				border-radius: 24rpx;
				padding: 24rpx 32rpx;
				transition: all 0.3s ease;

				&:focus-within {
					background-color: $color-surface;
					border: 2rpx solid $color-primary;
					box-shadow: 0 0 0 8rpx rgba(13, 85, 206, 0.1);
				}
			}

			.input {
				width: 100%;
				font-size: 32rpx;
				color: $color-on-surface;
				height: 48rpx;
			}

			.textarea-wrapper {
				position: relative;
				padding-bottom: 64rpx;

				.textarea {
					width: 100%;
					font-size: 32rpx;
					color: $color-on-surface;
					height: 160rpx;
					line-height: 1.5;
				}

				.word-count {
					position: absolute;
					bottom: 24rpx;
					right: 32rpx;
					font-size: 24rpx;
					color: $color-outline;
				}
			}
		}
	}
</style>
