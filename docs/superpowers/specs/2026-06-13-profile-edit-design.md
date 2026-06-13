---
comet_change: profile-edit
role: technical-design
canonical_spec: openspec
---

# Design Doc: 个人资料编辑页

## Technical Approach
- **前端页面架构**：新增独立的 `pages/profile/edit.vue`，作为 `profile.vue` 的二级页面。
- **状态存储与 Mock**：由于后端服务未接入，采用 `LocalStorage` (`uni.setStorageSync` / `uni.getStorageSync`) 充当数据持久化层，保存用户的头像路径、昵称和个人简介。
- **视图联动**：在 `edit.vue` 点击“保存”后更新 `LocalStorage` 并通过 `uni.navigateBack()` 返回上一页。在 `profile.vue` 的 `onShow` 生命周期内从 `LocalStorage` 重新拉取并应用资料，以实现视图的无缝刷新。
- **头像交互**：点击头像区域时，调用 `uni.chooseImage` 获取本地相册照片，使用返回的临时文件路径预览头像并将其路径存入 `LocalStorage`。

## Key Trade-offs and Risks
- **数据持久性**：数据仅存在于本地缓存中，一旦用户清除微信小程序/App缓存或更换设备，修改记录即丢失。此方案仅适用于前期的前端体验走查。
- **临时文件路径限制**：`uni.chooseImage` 返回的临时文件路径在应用重启或较长时间后可能会失效。在真实的开发阶段需要将其替换为真正的文件上传和 CDN 获取逻辑。

## Testing Strategy
- 在 HBuilderX 内置浏览器或真机模拟器中，通过点击“编辑资料”按钮检查跳转逻辑是否顺畅。
- 模拟选取相册图片，观察预览图是否立即变更。
- 输入自定义昵称和简介，点击保存并返回，验证“我的”页面的渲染内容是否已成功更新并对齐新输入。
