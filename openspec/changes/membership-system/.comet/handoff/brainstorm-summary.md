# Brainstorm Summary

- Change: membership-system
- Date: 2026-06-15

## Confirmed Technical Approach

- 数据库：用户表中增加 `points` (积分), `historical_max_points` (历史最高积分) 和 `membership_level_id` (等级关联)。新增表 `mkt_membership_level` 存储等级名称、积分门槛及折扣率。
- 等级与积分逻辑：10元=1积分。基于 `historical_max_points` 判断等级。发生退款时，扣除对应 `points`（确保>=0），但等级**只升不降**。
- 实施分期：当前开发阶段仅聚焦于**前端（C端与B端页面）、数据库定义更新、PRD文档更新**。后端逻辑与接口在后续阶段统一完成。

## Key Trade-offs and Risks

- 积分余额与等级存在脱钩（积分可能被扣除到0，但保留高级别）。通过引入 `historical_max_points` 字段，既实现了防刷分（积分余额会被扣减），也实现了“只升不降”的用户体验。

## Testing Strategy

- 验证数据库脚本是否正确建立结构。
- 验证PRD文档是否准确描述会员体系。
- 验证前端界面能否正常展示硬编码的Mock积分与等级数据（因为后端接口暂不开发）。

## Spec Patches

None
