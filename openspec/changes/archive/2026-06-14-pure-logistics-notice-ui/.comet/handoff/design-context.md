# Comet Design Handoff

- Change: pure-logistics-notice-ui
- Phase: design
- Mode: compact
- Context hash: 42c859c7cde71b7e6a20389e72410dc144f790388bdc2254d4c5e87c941212b1

Generated-by: comet-handoff.sh

OpenSpec remains the canonical capability spec. This handoff is a deterministic, source-traceable context pack, not an agent-authored summary.

## openspec/changes/pure-logistics-notice-ui/proposal.md

- Source: openspec/changes/pure-logistics-notice-ui/proposal.md
- Lines: 1-15
- SHA256: 06532eaacba31538a53ec292a78ebba7fc120ce18cd1633757b86e53f5564e69

```md
# Proposal: Pure Logistics Notice UI

## 目标 (Goals)
将消息页的“交易物流”页面（`logistics-notices.vue`）改版为纯粹的“物流动态通知”流。不再区分“我买的/我卖的”，取消顶部 Tab 切换，统一按照时间倒序展示最新的物流通知（参考闲鱼/淘宝的物流助手样式）。

## 非目标 (Non-goals)
不影响个人主页（我的页面）中“我买到的”和“我卖出的”订单列表样式，它们继续使用现有的订单卡片。不处理实际的后台物流接口对接，仅实现前端 UI 和 Mock 数据。

## 范围边界 (Scope Boundaries)
修改 `pages/messages/logistics-notices.vue`，新增专属的 `LogisticsNoticeCard.vue` UI 组件，并在 `mockData.js` 中新增专门的物流通知 Mock 数据。

## 验收场景 (Acceptance Scenarios)
1. 用户进入“交易物流”页面，不再看到顶部 Tab，而是直接看到一个纵向排列的物流通知列表。
2. 列表中的每条通知包含：物流状态（如“已发货”、“派送中”）、更新时间、相关商品缩略图及简要物流信息。
3. 点击新的物流通知卡片，默认跳转到系统已有的物流详情页（`/pages/order/logistics-detail`）。
```

## openspec/changes/pure-logistics-notice-ui/design.md

- Source: openspec/changes/pure-logistics-notice-ui/design.md
- Lines: 1-17
- SHA256: 307a87872c045a00a36c5b4bb28da2452050c65ed8061afd1875e58facd208cc

```md
# Design: Pure Logistics Notice UI

## 整体思路 (Approach)
放弃在消息中心的物流通知页复用订单管理卡片 (`OrderLogisticsCard.vue`)。改为引入一个更加轻量化、专门用于消息通知的卡片组件 `LogisticsNoticeCard.vue`。

## UI 与交互设计 (UI & Interaction Design)
- **LogisticsNoticeCard.vue**: 
  - 顶部显示：物流状态标题（例如：“您的包裹已发货”、“包裹派送中”），右侧带时间戳。
  - 中间内容区：商品缩略图 + 快递公司与单号或最新的流转文本（例如：“顺丰速运：您的快件已到达【深圳市】”）。
  - 点击卡片：使用 `uni.navigateTo` 跳转到 `/pages/order/logistics-detail`，传递运单相关参数（演示数据即可）。
- **logistics-notices.vue**:
  - 移除原有的 Tabs 和 Swiper 结构。
  - 仅保留一个简单的 `scroll-view` 列表页。
  - 引入并使用 `LogisticsNoticeCard` 渲染 Mock 的物流通知数组。

## 数据设计 (Data Design)
在 `mockData.js` 中新增 `logisticsNoticesDemoData`，专门用于驱动这条通知流。结构应当更侧重于时间线上的单条事件，而非按订单聚合的状态。
```

## openspec/changes/pure-logistics-notice-ui/tasks.md

- Source: openspec/changes/pure-logistics-notice-ui/tasks.md
- Lines: 1-6
- SHA256: 0f02a828e7e585819fcac1e34ce701d842d86010cb777cf650dede59d71634f1

```md
# Tasks: Pure Logistics Notice UI

- [ ] Task 1: 在 `mockData.js` 中新增专门的物流通知流 Demo 数据（`logisticsNoticesDemoData`）
- [ ] Task 2: 新建并实现专属通知流 UI 组件 `LogisticsNoticeCard.vue`
- [ ] Task 3: 改造 `logistics-notices.vue`，移除 Tab 切换和 OrderLogisticsCard，使用新卡片渲染通知流
- [ ] Task 4: 确保点击通知卡片能正确跳转到 `/pages/order/logistics-detail`
```

