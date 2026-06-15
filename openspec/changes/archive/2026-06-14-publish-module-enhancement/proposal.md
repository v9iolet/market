# Proposal: 完善发布模块具体功能项

## Why
当前商品发布页面 (`publish.vue`) 缺乏具体的表单选项数据流向，分类、成色等均为纯展示，且无防止误退出的草稿机制。完善这些交互模块，能显著提升用户的发布体验并保证发布数据的结构化与完整性。

## What Changes
- 添加本地草稿保存及恢复提示功能（退出防丢）。
- 完善图片上传逻辑限制（最多9图，纯图片，前端压缩）。
- 添加分类、成色、发货方式的弹窗选择逻辑。
- 引入分类联动的动态推荐标签模块（最多选择3个，不可手动补充）。
- 加入极其严格的发布拦截校验（包含描述、标签在内的所有字段必填）。

## Capabilities

### New Capabilities
- `publish-form-interaction`: 发布页面的表单项交互与必填项校验。
- `publish-draft-manager`: 发布页面未完成内容的草稿暂存及恢复管理。
- `publish-tag-selector`: 发布页基于商品分类的动态推荐标签选择能力。

### Modified Capabilities
（无）

## Impact
- 核心修改文件：`/market-frontend/pages/publish/publish.vue`
- 前端存储影响：`LocalStorage` 增加未发布商品的草稿字段。
- 依赖影响：无。所有选项（包含分类与标签）的数据本期仅在前端 mock，无需新接口。
