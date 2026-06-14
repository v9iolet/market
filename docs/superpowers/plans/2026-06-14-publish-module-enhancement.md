---
change: publish-module-enhancement
design-doc: docs/superpowers/specs/2026-06-14-publish-module-enhancement-design.md
base-ref: bebb9cdcd3b6bbbce193c1f3738dc44839558658
---

# Implementation Plan: 发布模块具体功能项完善

## 目标
根据设计文档，对 `publish.vue` 进行组件化重构，补充本地草稿保存机制、媒体上传组件交互、标签选择弹窗组件交互，并实现完整的表单必填校验。

## 前置准备 (Task 1)
- **文件**：`market-frontend/pages/publish/publish.vue`
- **动作**：在 `data` 中补充所需的 Mock 数据字典，如 `categories` 列表、`conditions` 列表、`deliveries` 列表，以及最为核心的 `categoryTagsMap`（映射分类与标签数组）。补充表单对应的数据结构 `formData`。

## 组件开发：MediaUpload (Task 2)
- **文件**：`market-frontend/pages/publish/components/MediaUpload.vue` (新建)
- **动作**：
  - 迁移 `publish.vue` 原有的图片上传静态结构。
  - 实现 `chooseImage` 方法，限制 `count: 9 - list.length`，开启 `sizeType: ['compressed']`。
  - 支持删除已选图片功能。
  - 使用 `v-model` 或 `emit('update')` 将选择的文件列表同步给父组件。

## 组件开发：TagSelectorPopup (Task 3)
- **文件**：`market-frontend/pages/publish/components/TagSelectorPopup.vue` (新建)
- **动作**：
  - 使用 `uni-popup` 搭建底部弹窗。
  - 接收父组件传入的 `category` 和当前已选的 `tags`。
  - 根据 `category` 查字典展示可选标签（若未选分类则提示先选分类）。
  - 实现点选交互，最大选择 3 项，重复点击取消选择。
  - 弹窗确认时触发 `emit` 更新父组件标签。

## 重构 publish.vue 主页面 (Task 4)
- **文件**：`market-frontend/pages/publish/publish.vue`
- **动作**：
  - **组件集成**：引入并注册 `MediaUpload` 和 `TagSelectorPopup`。
  - **表单数据绑定**：将 `title`, `description`, `price` 绑定至 `formData`。
  - **基础选择器接入**：利用 `uni.showActionSheet` 实现分类、成色、发货方式的选择。当分类改变时，清空当前已选的 tags。
  - **草稿机制**：
    - `onLoad`: 检测 `uni.getStorageSync('publish_draft')`，存在则 `uni.showModal` 提示恢复。
    - `onUnload`: 检查是否未发布且表单非空，是则静默存入缓存。
  - **校验与发布**：在发布按钮点击时，按顺序校验全部必填项。通过后提示发布成功。

## 验证与测试
- 在本地运行环境点击各个功能交互，确认 ActionSheet 正常唤起，分类改变会清空标签。
- 退出页面再进入，验证草稿恢复逻辑。
- 不填描述或标签点击发布，验证错误拦截是否准确生效。
