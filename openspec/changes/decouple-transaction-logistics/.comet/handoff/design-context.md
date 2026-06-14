# Comet Design Handoff

- Change: decouple-transaction-logistics
- Phase: design
- Mode: compact
- Context hash: 37932ba31a469022da8627bb3b02d318ed345fe9b9026e0ffce4d6b0a23adaa7

Generated-by: comet-handoff.sh

OpenSpec remains the canonical capability spec. This handoff is a deterministic, source-traceable context pack, not an agent-authored summary.

## openspec/changes/decouple-transaction-logistics/proposal.md

- Source: openspec/changes/decouple-transaction-logistics/proposal.md
- Lines: 1-22
- SHA256: 8e773d702ef1c21c0fb8d2632879f90e7ccf74c1504c636cccbd7edc65446e85

```md
# Proposal: Decouple Transaction Logistics

## Problem Statement
当前系统的交易物流采用时间线状态展示，在“我买到的”和“我卖出的”页面中，物流与订单信息分离且缺乏连贯的 UI 展现。用户在查看订单时，不能直观地在订单卡片中预览到最新的物流进度，这种体验落后于目前主流电商平台（如淘宝、闲鱼、转转等）。同时，“我的”页面结构需要调整，以适应业务上对“退款/售后”入口的提权。

## Goals
1. 在“我买到的”和“我卖出的”订单列表中写入 4 种状态的静态 Demo 数据（待发货、待付款、待收货、退款中）。
2. 将订单状态和最新一条物流动态耦合展示在订单列表卡片内部，点击卡片再进入物流详情，废弃原有的纯物流时间线 UI。
3. 在消息页（messages.vue）的物流消息 Tab 中，同步上述订单与物流耦合的 UI 设计及 Demo 数据。
4. 个人中心页调整：将“我的收藏”替换为“退款/售后”并展示退款中状态，原“我的账单”替换为“我的收藏”，并同步更新相关的路由与页面文件。

## Non-Goals
1. 不涉及真实的后端接口对接，所有数据纯前端静态 Mock。
2. 不涉及真实的退款流程或物流详情页深层级改造，仅聚焦在入口级和列表级卡片 UI 调整。
3. 不更改其他订单状态的深层交互逻辑。

## Scope
- `market-frontend/pages/profile/bought.vue`
- `market-frontend/pages/profile/sold.vue`
- `market-frontend/pages/profile/profile.vue`
- 新增或重命名二级页：`favorites.vue`, `bills.vue` (替换), `refunds.vue`
- `market-frontend/pages/messages/messages.vue`
```

## openspec/changes/decouple-transaction-logistics/design.md

- Source: openspec/changes/decouple-transaction-logistics/design.md
- Lines: 1-19
- SHA256: 6b5b60d3d1b8c28b9f69be70ef384dc9b45771c23719deafa24e41899b3a6a1a

```md
# Design: Decouple Transaction Logistics

## Architecture Decisions & Approach
为了实现前端静态的“订单与物流耦合” UI 体验并调整个人主页结构，我们将在以下层面进行设计：

1. **统一的订单与物流 Mock 数据结构**
   - 包含字段：`orderId`, `status` (待发货、待付款、待收货、退款中), `productInfo` (图片、名称、价格), `latestLogistics` (包含时间、状态文案、地点等信息)。
   - 在 `bought.vue` 和 `sold.vue` 中引用同一套或结构相同的数据集合，以便渲染具有一致 UI 的列表卡片。
   - 在 `messages.vue` 的“交易物流” Tab 中复用该数据结构或 UI 组件渲染逻辑。

2. **卡片 UI 组件化重构**
   - 新增或改造当前的订单卡片组件，使其底部或中部内嵌一个浅色的容器（如灰色背景区域），显示“最新一条物流动态”，并加上小图标或箭头，暗示可点击进入详情。
   - 样式参考淘宝、闲鱼的主流交互：左侧商品图，右侧商品详情，下方紧贴着一条物流摘要。

3. **路由与个人页结构调整**
   - 修改 `profile.vue` 中的应用网格 (Grid) 菜单列表。
   - 找到原“我的收藏”所处位置的 index，将其配置改为“退款/售后”，图标使用退款相关 icon，路由指向 `refunds.vue`。
   - 找到原“我的账单”所处位置的 index，将其配置改为“我的收藏”，图标使用收藏相关 icon，路由指向 `favorites.vue`。
   - 确保 `pages.json`（如果存在）注册了新的页面路径，并补充缺失的页面。
```

## openspec/changes/decouple-transaction-logistics/tasks.md

- Source: openspec/changes/decouple-transaction-logistics/tasks.md
- Lines: 1-9
- SHA256: 2170aaf2fc1b53001a09129e8b3a46befcd61e65dbd59ab6a5cf8e340159d8a7

```md
# Tasks: Decouple Transaction Logistics

- [ ] Task 1: 构造通用的订单与物流静态 Demo 数据结构（包含 4 种状态）。
- [ ] Task 2: 改造 `bought.vue` 页面，替换掉原有内容，渲染带物流卡片的订单列表。
- [ ] Task 3: 改造 `sold.vue` 页面，替换掉原有内容，渲染带物流卡片的订单列表。
- [ ] Task 4: 修改 `messages.vue` 页面中交易物流 Tab 的 UI，使其同样采用物流与订单耦合的展示样式。
- [ ] Task 5: 调整 `profile.vue`，将“我的收藏”替换为“退款/售后”，将“我的账单”替换为“我的收藏”。
- [ ] Task 6: 检查并配置关联的路由文件（如 `pages.json`），创建或重命名对应的二级页（`refunds.vue` 等）。
- [ ] Task 7: 确保各页面的点击流跳转正常工作（如从个人页点击退款售后能正确跳转，订单列表中不发生报错）。
```

