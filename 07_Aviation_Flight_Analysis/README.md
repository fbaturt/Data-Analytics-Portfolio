# ✈️ European Airspace Fleet Analysis
**Real-time aircraft behaviour analysis using OpenSky Network ADS-B data**

---

## 📌 Project Overview
A snapshot analysis of **2,910 active flights** over European airspace, 
fetched live from the OpenSky Network API. This project explores how 
aircraft behave differently across flight phases, which airlines dominate 
European skies, and how altitude and speed patterns reflect real aviation 
regulations and procedures.

As an aeronautical engineer, I brought domain knowledge to the analysis — 
interpreting results through the lens of RVSM procedures, sterile cockpit 
rules, and standard cruise performance rather than treating the data as 
abstract numbers.

---

## 🎯 Key Questions Answered
- Which airlines operate the most active flights over Europe at any given time?
- How do altitude and speed vary across flight phases?
- Does real-world data respect the 250 kt speed limit below 10,000 ft?
- Which countries operate the largest share of European airspace?

---

## 📊 Key Findings

| Metric | Value |
|---|---|
| Total aircraft analysed | 2,910 |
| Countries represented | 76 |
| Unique airlines detected | 513 |
| Average cruise altitude | 35,507 ft |
| Average cruise speed | 443 knots |
| Highest cruising aircraft | 47,000 ft |
| Top airline (by active flights) | Ryanair — 321 flights |

**Flight phase breakdown:**
- 64.8% Cruising — majority of aircraft at or above FL300
- 13.4% Intermediate — shorter routes that don't reach full cruise altitude
- 9.9% Descending
- 8.3% Low Altitude — airport environment, below 10,000 ft
- 3.5% Climbing

---

## 📈 Visualisations

### Chart 1 — Top 15 Airlines by Active Flights
![Top Airlines](chart1_top_airlines.png)
Ryanair (RYR) dominates with 321 active flights — nearly 3x the next 
largest operator (EZY — Easyjet with 117). The top 15 is dominated by 
low-cost carriers, reflecting the LCC model's reliance on high aircraft 
utilisation and frequent short-haul rotations.

### Chart 2 — Altitude Distribution by Flight Phase
![Altitude Distribution](chart2_altitude_distribution.png)
The sharp density peak at FL360 reflects RVSM (Reduced Vertical Separation 
Minima) — aircraft are assigned specific flight levels rather than choosing 
freely, creating the characteristic striping pattern visible in the data. 
The 10,000 ft boundary is clearly visible as the point where climbing and 
descending curves drop to near zero — consistent with sterile cockpit 
procedures.

### Chart 3 — Speed vs Altitude by Flight Phase
![Speed vs Altitude](chart3_speed_vs_altitude.png)
The 250 knot speed limit below 10,000 ft (ICAO standard) is largely 
respected in the data. Outliers above the limit at low altitude are likely 
military aircraft or business jets operating under different rules. The 
dense cruising band at 420–520 knots between FL340–FL380 represents the 
optimal cruise envelope for modern commercial narrowbody and widebody 
aircraft.

---

## 🛠️ Tools & Libraries
| Tool | Purpose |
|---|---|
| Python 3.13 | Core language |
| Pandas | Data manipulation & analysis |
| Matplotlib / Seaborn | Visualisation |
| Requests | OpenSky API calls |
| SciPy | KDE distribution plots |

---

## 📡 Data Source
**OpenSky Network** — opensky-network.org
Live ADS-B flight state data fetched via the REST API.
Enriched with aviation domain knowledge for phase classification
and regulatory context.

---

## 🚀 How to Run
```bash
# 1. Install dependencies
pip install pandas requests matplotlib seaborn scipy

# 2. Set your OpenSky credentials (never hardcode these)
$env:OPENSKY_USER="your_username"
$env:OPENSKY_PASS="your_password"

# 3. Open the notebook
code 07_aviation_fleet_analysis.ipynb

# 4. Run all cells top to bottom
```
> Note: Each run fetches a fresh live snapshot — results will differ 
> slightly from the charts above which were captured on a specific date.

---

## 👤 Author
**Furkan Batur Tavli** — Aeronautical Engineer & Aviation Data Analyst

[LinkedIn](https://www.linkedin.com/in/fbaturtavli/) · 
[GitHub](https://github.com/fbaturt) · 
[Portfolio](https://github.com/fbaturt/Data-Analytics-Portfolio)
