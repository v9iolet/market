# 设计：清理后台管理端前端页面广告并更换系统名称

## 修复方案 (Fix Solution)
针对后台管理端页面的定制化要求，执行以下修改：

1. **`admin-frontend/src/views/index.vue` (后台首页)**：
   - 移除包含“若依后台管理框架”描述、打赏信息、QQ群号、技术选型列表和更新日志等不必要的 `el-row` 和 `el-col` 元素。
   - 替换为简单的欢迎面板，例如“欢迎使用星空集市控制台”，保持页面结构整洁。

2. **全局文本替换**：
   - 搜索 `admin-frontend` 目录下的 “若依管理系统”、“若依后台管理系统” 或 “RuoYi” 等字样，将前端显示的文案修改为“星空集市控制台”。
   - 主要文件包括 `package.json`（更新 `name` 和 `description`），`.env` 及 `.env.*` 配置环境文件（更新 `VUE_APP_TITLE`），以及 `src/layout/components/Sidebar/Logo.vue`。

此方案无需引入新的依赖，仅需清理无用视图代码并替换相关文案配置，可以实现无副作用的热修复。
