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
