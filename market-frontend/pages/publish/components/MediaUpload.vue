<template>
	<view class="media-section">
		<view class="media-grid">
			<view 
				class="media-item" 
				v-for="(item, index) in list" 
				:key="index"
			>
				<image :src="item" mode="aspectFill" class="media-image"></image>
				<view class="delete-btn" @click.stop="handleDelete(index)">
					<text class="material-symbols-outlined icon-close">close</text>
				</view>
			</view>
			
			<view 
				class="upload-btn active-scale" 
				v-if="list.length < maxCount" 
				@click="handleUpload"
			>
				<text class="material-symbols-outlined icon-add">add_a_photo</text>
				<text class="upload-label">添加照片</text>
			</view>
			
			<view class="empty-slot" v-for="n in emptySlots" :key="'empty-'+n">
				<text class="material-symbols-outlined icon-empty">image</text>
			</view>
		</view>
	</view>
</template>

<script>
export default {
	props: {
		list: {
			type: Array,
			default: () => []
		},
		maxCount: {
			type: Number,
			default: 9
		}
	},
	computed: {
		emptySlots() {
			const totalCells = Math.max(4, this.list.length + 1);
			const currentCells = this.list.length + (this.list.length < this.maxCount ? 1 : 0);
			return Math.max(0, totalCells - currentCells);
		}
	},
	methods: {
		handleUpload() {
			const remain = this.maxCount - this.list.length;
			if (remain <= 0) return;
			
			uni.chooseImage({
				count: remain,
				sizeType: ['compressed'],
				sourceType: ['album', 'camera'],
				success: (res) => {
					const newFiles = res.tempFilePaths;
					this.$emit('update:list', [...this.list, ...newFiles]);
				}
			});
		},
		handleDelete(index) {
			const newList = [...this.list];
			newList.splice(index, 1);
			this.$emit('update:list', newList);
		}
	}
}
</script>

<style lang="scss" scoped>
.media-section {
	margin-top: $spacing-stack-lg;

	.media-grid {
		display: grid;
		grid-template-columns: repeat(3, 1fr);
		gap: 24rpx;

		.media-item {
			position: relative;
			aspect-ratio: 1/1;
			border-radius: 24rpx;
			overflow: hidden;

			.media-image {
				width: 100%;
				height: 100%;
			}

			.delete-btn {
				position: absolute;
				top: 8rpx;
				right: 8rpx;
				width: 48rpx;
				height: 48rpx;
				background-color: rgba(0, 0, 0, 0.5);
				border-radius: 50%;
				display: flex;
				align-items: center;
				justify-content: center;

				.icon-close {
					color: #fff;
					font-size: 32rpx;
				}
			}
		}

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
</style>
