# 页面右侧展示不全问题修复 Proposal

## 1. 目标 (Goal)

修复 `checkout.vue` 页面在移动端展示时，右侧内容被截断/显示不全的问题。

## 2. 背景与问题描述 (Background & Problem Description)

用户反馈在 `/Users/violet/Documents/gemini-work/market/market-frontend/pages/checkout/checkout.vue` 页面中，右侧内容展示不全。经过排查，问题根源在于部分具有 100% 宽度属性或弹性布局的容器设置了内边距（`padding`），但未全局或局部应用 `box-sizing: border-box;`。
在标准盒模型（`content-box`）下，宽度 = 内部内容宽度 + 左右 padding。当容器默认占满屏幕时，额外的 padding 会导致容器的总宽度超过屏幕宽度，从而造成右侧内容溢出并被截断。

## 3. 根因分析 (Root Cause Analysis)

`checkout.vue` 的样式中：
1. `.checkout-page` 及其内部元素如 `.main-content` 包含了左右 `padding: 0 $spacing-container-margin;`。
2. 小程序和H5中部分基础组件（如包含宽度的 `view` 或 `scroll-view`）默认使用 `box-sizing: content-box`。
3. 这些因素叠加导致容器撑破屏幕宽度，出现横向滚动或被截断的现象。

## 4. 修复目标 (Fix Goal)

通过在样式中引入 `box-sizing: border-box;`，确保元素的 `padding` 被包含在元素的指定宽度内，从而防止页面因为左右 padding 导致宽度超出屏幕宽度。
