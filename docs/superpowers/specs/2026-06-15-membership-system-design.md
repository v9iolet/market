---
comet_change: membership-system
role: technical-design
canonical_spec: openspec
---

# Membership System Technical Design

## Architecture Decisions
- **Points Logic**: When an order status becomes `completed`, calculate `floor(order_amount / 10)` and add to user's point balance.
- **Refund Logic**: If an order is fully refunded, subtract the earned points. Prevent the balance from going negative using `MAX(0, current_points - deducted_points)`.
- **Level Calculation**: Level is dynamically derived from the current `points` balance. If points are deducted, the level can be downgraded.
- **Configuration Storage**: Create a new table `mkt_membership_level` (id, level_name, point_threshold, discount_rate) managed by the B-end.
- **Staged Execution**: As requested, the initial execution phase will only cover PRD documentation, Database schema creation, and Frontend layout implementations. Backend APIs will be deferred to a later phase.

## Data Flow
1. **B-end Configuration**: Admin configures levels -> stored in `mkt_membership_level` table.
2. **Checkout**: User initiates purchase -> Backend calculates price = `original_price * user_discount_rate` -> Order created.
3. **Completion**: Order marked complete -> Backend calculates `points = pay_amount / 10` -> Updates user points -> Recalculates level if necessary.
4. **Refund**: Order refunded -> Deduct `points = pay_amount / 10` from user -> Ensure `points >= 0`. Level IS downgraded if the new point balance falls below the current level's threshold.
