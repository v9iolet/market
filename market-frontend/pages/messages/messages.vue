<template>
	<view class="messages-page">
		<!-- TopAppBar -->
		<view class="header glass-effect">
			<view class="header-content">
				<view class="icon-btn active-scale" v-if="!isSearchMode">
					<text class="material-symbols-outlined icon">menu</text>
				</view>
				<text class="header-title" v-if="!isSearchMode">消息</text>
				<view class="icon-btn active-scale" v-if="!isSearchMode" @click="toggleSearch">
					<text class="material-symbols-outlined icon">search</text>
				</view>
				
				<view class="search-bar" v-if="isSearchMode">
					<text class="material-symbols-outlined icon-search">search</text>
					<input 
						class="search-input" 
						v-model="searchQuery" 
						placeholder="搜索联系人或消息..." 
						:focus="isSearchMode"
					/>
					<text class="material-symbols-outlined icon-close active-scale" @click="toggleSearch">close</text>
				</view>
			</view>
		</view>

		<scroll-view scroll-y class="main-content">
			<!-- Functional Entry Group -->
			<view class="functional-group">
				<view class="func-item active-scale" @click="navTo('logistics')">
					<view class="icon-circle logistics">
						<text class="material-symbols-outlined icon-fill">local_shipping</text>
					</view>
					<text class="func-label">交易物流</text>
				</view>
				<view class="func-item active-scale" @click="navTo('notices')">
					<view class="icon-circle notices">
						<text class="material-symbols-outlined icon-fill">notifications</text>
						<view class="badge"></view>
					</view>
					<text class="func-label">通知消息</text>
				</view>
				<view class="func-item active-scale" @click="navTo('interactions')">
					<view class="icon-circle interactions">
						<text class="material-symbols-outlined icon-fill">favorite</text>
					</view>
					<text class="func-label">互动消息</text>
				</view>
			</view>

			<!-- Message List -->
			<view class="message-list">
				<view class="chat-entry active-scale" v-for="(msg, index) in filteredMessages" :key="msg.id" :class="{'opacity-80': msg.isOfficial}" @click="navToChat(msg)">
					<view class="avatar-wrapper">
						<image v-if="!msg.isOfficial" class="avatar" :src="msg.avatar" mode="aspectFill"></image>
						<view v-else class="icon-avatar">
							<text class="material-symbols-outlined">support_agent</text>
						</view>
						<view v-if="msg.statusDot" class="status-dot"></view>
					</view>
					<view class="chat-info">
						<view class="chat-header">
							<text class="chat-name">{{ msg.name }}</text>
							<text class="chat-time">{{ msg.time }}</text>
						</view>
						<text class="chat-preview">{{ msg.preview }}</text>
					</view>
				</view>
				<view v-if="filteredMessages.length === 0" class="empty-state">
					<text>没有找到相关消息</text>
				</view>
			</view>

			<view class="safe-bottom-area"></view>
		</scroll-view>

		<CustomTabBar current="messages" />
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
				isSearchMode: false,
				searchQuery: '',
				mockMessages: [
					{
						id: 1,
						name: 'Anna Studio',
						time: '10:42 AM',
						preview: '您好，这款Vintage包包还在吗？',
						avatar: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBfFZbGJuxvmI2uNx-5IsMX3_uotLPtyHCV8dCtB3iJxfT7HHrqmABoHUV1-emVGdjtg2MaOKvpVUMrk7mwAjqTAXiZdUyvncqwTKC9zZKQqJHU0AXoJ1BKVKLSGr_3IHMyCKA5jGjwmKXNiz1_D9zyJdfQzOZ_ut78T-hiwHE4L9xq_awKh7uQFiPGRcOEa13mCtL1Cvm6SKU88oa_eycwyxIt0PjNDDXIgVsXSwNwL4i6sCyEeHGQZcq6rIHFXx6LSODS19TDRDqx',
						isOfficial: false,
						statusDot: true
					},
					{
						id: 2,
						name: 'Maison Collector',
						time: '昨天',
						preview: '价格可以再商量，看您诚心要。',
						avatar: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCpv8hY7xabLnYvciJSFaH3aOYP1ohUeGQ9Ufjaz-O1DqdLepIDeIXWTC_QlIkHj9Qm5cHFO9SCgTczTqpKtV72TAu7PCdAPyZZMI7D4DoHSh430R87NDRhAmt3by3GUuet7K9DqKevVtTXgCeal1GFOyt4zC-OI6Sb-8tXFuugSfkVEn1NDw6sj9M1PhkRRudbe1ZAuvEq0H4_AQN61mgjaQneI56CGUjGMMxlrJqsKAPrSivNsR0f0dPpD6p82DE-2HCrdV-tb00_',
						isOfficial: false,
						statusDot: false
					},
					{
						id: 3,
						name: 'Lumina Tech',
						time: '星期二',
						preview: '物流信息已经更新了，请注意查收。',
						avatar: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC-Ta2lRNdLZPA05SD-5YfGAffamtiAmHMQUzto4-U3bR2pnAzbhrWhVWkzLRFDAaQonvcvDUmrL-LmTHVFMfkP5W04NTRDwF2uNCvBLFekeZcf4VV1p-UUhPDOh3I_hoyE8UyOOeMukPsMILb0_MtdrsAwG1R0a0bhi3-ywMxoV-BVve_V9pnitQPzS47pG9yk30J2Aq-FbXc3vbD84tPEkdcKfbgx-qDX5JVswni9Hk_0US0MlHxqk8O2CPrkj-VoDOQNno0-uICz',
						isOfficial: false,
						statusDot: false
					},
					{
						id: 4,
						name: '官方客服',
						time: '12/05',
						preview: '您的申诉已受理，进度可在详情页查看。',
						avatar: '',
						isOfficial: true,
						statusDot: false
					}
				]
			}
		},
		computed: {
			filteredMessages() {
				if (!this.searchQuery) return this.mockMessages;
				const lowerQuery = this.searchQuery.toLowerCase();
				return this.mockMessages.filter(msg => 
					msg.name.toLowerCase().includes(lowerQuery) || 
					msg.preview.toLowerCase().includes(lowerQuery)
				);
			}
		},
		methods: {
			toggleSearch() {
				this.isSearchMode = !this.isSearchMode;
				if (!this.isSearchMode) {
					this.searchQuery = '';
				}
			},
			navTo(type) {
				if (type === 'logistics') {
					uni.navigateTo({ url: `/pages/messages/logistics-notices` });
				} else {
					uni.navigateTo({ url: `/pages/messages/${type}` });
				}
			},
			navToChat(msg) {
				uni.navigateTo({ url: `/pages/messages/chat?id=${msg.id}&name=${encodeURIComponent(msg.name)}` });
			}
		}
	}
</script>

<style lang="scss" scoped>
	.messages-page {
		min-height: 100vh;
		background-color: $color-background;
		display: flex;
		flex-direction: column;
	}

	.icon-fill {
		font-variation-settings: 'FILL' 1;
	}

	/* TopAppBar */
	.search-bar {
		display: flex;
		align-items: center;
		flex: 1;
		background-color: $color-surface-container-low;
		border-radius: 999rpx;
		padding: 12rpx 24rpx;
		gap: 16rpx;
		
		.icon-search, .icon-close {
			font-size: 36rpx;
			color: $color-outline;
		}
		
		.search-input {
			flex: 1;
			font-size: 28rpx;
			background: transparent;
			border: none;
			padding: 0;
			color: $color-on-surface;
		}
	}
	
	.empty-state {
		display: flex;
		justify-content: center;
		padding: 40rpx 0;
		color: $color-outline;
		font-size: 28rpx;
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

			.icon-btn {
				width: 80rpx;
				height: 80rpx;
				display: flex;
				align-items: center;
				justify-content: center;
				color: $color-primary;
				
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

	.main-content {
		flex: 1;
		margin-top: calc(128rpx + env(safe-area-inset-top));
		display: flex;
		flex-direction: column;
	}

	/* Functional Entry Group */
	.functional-group {
		display: flex;
		justify-content: space-between;
		padding: 32rpx $spacing-container-margin;
		background-color: $color-surface-container-low;
		margin-bottom: $spacing-stack-lg;
		box-shadow: 0 4rpx 8rpx rgba(0,0,0,0.02);

		.func-item {
			display: flex;
			flex-direction: column;
			align-items: center;
			gap: 16rpx;

			.icon-circle {
				width: 96rpx;
				height: 96rpx;
				border-radius: 50%;
				display: flex;
				align-items: center;
				justify-content: center;
				box-shadow: 0 4rpx 8rpx rgba(0,0,0,0.1);
				position: relative;

				&.logistics {
					background-color: $color-secondary-container;
					color: $color-on-secondary-container;
				}

				&.notices {
					background-color: $color-primary-container;
					color: #8590a6; /* on-primary-container */
				}

				&.interactions {
					background-color: $color-surface-variant;
					color: $color-on-surface-variant;
				}

				.badge {
					position: absolute;
					top: 0;
					right: 0;
					width: 24rpx;
					height: 24rpx;
					background-color: $color-error;
					border-radius: 50%;
					border: 4rpx solid $color-surface-container-low;
				}
			}

			.func-label {
				font-size: 28rpx;
				color: $color-on-surface;
			}
		}
	}

	/* Message List */
	.message-list {
		padding: 0 $spacing-container-margin;
		display: flex;
		flex-direction: column;
		gap: $spacing-gutter;

		.chat-entry {
			display: flex;
			align-items: center;
			gap: $spacing-stack-md;
			background-color: $color-surface;
			border-radius: 24rpx;
			padding: 24rpx;
			box-shadow: 0 40rpx 50rpx -24rpx rgba(0, 0, 0, 0.1);

			&.opacity-80 {
				opacity: 0.8;
			}

			.avatar-wrapper {
				position: relative;
				flex-shrink: 0;

				.avatar {
					width: 112rpx;
					height: 112rpx;
					border-radius: 50%;
					box-shadow: 0 2rpx 4rpx rgba(0,0,0,0.1);
				}

				.icon-avatar {
					width: 112rpx;
					height: 112rpx;
					border-radius: 50%;
					background-color: $color-surface-dim;
					display: flex;
					align-items: center;
					justify-content: center;
					color: $color-outline;
					box-shadow: 0 2rpx 4rpx rgba(0,0,0,0.1);

					.material-symbols-outlined {
						font-size: 56rpx;
					}
				}

				.status-dot {
					position: absolute;
					bottom: 0;
					right: 0;
					width: 28rpx;
					height: 28rpx;
					background-color: #4edea3; /* secondary-fixed-dim */
					border-radius: 50%;
					border: 4rpx solid $color-surface;
				}
			}

			.chat-info {
				flex: 1;
				min-width: 0;
				display: flex;
				flex-direction: column;
				gap: 8rpx;

				.chat-header {
					display: flex;
					justify-content: space-between;
					align-items: baseline;

					.chat-name {
						font-size: 32rpx;
						font-weight: 600;
						color: $color-on-surface;
						white-space: nowrap;
						overflow: hidden;
						text-overflow: ellipsis;
					}

					.chat-time {
						font-size: 24rpx;
						color: $color-outline;
						flex-shrink: 0;
						margin-left: 16rpx;
					}
				}

				.chat-preview {
					font-size: 28rpx;
					color: $color-on-surface-variant;
					white-space: nowrap;
					overflow: hidden;
					text-overflow: ellipsis;
				}
			}
		}
	}

	.safe-bottom-area {
		height: calc(200rpx + env(safe-area-inset-bottom));
	}
</style>
