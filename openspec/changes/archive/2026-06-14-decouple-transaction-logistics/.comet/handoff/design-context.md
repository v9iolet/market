# Comet Design Handoff

- Change: decouple-transaction-logistics
- Phase: design
- Mode: compact
- Context hash: 356ebfff982cbd647b8322b267be5ec79d31e7ea97ccfc22ab357564a0710de7

Generated-by: comet-handoff.sh

OpenSpec remains the canonical capability spec. This handoff is a deterministic, source-traceable context pack, not an agent-authored summary.

## openspec/changes/decouple-transaction-logistics/proposal.md

- Source: openspec/changes/decouple-transaction-logistics/proposal.md
- Lines: 1-22
- SHA256: ed4fee841a28630ad922d2ae78f3baa2ea9bed8930672d304266e8459b7c6a1d

```md
# 重新规划交易物流页面 (Decouple Transaction Logistics)

## 为什么 (Why) / 问题背景
当前 `messages.vue` 的“交易物流”入口，以及 `profile.vue` 中的“我卖出的/我买到的”功能，在物流呈现上存在耦合或不清晰。买家关心物流进度，卖家关心签收状态，如果不区分买卖双方，用户在消息列表中将难以快速找到自己关注的信息，导致心智模型混乱。

## 目标 (Goals)
1. 在消息页的交易物流列表中，明确区分“我买到的”和“我卖出的”消息通知。
2. 将具体的物流时间线（Timeline）展示抽离为通用的物流详情页，实现展示层与业务入口解耦。
3. 统一 Profile 页订单列表及消息通知点击后的物流查看体验。

## 非目标 (Non-Goals)
- 暂不涉及实际后端的物流接口对接与状态抓取（仍使用 Mock 数据）。
- 不改变现有的交易订单本身的数据结构或状态流转。

## 范围与边界 (Scope)
- **包含**：`market-frontend/pages/messages/messages.vue` 及其对应的物流消息列表页；新增独立的通用物流详情页。
- **不包含**：其他类型的消息通知（如互动消息）。

## 核心验收场景 (Acceptance Scenarios)
1. 用户进入消息页，点击“交易物流”，能看到带有“买入”和“卖出”两个 Tab 的物流通知列表。
2. 用户在“买入”Tab 点击某条发货/派件通知，跳转至通用物流详情页，看到该包裹的物流轨迹。
3. 用户在“我的”页面，进入“我买到的”等订单列表，如果有“查看物流”按钮，也会同样跳转至该通用物流详情页。
```

## openspec/changes/decouple-transaction-logistics/design.md

- Source: openspec/changes/decouple-transaction-logistics/design.md
- Lines: 1-22
- SHA256: e979f8f512978dc0a5bc25135c306e257ef62cc13ad82148adf06fd0a5ea82f1

```md
# 架构与设计 (Design)

## 架构拆分方案
我们将交易物流相关的页面进行“三层解耦”：

1. **消息通知层 (Logistics Notices)**
   - 在 `pages/messages/logistics-notices.vue` 中实现物流消息流。
   - 包含顶部选项卡（Tabs），分为“我买到的”和“我卖出的”。
   - 列表仅展示状态变更的摘要（如“已发货”、“正在派件”）。

2. **订单管理层 (Order Management)**
   - `pages/profile/bought.vue` 和 `pages/profile/sold.vue` 作为订单列表。
   - 每个订单卡片中暴露“查看物流”的按钮。

3. **通用物流展示层 (Logistics Timeline)**
   - 将原有的 `pages/messages/logistics.vue` 重构并迁移至 `pages/order/logistics-detail.vue`。
   - 此页面不感知买卖双方上下文，仅根据传入的 `orderId` 或 `trackingNumber` 渲染纯粹的物流轨迹时间线。

## 数据流与路由 (Routing)
- `/pages/messages/messages` -> 点击交易物流 -> `/pages/messages/logistics-notices`
- `/pages/messages/logistics-notices` -> 点击具体通知 -> `/pages/order/logistics-detail?id=xxx`
- 订单列表（买到/卖出） -> 点击查看物流 -> `/pages/order/logistics-detail?id=xxx`
```

## openspec/changes/decouple-transaction-logistics/tasks.md

- Source: openspec/changes/decouple-transaction-logistics/tasks.md
- Lines: 1-7
- SHA256: f8b69c948c36b8020e17c90674297fa5337a079ce394d7a86facdf0ab21d85f7

```md
# 任务清单 (Tasks)

- [ ] 1. 迁移页面：创建目录 `pages/order`，将 `pages/messages/logistics.vue` 移动/重构至 `pages/order/logistics-detail.vue`。
- [ ] 2. 路由更新：在 `pages.json` 中配置新的通用物流详情页 `/pages/order/logistics-detail` 和 新的物流消息列表页 `/pages/messages/logistics-notices`，同时移除旧的 `/pages/messages/logistics` 路由（如果存在）。
- [ ] 3. 新建物流消息列表：实现 `pages/messages/logistics-notices.vue`，包含“我买到的”和“我卖出的”两个 Tab 切换，并渲染 mock 通知列表，列表项点击可跳转至 `logistics-detail` 页面。
- [ ] 4. 修改入口：在 `pages/messages/messages.vue` 中，将“交易物流”的跳转路径更新为 `/pages/messages/logistics-notices`。
- [ ] 5. 清理旧文件：删除不再使用的 `pages/messages/logistics.vue`。
```

