# Comet Design Handoff

- Change: unlogged-profile
- Phase: design
- Mode: compact
- Context hash: ba3b6272475668636968e392d6f022a3a886153cc395a0a5c0e54623d1d7c71b

Generated-by: comet-handoff.sh

OpenSpec remains the canonical capability spec. This handoff is a deterministic, source-traceable context pack, not an agent-authored summary.

## openspec/changes/unlogged-profile/proposal.md

- Source: openspec/changes/unlogged-profile/proposal.md
- Lines: 1-20
- SHA256: f7c97b6644a420555bc06f19b8a0f4d04f6d010987734d5774f9abb92a2fdf37

```md
# 目标

基于设计稿复刻未登录状态的“我的”页面（stitch_ 3）和“登录注册”页面（stitch_ 4），并通过前端状态模拟实现完整的登录与退出交互闭环。

## 背景

当前需要按照提供的高级二手交易平台设计规范还原“我的”页面和“登录注册”页面的视图。用户期望能有一个清晰的登录状态区分结构，并且能够在前端形成一个完整的、无需后端校验的交互演示 Demo。

## 范围

- 创建/更新 `market-frontend/pages/profile/profile.vue`，实现 1:1 设计稿（stitch_ 3）的未登录视图，并在已登录视图的底部添加“退出当前账号”按钮。
- 创建 `market-frontend/pages/login/login.vue`，实现 1:1 设计稿（stitch_ 4）的登录注册界面。
- 实现交互 Demo：
  - 未登录时，点击头像跳转到登录页。
  - 在登录页点击登录，前端模拟写入登录态并返回我的页面，页面自动响应并渲染出已登录视图。
  - 已登录状态下，点击“退出当前账号”按钮清除登录态，视图自动切换回未登录状态。

## 非目标

- 不实现真实的后端接口联调与校验。
```

## openspec/changes/unlogged-profile/design.md

- Source: openspec/changes/unlogged-profile/design.md
- Lines: 1-28
- SHA256: c1f933077a801d5b00f2e6e3c8b59b40e79619db56655a118ed005f6daa7526b

```md
# 架构与设计

## 视图结构

在 uni-app 前端项目中，我们采用 Vue 的条件渲染 (`v-if` / `v-else`) 搭建登录与未登录的状态切换结构。
1. **状态控制**：定义局部响应式变量 `isLoggedIn = ref(false)`。
2. **未登录视图**：
   - 顶部呈现空白头像和未登录状态文案。
   - 绑定 `@click` 事件，触发路由跳转。
3. **已登录视图**（基础骨架）：
   - 在页面底部或对应区块包含“退出账号”按钮。此按钮仅在 `isLoggedIn === true` 时展示。
4. **路由跳转**：
   - 点击空白头像调用 `uni.navigateTo({ url: '/pages/login/login' })`。

## 样式设计

根据 `stitch_ 3/DESIGN.md`：
- **颜色 (Colors)**:
  - 页面背景 (Background): `#f8f9ff`
  - 主色 (Primary): `#091426`
  - 辅助卡片/容器 (Surface Container): `#e5eeff` 等
  - 强调色 (Accent / Secondary): `#006c49`
- **排版 (Typography)**:
  - 采用 Inter 字体，配置 Headline 和 Body 层级样式。
- **圆角 (Shapes)**:
  - 基础组件如按钮使用 `rounded-lg` (8px)，卡片容器使用 `rounded-2xl` (24px)。

样式将直接使用 SCSS 编写于组件的 `<style>` 标签中，或作为全局 Token 写入 `uni.scss` 供页面调用。
```

## openspec/changes/unlogged-profile/tasks.md

- Source: openspec/changes/unlogged-profile/tasks.md
- Lines: 1-9
- SHA256: e938ffac8341f4175a95630574f7d13242822ffa77db66bbb19ccebd57da2662

```md
- [ ] 在 `uni.scss` 中引入或转换 DESIGN.md 里的颜色、排版等设计 Token。
- [ ] 创建或更新 `/pages/profile/profile.vue`。
- [ ] 1:1 还原未登录状态视图（stitch_ 3 空白头像、提示文字、背景等）。
- [ ] 创建 `/pages/login/login.vue`，并在 `pages.json` 中配置路由。
- [ ] 根据 `stitch_ 4` 1:1 还原登录注册界面的 UI。
- [ ] 实现前端本地登录态（Storage 存取）逻辑，在 profile 的 onShow 中读取并切换视图。
- [ ] 绑定交互：未登录状态点击头像跳转至登录页面。
- [ ] 绑定交互：登录页面点击登录按钮，写入状态并返回。
- [ ] 绑定交互：profile 已登录视图区域新增“退出账号”按钮 UI，并绑定清除状态的事件。
```

