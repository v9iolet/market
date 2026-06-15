# Design Doc: 个人资料编辑页

## Architecture Decisions
- 新增 `pages/profile/edit.vue` 页面。
- 页面中包含头像上传组件、昵称输入框、简介文本域等表单元素。
- 在 `profile.vue` 中配置路由导航跳转到此页面。
- 采用本地状态（如 Vuex 或 uni.setStorageSync）模拟资料的保存和回显。

## Approach Selection
表单使用常规的 input 和 textarea。头像部分提供点击事件以唤起相册选择模拟（`uni.chooseImage`）。
