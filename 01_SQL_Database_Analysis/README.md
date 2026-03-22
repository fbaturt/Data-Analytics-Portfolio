📊 SQL & Database Analysis Portfolio
This folder contains advanced SQL projects focused on extracting actionable business insights from complex marketing and e-commerce datasets. These projects demonstrate my ability to bridge the gap between technical data engineering and strategic product analysis.

🚀 Projects Overview
1. Omnichannel Marketing Performance Deep-Dive
Tools: PostgreSQL, DBeaver

File: marketing_performance_analysis.sql

This project analyzes cross-platform advertising data from Facebook and Google Ads to evaluate budget efficiency and campaign longevity.

KPI Engineering: Calculated core marketing metrics including ROMI (Return on Marketing Investment) and Month-over-Month (MoM) reach growth.

Advanced Logic: Utilized Gaps and Islands theory to identify the longest uninterrupted ad delivery streaks using Window Functions.

Data Aggregation: Unified disparate data sources using UNION ALL and CTEs to provide a holistic view of marketing spend.

2. GA4 E-commerce User Behavior Analysis
Tools: Google BigQuery, GA4 Event-Driven Data Model

File: ga4_ecommerce_user_behavior.sql

Using the Google Analytics 4 public dataset, this project reconstructs the user journey to identify conversion bottlenecks and behavioral trends.

Funnel Reconstruction: Built a multi-step conversion funnel (Session Start → Add to Cart → Purchase) to calculate step-specific drop-off rates.

Landing Page Optimization: Leveraged REGEXP_EXTRACT to parse URL paths and identify which landing pages drive the highest conversion rates.

Statistical Analysis: Calculated the Pearson Correlation Coefficient to determine the relationship between session engagement time and purchase probability.

🛠️ Technical Skills Demonstrated
Complex Joins & Unions: Merging multi-platform datasets while maintaining data integrity.

Window Functions: Leveraging LAG(), ROW_NUMBER(), and PARTITION BY for time-series and streak analysis.

JSON/Nested Data: Handling GA4's nested event_params using the UNNEST function in BigQuery.

Statistical Functions: Using CORR() for data-driven hypothesis testing.

Data Cleaning: Implementing NULLIF, COALESCE, and SAFE_DIVIDE to ensure error-free calculations.
