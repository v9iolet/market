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
