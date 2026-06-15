# Comet Design Handoff

- Change: membership-system
- Phase: design
- Mode: compact
- Context hash: 850f99de7f37c9d5da7737c16ba4afe37f33d2ca48f6467254c293a4e6e62311

Generated-by: comet-handoff.sh

OpenSpec remains the canonical capability spec. This handoff is a deterministic, source-traceable context pack, not an agent-authored summary.

## openspec/changes/membership-system/proposal.md

- Source: openspec/changes/membership-system/proposal.md
- Lines: 1-21
- SHA256: a79991daab7be30f54cc1e2b557a85bdee5b5fc73ee4e12e81e83612a8748dd4

```md
# Proposal: Membership System

## Problem
目前平台使用简单的默认“信用分”体系，无法有效激励用户复购，也不能体现高价值用户的消费成就感。

## Goals
- 将目前的“信用体系”替换为“会员体系”。
- 用户每消费10元可获得1点积分。
- 引入会员等级制度，不同等级对应不同折扣。
- 等级和对应折扣由B端后台进行动态配置管理。
- C端前端页面明确展示会员等级与积分，并在下单时自动应用对应的会员折扣。

## Scope
- C端前端：个人中心增加会员等级、积分展示；下单结算页自动应用等级折扣。
- B端前端：新增会员等级和折扣配置的管理界面。
- 后端：新增会员积分累加、扣除逻辑（订单完成/退款）；新增B端会员等级配置相关的接口；订单结算时的折扣计算。
- 数据库：新增积分、等级字段，或单独的会员表；新增等级配置表。
- 文档：修改 PRD 文档。

## Non-goals
- 暂不引入复杂的会员专属营销玩法（如签到积分、会员日活动、积分商城等），专注基于消费金额的基础会员成长体系。
```

## openspec/changes/membership-system/design.md

- Source: openspec/changes/membership-system/design.md
- Lines: 1-14
- SHA256: 1432da23962bb6df0b126edafe6909080dfcd55f62e0f2402bb66ea281c0a577

```md
# Design: Membership System

## 核心架构决策 (Architecture Decisions)
- **积分计算 (Points Logic)**: 订单状态流转为“已完成”时，后端按公式 `floor(支付金额 / 10)` 计算获得积分，并累加到用户账户。
- **退款扣除 (Refund Logic)**: 当订单发生全额退款时，收回原先发放的积分。扣除公式：`MAX(0, 现有积分 - 退款需扣除积分)`，确保积分不为负数。
- **等级判断 (Level Calculation)**: 会员等级由用户当前累计的积分（或有效积分）决定。当积分发生增减时，动态匹配 `mkt_membership_level` 配置表中的门槛，自动更新对应等级。
- **B端配置存储 (Configuration Storage)**: 新增配置表 `mkt_membership_level`，字段包括 `id, level_name, point_threshold, discount_rate`，由B端管理员进行增删改查。
- **结算折扣 (Checkout Discount)**: 创建订单接口在计算最终支付金额 `pay_amount` 时，需查询用户当前的 `discount_rate` 并计算折后价格。

## 数据流向 (Data Flow)
1. **B端配置**: 管理员在后台配置各等级名称、积分门槛及折扣（如黄金会员，500分，0.95折扣）。
2. **C端结算**: 用户下单 -> 后端拉取用户当前折扣率 -> 计算 `折后金额 = 原价 * 折扣率` -> 生成订单。
3. **交易完成**: 订单变为已完成 -> 后端按 `金额/10` 发放积分 -> 检查并更新用户等级 -> 落库记录。
4. **售后退款**: 订单退款成功 -> 后端按 `金额/10` 扣除积分 -> 积分不足则扣至0 -> 重新评估等级。
```

## openspec/changes/membership-system/tasks.md

- Source: openspec/changes/membership-system/tasks.md
- Lines: 1-11
- SHA256: 464b893e3d1f242ed1605d3febb89821d4b85f55c198f611369b687d9f96e218

```md
# Tasks: Membership System

- [ ] 更新 `docs/产品需求文档_PRD.md`，将“信用体系”相关描述替换为“会员体系”及对应逻辑。
- [ ] 数据库设计：创建 `mkt_membership_level` 配置表；在用户表中增加积分（points）和当前等级（level_id）字段。
- [ ] 后端：实现B端 `mkt_membership_level` 相关的 CRUD 配置接口。
- [ ] 后端：实现订单“已完成”时的积分增加、等级重估逻辑。
- [ ] 后端：实现订单全额退款时的积分扣除、防负数及等级重估逻辑。
- [ ] 后端：修改订单结算逻辑，在创建订单时应用用户当前等级对应的折扣率。
- [ ] B端前端：开发会员等级及折扣配置管理页面。
- [ ] C端前端：修改个人中心页面，展示用户的当前积分与会员等级。
- [ ] C端前端：修改商品详情页/下单页，提示并应用会员等级专属折扣。
```

