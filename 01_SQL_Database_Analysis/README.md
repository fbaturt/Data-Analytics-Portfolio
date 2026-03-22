![SQL](https://img.shields.io/badge/Language-SQL-blue)
![BigQuery](https://img.shields.io/badge/Platform-Google_BigQuery-white?logo=google-cloud)
![PostgreSQL](https://img.shields.io/badge/Platform-PostgreSQL-336791?logo=postgresql)

# 📊 SQL & Database Analysis Portfolio

> **High-impact SQL projects transforming raw marketing and product event data into actionable business strategies.** This folder highlights my ability to handle complex data architectures, from **PostgreSQL** marketing databases to **Google BigQuery** GA4 event streams.

---

## 🚀 Projects Overview

### 1️⃣ Omnichannel Marketing Performance Deep-Dive
**Tools:** `PostgreSQL` | `DBeaver`  
**File:** [`marketing_performance_analysis.sql`](./marketing_performance_analysis.sql)

Analytic deep-dive into cross-platform advertising data (Facebook & Google Ads) to optimize budget efficiency.

* **KPI Engineering:** Developed custom metrics for **ROMI** (Return on Marketing Investment) and **MoM Reach Growth** to track campaign performance over time.
* **Advanced Logic:** Solved **"Gaps and Islands"** problems using window functions to identify the longest uninterrupted ad delivery streaks.
* **Data Integration:** Unified disparate data sources using `UNION ALL` and `CTEs` for a centralized view of marketing spend.

### 2️⃣ GA4 E-commerce User Behavior Analysis
**Tools:** `BigQuery` | `GA4 Event-Model`  
**File:** [`ga4_ecommerce_user_behavior.sql`](./ga4_ecommerce_user_behavior.sql)

End-to-end reconstruction of the user journey using the GA4 public dataset to identify conversion friction.

* **Funnel Reconstruction:** Built a multi-stage conversion pipeline (**Session Start → Add to Cart → Purchase**) to visualize specific drop-off points.
* **Landing Page Optimization:** Leveraged `REGEXP_EXTRACT` to identify high-converting entry paths and landing page efficiency.
* **Statistical Insights:** Calculated the **Pearson Correlation Coefficient** to prove the link between engagement time and purchase probability.

---

## 🛠️ Technical Skill Stack

* **Advanced Queries:** CTEs, subqueries, and complex multi-table joins.
* **Window Functions:** Skilled in `LAG()`, `ROW_NUMBER()`, and `PARTITION BY`.
* **Schema Handling:** Expert in **BigQuery `UNNEST`** for nested GA4 event parameters.
* **Data Integrity:** Utilizing `SAFE_DIVIDE`, `COALESCE`, and `NULLIF` for production-grade calculations.

---
