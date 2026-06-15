# Brainstorm Summary

- Change: publish-module-enhancement
- Date: 2026-06-14

## Confirmed Technical Approach
采用“组件化拆分 (方案 B)”架构。将页面拆解为几个高内聚的组件（例如图片上传组件、标签选择弹窗组件等），`publish.vue` 作为容器组件负责状态聚合、草稿读取恢复、必填校验与提交。

## Key Trade-offs and Risks
- 优势：保持主文件 `publish.vue` 整洁，上传组件和标签选择弹窗后续可供其他页面复用。
- 风险/折衷：增加了父子组件通信（v-model / emit）的复杂度，需要妥善处理子组件对表单状态的更新反馈。

## Testing Strategy
- 手工测试组件的交互：图片选择上限逻辑、弹窗的开启关闭。
- 测试分类切换时标签数据的清空和重载逻辑。
- 校验必填拦截：尝试在各种不完整输入情况下点击发布，验证错误提示。
- 测试草稿保存与恢复机制是否按预期工作。

## Spec Patches
None
