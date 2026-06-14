<template>
	<view class="publish-page">
		<!-- TopAppBar Section -->
		<view class="header glass-effect">
			<view class="header-content">
				<view class="cancel-btn active-scale" @click="goBack">取消</view>
				<text class="header-title">发布闲置</text>
				<view class="publish-btn active-scale" @click="submit">发布</view>
			</view>
		</view>

		<scroll-view scroll-y class="main-content">
			<!-- Media Upload Section -->
			<MediaUpload v-model:list="formData.mediaList" :max-count="9" />

			<!-- Input Section -->
			<view class="input-section">
				<view class="title-input-group" :class="{ 'focused': isTitleFocused }">
					<input 
						class="title-input" 
						placeholder="请输入宝贝品牌和型号" 
						placeholder-class="input-placeholder"
						v-model="formData.title"
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
						v-model="formData.description"
					></textarea>
				</view>
				<view class="tag-hint active-scale" @click="openTagSelector">
					<text class="material-symbols-outlined icon-tag">sell</text>
					<text class="tag-label">
						{{ formData.tags.length ? formData.tags.join(' · ') : '添加标签，让更多人看到' }}
					</text>
				</view>
			</view>

			<!-- Form Rows Section -->
			<view class="form-section">
				<!-- Category -->
				<view class="form-row active-scale" @click="selectCategory">
					<view class="row-left">
						<text class="material-symbols-outlined row-icon">category</text>
						<text class="row-label">分类</text>
					</view>
					<view class="row-right">
						<text class="row-value" :class="{ 'placeholder-value': !formData.category }">
							{{ formData.category || '选择分类' }}
						</text>
						<text class="material-symbols-outlined icon-arrow">chevron_right</text>
					</view>
				</view>
				<!-- Condition -->
				<view class="form-row active-scale" @click="selectCondition">
					<view class="row-left">
						<text class="material-symbols-outlined row-icon">check_circle</text>
						<text class="row-label">成色</text>
					</view>
					<view class="row-right">
						<text class="row-value" :class="{ 'placeholder-value': !formData.condition }">
							{{ formData.condition || '选择成色' }}
						</text>
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
						<input class="price-input" type="digit" placeholder="0.00" placeholder-class="price-placeholder" v-model="formData.price" />
						<text class="material-symbols-outlined icon-arrow">chevron_right</text>
					</view>
				</view>
				<!-- Delivery -->
				<view class="form-row active-scale no-border" @click="selectDelivery">
					<view class="row-left">
						<text class="material-symbols-outlined row-icon">local_shipping</text>
						<text class="row-label">发货方式</text>
					</view>
					<view class="row-right">
						<text class="row-value" :class="{ 'placeholder-value': !formData.deliveryMethod }">
							{{ formData.deliveryMethod || '选择发货方式' }}
						</text>
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
		
		<!-- Tag Selector Popup -->
		<TagSelectorPopup 
			ref="tagSelector" 
			:category="formData.category" 
			:selected-tags="formData.tags"
			:category-tags-map="categoryTagsMap"
			@confirm="handleTagConfirm"
		/>
	</view>
</template>

<script>
	import CustomTabBar from '@/components/CustomTabBar/CustomTabBar.vue';
	import MediaUpload from './components/MediaUpload.vue';
	import TagSelectorPopup from './components/TagSelectorPopup.vue';

	export default {
		components: {
			CustomTabBar,
			MediaUpload,
			TagSelectorPopup
		},
		data() {
			return {
				isTitleFocused: false,
				formData: {
					title: '',
					description: '',
					price: '',
					category: '',
					condition: '',
					deliveryMethod: '',
					tags: [],
					mediaList: []
				},
				hasDraftRestored: false,
				isPublished: false,
				
				// Mock Data Dictionary
				categories: ['手机数码', '服装配饰', '家用电器', '美妆个护', '书籍文具', '运动户外'],
				conditions: ['全新', '99新', '9成新', '8成新', '7成新及以下'],
				deliveries: ['快递发货', '同城面交', '自提'],
				categoryTagsMap: {
					'手机数码': ['无拆无修', '箱说全', '国行', '还在保', '女生自用', '电池健康高'],
					'服装配饰': ['吊牌未拆', '仅试穿', '正品保证', '包邮', '小众设计'],
					'家用电器': ['功能完好', '配件齐全', '极少使用', '外观无损', '制冷强劲'],
					'美妆个护': ['未拆封', '专柜正品', '余量多', '日期新鲜', '小样'],
					'书籍文具': ['无笔记', '绝版', '保存完好', '全新塑封', '打包出'],
					'运动户外': ['专业装备', '几乎全新', '带票', '轻量化', '露营必备']
				}
			};
		},
		onLoad() {
			this.checkDraft();
		},
		onUnload() {
			this.saveDraft();
		},
		methods: {
			goBack() {
				uni.navigateBack();
			},
			checkDraft() {
				try {
					const draft = uni.getStorageSync('publish_draft');
					if (draft) {
						uni.showModal({
							title: '提示',
							content: '您有未发布的草稿，是否恢复？',
							success: (res) => {
								if (res.confirm) {
									this.formData = draft;
								} else {
									uni.removeStorageSync('publish_draft');
								}
								this.hasDraftRestored = true;
							}
						});
					} else {
						this.hasDraftRestored = true;
					}
				} catch (e) {
					console.error('Failed to read draft', e);
					this.hasDraftRestored = true;
				}
			},
			saveDraft() {
				if (this.isPublished) return;
				
				const hasContent = 
					this.formData.title.trim() !== '' || 
					this.formData.description.trim() !== '' || 
					this.formData.category !== '' || 
					this.formData.mediaList.length > 0 ||
					this.formData.price !== '';

				if (hasContent) {
					uni.setStorageSync('publish_draft', this.formData);
				}
			},
			selectCategory() {
				uni.showActionSheet({
					itemList: this.categories,
					success: (res) => {
						const selected = this.categories[res.tapIndex];
						if (this.formData.category !== selected) {
							this.formData.category = selected;
							// 清空标签，因为分类变了
							this.formData.tags = [];
						}
					}
				});
			},
			selectCondition() {
				uni.showActionSheet({
					itemList: this.conditions,
					success: (res) => {
						this.formData.condition = this.conditions[res.tapIndex];
					}
				});
			},
			selectDelivery() {
				uni.showActionSheet({
					itemList: this.deliveries,
					success: (res) => {
						this.formData.deliveryMethod = this.deliveries[res.tapIndex];
					}
				});
			},
			openTagSelector() {
				this.$refs.tagSelector.open();
			},
			handleTagConfirm(tags) {
				this.formData.tags = tags;
			},
			submit() {
				// 严格拦截
				if (this.formData.mediaList.length === 0) {
					return uni.showToast({ title: '至少上传1张图片', icon: 'none' });
				}
				if (this.formData.title.trim() === '') {
					return uni.showToast({ title: '请输入标题', icon: 'none' });
				}
				if (this.formData.category === '') {
					return uni.showToast({ title: '请选择分类', icon: 'none' });
				}
				if (this.formData.description.trim() === '') {
					return uni.showToast({ title: '请输入描述', icon: 'none' });
				}
				if (this.formData.tags.length === 0) {
					return uni.showToast({ title: '请至少选择1个标签', icon: 'none' });
				}
				if (this.formData.condition === '') {
					return uni.showToast({ title: '请选择成色', icon: 'none' });
				}
				if (!this.formData.price || Number(this.formData.price) <= 0) {
					return uni.showToast({ title: '请输入有效的价格', icon: 'none' });
				}
				if (this.formData.deliveryMethod === '') {
					return uni.showToast({ title: '请选择发货方式', icon: 'none' });
				}

				// 发布成功
				this.isPublished = true;
				uni.removeStorageSync('publish_draft');
				uni.showToast({
					title: '发布成功',
					icon: 'success'
				});
				setTimeout(() => {
					uni.switchTab({
						url: '/pages/index/index'
					});
				}, 1500);
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
