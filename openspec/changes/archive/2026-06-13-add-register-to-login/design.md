# Design: Login/Register Page Hotfix

## Fix Solution
- Modify `pages/login/login.vue` to introduce a `currentMode` state, which can be `'login'` or `'register'`.
- Add a set of styled tabs in the UI to switch between 登录 (Login) and 注册 (Register). The active tab will show a bold text with an underline, keeping it clean and minimal.
- When `currentMode` is `'register'`, conditionally display a "确认密码" (Confirm Password) input field.
- Update the action button text to dynamically say "登录" (Login) or "注册" (Register) depending on the active mode.
- Update the styling of the main action button `.login-btn`. Currently, it uses `background-color: $color-primary;`. We will change it to `background-color: $color-secondary;` to apply the green theme, matching the frontend project design. 
- The tabs should maintain the premium aesthetics defined in `stitch_ 4` by having proper spacing and smooth interaction transitions.
