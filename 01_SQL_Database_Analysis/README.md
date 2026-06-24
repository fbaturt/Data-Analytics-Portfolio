# 01 — SQL Database & Marketing Analytics

![SQL](https://img.shields.io/badge/SQL-00758F?style=flat-square&logo=postgresql&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-336791?style=flat-square&logo=postgresql&logoColor=white)
![BigQuery](https://img.shields.io/badge/BigQuery-4285F4?style=flat-square&logo=googlecloud&logoColor=white)
![GA4](https://img.shields.io/badge/GA4-E37400?style=flat-square&logo=googleanalytics&logoColor=white)

> Two independent SQL projects analysing cross-platform marketing performance and e-commerce user behaviour — using advanced query techniques on PostgreSQL and Google BigQuery.

---

## 📂 Files

| File | Database | Description |
|---|---|---|
| [`marketing_performance_analysis.sql`](./marketing_performance_analysis.sql) | PostgreSQL | Cross-platform ad performance analysis (Google & Facebook) |
| [`ga4_ecommerce_user_behavior.sql`](./ga4_ecommerce_user_behavior.sql) | BigQuery | GA4 e-commerce funnel and user engagement analysis |

---

## Project 1 — Omnichannel Marketing Performance Analysis

**Database:** PostgreSQL · **Tool:** DBeaver

### Objective
Analyse cross-platform advertising data (Google Ads + Facebook Ads) to identify spend efficiency, ROMI performance, audience growth, and delivery reliability across campaigns.

### What I Built

**1. Cross-Platform Spend Volatility**
Combined Facebook and Google ad data using `UNION ALL` to calculate daily average, maximum, and minimum spend per platform — identifying outlier days with abnormal spend behaviour.

**2. Top 5 Days by ROMI**
Calculated Return on Marketing Investment (`(Value - Spend) / Spend`) per platform per day and ranked the top 5 performers — surfacing which days and channels delivered the highest return.

**3. Weekly Revenue Records**
Identified the single highest revenue-generating campaign in any given week across both platforms using `DATE_TRUNC('week')` — useful for understanding peak performance windows.

**4. Month-over-Month Audience Reach Growth**
Used `LAG()` window function partitioned by campaign to calculate MoM reach growth rate — identifying which campaigns grew their audience fastest over time.

**5. Delivery Streak Analysis (Gaps & Islands)**
Engineered a streak calculation using `ROW_NUMBER()` minus date arithmetic to identify the longest uninterrupted run of active ad delivery per adset — a classic gaps-and-islands pattern that surfaces reliability issues invisible in aggregate metrics.

### Key SQL Techniques
`UNION ALL` across heterogeneous schemas · `DATE_TRUNC` for time-series aggregation · `LAG()` window function for MoM comparison · `ROW_NUMBER()` gaps-and-islands pattern · `NULLIF` for safe division · Multi-table `LEFT JOIN` with adset mapping

---

## Project 2 — GA4 E-commerce User Behaviour Analysis

**Database:** Google BigQuery · **Dataset:** GA4 Obfuscated Sample E-commerce (2020–2021)

### Objective
Reconstruct the full e-commerce conversion funnel from raw GA4 event data, evaluate landing page performance, and statistically validate the relationship between user engagement and purchase behaviour.

### What I Built

**1. Event Extraction from Nested GA4 Schema**
Extracted core e-commerce events (`session_start`, `view_item`, `add_to_cart`, `begin_checkout`, `add_shipping_info`, `add_payment_info`, `purchase`) from BigQuery's nested `event_params` array using `UNNEST` — handling GA4's JSON-like schema structure.

**2. 7-Step Conversion Funnel by Traffic Channel**
Built a session-level funnel using `CONCAT(user_pseudo_id, session_id)` as a unique session key, then calculated conversion rates at each stage (visit → cart → checkout → purchase) broken down by `source / medium / campaign` — pinpointing exactly where users drop off and which channels convert best.

**3. Landing Page Performance (CRO Analysis)**
Used `REGEXP_EXTRACT` to parse clean page paths from full URLs, then joined session starts with purchases to calculate per-page conversion rates — identifying which landing pages drive the highest purchase probability.

**4. Engagement vs. Purchase Correlation**
Calculated Pearson correlation (`CORR()`) between session engagement time and purchase events — statistically validating whether engaged users are meaningfully more likely to convert.

### Key SQL Techniques
`UNNEST` for nested BigQuery event parameters · `CONCAT` composite session keys · `SAFE_DIVIDE` for null-safe rate calculations · `REGEXP_EXTRACT` for URL path parsing · `CORR()` for statistical correlation · CTE chaining for multi-step funnel logic

---

## 📐 Metrics Reference

| Metric | Formula | Purpose |
|---|---|---|
| ROMI | `(Value - Spend) / Spend × 100` | Direct profitability of ad spend |
| Reach Growth (MoM) | `(Current - Previous) / Previous` | Audience expansion velocity |
| CVR | `Purchases / Total Sessions` | E-commerce funnel efficiency |
| Pearson Correlation | `CORR(Engagement, Purchase)` | Statistical engagement-to-revenue validation |

---

## 💡 Key Takeaways

- The **gaps-and-islands streak pattern** is a powerful technique for identifying delivery consistency — something most standard BI dashboards miss entirely
- GA4's nested schema requires `UNNEST` mastery; flat SQL thinking breaks immediately on event-level data
- `CORR()` in BigQuery provides a quick statistical sanity check before investing in more complex attribution modelling
- Session-level deduplication using composite keys (`user_pseudo_id + session_id`) is critical to avoid double-counting in funnel analysis
