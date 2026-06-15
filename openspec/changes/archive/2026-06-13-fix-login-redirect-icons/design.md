# Design: Fix Login Redirect and Icons

## Fix Solution
- Modify `login.vue`: Change `uni.navigateBack()` inside `handleAction` to `uni.reLaunch({ url: '/pages/profile/profile' })` so it correctly replaces the stack and navigates to the profile page.
- Modify the third-party login section in `login.vue`:
  - Remove the material symbols text icons.
  - Insert `<image class="auth-icon" src="https://img.icons8.com/color/96/wechat.png" mode="aspectFit"></image>` for WeChat.
  - Insert `<image class="auth-icon" src="https://img.icons8.com/color/96/qq.png" mode="aspectFit"></image>` for QQ.
  - Remove `font-size` styles on `material-symbols-outlined` within `.icon-item` and add `.auth-icon { width: 56rpx; height: 56rpx; }` to fit properly in the 96rpx container.
