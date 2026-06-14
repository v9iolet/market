---
comet_change: publish-module-enhancement
role: technical-design
canonical_spec: openspec
---

# Technical Design: 发布模块具体功能项完善

## 1. 架构概览

遵循高内聚低耦合的原则，针对 `publish.vue` 的交互逻辑进行**组件化拆分**，主页面专注于统筹表单数据和流转逻辑，交互复杂的区块抽取为独立 Vue 组件。

## 2. 组件划分

- **`publish.vue` (父容器)**：
  - 管理核心 `formData` 状态（包含所有表单字段及草稿标记）。
  - 处理 `onLoad` (草稿恢复检测) 和 `onUnload` (草稿静默保存)。
  - 提供 "分类"、"成色"、"发货方式" 的系统 ActionSheet 调用（因其逻辑极其简单，无需单独写组件，直接调 API）。
  - 承载 `submit` 校验逻辑。
- **`MediaUpload.vue` (新增子组件)**：
  - 负责媒体文件（图片）的选择。
  - 内部利用 `uni.chooseImage`，支持配置 `count`。
  - 向上触发变更事件，同步已选文件数组。
- **`TagSelectorPopup.vue` (新增子组件)**：
  - 封装底部的标签选择面板，基于 `uni-popup`。
  - 接收当前的 `category`，展示对应的推荐标签列表。
  - 内部维护多选逻辑（最高限制 3 项），输出选择的标签数组。

## 3. 数据流与状态管理

### 3.1. 草稿恢复逻辑 (Draft Manager)
- 用户在填写中途退出（`onUnload`）：
  - 校验当前表单如果非空（至少填写了任意一项）且未成功发布，则 `uni.setStorageSync('publish_draft', formData)`。
- 用户重新进入页面（`onLoad`）：
  - `const draft = uni.getStorageSync('publish_draft')`
  - 如果有 draft，通过 `uni.showModal` 提示用户。用户点“确定”则 `this.formData = draft`，点“取消”则 `uni.removeStorageSync('publish_draft')`。

### 3.2. 必填项严格拦截
按顺序依次拦截，任一项为空则 `uni.showToast` 并终止：
1. `mediaList.length > 0` (至少1张图)
2. `title.trim() !== ''`
3. `category` 不能为空
4. `description.trim() !== ''`
5. `tags.length > 0`
6. `condition` 不能为空
7. `price > 0`
8. `deliveryMethod` 不能为空

## 4. 依赖项与影响范围
- 无需新增后端 API，全部使用前端常量字典模拟（如分类配置及对应标签）。
- 改动完全局限在 `market-frontend/pages/publish/` 目录下（含新建的 `components` 目录）。
