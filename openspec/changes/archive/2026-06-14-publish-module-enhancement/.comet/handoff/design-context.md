# Comet Design Handoff

- Change: publish-module-enhancement
- Phase: design
- Mode: compact
- Context hash: f650a829ff5e1962260e9f83b913743199dec05b63609cb699dbf1b5622c0550

Generated-by: comet-handoff.sh

OpenSpec remains the canonical capability spec. This handoff is a deterministic, source-traceable context pack, not an agent-authored summary.

## openspec/changes/publish-module-enhancement/proposal.md

- Source: openspec/changes/publish-module-enhancement/proposal.md
- Lines: 1-26
- SHA256: c49541e3644eac5c1f06200647052e768274099c59162096dbf8f0030ca6c765

```md
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
```

## openspec/changes/publish-module-enhancement/design.md

- Source: openspec/changes/publish-module-enhancement/design.md
- Lines: 1-20
- SHA256: 175893abd7b99ef255b5158d44168d48d93dd4ba0294214028820628506c1c6a

```md
# Design: 完善发布模块具体功能项

## Architecture Decisions

### 草稿状态管理
*   **方案选择**：在 `onUnload` 或应用生命周期钩子中，检测页面是否已发布。如果未发布且有数据变更，则将表单对象序列化存入本地缓存（如 `publish_draft`）。
*   **恢复机制**：在 `onLoad` 中检测本地是否存在草稿记录，若存在则弹窗 `uni.showModal` 提示用户是否恢复。确认后还原数据，否则清理草稿。

### 媒体上传策略
*   **方案选择**：调用 `uni.chooseImage` ，屏蔽视频选项。设定 `count` 动态计算（剩余可选 = 9 - 已选数量）。
*   **图片压缩**：前端在选择后执行本地压缩机制（利用 `chooseImage` 自带的 `sizeType: ['compressed']`），本期暂不需要真实对接云存储。

### 表单选项交互与数据流转
*   **数据源**：分类、成色、发货方式的静态列表写在 `data` 或外部常量文件中。
*   **交互组件**：统一采用系统 Action Sheet 或自定义底部面板进行单项选择。
*   **标签联动**：声明一个映射字典，例如 `const categoryTagsMap = { "数码": ["女生自用", "无拆修"], "服饰": ["仅试穿", "全新带吊牌"] }`。当分类选项变更时，清空已选标签并加载新的推荐标签源。标签只允许点选，不可手敲，监听最大数量为 3。

### 必填项拦截
*   **执行时机**：在点击“发布”按钮时。
*   **策略**：按顺序校验图片数组长度、标题、分类、描述、标签、成色、价格、发货方式。任何一项为空或未选则阻断流程，并通过 Toast 提示用户。
```

## openspec/changes/publish-module-enhancement/tasks.md

- Source: openspec/changes/publish-module-enhancement/tasks.md
- Lines: 1-10
- SHA256: e089327feb74c9496470ca1fce09a42bc69f157bcf7235005934d100d1db86de

```md
# Tasks: 完善发布模块具体功能项

- [ ] 搭建前端静态 Mock 数据字典（包含分类、成色、发货方式、分类对应的推荐标签）。
- [ ] 实现媒体上传组件交互，限制最多选择 9 张纯图片。
- [ ] 开发底部弹窗/ActionSheet，对接分类、成色、发货方式的选项交互。
- [ ] 开发分类与标签列表联动的能力，实现基于分类的标签展现。
- [ ] 实现标签选择交互，设置最多可选 3 个标签的上限及排他/去重逻辑。
- [ ] 在发布按钮的点击事件中加入极其严格的所有表单字段非空必填校验。
- [ ] 加入页面退出的草稿自动本地缓存逻辑。
- [ ] 加入页面加载时的草稿检测与弹窗询问恢复逻辑。
```

