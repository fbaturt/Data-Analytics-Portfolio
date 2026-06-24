# Tableau — Supply Chain & Lead Time Optimisation

![Tableau](https://img.shields.io/badge/Tableau-E97627?style=flat-square&logo=tableau&logoColor=white)

> A geospatial supply chain dashboard identifying logistical bottlenecks, unprofitable shipping routes, and lead time variance across North American regions — with direct applicability to MRO spare parts distribution in aviation.

---

## 📊 Live Dashboard

🔗 **[View Interactive Dashboard on Tableau Public →](https://public.tableau.com/views/Superstore_Logistics_and_Profitability/SupplyChainLeadTimeDashboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)**

![Dashboard Screenshot](tableau_dashboard_screenshot.png)

---

## 🎯 Objective

Identify which shipping routes, product sub-categories, and regions are generating losses — and pinpoint where delivery lead times are driving operational inefficiency. The analytical principles here map directly to aviation MRO challenges: spare parts network optimisation, regional AOG response times, and cost-per-delivery balancing across multiple distribution hubs.

---

## 🛠️ What I Built

**1. Geospatial Profitability Heat Map**
Engineered a zero-centered diverging colour map across North America to instantly flag unprofitable product sub-categories and high-lead-time regions — making regional performance patterns visible at a glance rather than buried in tables.

**2. Exact Lead Time Calculation**
Used `DATEDIFF` date functions to calculate precise order-to-delivery lead times per individual order rather than relying on aggregated averages — revealing variance that mean values mask. High variance in lead times is as operationally damaging as high averages.

**3. Dual-Axis Volume vs. Profit Chart**
Synchronised dual-axis charts comparing physical sales volume against profit margins on a single unified scale — immediately surfacing sub-categories where high sales volume is destroying rather than building margin.

**4. Performance-Optimised Global Filters**
Implemented cross-dashboard global filters (Date, Segment, Ship Mode) with `Apply` buttons to batch filter queries — reducing dashboard query load on large datasets and improving interactivity speed.

---

## 💡 Key Takeaways

- Zero-centered diverging colour scales are far more informative than sequential palettes for profitability maps — the neutral midpoint makes losses immediately visible without needing to read the legend
- Order-level lead time variance (`DATEDIFF` per row) reveals operational inconsistency that aggregated averages completely hide
- The supply chain logic here — balancing speed, cost, and geographic coverage — translates directly to aviation spare parts distribution and AOG logistics planning
