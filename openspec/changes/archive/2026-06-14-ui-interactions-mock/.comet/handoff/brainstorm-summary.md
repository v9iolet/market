# Brainstorm Summary

- Change: ui-interactions-mock
- Date: 2026-06-14

## Confirmed Technical Approach

1. 首页通知路由：在首页对应组件中绑定 `@click` 跳转至 `/pages/messages/messages`。
2. 收藏交互提示：在商品详情页底部操作栏正上方采用**局部绝对定位组件 (Approach A)**实现。通过 `v-if="showToast"` 控制显示，包含 CSS 过渡动画，并在 `setTimeout` 后自动隐藏。
3. 咨询跳转：在商品详情页底部操作栏的“咨询”按钮绑定事件，携带 mock 参数（例如 `?id=mock123&name=卖家昵称`）跳转至 `/pages/messages/chat`。

## Key Trade-offs and Risks

- 采用局部绝对定位组件实现“收藏”提示非常轻量且易于维护，但这要求底部栏有相对定位（`relative`）包裹以避免定位越界。
- 目前为纯前端路由模拟，后续若接入后端时可能需重构状态管理逻辑。

## Testing Strategy

在 H5 端或小程序开发者工具中，分别点击首页通知、详情页想要和咨询按钮，验证控制台及页面跳转链路是否成功、内联 Toast 提示是否如期渲染与淡出。

## Spec Patches

None
