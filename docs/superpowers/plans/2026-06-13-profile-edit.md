---
change: profile-edit
design-doc: docs/superpowers/specs/2026-06-13-profile-edit-design.md
base-ref: 010738b33095c5814494f62d06359fa7f7bf25e3
---

# 个人资料编辑页 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [x]`) syntax for tracking.

**Goal:** 实现一个纯前端 Mock 的个人资料编辑页面，允许用户修改头像、昵称和个人简介。

**Architecture:** 新增 `pages/profile/edit.vue`，通过 `uni.getStorageSync` 和 `uni.setStorageSync` 实现本地数据持久化和多页面状态回显。

**Tech Stack:** uni-app, Vue 2, uni API (chooseImage, storage)

---

### Task 1: 创建编辑资料页面基础布局

**Files:**
- Create: `market-frontend/pages/profile/edit.vue`

- [x] **Step 1: 编写 edit.vue 基础结构**

```vue
<template>
	<view class="edit-profile-page">
		<view class="header">
			<text class="material-symbols-outlined back-icon" @click="goBack">arrow_back</text>
			<text class="title">编辑资料</text>
			<text class="save-btn" @click="handleSave">保存</text>
		</view>
		<view class="form-container">
			<view class="avatar-section" @click="changeAvatar">
				<image class="avatar" :src="profile.avatar" mode="aspectFill"></image>
				<text class="avatar-hint">点击更换头像</text>
			</view>
			<view class="form-group">
				<text class="label">昵称</text>
				<input class="input" v-model="profile.nickname" placeholder="请输入昵称" />
			</view>
			<view class="form-group">
				<text class="label">个人简介</text>
				<textarea class="textarea" v-model="profile.bio" placeholder="介绍一下你自己..." maxlength="100"></textarea>
			</view>
		</view>
	</view>
</template>
```

- [x] **Step 2: 添加基础样式**

- [x] **Step 3: Commit**

```bash
git add market-frontend/pages/profile/edit.vue
git commit -m "feat(profile): add base layout for profile edit page"
```

### Task 2: 注册页面路由与配置

**Files:**
- Modify: `market-frontend/pages.json`

- [x] **Step 1: 在 pages.json 注册 edit 页面**

```json
		{
			"path": "pages/profile/edit",
			"style": {
				"navigationBarTitleText": "编辑资料",
				"navigationStyle": "custom"
			}
		}
```

- [x] **Step 2: Commit**

```bash
git add market-frontend/pages.json
git commit -m "feat(profile): register edit page route"
```

### Task 3: 在原页面接入跳转和回显逻辑

**Files:**
- Modify: `market-frontend/pages/profile/profile.vue`

- [x] **Step 1: 增加默认状态并关联回显**

读取 `uni.getStorageSync('userProfile')`，若无则给默认头像和昵称。

- [x] **Step 2: 为编辑按钮添加跳转**

`@click="goToEdit"` -> `uni.navigateTo({ url: '/pages/profile/edit' })`

- [x] **Step 3: Commit**

```bash
git add market-frontend/pages/profile/profile.vue
git commit -m "feat(profile): add navigation to edit page and state load"
```

### Task 4: 实现编辑页面的交互逻辑与 Mock 存储

**Files:**
- Modify: `market-frontend/pages/profile/edit.vue`

- [x] **Step 1: 添加数据加载逻辑 (onLoad/onShow)**

读取缓存的资料数据并填充到表单中。

- [x] **Step 2: 实现头像选择 (changeAvatar)**

调用 `uni.chooseImage({ count: 1 })` 将选中图片的临时路径赋值给 `profile.avatar`。

- [x] **Step 3: 实现保存逻辑 (handleSave)**

将当前表单内容 `uni.setStorageSync('userProfile', this.profile)`。弹窗 `uni.showToast({title: '保存成功'})`，然后延时 `uni.navigateBack()`。

- [x] **Step 4: Commit**

```bash
git add market-frontend/pages/profile/edit.vue
git commit -m "feat(profile): implement save and avatar selection logic"
```
