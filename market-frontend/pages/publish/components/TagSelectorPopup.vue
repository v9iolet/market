<template>
	<view class="tag-selector-container">
		<!-- Mask -->
		<view class="popup-mask" :class="{ 'is-visible': visible }" @click="close"></view>

		<!-- Popup -->
		<view class="popup-wrapper" :class="{ 'is-visible': visible }">
			<view class="popup-content">
				<view class="popup-header">
					<text class="cancel-btn" @click="close">取消</text>
					<text class="title">选择标签</text>
					<text class="confirm-btn" @click="confirm">确定</text>
				</view>
				
				<scroll-view scroll-y class="tag-scroll">
					<view class="tag-list">
						<view 
							class="tag-item" 
							:class="{ 'is-active': tempSelected.includes(tag) }"
							v-for="tag in availableTags" 
							:key="tag"
							@click="toggleTag(tag)"
						>
							<text>{{ tag }}</text>
						</view>
					</view>
				</scroll-view>
				<view class="safe-area-bottom"></view>
			</view>
		</view>
	</view>
</template>

<script>
export default {
	props: {
		category: {
			type: String,
			default: ''
		},
		selectedTags: {
			type: Array,
			default: () => []
		},
		categoryTagsMap: {
			type: Object,
			default: () => ({})
		}
	},
	data() {
		return {
			visible: false,
			tempSelected: []
		}
	},
	computed: {
		availableTags() {
			if (!this.category) return [];
			return this.categoryTagsMap[this.category] || [];
		}
	},
	methods: {
		open() {
			if (!this.category) {
				uni.showToast({
					title: '请先选择分类',
					icon: 'none'
				});
				return;
			}
			this.tempSelected = [...this.selectedTags];
			this.visible = true;
		},
		close() {
			this.visible = false;
		},
		toggleTag(tag) {
			const index = this.tempSelected.indexOf(tag);
			if (index > -1) {
				this.tempSelected.splice(index, 1);
			} else {
				if (this.tempSelected.length >= 3) {
					uni.showToast({
						title: '最多选择3个标签',
						icon: 'none'
					});
					return;
				}
				this.tempSelected.push(tag);
			}
		},
		confirm() {
			this.$emit('confirm', [...this.tempSelected]);
			this.close();
		}
	}
}
</script>

<style lang="scss" scoped>
/* 遮罩层 */
.popup-mask {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background: rgba(0, 0, 0, 0.4);
	z-index: 999;
	visibility: hidden;
	opacity: 0;
	transition: all 0.3s;

	&.is-visible {
		visibility: visible;
		opacity: 1;
	}
}

/* 弹窗容器 */
.popup-wrapper {
	position: fixed;
	bottom: 0;
	left: 0;
	right: 0;
	z-index: 1000;
	transform: translateY(100%);
	transition: transform 0.3s ease-out;

	&.is-visible {
		transform: translateY(0);
	}
}

.popup-content {
	background-color: #ffffff;
	border-radius: 32rpx 32rpx 0 0;
	display: flex;
	flex-direction: column;

	.popup-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		padding: 32rpx 40rpx;
		border-bottom: 2rpx solid $color-surface-container;

		.cancel-btn {
			font-size: 32rpx;
			color: $color-on-surface-variant;
			padding: 16rpx 0;
		}

		.title {
			font-size: 36rpx;
			font-weight: 600;
			color: $color-on-surface;
		}

		.confirm-btn {
			font-size: 32rpx;
			color: $color-primary;
			font-weight: 600;
			padding: 16rpx 0;
		}
	}

	.tag-scroll {
		max-height: 600rpx;
		min-height: 400rpx;
		padding: 40rpx;
		box-sizing: border-box;

		.tag-list {
			display: flex;
			flex-wrap: wrap;
			gap: 24rpx;

			.tag-item {
				padding: 16rpx 32rpx;
				background-color: $color-surface-container-low;
				border-radius: 9999rpx;
				font-size: 28rpx;
				color: $color-on-surface-variant;
				transition: all 0.3s ease;

				&.is-active {
					background-color: $color-primary;
					color: $color-on-primary;
				}
			}
		}
	}

	.safe-area-bottom {
		height: env(safe-area-inset-bottom);
	}
}
</style>
