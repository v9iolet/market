<template>
	<view class="category-zone-page">
	</view>
</template>

<script>
export default {
	data() {
		return {
			categoryName: '全部分类'
		}
	},
	onLoad(options) {
		if (options.type) {
			this.categoryName = options.type;
		}
	}
}
</script>

<style lang="scss" scoped>
.category-zone-page {
	min-height: 100vh;
	background-color: $color-background;
}
</style>
