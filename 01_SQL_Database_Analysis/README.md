![SQL](https://img.shields.io/badge/Language-SQL-blue)
![PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL-336791?logo=postgresql&logoColor=white)
![Google BigQuery](https://img.shields.io/badge/Cloud-Google_BigQuery-white?logo=google-cloud&logoColor=4285F4)
![Data Analysis](https://img.shields.io/badge/Focus-Product_Analytics-green)

# 📊 SQL & Database Analysis Portfolio

> **High-impact SQL projects transforming raw marketing and product event data into actionable business strategies.** This folder highlights my ability to handle complex data architectures and extract core performance KPIs.

---

## 📖 Performance Metrics Dictionary
To ensure data consistency across platforms, the following business logic was implemented in the analytical scripts:

| Metric | Definition | Business Value |
| :--- | :--- | :--- |
| **ROMI** | `(Value - Spend) / Spend * 100` | Measures the direct profitability of ad spend. |
| **Reach Growth** | `(Current Reach - Previous Reach) / Previous Reach` | Tracks the velocity of audience expansion MoM. |
| **CVR (Funnel)** | `Purchases / Total Sessions` | Identifies the efficiency of the e-commerce user journey. |
| **Pearson Corr** | `CORR(Engagement, Purchase)` | Statistically validates if user activity leads to revenue. |

---

## 🚀 Projects Overview

### 1️⃣ Omnichannel Marketing Performance Deep-Dive
**Tools:** `PostgreSQL` | `DBeaver`  
**File:** [`marketing_performance_analysis.sql`](./marketing_performance_analysis.sql)

**Highlights:**
* **Gaps & Islands Analysis:** Engineered a "Streak" calculation to identify the longest continuous run of active adsets, ensuring high delivery reliability.
* **Spend Volatility:** Aggregated multi-source data to identify daily minimum/maximum spend outliers across Google and Facebook.

### 2️⃣ GA4 E-commerce User Behavior Analysis
**Tools:** `BigQuery` | `GA4 Event-Model`  
**File:** [`ga4_ecommerce_user_behavior.sql`](./ga4_ecommerce_user_behavior.sql)

**Highlights:**
* **Funnel Diagnostics:** Reconstructed a 7-step conversion pipeline to pinpoint exactly where users drop off before checking out.
* **Landing Page Efficiency:** Used Regex to parse URL paths and identify the highest converting entry points for new users.

---

## 🛠️ Technical Skill Stack
* **Advanced Queries:** CTEs, subqueries, and complex multi-table joins.
* **Window Functions:** Expert use of `LAG()`, `ROW_NUMBER()`, and `PARTITION BY`.
* **Schema Handling:** Proficiency in BigQuery `UNNEST` for handling nested JSON event parameters.
