---
comet_change: unlogged-profile
role: technical-design
canonical_spec: openspec
archived-with: unlogged-profile
status: archived
---

# 个人主页与登录流程前端架构设计

## 架构选型
本项目使用 uni-app 和 Vue 技术栈。考虑到这是纯前端的闭环演示（Demo）环境，暂不引入复杂的全局状态管理库 (如 Vuex/Pinia)。我们采用原生的 `uni.setStorageSync` 和 `uni.getStorageSync` 来实现极简的会话状态持久化，满足跨页面状态同步需求。

## 核心流程与页面结构

### 1. 个人主页 (Profile) -> `pages/profile/profile.vue`
- **状态感知**：在页面的 `onShow` 钩子中，调用 `uni.getStorageSync('isLoggedIn')` 获取当前状态，并更新响应式变量 `isLoggedIn`，确保页面可见时视图状态是最新的。
- **未登录视图 (`!isLoggedIn`)**：
  - 依赖 `stitch_ 3` 规范，实现未登录占位组件（空白灰色头像、引导语等）。
  - 为空白头像绑定点击事件：`uni.navigateTo({ url: '/pages/login/login' })`。
- **已登录视图 (`isLoggedIn`)**：
  - 渲染页面骨架。
  - 在页面底部额外渲染“退出当前账号”按钮。
  - 退出按钮点击事件：调用 `uni.removeStorageSync('isLoggedIn')`，并将当前组件的 `isLoggedIn` 设为 `false`，从而立即切换回未登录视图。

### 2. 登录注册页 (Login) -> `pages/login/login.vue`
- **界面还原**：根据 `stitch_ 4` 规范，1:1 实现包含输入框、第三方登录按钮等组件的登录注册面板。
- **状态写入**：
  - 忽略实际表单校验和后端调用逻辑。
  - 点击核心的“登录”按钮后，直接触发处理函数：调用 `uni.setStorageSync('isLoggedIn', true)`。
  - 随后调用 `uni.navigateBack({ delta: 1 })`（或者视路由层级使用 `uni.switchTab` 如果 profile 是 tab 页，根据 pages.json 实际上它是普通页面），返回上一个页面（即 Profile 页）。

## 样式与组件设计
- **Design Tokens**：严格参照 `DESIGN.md` 中定义的 Premium Exchange System 样式。通过局部 SCSS 变量或者在 `uni.scss` 中复用这些 Tokens。
- **公共组件**：如果后续有复用可能，可以考虑将底部导航或其他基础组件抽出，但基于目前规模，将视图分离在同一个文件内的 `v-if/else` 模板区块是最高效的选择。
