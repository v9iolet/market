<script>
	export default {
		onLaunch: function() {
			console.log('App Launch')
		},
		onShow: function() {
			console.log('App Show')
		},
		onHide: function() {
			console.log('App Hide')
		}
	}
</script>

<style lang="scss">
	/* 引入字体 */
	@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap');
	@import url('https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap');

	/* 全局样式 */
	page {
		font-family: $font-family-base;
		background-color: $color-background;
		color: $color-on-surface;
		min-height: 100vh;
	}

	.material-symbols-outlined {
		font-family: 'Material Symbols Outlined';
		font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
		user-select: none;
	}

	.hide-scrollbar::-webkit-scrollbar {
		display: none;
	}

	.hide-scrollbar {
		-ms-overflow-style: none;
		scrollbar-width: none;
	}

	/* Glassmorphism utility */
	.glass-effect {
		backdrop-filter: blur(24rpx);
		-webkit-backdrop-filter: blur(24rpx);
	}

	/* Micro-interactions */
	.active-scale:active {
		transform: scale(0.96);
		transition: transform 0.2s ease;
	}
</style>
