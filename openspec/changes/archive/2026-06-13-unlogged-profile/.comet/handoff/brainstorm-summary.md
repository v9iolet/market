# Brainstorm Summary

- Change: unlogged-profile
- Date: 2026-06-13

## Confirmed Technical Approach
1. **全局状态模拟**：为了实现跨页面的状态同步，在前端使用 `uni.setStorageSync('isLoggedIn', ...)` 来模拟用户的登录状态。
2. **我的页面 (`pages/profile/profile.vue`)**：
   - 在页面 `onShow` 生命周期中读取登录状态。
   - **未登录状态**：1:1 还原 `stitch_ 3`，点击空白头像触发 `uni.navigateTo({ url: '/pages/login/login' })`。
   - **已登录状态**：展示已登录的用户结构，并在底部新增“退出当前账号”按钮。点击后清空本地缓存的登录状态，自动切回未登录视图。
3. **登录/注册页面 (`pages/login/login.vue`)**：
   - 1:1 还原 `stitch_ 4`。
   - 点击“登录”按钮不经过后端校验，直接写入登录状态 (`isLoggedIn = true`)，并执行 `uni.navigateBack` 返回到“我的”页面，页面会自动渲染已登录状态。

## Key Trade-offs and Risks
由于当前是不连后端的 Demo 模式，后续接入真实后端时，需要重构登录逻辑替换这部分本地 Storage 操作。

## Testing Strategy
通过手动点击流程测试状态流转（从未登录点击头像到登录页，点击登录再返回，并使用退出按钮重置状态）。

## Spec Patches
更新了 proposal.md 和 tasks.md，补充了登录页 `stitch_ 4` 的 UI 还原和完整闭环的数据流模拟要求。
