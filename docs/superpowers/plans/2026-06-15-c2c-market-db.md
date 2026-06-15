---
change: design-c2c-market-db
design-doc: docs/superpowers/specs/2026-06-15-c2c-market-db-design.md
base-ref: e67f60a4f3cc408c9582316b69588f7bef6ffa6b
---

# C2C 二手交易平台数据库实施计划

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 根据设计方案，生成 3 个规范的 MySQL 脚本文件（建库、建表、测试数据），以初始化 C 端市场的独立数据库结构。

**Architecture:** 所有表结构前缀为 `mkt_`，涵盖用户、商品、交易、互动四大核心域。字段定义遵循互联网大厂规范（包含 created_at, updated_at，不使用物理 FOREIGN KEY 约束，所有字段加 COMMENT）。

**Tech Stack:** MySQL 8.0+, SQL Script

---

### Task 1: 创建建库 SQL 脚本

**Files:**
- Create: `/Users/violet/Documents/gemini-work/market/market-backend/market-sql/01_market_database.sql`

- [x] **Step 1: 编写建库 SQL 内容**

```sql
-- 创建 C2C 市场专属数据库（如果不存在则创建）
CREATE DATABASE IF NOT EXISTS `market_c2c` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE `market_c2c`;
```

- [x] **Step 2: 验证文件创建**

Run: `cat /Users/violet/Documents/gemini-work/market/market-backend/market-sql/01_market_database.sql`
Expected: 包含 `CREATE DATABASE` 和 `USE` 语句

- [x] **Step 3: Commit**

```bash
git add market-backend/market-sql/01_market_database.sql
git commit -m "feat(db): add market database creation script"
```

### Task 2: 创建建表 SQL 脚本

**Files:**
- Create: `/Users/violet/Documents/gemini-work/market/market-backend/market-sql/02_market_tables.sql`

- [x] **Step 1: 编写核心建表语句**

```sql
-- 必须包含所有设计域的核心表（mkt_user, mkt_user_address, mkt_category, mkt_product, mkt_order, mkt_message等）
-- 且附带完整的 COMMENT 和逻辑外键说明
```
*(完整建表 SQL 会在此步骤编写执行)*

- [x] **Step 2: 验证文件内容**

Run: `grep "CREATE TABLE" /Users/violet/Documents/gemini-work/market/market-backend/market-sql/02_market_tables.sql | wc -l`
Expected: 大于等于 9（因为有至少9张核心表）

- [x] **Step 3: Commit**

```bash
git add market-backend/market-sql/02_market_tables.sql
git commit -m "feat(db): add market tables schema script"
```

### Task 3: 创建测试数据 SQL 脚本

**Files:**
- Create: `/Users/violet/Documents/gemini-work/market/market-backend/market-sql/03_market_data.sql`

- [x] **Step 1: 编写测试数据插入语句**

```sql
-- 插入测试买家和卖家 (mkt_user)
-- 插入分类 (mkt_category)
-- 插入示例二手商品 (mkt_product)
-- 插入一笔测试订单 (mkt_order)
```

- [x] **Step 2: 验证文件内容**

Run: `grep "INSERT INTO" /Users/violet/Documents/gemini-work/market/market-backend/market-sql/03_market_data.sql | wc -l`
Expected: 能够查到 INSERT 语句

- [x] **Step 3: Commit**

```bash
git add market-backend/market-sql/03_market_data.sql
git commit -m "chore(db): add initial test data for market schema"
```
<!-- review skipped: skill unavailable -->
