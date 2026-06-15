---
change: membership-system
design-doc: docs/superpowers/specs/2026-06-15-membership-system-design.md
base-ref: 15eae32d8a5934d73d2602a4bb541272a07a19f1
---

# Implementation Plan: Membership System

## Proposed Changes

### Database Schema Updates
- **`market-backend/market-sql/02_market_tables.sql`**
  - Update `mkt_user` table:
    - Replace `credit_score` with `points` INT DEFAULT 0 COMMENT '积分'.
    - Add `historical_max_points` INT DEFAULT 0 COMMENT '历史最高积分'.
    - Add `membership_level_id` BIGINT COMMENT '当前会员等级ID'.
  - Create new table `mkt_membership_level`:
    - `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
    - `level_name` VARCHAR(50) COMMENT '等级名称',
    - `point_threshold` INT COMMENT '积分门槛',
    - `discount_rate` DECIMAL(3,2) COMMENT '折扣率 (例 0.95 = 9.5折)'
- **`market-backend/market-sql/03_market_data.sql`**
  - Add initial setup data for `mkt_membership_level` (e.g. Regular, Gold, Diamond).

### Frontend - B-End Admin Panel
- **`admin-frontend/src/api/market/membership.js`**
  - Add API function definitions for membership levels (we'll implement mock functionality since the backend is deferred).
- **`admin-frontend/src/views/market/membership/index.vue`**
  - Create a standard UI view for managing membership levels.

### Frontend - C-End User App
- **`market-frontend/pages/my/my.vue`** (or equivalent user page)
  - Update user profile section to display Points and Membership Level instead of Credit Score.
- **`market-frontend/pages/order/create.vue`** (or checkout equivalent)
  - Display the calculated discount based on the user's membership level in the order summary.

### PRD Documentation
- **`docs/产品需求文档_PRD.md`**
  - Update section 2.1 to replace "信用体系" with "会员体系".
  - Add logic for points and discounts.
