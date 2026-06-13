<template>
	<view class="profile-page">
		<!-- TopAppBar -->
		<view class="header glass-effect">
			<view class="header-content">
				<text class="header-title">我的</text>
				<view class="header-actions">
					<view class="icon-btn active-scale">
						<text class="material-symbols-outlined icon">notifications</text>
						<view class="badge"></view>
					</view>
					<view class="icon-btn active-scale">
						<text class="material-symbols-outlined icon">settings</text>
					</view>
				</view>
			</view>
		</view>

		<scroll-view scroll-y class="main-content">
			<!-- User Profile Header -->
			<view class="profile-header" v-if="isLoggedIn">
				<view class="user-info">
					<view class="avatar-wrapper">
						<image class="avatar" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDZayQbW7Q6gFkqRnSNBpL-M3aW8BrZXWw9026KO1h6HrIDkcLaJpRuBPjjG2TQMxT9Ap-vV3LWemQ67OaXL39Ba0vpueIVNfyJQmfp5zLnALZuI0J1ZmHIqmhnj6rjXz7EH4aYqzF7gz4p2im-IiMGdSdKTVNXrMqb1nf1WAR2n5KoaLl-sSZZ3FlHMQdTUXR6cHxIibC4END5uFyNOzTPYiYIaQ1BD-FIXZGlKvPkVvy1r9XfkDwRa7ubbDJ9EZ_UabL04Beheffx" mode="aspectFill"></image>
					</view>
					<view class="user-details">
						<text class="username">极客小王</text>
						<view class="verified-tag">
							<text class="material-symbols-outlined icon-small">verified_user</text>
							<text>认证用户</text>
						</view>
					</view>
				</view>
				<view class="edit-btn active-scale">编辑资料</view>
			</view>

			<view class="profile-header unlogged-header" v-else @click="goToLogin">
				<view class="user-info">
					<view class="avatar-wrapper">
						<view class="avatar empty-avatar">
							<text class="material-symbols-outlined">person</text>
						</view>
					</view>
					<view class="user-details">
						<text class="username">点击登录 / 注册</text>
						<text class="sub-text">登录后享受更多专属服务</text>
					</view>
				</view>
				<view class="edit-btn active-scale">去登录</view>
			</view>

			<!-- Stats Section -->
			<view class="stats-section" v-if="isLoggedIn">
				<view class="stat-item">
					<text class="stat-value">12</text>
					<text class="stat-label">关注</text>
				</view>
				<view class="divider"></view>
				<view class="stat-item">
					<text class="stat-value">38</text>
					<text class="stat-label">粉丝</text>
				</view>
				<view class="divider"></view>
				<view class="stat-item">
					<text class="stat-value">156</text>
					<text class="stat-label">获赞与收藏</text>
				</view>
			</view>

			<!-- My Transactions Card -->
			<view class="transactions-card">
				<view class="card-header">
					<text class="card-title">我的交易</text>
					<text class="material-symbols-outlined icon-more">chevron_right</text>
				</view>
				<view class="grid-actions">
					<view class="action-item active-scale">
						<view class="icon-box">
							<text class="material-symbols-outlined">outbox</text>
						</view>
						<view class="action-text">
							<text class="label">我发布的</text>
							<text class="count">5</text>
						</view>
					</view>
					<view class="action-item active-scale">
						<view class="icon-box">
							<text class="material-symbols-outlined">payments</text>
						</view>
						<view class="action-text">
							<text class="label">我卖出的</text>
							<text class="count">12</text>
						</view>
					</view>
					<view class="action-item active-scale">
						<view class="icon-box">
							<text class="material-symbols-outlined">shopping_bag</text>
						</view>
						<view class="action-text">
							<text class="label">我买到的</text>
							<text class="count">8</text>
						</view>
					</view>
					<view class="action-item active-scale">
						<view class="icon-box">
							<text class="material-symbols-outlined">favorite</text>
						</view>
						<view class="action-text">
							<text class="label">收藏的</text>
							<text class="count">24</text>
						</view>
					</view>
				</view>
			</view>

			<!-- Help & Settings List -->
			<view class="settings-list">
				<view class="list-item active-scale">
					<view class="item-left">
						<text class="material-symbols-outlined icon-list">receipt_long</text>
						<text class="item-text">我的账单</text>
					</view>
					<text class="material-symbols-outlined icon-more">chevron_right</text>
				</view>
				<view class="list-item active-scale">
					<view class="item-left">
						<text class="material-symbols-outlined icon-list">location_on</text>
						<text class="item-text">收货地址</text>
					</view>
					<text class="material-symbols-outlined icon-more">chevron_right</text>
				</view>
				<view class="list-item active-scale">
					<view class="item-left">
						<text class="material-symbols-outlined icon-list">support_agent</text>
						<text class="item-text">官方客服</text>
					</view>
					<text class="material-symbols-outlined icon-more">chevron_right</text>
				</view>
				<view class="list-item active-scale">
					<view class="item-left">
						<text class="material-symbols-outlined icon-list">info</text>
						<text class="item-text">关于我们</text>
					</view>
					<text class="material-symbols-outlined icon-more">chevron_right</text>
				</view>
			</view>

			<view class="logout-section" v-if="isLoggedIn">
				<view class="logout-btn active-scale" @click="handleLogout">
					<text>退出当前账号</text>
				</view>
			</view>

			<view class="safe-bottom-area"></view>
		</scroll-view>

		<CustomTabBar current="profile" />
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
				isLoggedIn: false
			}
		},
		onShow() {
			this.isLoggedIn = uni.getStorageSync('isLoggedIn') || false;
		},
		methods: {
			handleLogout() {
				uni.removeStorageSync('isLoggedIn');
				this.isLoggedIn = false;
			},
			goToLogin() {
				uni.navigateTo({ url: '/pages/login/login' });
			}
		}
	}
</script>

<style lang="scss" scoped>
	.profile-page {
		min-height: 100vh;
		background-color: $color-background;
		display: flex;
		flex-direction: column;
		width: 100%;
		overflow-x: hidden;
		box-sizing: border-box;
	}

	/* TopAppBar */
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
				font-size: 40rpx;
				font-weight: 700;
				color: $color-primary;
			}

			.header-actions {
				display: flex;
				align-items: center;
				gap: 16rpx;

				.icon-btn {
					width: 80rpx;
					height: 80rpx;
					display: flex;
					align-items: center;
					justify-content: center;
					border-radius: 50%;
					color: $color-on-surface-variant;
					position: relative;
					
					.icon {
						font-size: 48rpx;
					}

					.badge {
						position: absolute;
						top: 16rpx;
						right: 16rpx;
						width: 16rpx;
						height: 16rpx;
						background-color: $color-error;
						border-radius: 50%;
						border: 4rpx solid $color-surface;
					}
				}
			}
		}
	}

	.main-content {
		height: 100vh;
		margin-top: calc(128rpx + env(safe-area-inset-top));
		padding: 0 $spacing-container-margin;
		padding-top: 32rpx;
		box-sizing: border-box;
	}

	/* User Profile Header */
	.profile-header {
		display: flex;
		align-items: center;
		justify-content: space-between;
		margin-bottom: $spacing-stack-lg;

		.user-info {
			display: flex;
			align-items: center;
			gap: 32rpx;

			.avatar-wrapper {
				position: relative;
				
				.avatar {
					width: 160rpx;
					height: 160rpx;
					border-radius: 50%;
					border: 8rpx solid $color-surface-container;
					box-shadow: 0 8rpx 16rpx rgba(0,0,0,0.1);
				}
			}

			.empty-avatar {
				background-color: $color-surface-container-high;
				display: flex;
				align-items: center;
				justify-content: center;
				color: $color-on-surface-variant;
				.material-symbols-outlined {
					font-size: 80rpx;
				}
			}

			.user-details {
				display: flex;
				flex-direction: column;

				.username {
					font-size: 40rpx;
					font-weight: 600;
					color: $color-primary;
					margin-bottom: 8rpx;
				}

				.verified-tag {
					display: inline-flex;
					align-items: center;
					background-color: $color-secondary-container;
					color: $color-on-secondary-container;
					padding: 4rpx 16rpx;
					border-radius: 9999rpx;
					font-size: 20rpx;
					font-weight: 600;
					text-transform: uppercase;
					letter-spacing: 0.05em;

					.icon-small {
						font-size: 28rpx;
						margin-right: 4rpx;
						font-variation-settings: 'FILL' 1;
					}
				}
			}
		}

		.edit-btn {
			padding: 16rpx 32rpx;
			border-radius: 16rpx;
			border: 2rpx solid $color-outline-variant;
			color: $color-on-surface-variant;
			font-size: 24rpx;
			font-weight: 600;
			letter-spacing: 0.05em;
		}
	}

	.unlogged-header {
		.sub-text {
			font-size: 24rpx;
			color: $color-on-surface-variant;
			margin-top: 8rpx;
		}
	}

	/* Stats Section */
	.stats-section {
		display: flex;
		justify-content: space-around;
		align-items: center;
		padding: 32rpx 0;
		background-color: $color-surface-container-low;
		border-radius: 32rpx;
		margin-bottom: $spacing-stack-lg;

		.stat-item {
			display: flex;
			flex-direction: column;
			align-items: center;

			.stat-value {
				font-size: 40rpx;
				font-weight: 600;
				color: $color-primary;
			}

			.stat-label {
				font-size: 22rpx;
				font-weight: 600;
				color: $color-on-surface-variant;
				text-transform: uppercase;
			}
		}

		.divider {
			width: 2rpx;
			height: 64rpx;
			background-color: rgba(197, 198, 205, 0.3);
		}
	}

	/* My Transactions Card */
	.transactions-card {
		background-color: $color-surface-container-lowest;
		border-radius: 32rpx;
		padding: 48rpx;
		box-shadow: 0 40rpx 50rpx -24rpx rgba(0, 0, 0, 0.1);
		border: 2rpx solid rgba(211, 228, 254, 0.2);
		margin-bottom: $spacing-stack-lg;

		.card-header {
			display: flex;
			justify-content: space-between;
			align-items: center;
			margin-bottom: 48rpx;

			.card-title {
				font-size: 40rpx;
				font-weight: 600;
				color: $color-primary;
			}

			.icon-more {
				color: $color-outline;
				font-size: 48rpx;
			}
		}

		.grid-actions {
			display: grid;
			grid-template-columns: repeat(4, 1fr);
			gap: 32rpx;

			.action-item {
				display: flex;
				flex-direction: column;
				align-items: center;
				gap: 16rpx;

				.icon-box {
					width: 96rpx;
					height: 96rpx;
					border-radius: 24rpx;
					background-color: $color-surface-container;
					display: flex;
					align-items: center;
					justify-content: center;
					color: $color-primary;

					.material-symbols-outlined {
						font-size: 48rpx;
					}
				}

				.action-text {
					display: flex;
					flex-direction: column;
					align-items: center;

					.label {
						font-size: 20rpx;
						font-weight: 600;
						color: $color-on-surface-variant;
					}

					.count {
						font-size: 28rpx;
						font-weight: 700;
						color: $color-primary;
					}
				}
			}
		}
	}

	/* Help & Settings List */
	.settings-list {
		background-color: $color-surface-container-lowest;
		border-radius: 32rpx;
		overflow: hidden;
		box-shadow: 0 40rpx 50rpx -24rpx rgba(0, 0, 0, 0.1);
		border: 2rpx solid rgba(211, 228, 254, 0.2);
		display: flex;
		flex-direction: column;

		.list-item {
			display: flex;
			align-items: center;
			justify-content: space-between;
			padding: 40rpx;
			border-bottom: 2rpx solid rgba(211, 228, 254, 0.3);

			&:last-child {
				border-bottom: none;
			}

			.item-left {
				display: flex;
				align-items: center;
				gap: 32rpx;

				.icon-list {
					color: $color-on-surface-variant;
					font-size: 48rpx;
				}

				.item-text {
					font-size: 32rpx;
					color: $color-on-surface;
				}
			}

			.icon-more {
				color: $color-outline;
				font-size: 48rpx;
			}
		}
	}

	.logout-section {
		margin-top: $spacing-stack-lg;
		margin-bottom: $spacing-stack-lg;
		.logout-btn {
			background-color: $color-surface-container-lowest;
			color: $color-error;
			font-size: 32rpx;
			font-weight: 600;
			text-align: center;
			padding: 32rpx;
			border-radius: 32rpx;
			box-shadow: 0 40rpx 50rpx -24rpx rgba(0, 0, 0, 0.1);
			border: 2rpx solid rgba(211, 228, 254, 0.2);
		}
	}

	.safe-bottom-area {
		height: calc(200rpx + env(safe-area-inset-bottom));
	}
</style>
