# Brainstorm Summary

- Change: profile-edit
- Date: 2026-06-13

## Confirmed Technical Approach

- 采用独立页面 (`edit.vue`) + `LocalStorage` 存储模式进行前端数据 Mock。
- 在 `profile.vue` 点击“编辑资料”跳转，通过 `uni.chooseImage` 获取本地图片进行头像预览和设置。
- 编辑保存后，使用 `uni.setStorageSync` 保存更新的数据，并通过 `uni.navigateBack` 返回。`profile.vue` 结合 `onShow` 生命周期实现状态回显。

## Key Trade-offs and Risks

- 不连接真实后端 API，仅通过 LocalStorage 验证交互流，因此应用清除缓存后数据会重置。
- 头像上传目前只获取本地相册临时路径预览，未实现真正的文件上传到服务器。

## Testing Strategy

- 在模拟器或真机测试 `uni.chooseImage` 对相册的拉起。
- 验证表单回填（进入编辑页时）和数据覆盖（返回我的页面时）。

## Spec Patches

None
