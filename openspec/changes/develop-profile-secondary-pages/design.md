# Design: 二级页面开发及未登录状态拦截机制

## 1. 架构方案选项 (Architecture Decisions)

### 未登录点击拦截实现方式
- **方案 A：在组件/页面层级拦截 (推荐)**：在 `profile.vue` 中封装一个统一的 `handleAuthClick(url)` 方法或使用指令，统一校验 `isLoggedIn` 状态。未登录则拦截跳转 `/pages/login/login?redirect=encodeURIComponent(url)`。
- **方案 B：路由级拦截**：使用 uni-app 的 `addInterceptor` 在全局对跳转路由进行拦截。
- **决定**：采用**方案 A**，因为“我的”页面展示丰富内容时点击需要立即反馈，组件层级的封装 `checkAuthAndNavigate` 最为轻量直观，且能精确传递重定向参数。

### 登录回跳机制
- 登录页面 (`pages/login/login.vue` 或类似组件) 接受 `redirect` 参数。
- 登录成功后，检测是否存在 `redirect`，如果存在则使用 `uni.redirectTo` 或 `uni.navigateTo` 跳转到目标地址，否则按默认逻辑处理。

## 2. 核心模块与数据流 (Data Flow)
1. **Profile 视图层 (`pages/profile/profile.vue`)**:
   - 将原有的静态点击事件，或没有点击事件的功能项，统一绑定到 `navigateToAuth` 函数。
   - 函数内部检查 `isLoggedIn` (从 Storage 取值或通过 Store)。如果 false，则跳转登录页并带上当前期望去向。
2. **Login 视图层 (`pages/login/login.vue`)**:
   - `onLoad(options)` 中接收 `options.redirect`。
   - `loginSuccess` 回调中读取 `redirect` 执行重定向。
3. **二级页面**:
   - `pages/profile/published` (我发布的)
   - `pages/profile/sold` (我卖出的)
   - `pages/profile/bought` (我买到的)
   - `pages/profile/favorites` (收藏的)
   - `pages/profile/address` (收货地址)
