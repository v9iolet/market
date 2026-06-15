# Proposal: 修复标签选择页面异常显示的问题

## 问题描述 (Problem)
当前发布商品页面和标签选择页面同时显示在同一页。点击添加标签时，期望标签选择页从底部弹窗出来，但由于未正确配置弹窗组件，导致标签选择组件在页面中直接渲染，始终可见。

## 根本原因分析 (Root Cause)
`publish.vue` 中使用的 `TagSelectorPopup` 组件依赖于 `<uni-popup>`。但项目中并未安装 `uni_modules` 的 `uni-popup` 组件包。由于组件缺失，`<uni-popup>` 被当作普通 HTML 标签直接渲染在了发布页面的最底部，失去原本默认隐藏、触发后底部滑出的特性。

## 修复目标 (Goal)
- 修复 `TagSelectorPopup.vue`，实现从底部平滑弹出的效果。
- 考虑到热修复的范围最小化原则，不再引入庞大的组件库，直接在 `TagSelectorPopup.vue` 内实现一个包含遮罩层和动画效果的轻量底部弹窗。
