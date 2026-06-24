# Power BI — Dynamic Sales & Currency Dashboard

![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=flat-square&logo=powerbi&logoColor=black)
![DAX](https://img.shields.io/badge/DAX-00599C?style=flat-square)
![Power Query](https://img.shields.io/badge/Power_Query-217346?style=flat-square&logo=microsoft&logoColor=white)

> A dynamic financial dashboard that transforms static supermarket sales data into a live, currency-aware reporting tool — integrating a real external API directly into Power BI.

---

## 📊 Dashboard Preview

![Dashboard Screenshot](powerbi_dashboard_screenshot.png)

---

## 🎯 Objective

Build a dashboard that lets business users instantly switch revenue and sales volume views between local and foreign currencies — powered by a live exchange rate feed rather than hardcoded values. The goal was to demonstrate that BI tools aren't just for static reporting: they can consume live external data and make every calculated metric dynamic.

---

## 🛠️ What I Built

**1. Live API Integration via Power Query**
Connected directly to the National Bank of Ukraine exchange rate API inside Power Query — pulling live USD rates on refresh without any manual data entry. This means the entire dashboard stays current automatically.

**2. Dynamic Currency Switching with DAX**
Engineered custom DAX measures using `IF`, `MAX`, and `FORMAT` logic to switch the dashboard's revenue calculations between native and foreign currency based on a user slicer selection — all metrics update simultaneously with a single click.

**3. Volume vs. Revenue Disparity Analysis**
Built comparative visualisations highlighting the gap between physical sales volume (`Quantity`) and actual financial intake (`Gross Income`) — surfacing product lines where high unit sales don't translate to proportional revenue.

---

## ⚙️ How to Run

1. Download [`supermarket_sales.pbix`](./supermarket_sales.pbix)
2. Open with **Power BI Desktop**
3. Click **Refresh** on the Home ribbon to pull the latest exchange rate from the API

---

## 💡 Key Takeaways

- Live API integration in Power Query eliminates manual data refresh cycles — a direct parallel to automated data pipelines in production environments
- DAX currency switching logic is reusable across any multi-currency reporting scenario
- Separating volume and revenue metrics in the same visual immediately surfaces margin inefficiencies that aggregate totals hide
