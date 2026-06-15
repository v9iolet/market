# Comet Design Handoff

- Change: develop-profile-secondary-pages
- Phase: design
- Mode: compact
- Context hash: 1492b5bc9ecbba6c1971f5027d9988fafabec5610519a18656744ad309e11ce8

Generated-by: comet-handoff.sh

OpenSpec remains the canonical capability spec. This handoff is a deterministic, source-traceable context pack, not an agent-authored summary.

## openspec/changes/develop-profile-secondary-pages/proposal.md

- Source: openspec/changes/develop-profile-secondary-pages/proposal.md
- Lines: 1-21
- SHA256: 61e4e7ecc2e40e0381a5582e27f75cc7558e1398ce7697072fb7654b292c880f

```md
# Proposal: 完善已登陆页面的我的页面的二级页面开发及未登录状态区分

## 1. Problem (背景问题)
当前“我的” (Profile) 页面在未登录状态下仍然展示了“我的交易”、“我的账单”等敏感和个性化功能入口，并且没有进行点击拦截，导致未登录用户可以点击，体验不佳。此外，已登录状态下的各个二级页面（如我发布的、我卖出的、收货地址等）尚未开发完成。

## 2. Goals (目标)
1. 优先完善“我的”页面的核心二级页面（主要为交易模块、收货地址）。
2. 实现未登录状态下的统一拦截：保持原样展示各功能入口，营造丰富内容感；但点击任何入口均拦截并跳转登录页。
3. 优化登录流程交互：点击拦截后支持传递回跳参数 (redirect param)，在登录成功后能够记住意图，无缝跳转至原目标页面。

## 3. Scope Boundaries (范围边界)
- **包含**：新增或完善核心二级页面（我发布的、我卖出的、我买到的、收藏的、收货地址）；对未登录用户的操作进行前端点击拦截；重定向与登录回跳逻辑的实现。
- **不包含**：暂不开发所有的二级页面（如关于我们、官方客服、我的账单、消息等暂不包含）；不修改“我的”页面的现有整体视觉布局和结构。

## 4. Key Unknowns (关键未知点)
- 后端接口是否就绪：交易模块和收货地址在后端的接口是否已经完成开发？（如果暂未就绪，前端需先使用 Mock 数据或基于现有接口规范进行开发）。

## 5. Acceptance Scenarios (验收场景)
1. **未登录点击拦截**：用户在“我的”页面，未登录状态下，点击“收货地址”或“我的交易”相关入口，页面立即拦截并跳转至登录页。
2. **登录后自动回跳**：用户在登录页完成登录，系统根据之前传递的回跳参数，自动跳转回“收货地址”或最初想要去的页面。
3. **正常功能访问**：用户在已登录状态下，在“我的”页面点击“我发布的”，顺利进入“我发布的”二级页面，功能显示正常。
```

## openspec/changes/develop-profile-secondary-pages/design.md

- Source: openspec/changes/develop-profile-secondary-pages/design.md
- Lines: 1-26
- SHA256: ff495b7853a4e2bfce32417040398c94a9b1b5f85f5f3c467a8ce07e78586c69

```md
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
```

## openspec/changes/develop-profile-secondary-pages/tasks.md

- Source: openspec/changes/develop-profile-secondary-pages/tasks.md
- Lines: 1-8
- SHA256: c614146af5415f4870dc685145812f5cd31cc1b28b42cecf8a1e6aa16b2cbc8c

```md
# Tasks

- [ ] 1. 在 `pages.json` 中配置并初始化核心二级页面：`published`（我发布的）、`sold`（我卖出的）、`bought`（我买到的）、`favorites`（收藏的）、`address`（收货地址）。
- [ ] 2. 在 `profile.vue` 中封装统一的拦截跳转方法 `checkAuthAndNavigate(targetUrl)`。
- [ ] 3. 修改 `profile.vue`，为“我的交易”模块和“收货地址”等入口绑定点击事件，调用统一的拦截跳转方法。
- [ ] 4. 修改 `login.vue`：在 `onLoad` 获取 `redirect` 参数，并在登录成功后优先执行重定向跳转。
- [ ] 5. 完善 `address` (收货地址) 静态页面及交互。
- [ ] 6. 完善 `published`, `sold`, `bought`, `favorites` 等核心交易二级页面的基本结构或 Mock 数据展示。
```

